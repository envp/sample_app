require 'rails_helper'

describe "PagesController", :type => :controller do
  render_views

  before :each do
    @base_title = ApplicationHelper::BASE_TITLE
  end

  describe "Home Page" do
    it "returns http success" do
      visit '/'
      expect(response).to be_success
    end

    # Test for title in home page
    it "has the correct page title" do
      visit '/'
      expect(page).to have_title("#{@base_title} | Home")
    end

  end

  describe "About Page" do
    it "returns http success" do
      visit '/about'
      expect(response).to be_success
    end

    it "has the correct page title" do
      visit '/about'
      expect(page).to have_title("#{@base_title} | About Us")
    end
  end

  describe "Contacts Page" do
    it "returns http success" do
      visit '/contact'
      expect(response).to be_success
    end

    it "has the correct page title" do
      visit '/contact'
      expect(page).to have_title("#{@base_title} | Contact Us")
    end
  end


  describe "Help Page" do
    it "returns http success" do
      visit '/help'
      expect(response).to be_success
    end

    it "has the correct page title" do
      visit '/help'
      expect(page).to have_title("#{@base_title} | Help")
    end
  end

end
