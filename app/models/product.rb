class Product < ApplicationRecord
  has_many :product_articles
  has_many :articles, through: :product_articles
  
  validates_presence_of :name
  validates_uniqueness_of :name
  
  attribute :available, :boolean
  
  def available?
    product_articles.each do |product_article|
      return false unless product_article.available?
    end
    true
  end

  def available
    available?
  end
end
