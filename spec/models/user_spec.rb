require 'rails_helper'

describe User, :type => :model do

  before :each do
    @user_data = {
      name: 'Example User',
      email: 'user@example.com',
      password: 'foobar',
      password_confirmation: 'foobar'
    }
  end

  describe "UserModel" do
    it "should create a new instance, given valid attributes" do
      User.create!(@user_data)
    end

    # Empty strings provide a more realistic
    # simulation of the empty form situation

    it "should require a name" do
      anon_chan = User.new(@user_data.merge(name: ''))
      expect(anon_chan).to_not be_valid
    end

    it "should require an email" do
      anon_chan = User.new(@user_data.merge(email: ''))
      expect(anon_chan).to_not be_valid
    end

    # Probably need to add 3 such validations for F/M*/L format of names
    it "should reject names that are too long (larger than 48 chars)" do
      verbose_name = 'a' * 49
      verbose_name_user = User.new(@user_data.merge(name: verbose_name))
      expect(verbose_name_user).to_not be_valid
    end

    it "should accept valid email addresses" do
      emails = %w[
        user@example.org THE_DUDE@aBiD.eS
        hello@hatana.ne.jp first.last@something.fishy.net
      ]
        emails.each do |email|
          valid_email_user = User.new(@user_data.merge(email: email))
          expect(valid_email_user).to be_valid
        end
    end

    it "should reject invalid email addresses" do
      emails = %w[usr_at_goo.org so+you:think@you.can.dance
        holy;shit\ its@vip.er troll\[s\]{b}(t)=r@ll.in
      ]

      emails.each do |email|
        invalid_email_user = User.new(@user_data.merge(email: email))
        expect(invalid_email_user).to_not be_valid
      end
    end

    it "should reject duplicate email addresses" do
      User.create!(@user_data)
      dupe_usr = User.new(@user_data)
      expect(dupe_usr).to_not be_valid
    end

    it "should reject email addresses identical upto case" do
      User.create!(@user_data)
      upcase_usr = User.new(@user_data.merge(email: @user_data[:email].upcase))
      expect(upcase_usr).to_not be_valid
    end
  end

  describe "Passwords" do

    before :each do
      @user = User.new(@user_data)
    end

    it "should have a password attribute" do
      expect(@user).to respond_to(:password)
    end

    it "should have a password confirmation attribute" do
      expect(@user).to respond_to(:password_confirmation)
    end
  end

  describe "PasswordValidation" do

    it "should require a password field" do
      expect(User.new(
        @user_data.merge(password: "" , password_confirmation: "")
        )).to_not be_valid
    end

    it "should require a matching password confirmation" do
      expect(User.new(
        @user_data.merge(password_confirmation: "invalid")
        )).to_not be_valid
    end

    it "should reject short passwords" do
      short_pass = "a" * 5
      expect(User.new(
        @user_data.merge(password: short_pass, password_confirmation: short_pass)
        )).to_not be_valid
    end

    it "should reject long passwords" do
      long_pass = "a" * 49
      expect(User.new(
        @user_data.merge(password: long_pass, password_confirmation: long_pass)
        )).to_not be_valid
    end
  end

  describe "Encryption" do
    before :each do
      @user = User.create!(@user_data)
    end

    it "should have an encrypted password attribute" do
      expect(@user).to respond_to(:encrypted_password)
    end

    it "should set the encrypted_password attribute" do
      expect(@user.encrypted_password).to_not be_blank
    end

    it "should have a exist" do
      expect(@user).to respond_to(:salt)
    end

    describe "has_password? method" do
      it "should exist" do
        expect(@user).to respond_to(:has_password?)
      end

      it "should return true if passwords match" do
        expect(@user).to have_password(@user_data[:password])
      end

      it "should return false if passwords don't match" do
        expect(@user).to_not have_password("invalid")
      end
    end
  end

  describe "Authentication" do

    before :each do
      @user = User.create!(@user_data)
    end

    it "should exist" do
      expect(User).to respond_to(:authenticate)
    end

    # User types in a bad password
    it "should return nil on email -> password mismatch" do
      expect(User.authenticate(@user_data[:email], "totallynotthepassword")).to be_nil
    end

    # User forgets his/her email
    # Feature: return an EmailNotFoundError
    # to be caught and sent to /signup
    it "should return nil for invalid email ids" do
      expect(User.authenticate("does.not.exist@example.com", @user_data[:password])).to be_nil
    end

    it "should return the matched user with the given email on match" do
      expect(User.authenticate(@user_data[:email], @user_data[:password])).to eq(@user)
    end
  end
end


