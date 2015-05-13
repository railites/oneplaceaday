module PostsHelper
  def post_is_editable?(author, logged_in_user)
    author == logged_in_user
  end

  def value_of_user_id(user)
    user.nil? ? nil : user.id
  end

  def image_for_current_user(user)
    user.present? and user.profile_photo.url.present? ?  user.profile_photo.url : 'nouserimage.png'
  end

  def username_for_user(user)
    user.nil? ? 'Anonymous User' : user.username
  end

  def map_image(latitude, longitude)
    return nil if latitude.nil? and longitude.nil?
    link_to glyph_icon("globe"), "https://www.google.co.in/maps/place/#{latitude},#{longitude}", target: "_blank;"
  end

  def get_user_profile_picture(user)
    if user.nil?
      pic_url = 'nouserimage.png'
    elsif user.provider.present?
      pic_url = user.picture_url
    else
      pic_url = user.profile_photo.url
    end
    pic_url = 'nouserimage.png' if pic_url.nil?
    pic_url
  end

  def get_like_button(post, current_user)
    if current_user.present? and post.user != current_user
      link_to glyph_icon("heart untitle like_count #{class_for_like_unlike(post, current_user)}", text: post.likes_count.to_s), like_unlike_path(post), remote: true
    else
      link_to glyph_icon("heart untitle like_count #{class_for_like_unlike(post, current_user)}", text: post.likes_count.to_s)
    end
  end

  def class_for_link_unlike_based_on_count(post)
    post.likes_count != 0 ? 'red' : 'black'
  end

  def class_for_like_unlike(post, current_user)
    current_user.has_liked_post?(post) ? 'red' : 'black'
  end
end