class Auth::CallbacksController < Devise::OmniauthCallbacksController
  def facebook
    user = User.from_omniauth(auth_hash)
    sign_in_and_redirect user
  end

  def google_oauth2
    user = User.from_omniauth(auth_hash)
    sign_in_and_redirect user
  end

  def failure
    flash[:danger] = 'Authentication failed!'
    redirect_to new_user_session_path
  end

  private
  def auth_hash
    request.env['omniauth.auth']
  end
end
