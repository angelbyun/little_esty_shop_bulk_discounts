require 'rails_helper'

RSpec.describe BundleDiscount, type: :model do
  describe 'relationships' do
    it { should belong_to(:merchant) }
  end
end
