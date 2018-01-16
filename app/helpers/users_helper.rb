module UsersHelper
  def gravatar_for user, _size: Settings.user.gravatar_size.default
    gravatar_id = Digest::MD5.hexdigest user.email.downcase
    gravatar_url = Settings.user.url.gravatar + gravatar_id
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
