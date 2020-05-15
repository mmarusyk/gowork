class Order < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  belongs_to :category
  validates :user_id, presence: true
  validates :category_id, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :city, presence: true
  validates :price, presence: true
end
