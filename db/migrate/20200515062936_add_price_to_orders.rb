class AddPriceToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :price, :decimal, precision: 8, scale: 0
  end
end
