class ApplicationController < ActionController::Base

  private

  def check_session
    redirect_to "/" unless session[:id]
  end
end
