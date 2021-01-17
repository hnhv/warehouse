class Product < ApplicationRecord
  has_many :product_articles
  has_many :articles, through: :product_articles
  
  validates_presence_of :name
  validates_uniqueness_of :name
  
  attribute :quantity_available, :integer
  
  def quantity_available
    product_articles.map(&:stock_available_for_products).min
  end
end
