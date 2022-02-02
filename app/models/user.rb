class User < ApplicationRecord

    # --------------------------------------> ARTICLE Model. <------------------------------------------

    # ------------------------------ CONSTANTS Section. -----------------------------------
    
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    # ---------------------------------------------------------------------------------------
    # ------------------------------ VALIDATIONS  Section. -----------------------------------

    validates :username, presence: true, length: { minimum: 2, maximum: 25 }
    validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }
    validates :password, presence: true
    validates :password_confirmation, presence: true

    # ---------------------------------------------------------------------------------------
    # ------------------------------ SECURE PASSWORD Section. -----------------------------------

    has_secure_password

    # ---------------------------------------------------------------------------------------
    # ------------------------------ ASOCIATIONS Section. -----------------------------------

    has_many :articles, dependent: :destroy

    # ---------------------------------------------------------------------------------------
end