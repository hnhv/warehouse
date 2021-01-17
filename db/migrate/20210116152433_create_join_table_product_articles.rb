class CreateJoinTableProductArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :product_articles do |t|
      t.references :product, foreign_key: true
      t.references :article, foreign_key: true
    end
  end
end
