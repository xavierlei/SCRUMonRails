class ProjectsController < ApplicationController
  before_action :logged_in_user, only: [:create,:edit,:update,:destroy,:show]
  before_action :correct_user,   only: [:create,:edit,:update,:destroy]
  before_action :check_user_permission, only: :show

# CRUMBS ----------------
  before_filter :load_user, :load_project, :only=>'show'
  add_crumb(:user_name, :only=>'show'){[:user]}
  add_crumb(:project_name, :only=>'show'){[:user, :project]}

  def load_user
    @user_name = User.find(params[:user_id]).name
    @user = User.find(params[:user_id])
  end
  def load_project
    @user = User.find(params[:user_id])
    @project = @user.projects.find(params[:id])
    @project_name = @user.projects.find(params[:id]).name
  end
# CRUMBS ----------------
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
    @teams = @project.teams
  end
  def destroy
    @user = User.find(params[:user_id])
    @project = @user.projects.find(params[:id])
    if @project.destroy
      flash[:success] = "project successfuly deleted"
    else
      flash[:danger] = "error while deleting project"
    end
    redirect_to @user
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

    def check_user_permission
      contribution_project_ids = current_user.teams.map(&:project_id)
      own_projects_ids = current_user.projects.map(&:id)
      redirect_to(root_url) unless contribution_project_ids.include?(params[:id].to_i) || own_projects_ids.include?(params[:id].to_i)
    end

end
