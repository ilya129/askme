module UsersHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_url 'avatar.jpg'
    end
  end

  def user_color(user)
    if user.avatar_color.present?
      user.avatar_color
    else
      'dark-green'
    end
  end
end
