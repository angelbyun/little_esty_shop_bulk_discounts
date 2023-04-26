require 'rails_helper'

describe 'Admin Invoices Index Page' do
  before :each do
    @m1 = Merchant.create!(name: 'Merchant 1')

    @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @m1.id, status: 1)
    @item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @m1.id)

    @c1 = Customer.create!(first_name: 'Yo', last_name: 'Yoz')
    @c2 = Customer.create!(first_name: 'Hey', last_name: 'Heyz')

    @i1 = Invoice.create!(customer_id: @c1.id, status: 2)
    @i2 = Invoice.create!(customer_id: @c1.id, status: 2)
    @i3 = Invoice.create!(customer_id: @c2.id, status: 2)
    @i4 = Invoice.create!(customer_id: @c2.id, status: 2)

    @ii_11 = InvoiceItem.create!(invoice_id: @i1.id, item_id: @item_8.id, quantity: 12, unit_price: 5, status: 1)
    @ii_12 = InvoiceItem.create!(invoice_id: @i1.id, item_id: @item_1.id, quantity: 16, unit_price: 10, status: 1)
    @ii_13 = InvoiceItem.create!(invoice_id: @i1.id, item_id: @item_8.id, quantity: 25, unit_price: 5, status: 1)
  end

  it 'should list all invoice ids in the system as links to their show page' do
    visit admin_invoices_path

    expect(page).to have_link("Invoice ##{@i1.id}")
    expect(page).to have_link("Invoice ##{@i2.id}")
    expect(page).to have_link("Invoice ##{@i3.id}")
    expect(page).to have_link("Invoice ##{@i4.id}")
  end
end
