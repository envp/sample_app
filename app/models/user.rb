require 'digest'

class User < ActiveRecord::Base
  # Strong parameters in the model take
  # care of whitelisting our mass asignment

  attr_accessor :password
  # Must decode this magic
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name,
    presence: true,
    length: { maximum: 48 }

  validates :email, presence: true,
    format: { with: EMAIL_REGEX },
    uniqueness: { case_sensitive: false }

  validates :password,
    presence: true,
    confirmation: true,
    length: { within: 6..48 }


  before_save :encrypt_password

  def has_password?(submission)
    # Store salt only once
    self.encrypted_password == encrypt(submission)
  end

  class << self
    def authenticate(email, submitted_password)
      user = find_by_email(email)

      # No user exists in db
      return nil if user.nil?

      # Hit only if user has
      return user if user.has_password?(submitted_password)
    end
  end
  private

  def encrypt_password
    self.salt = make_salt if self.new_record?
    self.encrypted_password = encrypt(password)
  end

  def encrypt(data)
    secure_hash("#{self.salt}--#{data}")
  end

  def secure_hash(data)
    Digest::SHA2.hexdigest(data)
  end

  def make_salt
    secure_hash("#{Time.now.utc}--#{self.password}")
  end

end
