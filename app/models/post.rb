class Post
  include Mongoid::Document
  # include Mongoid::Versioning
  include Mongoid::Timestamps
  include Mongoid::Document::Taggable

  belongs_to :author, class_name: 'User'
  belongs_to :category

  field :_id,   type: String, default: -> { "#{title}".parameterize }
  field :title, type: String
  field :lead,  type: String
  field :body,  type: String

  field :published_at, type: Time

  validates :title, :body, :category_id, presence: true

  def tags=(value)
    value = value.split(',').map(&:strip) if value.is_a?(String)
    self[:tags] = value
  end

  def humanize
    "#{title}"
  end

  def operations(group = nil)
    Post::Operations.new self, group
  end
end
