class UsersController < ApplicationController

  def settings
    @user = current_user
  end

  def update
    if params[:user].has_key?(:avatar)
      current_user.update_attribute(:avatar, params[:user][:avatar])
      redirect_to user_settings_path
    end
    if params[:user].has_key?(:gender)
      current_user.update_attribute(:gender, params[:user][:gender])
      redirect_to user_settings_path
    end
  end
end
