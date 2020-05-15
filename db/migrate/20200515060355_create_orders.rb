class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :title
      t.text :description
      t.text :skills
      t.string :city
      t.datetime :duedate
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
    add_index :orders, %i[user_id created_at]
    add_index :orders, %i[category_id created_at]
  end
end
