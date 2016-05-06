class UsersController < ApplicationController
  #prevent non logged users to edit users info
  before_action :logged_in_user, only: [:index, :edit, :update]
  #prevent logged users to edit other's info
  before_action :correct_user,   only: [:edit, :update]
  #to prevent that only admins can delete users
  before_action :admin_user, only: :destroy

 # CRUMBS ----------------
 before_filter :load_user, :only=>'show'
 add_crumb(:user_name, :load_user, :only=>'show')
 def load_user
   @user_name = User.find(params[:id]).name
   @user = User.find(params[:id])
 end
# CRUMBS ----------------

  def show
    @user = User.find(params[:id])
    @projects = @user.projects.paginate(page: params[:page])
  end
  def new
    @user = User.new
  end
  def create
      @user = User.new(user_params)
      if @user.save
        log_in @user
        flash[:success] = "Welcome to SCRUM on Rails!"
        redirect_to @user
      else
        flash.now[:danger] = 'Register failed'
        render 'new'
      end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end
