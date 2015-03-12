class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      warden.set_user(user)
      flash[:success] = I18n.t('flash.signup.success', username: user.display_name)
      redirect_to root_path
    else
      flash.now.notice = I18n.t('alerts.signup.fail')
      redirect_to login_path
    end
  end

  def update
  end

    private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :display_name)
    end
end