class Article < ApplicationRecord
  has_many :product_articles
  has_many :products, through: :product_articles
  validates_presence_of :name, :quantity
end
