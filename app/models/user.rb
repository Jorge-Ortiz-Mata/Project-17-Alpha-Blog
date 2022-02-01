class User < ApplicationRecord
    validates :username, presence: true, length: { minimum: 2, maximum: 25 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }
    has_many :articles, dependent: :destroy
    validates :password, presence: true
    validates :password_confirmation, presence: true
    has_secure_password
end