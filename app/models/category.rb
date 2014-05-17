class Category
  include Mongoid::Document

  has_many :posts

  field :_id,   type: String, default: -> { title.parameterize }
  field :title, type: String

  validates :title, presence: true

  def humanize
    "#{title}"
  end
end
