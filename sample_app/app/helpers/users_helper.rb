module UsersHelper
  def gravatar_for user, options = {size: Settings.gravatar.size}
    gravatar_id = Digest::MD5::hexdigest user.email.downcase
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag gravatar_url, alt: user.name, class: "gravatar"
  end

  def number_microposts user
    return user.posts.size if user.posts.any?
  end

  def number_following user
    user.following.size
  end

  def number_followers user
    user.followers.size
  end

  def active_relationship
    @follower = current_user.active_relationships.build
  end

  def passtive_relationship other_user
    @unfollow = current_user.active_relationships
      .find_by followed_id: other_user
  end
end
