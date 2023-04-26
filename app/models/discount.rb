class Discount < ApplicationRecord
  belongs_to :merchant
  has_many :items, through: :merchant
  has_many :invoice_items, through: :items
  validates :discount, 
            :item_quantity, 
            numericality: true, 
            presence: true
end
