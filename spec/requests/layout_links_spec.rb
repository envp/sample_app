require 'rails_helper'

describe "LayoutLinks", :type => :request do

  before :each do
    @base_title = ApplicationHelper::BASE_TITLE
  end

  it "should have a Home page at '/'" do
    visit '/'
    expect(page).to have_title("#{@base_title} | Home")
  end

  it "should have a Contact page at '/contact'" do
    visit '/contact'
    expect(page).to have_title("#{@base_title} | Contact Us")
  end

  it "should have an About page at '/about'" do
    visit '/about'
    expect(page).to have_title("#{@base_title} | About Us")
  end

  it "should have a Help page at '/help'" do
    visit '/help'
    expect(page).to have_title("#{@base_title} | Help")
  end

  describe "Logo link" do

    before :each do
      @testcases = ['/', '/about', '/contact', '/help']
    end

    it "should be a#logo element containing an img" do
      visit @testcases.fetch(rand(@testcases.size))
      expect(page).to have_css('a#logo img')
    end

    it "should redirect to '/' on clicking the logo" do
      visit '/'
      page_from_visit = page

      visit @testcases.fetch(rand(@testcases.size))
      click_link('logo')
      expect(page).to have_title("#{@base_title} | Home")
      page_from_click = page

      expect(page_from_click).to eq(page_from_visit)
    end
  end
end
