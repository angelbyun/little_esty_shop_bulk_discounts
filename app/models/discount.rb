class Discount < ApplicationRecord
  belongs_to :merchant
  validates :discount, 
            :item_quantity, 
            numericality: true, 
            presence: true
end
