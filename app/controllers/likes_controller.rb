class LikesController < ApplicationController
  before_filter :authenticate_user!
  include DetectLikeable

  def up_or_down
    likeable = find_likeable
    like = likeable.likes.where(user_id: current_user.id).first

    if like.nil?
      @action = 'like'
      like = current_user.likes.create(likeable_id: likeable.id, likeable_type: likeable.class.name)
    else
      @action  = 'unlike'
      like.destroy
    end
    @likes_count = likeable.likes_count
  end
end