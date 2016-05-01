class ProjectsController < ApplicationController
  before_action :logged_in_user, only: [:create,:edit,:update]
  before_action :correct_user,   only: [:create,:edit,:update]

  def new
    @user = User.find(params[:user_id])
    @project = Project.new
  end

  def edit
    @user = User.find(params[:user_id])
    @project = @user.projects.find(params[:id])
  end

  def show
    @user = User.find(params[:user_id])
    @project = @user.projects.find(params[:id])
    @requirements = @project.requirements.paginate(page: params[:page])
  end

  def create
    @user = User.find(params[:user_id])
    @project = @user.projects.new(project_params)
    if @project.save
      flash[:success] = "Project successfuly created"
      redirect_to @user
    else
      flash.now[:danger] = 'Project creation failed'
      render 'new'
    end
  end

  def update
    @user = User.find(params[:user_id])
    @project = @user.projects.find(params[:id])
    if @project.update_attributes(project_params)
      flash[:success] = "Project successfuly updated"
      redirect_to @user
    else
      flash[:danger] = "Project update failed"
      render 'edit'
    end
  end

  private
    def project_params
      params.require(:project).permit(:name, :description)
    end
 #####This code is (almost) the same that in UsersController.
 #####move this code to ApplicationController
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:user_id])
      redirect_to(root_url) unless current_user?(@user)
    end

end
