class UsersController < ApplicationController
  skip_before_filter :authenticate
  before_filter :check_current_user, only: [:new, :create]

  def index
    users = User.where('email LIKE ?', "%#{params[:query]}%").select('email, id')
    render json: users
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, :notice => "Signed up!"
    else
      render "new"
      flash[:error] = 'Error'
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
