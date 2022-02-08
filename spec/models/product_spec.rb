require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here

    it "should save product with all four fields filled" do
      @category = Category.create(name: 'Books')

      @product = Product.new
      @product.name = 'Sapiens'
      @product.price = 50
      @product.quantity = 3
      @product.category_id = @category.id
      @product.save

      expect(@product.valid?).to be true
      expect(@product.errors.full_messages.count).to be 0

      puts @product.errors.full_messages

    end

    it "should not save product without a name" do
      @category = Category.create(name: 'Books')

      @product = Product.new
      @product.name = nil
      @product.price = 50
      @product.quantity = 3
      @product.category_id = @category.id
      @product.save
  
      expect(@product.valid?).to be false
      expect(@product.errors.full_messages).to include "Name can't be blank"

      puts @product.errors.full_messages

    end

    it "should not save product without a price" do
      @category = Category.create(name: 'Books')

      @product = Product.new
      @product.name = "Sapiens"
      @product.price = nil
      @product.quantity = 3
      @product.category_id = @category.id
      @product.save
  
      expect(@product.valid?).to be false
      expect(@product.errors.full_messages).to include "Price can't be blank"

      puts @product.errors.full_messages

    end

    it "should not save product without a quantity" do
      @category = Category.create(name: 'Books')

      @product = Product.new
      @product.name = "Sapiens"
      @product.price = 50
      @product.quantity = nil
      @product.category_id = @category.id
      @product.save
  
      expect(@product.valid?).to be false
      expect(@product.errors.full_messages).to include "Quantity can't be blank"

      puts @product.errors.full_messages

    end


    it "should not save product without a category" do

      @product = Product.new
      @product.name = "Sapiens"
      @product.price = 50
      @product.quantity = 3
      @product.category_id = nil
      @product.save
  
      expect(@product.valid?).to be false
      expect(@product.errors.full_messages).to include "Category can't be blank"

      puts @product.errors.full_messages
      
    end
  end
end