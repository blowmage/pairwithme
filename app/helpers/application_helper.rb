module ApplicationHelper
  def avatar_url user
    "http://gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email.downcase)}.png?s=512"
  end
end
