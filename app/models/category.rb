class Category
  include Mongoid::Document

  has_many :posts, dependent: :destroy

  field :_id,   type: String, default: -> { "#{title}".parameterize }
  field :title, type: String

  validates :title, presence: true

  scope :ordered, -> { order_by :title.asc }

  def posts_count
    posts.published.count
  end

  def humanize
    "#{title}"
  end

  def operations(group = nil)
    Category::Operations.new self, group
  end
end
