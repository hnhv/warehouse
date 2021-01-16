class CreateJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_join_table :Articles, :Products do |t|
      # t.index [:article_id, :product_id]
      # t.index [:product_id, :article_id]
    end
  end
end
