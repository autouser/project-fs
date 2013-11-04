class ApplicationController < ActionController::Base
  protect_from_forgery

  skip_before_filter :verify_authenticity_token, if: lambda{ |controller| controller.request.format.json? }

  # before_filter :authenticate_user!, :unless => lambda{ |controller| controller.request.format.js? }
  before_filter :auth_user!

  private

  def auth_user!
    if request.format.json?
      raise "Empty token" if params[:token].blank?
      user = User.find_by_token(params[:token])
      raise "Authentication failed" if user.nil?
      @current_user = user
    else
      authenticate_user!
    end
  end

end
