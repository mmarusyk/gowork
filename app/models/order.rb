class Order < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :proposals, dependent: :destroy
  default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true
  validates :category_id, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 5000 }
  validates :city, presence: true
  validates :price, presence: true
end
