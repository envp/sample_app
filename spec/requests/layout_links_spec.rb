require 'rails_helper'

describe "LayoutLinks", :type => :request do

  before :each do
    @base_title = ApplicationHelper::BASE_TITLE
  end

  it "has a Home page at '/'" do
    visit '/'
    expect(page).to have_title("#{@base_title} | Home")
  end

  it "has a Contact page at '/contact'" do
    visit '/contact'
    expect(page).to have_title("#{@base_title} | Contact Us")
  end

  it "has an About page at '/about'" do
    visit '/about'
    expect(page).to have_title("#{@base_title} | About Us")
  end

  it "has a Help page at '/help'" do
    visit '/help'
    expect(page).to have_title("#{@base_title} | Help")
  end

  describe "Logo link" do

    before :each do
      @testcases = [root_path, about_path, contact_path, help_path]
    end

    it "has the logo image in an anchor to '/'" do
      visit @testcases.fetch(rand(@testcases.size))
      expect(page).to have_css("a[href='/'] > img")
    end

    it "redirects to '/' on clicking the logo img" do
      visit '/'
      page_from_visit = page

      visit @testcases.fetch(rand(@testcases.size))
      click_link('logo')
      page_from_click = page

      expect(page_from_click).to eq(page_from_visit)
    end

    it "has a signup page at /signup" do
      visit '/signup'
      expect(page).to have_title("Sign up")
    end

    it "has the right links on the layout" do
      visit root_path
      expect(page).to have_title('Home')

      click_link 'About'
      expect(page).to have_title('About')

      click_link 'Contact'
      expect(page).to have_title('Contact')

      click_link 'Help'
      expect(page).to have_title('Help')

      click_link 'Home'
      expect(page).to have_title('Home')

      click_link 'Sign up now!'
      expect(page).to have_title('Sign up')

    end

  end
end
