module ApplicationHelper
  BASE_TITLE = "Sample App"

  # Return a title on a per-page basis
  def title
    if @title.nil?
      BASE_TITLE
    else
      "#{BASE_TITLE} | #{@title}"
    end
  end

  # Return the site's logo as a HTML element.
  # Short and sweet
  def logo
    image_tag('rubyLogo.gif', alt: 'Ruby on Rails Sample App', class: 'round', height: "50px")
  end
end
