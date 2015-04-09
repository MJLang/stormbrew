class SessionsController < ApplicationController

  def create
    @user = env['warden'].authenticate
    if @user
      respond_to do |format|
        format.js
        format.html { redirect_to root_path }
      end
    else
      respond_to do |format|
        format.js
        format.html { redirect_to root_path }
      end
    end
  end

  def destroy
    env['warden'].logout
    redirect_to root_path
  end
end