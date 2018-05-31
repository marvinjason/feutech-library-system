class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  def self.from_omniauth(auth_hash)
    users =
      where(
        provider: auth_hash.provider,
        uid: auth_hash.provider
      )

    users.first_or_create do |user|
      user.email = auth_hash.info.email,
      user.password = Devise.friendly_token[0, 20]
    end
  end
end
