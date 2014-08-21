module UsersHelper

  def gravatar_image(user, opts = {size: 50})
    gravatar_image_tag user.email.downcase,
      :alt => user.name,
      :class => 'gravatar',
      :gravatar => opts
  end
end
