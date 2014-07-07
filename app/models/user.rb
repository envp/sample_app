class User < ActiveRecord::Base
  # Strong parameters in the model take
  # care of whitelisting our mass asignment

  # Must decode this magic
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name,  presence: true,
                    length: { maximum: 48 }
  validates :email, presence: true,
                    format: { with: EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
end
