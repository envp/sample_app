require 'rails_helper'

describe UsersController, :type => :controller do
  render_views

  describe "New user creation page" do
    it 'returns http success' do
      get 'new'
      expect(response).to be_success
    end

    it 'has the right title' do
      get 'new'
      #
      expect(response.body).to have_title("Sign up")
    end

  end

end
