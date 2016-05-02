class TeamsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @project = @user.projects.find(params[:project_id])
    @team = Team.new
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
