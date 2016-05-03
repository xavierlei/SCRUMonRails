class TeamsController < ApplicationController
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

end
