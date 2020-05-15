class CreateProposals < ActiveRecord::Migration[6.0]
  def change
    create_table :proposals do |t|
      t.text :content
      t.decimal :price
      t.datetime :duedate
      t.references :user, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
    add_index :proposals, %i[user_id created_at]
    add_index :proposals, %i[order_id created_at]
  end
end
