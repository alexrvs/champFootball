module SessionsHelper

  def sign_in(user)

    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user

  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def signed_in?
    !current_user.nil?
  end

  def signed_in_as_admin?
    !current_user.nil? && current_user.is_admin
  end

  def sign_out
    current_user.update_attribute(:remember_token, User.encrypt(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  def getIdCurrentUser
    self.current_user.id
  end

  def current_team
      Team.with_current_user self.current_user.id
  end

  def current_tournament
    Tournament.all
  end

end