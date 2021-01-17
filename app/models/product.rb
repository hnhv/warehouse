class Product < ApplicationRecord
  has_many :product_articles
  has_many :articles, through: :product_articles
  validates_presence_of :name, :price

  def quantity_available
    self.articles.each do |article|
      # 
    end
  end
end
