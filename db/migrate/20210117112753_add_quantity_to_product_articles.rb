class AddQuantityToProductArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :product_articles, :quantity, :integer
  end
end
