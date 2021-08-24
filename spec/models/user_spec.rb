require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'Validations' do

    # password and confirmation of password
    it 'is not valid when with password and password_confirmation fields unmatched' do
      @user = User.new(first_name: 'Amy', last_name: "White", password: "12345", password_confirmation: "2345", email: "amy@mail.com")
      expect(@user).to_not be_valid
    end
    
    it 'is not valid when with both password and password_confirmation field with nil value' do
      @user = User.new(first_name: 'Amy', last_name: "White", password: nil, password_confirmation: nil, email: "amy@mail.com")
      expect(@user).to_not be_valid
    end

    # email uniqueness
    it 'is not valid with email matching an exisiting email, no case sensitive ' do
      @user1 = User.new(first_name: 'Amy', last_name: "White", password: "12345", password_confirmation: "12345", email: "amy@mail.com")
      @user1.save!
      @user2 = User.new(first_name: 'Amy', last_name: "White", password: "12345", password_confirmation: "12345", email: "amy@mail.com")
      expect(@user2).to_not be_valid
      @user3 = User.new(first_name: 'Amy', last_name: "White", password: "12345", password_confirmation: "12345", email: "AMY@MAIL.COM")
      expect(@user3).to_not be_valid
    end

    #first_name is required
    it 'is not valid for first_name with nil value' do
      @user = User.new(first_name: nil, last_name: "White", password: "12345", password_confirmation: "12345", email: "amy@mail.com")
      expect(@user).to_not be_valid
    end

    it 'is valid for first_name with string input' do
      @user = User.new(first_name: "Amy", last_name: "White", password: "12345", password_confirmation: "12345", email: "bob@mail.com")
      expect(@user).to be_valid
    end
    
    # last_name is required
    it 'is not valid for last_name with nil value' do
      @user = User.new(first_name: "Amy", last_name: nil, password: "12345", password_confirmation: "12345", email: "bob@mail.com")
      expect(@user).to_not be_valid
    end

    it 'is valid for last_name with string input' do
      @user = User.new(first_name: "Amy", last_name: "White", password: "12345", password_confirmation: "12345", email: "bob@mail.com")
      expect(@user).to be_valid
    end

    # password min length
    it 'is not valid with password length less 3' do
      @user = User.new(first_name: "Amy", last_name: "White", password: "12", password_confirmation: "12", email: "bob@mail.com")
      expect(@user).to_not be_valid
    end

  end

  describe '.authenticate_with_credentials' do
    # the way to avoid the repeating user1 information setting up. call before each
    before(:each) do 
      @user1 = User.new(first_name: 'Amy', last_name: "White", password: "12345", password_confirmation: "12345", email: "amy@mail.com")
      @user1.save!
    end
    it 'is valid with user login input matchs the database records ' do
      expect(User.authenticate_with_credentials("amy@mail.com", "12345")).to eq(@user1)
    end

    it 'is not valid with user login input doesnt match the database records for email ' do
      expect(User.authenticate_with_credentials("bob@mail.com", "12345")).to eq(nil)
    end

    it 'is not valid with user login input doesnt match the database records for email ' do
      expect(User.authenticate_with_credentials("amy@mail.com", "123456789")).to eq(nil)
    end

  # edge case blank space 
    it 'is valid with user login input email with blank space before and after ' do
      expect(User.authenticate_with_credentials(" amy@mail.com ", "12345")).to eq(@user1)
     
    end
    it 'is valid with user login input email with blank space before ' do
      expect(User.authenticate_with_credentials(" amy@mail.com", "12345")).to eq(@user1)
    end
    it 'is valid with user login input email with blank space after ' do
      expect(User.authenticate_with_credentials("amy@mail.com ", "12345")).to eq(@user1)
    end


  # edge case --case not sensitive
    it 'is valid with user login input email with no case sensitive' do
      expect(User.authenticate_with_credentials("AmY@MaiL.COM", "12345")).to eq(@user1)
    end
  end
end


