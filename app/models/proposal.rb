class Proposal < ApplicationRecord
  belongs_to :user
  belongs_to :order
  default_scope -> { order(created_at: :desc) } 
  validates :user_id, presence: true
  validates :order_id, presence: true
  validates :content, length: { maximum: 5000 }
  validates :price, presence: true, numericality: {message: 'є неправильним значенням' }
  validates_datetime :duedate, on_or_after: lambda { Time.current }
end
