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
end
