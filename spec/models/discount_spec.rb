require 'rails_helper'

RSpec.describe Discount, type: :model do
  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:items).through(:merchant) }
    it { should have_many(:invoice_items).through(:items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:discount) }
    it { should validate_presence_of(:item_quantity) }
    it { should validate_numericality_of(:discount) }
    it { should validate_numericality_of(:item_quantity) }
  end
end
