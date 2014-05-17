class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :post

  field :author, type: String
  field :body,   type: String

  validates :author, :body, presence: true

  scope :ordered, -> { order_by :created_at.desc }
end
