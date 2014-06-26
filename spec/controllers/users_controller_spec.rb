require 'rails_helper'

describe UsersController, :type => :controller do

  describe "New user creation page" do
    it "returns http success" do
      get 'new'
      expect(response).to be_success
    end
  end

end
