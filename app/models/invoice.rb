class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :discounts, through: :merchants

  enum status: [:cancelled, 'in progress', :completed]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def discounted_items(merchant_id)
    invoice_items.joins(:discounts)
    .where(merchants: {id: merchant_id})
    .where("invoice_items.quantity >= discounts.item_quantity")
    .group(:id) #group by invoice_item ids to condense to be able to find all of the discounted items within the invoice_items
    .select("max(discounts.discount) AS max_discount, invoice_items.*")
  end

  def total_discounted_revenue(merchant_id)
    discounted_items(merchant_id).sum do |invoice_item|
      (invoice_item.unit_price - (invoice_item.unit_price * invoice_item.max_discount / 100)) * invoice_item.quantity
    end
  end

  def discounted_items_for_admin
    invoice_items.joins(:discounts)
    .where("invoice_items.quantity >= discounts.item_quantity")
    .group(:id)
    .select("max(discounts.discount) AS max_discount, invoice_items.*")
  end

  def total_discounted_revenue_for_admin
    discounted_items_for_admin.sum do |invoice_item|
      (invoice_item.unit_price - (invoice_item.unit_price * invoice_item.max_discount / 100)) * invoice_item.quantity
    end
  end
end
