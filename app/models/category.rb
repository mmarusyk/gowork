class Category < ApplicationRecord
  has_many :orders, dependent: :destroy
  validates :title, presence: true
end
