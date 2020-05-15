class Category < ApplicationRecord
  has_one :orders, dependent: :destroy
  validates :title, presence: true
end
