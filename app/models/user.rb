class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :twitter]

  mount_uploader :profile_photo, ProfilePhotoUploader

  searchkick
  has_many :posts
  has_many :comments
  has_many :likes

  def facebook?
    provider == 'facebook'
  end

  def twitter?
    provider == 'twitter'
  end

  def has_liked_post?(post)
    likes.include?(post)
  end

  def self.from_omniauth(auth)
    user = self.where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end

    user.picture_url = auth.info.image

    if auth.provider.eql?('twitter')
      user.username = auth.info.nickname
      user.save(validate: false) # because twitter does not provide email
    else
      user.username = auth.info.name
      user.save
    end

    return user
  end
end