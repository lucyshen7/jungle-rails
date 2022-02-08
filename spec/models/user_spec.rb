require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    it "should create a new user with email, first name and last name fields filled out and matching password and password_confirmation fields" do

      @user = User.create(first_name: 'John', last_name: 'Smith', email: 'test@test.com', password: 'helloworld123', password_confirmation: 'helloworld123')

      expect(@user.valid?).to be true
      expect(@user.password).to eql(@user.password_confirmation)
      expect(@user.errors.full_messages.count).to be 0
    end

    it "should not create a new user if the password and password_confirmation fields do not match" do
      @user = User.create(first_name: 'John', last_name: 'Smith', email: 'test@test.com', password: 'helloworld123', password_confirmation: 'helloworld12')

      expect(@user.valid?).to be false
      expect(@user.password).to_not eql(@user.password_confirmation)
      expect(@user.errors.full_messages.count).to be 1
      puts @user.errors.full_messages
    end

    it "should not create a new user if the password and password_confirmation fields do not match" do      
      @user = User.create(first_name: 'John', last_name: 'Smith', email: 'johnsmith@test.com', password: 'helloworld123', password_confirmation: 'helloworld12')

      expect(@user.valid?).to be false
      expect(@user.password).to_not eql(@user.password_confirmation)
      expect(@user.errors.full_messages.count).to be 1
      puts @user.errors.full_messages
    end  


    it "should not create a new user if the email is not unique" do
      @user = User.create(first_name: 'John', last_name: 'Smith', email: 'test@test.com', password: 'helloworld123', password_confirmation: 'helloworld123')

      @user2 = User.create(first_name: 'Alice', last_name: 'Bob', email: 'TEST@TEST.com', password: 'hello123', password_confirmation: 'hello123')

      expect(@user2.valid?).to be false
      expect(@user2.errors.full_messages.count).to be 1
      puts @user2.errors.full_messages
    end  

    it "should not create a new user if the password does not meet the minimum length" do
      @user = User.create(first_name: 'John', last_name: 'Smith', email: 'test@test.com', password: '123', password_confirmation: '123')

      expect(@user.valid?).to be false
      expect(@user.errors.full_messages.count).to be 1
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 5 characters)")
    end  
  end

  describe '.authenticate_with_credentials' do
    it "should not authenticate (login) user if the password does not match" do
      @user = User.create(first_name: 'John', last_name: 'Smith', email: 'good@bye.com', password: 'hello123', password_confirmation: 'hello123')

      expect(User.authenticate_with_credentials('good@bye.com', 'hello12')).to be nil
    end
    
    it "should authenticate user if the password does match" do
      @user = User.create(first_name: 'John', last_name: 'Smith', email: 'good@bye.com', password: 'hello123', password_confirmation: 'hello123')

      expect(User.authenticate_with_credentials('good@bye.com', 'hello123')).to eq(@user)
    end  

    it "should authenticate user if the password matches and the visitor types spaces before and/or after their email address" do
      @user = User.create(first_name: 'John', last_name: 'Smith', email: 'good@bye.com', password: 'hello123', password_confirmation: 'hello123')

      expect(User.authenticate_with_credentials(' good@bye.com ', 'hello123')).to eq(@user)
    end  

    it "should authenticate user if the password matches and the visitor types in the wrong case for their email" do
      @user = User.create(first_name: 'John', last_name: 'Smith', email: 'GOOD@bye.com', password: 'hello123', password_confirmation: 'hello123')

      expect(User.authenticate_with_credentials('good@BYE.COM', 'hello123')).to eq(@user)
    end  
  end
end

