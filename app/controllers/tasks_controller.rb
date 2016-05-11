class TasksController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @project = @user.projects.find(params[:project_id])
    @sprint = @project.sprints.find(params[:sprint_id])
    @task = Task.new
    @teams = @project.teams.all
    @requirements = @project.requirements.all
  end
  def create
    @user = User.find(params[:user_id])
    @project = @user.projects.find(params[:project_id])
    @sprint = @project.sprints.find(params[:sprint_id])
    #@sprint = @project.sprints.new(:project_id =>params[:project_id],:begin_date => begin_date, :end_date => end_date)
    @task = Task.new(sprint_id: @sprint.id, team_id: params[:task][:team_id],
            requirement_id: params[:task][:requirement_id])
    if @task.save
      flash[:success] = "task successfully delegated"
    else
      flash[:danger] = "task delegation failed"
    end
    redirect_to user_project_sprints_path(@user.id,@project.id)
  end
end
