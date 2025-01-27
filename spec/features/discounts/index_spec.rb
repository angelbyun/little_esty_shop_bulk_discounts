require 'rails_helper'

RSpec.describe "discounts index" do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')

    @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
    @customer_2 = Customer.create!(first_name: 'Cecilia', last_name: 'Jones')
    @customer_3 = Customer.create!(first_name: 'Mariah', last_name: 'Carrey')
    @customer_4 = Customer.create!(first_name: 'Leigh Ann', last_name: 'Bron')
    @customer_5 = Customer.create!(first_name: 'Sylvester', last_name: 'Nader')
    @customer_6 = Customer.create!(first_name: 'Herber', last_name: 'Kuhn')

    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2)
    @invoice_2 = Invoice.create!(customer_id: @customer_1.id, status: 2)
    @invoice_3 = Invoice.create!(customer_id: @customer_2.id, status: 2)
    @invoice_4 = Invoice.create!(customer_id: @customer_3.id, status: 2)
    @invoice_5 = Invoice.create!(customer_id: @customer_4.id, status: 2)
    @invoice_6 = Invoice.create!(customer_id: @customer_5.id, status: 2)
    @invoice_7 = Invoice.create!(customer_id: @customer_6.id, status: 1)

    @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id)
    @item_2 = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 8, merchant_id: @merchant1.id)
    @item_3 = Item.create!(name: "Brush", description: "This takes out tangles", unit_price: 5, merchant_id: @merchant1.id)
    @item_4 = Item.create!(name: "Hair tie", description: "This holds up your hair", unit_price: 1, merchant_id: @merchant1.id)

    @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 0)
    @ii_2 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 1, unit_price: 8, status: 0)
    @ii_3 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_3.id, quantity: 1, unit_price: 5, status: 2)
    @ii_4 = InvoiceItem.create!(invoice_id: @invoice_3.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)
    @ii_5 = InvoiceItem.create!(invoice_id: @invoice_4.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)
    @ii_6 = InvoiceItem.create!(invoice_id: @invoice_5.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)
    @ii_7 = InvoiceItem.create!(invoice_id: @invoice_6.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)

    @transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_1.id)
    @transaction2 = Transaction.create!(credit_card_number: 230948, result: 1, invoice_id: @invoice_3.id)
    @transaction3 = Transaction.create!(credit_card_number: 234092, result: 1, invoice_id: @invoice_4.id)
    @transaction4 = Transaction.create!(credit_card_number: 230429, result: 1, invoice_id: @invoice_5.id)
    @transaction5 = Transaction.create!(credit_card_number: 102938, result: 1, invoice_id: @invoice_6.id)
    @transaction6 = Transaction.create!(credit_card_number: 879799, result: 1, invoice_id: @invoice_7.id)
    @transaction7 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_2.id)

    @discount1 = Discount.create!(item_quantity: 10, discount: 20, merchant: @merchant1)
    @discount2 = Discount.create!(item_quantity: 15, discount: 30, merchant: @merchant1)
    @discount3 = Discount.create!(item_quantity: 20, discount: 40, merchant: @merchant1)
  end

  describe "As a merchant when I visit the discounts index page" do
    it 'displays all discounts including the percentage discount and quantity threshold' do
      visit "/merchant/#{@merchant1.id}/discounts"

      expect(page).to have_content(@discount1.item_quantity)
      expect(page).to have_content(@discount1.discount)
      expect(page).to have_content(@discount2.item_quantity)
      expect(page).to have_content(@discount2.discount)
      expect(page).to have_content(@discount3.item_quantity)
      expect(page).to have_content(@discount3.discount)
    end

    it 'creates a link to each discount listed to the merchant discount show page' do
      visit "/merchant/#{@merchant1.id}/discounts"
      
      within "#discount-#{@discount1.id}" do
        click_link("Discount Information")
      end
      
      expect(current_path).to eq("/merchant/#{@merchant1.id}/discounts/#{@discount1.id}")
      visit "/merchant/#{@merchant1.id}/discounts"

      within "#discount-#{@discount2.id}" do
        click_link("Discount Information")
      end

      expect(current_path).to eq("/merchant/#{@merchant1.id}/discounts/#{@discount2.id}")
      visit "/merchant/#{@merchant1.id}/discounts"

      within "#discount-#{@discount3.id}" do
        click_link("Discount Information")
      end

      expect(current_path).to eq("/merchant/#{@merchant1.id}/discounts/#{@discount3.id}")
      visit "/merchant/#{@merchant1.id}/discounts"
    end

    it 'creates a link to create a new discount' do
      visit "/merchant/#{@merchant1.id}/discounts"
      
      click_link("New Discount")

      expect(current_path).to eq("/merchant/#{@merchant1.id}/discounts/new")
    end

    it 'displays upcoming holidays header with name and date of of next 3 upcoming holidays' do
      visit "/merchant/#{@merchant1.id}/discounts"

      expect(page).to have_content("Upcoming Holidays")
      expect(page).to have_content("Memorial Day 2023-05-29")
      expect(page).to have_content("Juneteenth 2023-06-19")
      expect(page).to have_content("Independence Day 2023-07-04")
    end
  end
end