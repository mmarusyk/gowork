class CreateResponses < ActiveRecord::Migration[6.0]
  def change
    create_table :responses do |t|
      t.integer :score
      t.text :content
      t.references :proposal, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
    add_index :responses, [:user_id, :created_at]
    add_index :responses, [:proposal_id, :created_at] 
  end
end
