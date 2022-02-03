class Category < ApplicationRecord
    validates :name, presence: true, length: { minimum: 6, maximum: 25 }, uniqueness: true
    has_many :article_categories
    has_many :articles, through: :article_categories
end