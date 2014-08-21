require 'rails_helper'

describe UsersController, :type => :controller do
  render_views

  describe "GET 'new'" do
    it 'returns http success' do
      get :new
      expect(response).to be_success
    end

    it 'has the right title' do
      get :new
      #
      expect(response.body).to have_title("Sign up")
    end
  end

  describe "GET 'show'" do
    before :each do
      @user = FactoryGirl.create(:user)
    end

    it "returns http success" do
      get :show, id: @user.id
      expect(response).to be_success
    end

    it "should find the right user" do
      get :show, id: @user.id
      expect(assigns(:user)).to eq(@user)
    end

    it "should have the right title" do
      get :show, id: @user.id
      expect(response.body).to have_title(@user.name)
    end

    it "should have the user's name" do
      get :show, id: @user.id

      # Keep the match as strict as possible
      expect(response.body).to have_selector('h1', exact: @user.name)
    end

    it "should have a profile image" do
      get :show, id: @user.id
      expect(response.body).to have_selector('h1 > img.gravatar', match: :prefer_exact )
    end
  end
end
