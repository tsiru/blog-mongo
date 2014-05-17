namespace :db do
  desc "Downloads some random posts from www.infakt.pl/blog and puts them into database"
  task seed_infakt: :environment do
    require 'rubygems'
    require 'nokogiri'
    require 'open-uri'

    puts "starting ..."

    limit       = 5
    offset      = 0
    fetch_posts = true
    errors      = []
    counters    = {}

    begin
      url      = "http://www.infakt.pl/blog/ajax-posts/?filter[limit]=#{limit}&filter[offset]=#{offset}"
      page     = Nokogiri::HTML("<html><body>#{open(url).read}</body></html>")
      articles = page.css('article')

      articles.each do |lead|
        begin
          params = {}
          params[:title] = lead.css('h2[itemprop="headline"]').text.strip

          begin
            Post.find(params[:title].parameterize)
            print '.'
            next
          rescue Mongoid::Errors::DocumentNotFound
          end
          # print "putting #{params[:title]} ... "

          first_name, last_name = lead.css('footer a[rel="author"]').first.text.strip.split(' ')
          params[:author] = User.where(
            first_name: first_name,
            last_name:  last_name,
            email:      "#{first_name}.#{last_name}@example.com".downcase
            ).first_or_initialize
          unless params[:author].persisted?
            params[:author].skip_password_validation = true
            params[:author].save!
            print 'u'
            counters[:user] = (counters[:user] || 0) + 1
          end

          params[:category] = Category.where(
            title: lead.css('p.post-meta-cat a[rel="category tag"]').first.text.strip
            ).first_or_initialize
          unless params[:category].persisted?
            params[:category].save!
            print 'c'
            counters[:category] = (counters[:category] || 0) + 1
          end

          params[:published_at] = Date.parse lead.css('footer time').first.attributes['datetime'].value

          full_article_url = lead.css('h2[itemprop="headline"] a').first.attributes['href'].value
          Nokogiri::HTML(open(full_article_url)).css('article').each do |article|
            body = article.css('.article-body').first.children
            params[:lead] = ''
            begin
              params[:lead] << body.shift.text.strip
            end while params[:lead].blank?
            params[:body] = body.to_html.strip
            params[:body] = params[:lead] if params[:body].blank?
            params[:tags] = article.css('dd[itemprop="keywords"] a').map(&:text)
          end

          Post.create!(params)
          print '+'
          counters[:post] = (counters[:post] || 0) + 1
        rescue Mongoid::Errors::Validations => e
          errors << e
          print 'F'
        end
      end

      fetch_posts = articles.any?
      offset += limit
    end while fetch_posts

    puts

    counters.each do |label, count|
      puts "#{label}: #{count} items imported"
    end

    if errors.any?
      puts "failed :-("
      errors.each { |error| puts error }
      exit 1
    else
      puts " all done :-)"
    end
  end
end
