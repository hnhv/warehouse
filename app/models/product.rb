class Product < ApplicationRecord
  has_many :product_articles
  has_many :articles, through: :product_articles

  validates_presence_of :name
  validates_uniqueness_of :name

  attribute :quantity_available, :integer

  def quantity_available
    product_articles.map(&:stock_available_for_products).min
  end

  def remove!
    raise InsufficientStock unless quantity_available > 0

    product_articles.each do |product_article|
      product_article.article.remove_stock!(product_article.quantity)
    end
  end

  class InsufficientStock < StandardError; end
end
