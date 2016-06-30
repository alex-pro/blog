class User < ActiveRecord::Base
  has_many :articles

  has_many :friendships
  has_many :friends, :through => :friendships

  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  has_many :comments
  has_one :profile

  attr_accessor :password

  before_save :encrypt_password
  after_create :default_profile

  validates :password, :email, :password_confirmation, presence: true
  validates :password, confirmation: true
  validates :email, uniqueness: true

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  private

  def encrypt_password
    if self.password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(self.password, self.password_salt)
    end
  end

  def default_profile
    self.create_profile
  end
end
