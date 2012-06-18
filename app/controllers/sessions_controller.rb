class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    user = User.find_by_provider_and_uid(auth['provider'], auth['uid'].to_s) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    cookies[:logged_in] = true
    redirect_to root_url, notice: "Benvenuto #{user.name}, ora puoi contribuire con nuove parole."
  end

  def destroy
    session[:user_id] = nil
    cookies.delete :logged_in
    redirect_to root_url, notice: 'Sei stato disconnesso. Grazie per il tuo contributo.'
  end
  
  def index
    render json: (User.find(session[:user_id]) if session[:user_id])
  end
end
