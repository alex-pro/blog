class ProfilesController < ApplicationController
  before_filter :profile, only: [:index, :edit, :update]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @profile = @user.profile
  end

  def update
    if @profile.update(profile_params)
      redirect_to profiles_path
    else
      render 'edit'
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:name, :country, :birthday, :sex, :about)
  end

  def profile
    if current_user
      @profile = current_user.profile
    else redirect_to root_path
    end
  end
end
