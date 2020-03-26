module ApplicationHelper

  # Any method that needs to be used in your views can be listed here in the ApplicationHelper.

  # gravatar is a service to profide a profile picture.
  # Pss in the user and a specific size or the default 80.
  def gravatar_for(user, options = { size: 80})
    # Set the gravatar id to the proper format.
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    # Set the size attribute for this url
    size = options[:size]
    # Set the gravatar url according to gravatars specs.
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    # create an image tag based on all the given information.
    image_tag(gravatar_url, alt: user.username, class: "img-circle")
  end
end
