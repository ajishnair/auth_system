class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  helper_method :current_user, :current_access

  private
  def current_user
    User.find_by(:id => session[:current_user_id])
  end

  def login_user(user)
  	session[:current_user_id] = user.id
  end

  def current_access
  	access = 'READ'
    if request.post? or request.put?
      access = 'WRITE'
    elsif request.delete?
      access = 'DELETE'
    elsif request.patch?
      access = 'UPDATE'
    end
    access
  end

end
