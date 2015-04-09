class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      warden.set_user(@user)

      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    else
      flash.now.notice = I18n.t('alerts.signup.fail')
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    end
  end


  def update
  end

  private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :display_name)
    end
end