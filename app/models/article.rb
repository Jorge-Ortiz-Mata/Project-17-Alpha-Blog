class Article < ApplicationRecord

    # --------------------------------------> ARTICLE Model. <------------------------------------------
    
    # ------------------------------ VALIDATIONS Section. -----------------------------------

    validates :title, presence: true
    validates :description, presence: true

    # ---------------------------------------------------------------------------------------
    # ------------------------------ ASOCIATIONS Section. -----------------------------------

    belongs_to :user
    has_many :article_categories
    has_many :categories, through: :article_categories
    # ---------------------------------------------------------------------------------------
end