class Category
  include Mongoid::Document

  has_many :posts

  field :_id,   type: String, default: -> { "#{title}".parameterize }
  field :title, type: String

  validates :title, presence: true

  delegate :count, to: :posts, prefix: true

  def humanize
    "#{title}"
  end

  def operations(group = nil)
    Category::Operations.new self, group
  end
end
