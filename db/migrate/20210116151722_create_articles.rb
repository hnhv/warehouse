class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.string :name
      t.integer :quantity

      t.timestamps
    end
  end
end
