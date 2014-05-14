class Post
  include Mongoid::Document
  # include Mongoid::Versioning
  include Mongoid::Timestamps

  field :_id,   type: String, default: -> { title.parameterize }
  field :title, type: String
  field :lead,  type: String
  field :body,  type: String

  field :published_at, type: Time

  validates :title, :body, presence: true
end
