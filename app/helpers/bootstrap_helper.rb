module BootstrapHelper
  def bootstrap_flash_class(level)
    [:alert].tap do |list|
      list << case level.to_s
      when 'notice'
        :'alert-info'
      when 'success'
        :'alert-success'
      when 'error'
        :'alert-danger'
      when 'alert'
        :'alert-warning'
      end
    end.compact.join ' '
  end

  def icon(*icons, text)
    icons.map!{ |icon| "fa-#{icon}" }
    icons << :fa << :'fa-fw'
    tag = content_tag(:i, nil, class: icons.join(' '))
    "#{tag} #{text}".html_safe
  end

  def content_for_message(level, &block)
    content_tag(:div, nil, class: bootstrap_flash_class(level), &block)
  end
end
