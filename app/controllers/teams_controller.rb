class TeamsController < ApplicationController
  before_action :logged_in_user, only: [:create,:edit,:update,:destroy]
  before_action :correct_user,   only: [:create,:edit,:update,:destroy]
  def new
    @user = User.find(params[:user_id])
    @project = @user.projects.find(params[:project_id])
    @team = Team.new
  end

  def edit
    @user = User.find(params[:user_id])
    @project = @user.projects.find(params[:project_id])
    @team = @project.teams.find(params[:id])
  end

  def show
    @user = User.find(params[:user_id])
    @project = @user.projects.find(params[:project_id])
    @team = @project.teams.find(params[:id])
    @roles = @team.roles
  end

  def destroy
    @user = User.find(params[:user_id])
    @project = @user.projects.find(params[:project_id])
    @team = @project.teams.find(params[:id])
    if @team.destroy
      flash[:success] = "Team successfuly deleted"
      redirect_to user_project_path(@user.id,@project.id)
    else
      flash[:danger] = "Team deletion failed."
    end
  end

  def update
    @user = User.find(params[:user_id])
    @project = @user.projects.find(params[:project_id])
    @team = @project.teams.find(params[:id])
    if @team.update_attributes(team_params)
      flash[:success] = "team successfuly updated"
      redirect_to user_project_path(@user.id,@project.id)
    else
      flash[:danger] = "team update failed"
    end
  end

  def create
    @user = User.find(params[:user_id])
    @project = @user.projects.find(params[:project_id])
    @team = @project.teams.new(team_params)
    if @team.save
      flash[:success] = "new team added to project"
      redirect_to user_project_path(@user.id,@project.id)
    else
      flash[:danger] = "team creation failed"
    end
  end
  private
    def team_params
      params.require(:team).permit(:name)
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
