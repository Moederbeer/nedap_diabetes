class UsersController < ApplicationController
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user, only: [:destroy, :index]

  def show
    @user = User.find(params[:id])
  end

  def new
    if logged_in?
      redirect_to articles_path
    else
      @user = User.new
    end
  end

  def create

    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Account succesvol aangemaakt!"
      redirect_to @user
      # Handle a successful save.
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profiel bijgewerkt"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def favorites
    if logged_in?
      @user = current_user
    else
      redirect_to root_url
    end
  end

  def index
    @users = User.all
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Gebruiker verwijderd"
    redirect_to specialists_url
  end

  private

    def user_params
      params.require(:user).permit(:firstname, :email, :password, :password_confirmation)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end