require 'rails_helper'

describe "PagesController" do

  describe "Home Page" do
    it "returns http success" do
      visit '/pages/home'
      expect(response).to be_success
    end

    # Test for title in home page
    it "has the correct page title" do
      visit '/pages/home'
      expect(page).to have_title("Sample App | Home")
    end

  end

  describe "About Page" do
    it "returns http success" do
      visit '/pages/about'
      expect(response).to be_success
    end

    it "has the correct page title" do
      visit '/pages/about'
      expect(page).to have_title("Sample App | About Us")
    end
  end

  describe "Contacts Page" do
    it "returns http success" do
      visit '/pages/contact'
      expect(response).to be_success
    end

    it "has the correct page title" do
      visit '/pages/contact'
      expect(page).to have_title("Sample App | Contact Us")
    end
  end
end
