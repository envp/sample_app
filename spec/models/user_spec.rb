require 'rails_helper'

describe User, :type => :model do

  before :each do
    @user_data = { name: 'Example User', email: 'user@example.com' }
  end

  it "should create a new instance, given valid attributes" do
    User.create!(name: 'Example User', email: 'user@example.com')
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


