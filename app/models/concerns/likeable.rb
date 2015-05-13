module Likeable
  extend ActiveSupport::Concern

  included do
    has_many :likes, as: :likeable
  end

  def likes_count
    likes.count
  end
end