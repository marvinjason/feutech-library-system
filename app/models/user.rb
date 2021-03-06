class User < ApplicationRecord
  has_many :reservations, dependent: :destroy
  has_many :books, through: :reservations
  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :logs, dependent: :destroy

  mount_uploader :avatar, AvatarUploader

  validates :last_name, :first_name, :role, :avatar, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  def self.from_omniauth(auth_hash)
    user = User.where(email: auth_hash.info.email).first

    unless user
      user = User.new(
        provider: auth_hash.provider,
        uid: auth_hash.uid,
        email: auth_hash.info.email,
        password: Devise.friendly_token[0, 20],
        first_name: auth_hash.info.first_name,
        last_name: auth_hash.info.last_name
      )

      user.remote_avatar_url = auth_hash.info.image
      user.save!
    end

    user
  end
end
