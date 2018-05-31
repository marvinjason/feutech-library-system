class Auth::CallbacksController < Devise::OmniauthCallbacksController
  def facebook
    user = User.from_omniauth(auth_hash)
    sign_in_and_redirect user
  end

  def failure
    redirect_to :root
  end

  private
  def auth_hash
    request.env['omniauth.auth']
  end
end
