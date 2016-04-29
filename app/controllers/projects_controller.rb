class ProjectsController < ApplicationController
  before_action :logged_in_user, only: [:create]
  before_action :correct_user,   only: [:create]

  def new
    @user = User.find(params[:user_id])
    @project = Project.new
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
