require 'rails_helper'

RSpec.describe Product, type: :model do

  describe 'Validations' do
    it 'is valid with valid attributes' do
      @category = Category.new(name: 'Apparel')
      @product = Product.new(name: 'Blazer', price: 300, quantity: 15, category: @category)
      expect(@category).to be_valid
      expect(@product).to be_valid
    end
    
    it 'is not vaild for name with nil value' do
    @product = Product.new(name: nil, price: nil, quantity: 15, category: @category)
    expect(@product).to_not be_valid
    end

    it 'is not vaild for price with nil value' do
      @product = Product.new(name: 'Blazer', price: nil, quantity: 15, category: @category)
      expect(@product).to_not be_valid
    end

    it 'is not vaild for quantity with nil value' do
      @product = Product.new(name: 'Blazer', price: nil, quantity: nil, category: @category)
      expect(@product).to_not be_valid
    end

    it 'is not vaild for category with nil value' do
      @product = Product.new(name: 'Blazer', price: nil, quantity: 15, category: nil)
      expect(@product).to_not be_valid
    end

  end

end
