class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, #:registerable,
         :recoverable, :rememberable, :trackable #, :validatable

  ## Database authenticatable
  field :_id,                type: String, default: -> { "#{first_name} #{last_name}".parameterize }
  field :first_name,         type: String
  field :last_name,          type: String
  field :email,              type: String
  field :encrypted_password, type: String, default: ''

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  validates :first_name, :last_name, :email, presence: true
  validates :password, presence: true unless :skip_password_validation

  has_many :posts

  after_save :skip_password_validation_reset!

  scope :authors, -> { where(:id.in => Post.pluck(:author) ) }

  attr_accessor :skip_password_validation

  def humanize
    "#{first_name} #{last_name}"
  end

  def operations(group = nil)
    User::Operations.new self, group
  end

  private

  def skip_password_validation_reset!
    @skip_password_validation = false
  end

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time
end
