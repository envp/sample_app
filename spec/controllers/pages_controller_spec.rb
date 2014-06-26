require 'rails_helper'

describe PagesController, :type => :controller do
  render_views

  before :each do
    @base_title = ApplicationHelper::BASE_TITLE
  end

  describe "Home Page" do
    it "returns http success" do
      get 'home'
      expect(response).to be_success
    end

    # Test for title in home page
    it "has the correct page title" do
      get 'home'
      expect(response.body).to have_title("#{@base_title} | Home")
    end

  end

  describe "About Page" do
    it "returns http success" do
      get 'about'
      expect(response).to be_success
    end

    it "has the correct page title" do
      get 'about'
      expect(response.body).to have_title("#{@base_title} | About Us")
    end
  end

  describe "Contacts Page" do
    it "returns http success" do
      get 'contact'
      expect(response).to be_success
    end

    it "has the correct page title" do
      get 'contact'
      expect(response.body).to have_title("#{@base_title} | Contact Us")
    end
  end


  describe "Help Page" do
    it "returns http success" do
      get 'help'
      expect(response).to be_success
    end

    it "has the correct page title" do
      get 'help'
      expect(response.body).to have_title("#{@base_title} | Help")
    end
  end

end
