class TasksController < ApplicationController
  before_action :logged_in_user, only: [:create,:destroy]
  before_action :correct_user, only: [:create,:destroy]
  def new
    @user = User.find(params[:user_id])
    @project = @user.projects.find(params[:project_id])
    @sprint = @project.sprints.find(params[:sprint_id])
    @task = Task.new
    @teams = @project.teams.all
    @requirements = @project.requirements.all
  end
  def destroy
    @user = User.find(params[:user_id])
    @project = @user.projects.find(params[:project_id])
    @sprint = @project.sprints.find(params[:sprint_id])
    @task = @sprint.tasks.find(params[:id])
    if @task.destroy
      flash[:success] = "task successfully undelegated"
    else
      flash[:danger] = @task.errors.full_messages.to_sentence
    end
    redirect_to user_project_sprints_path(@user.id,@project.id)
  end
  def create
    @user = User.find(params[:user_id])
    @project = @user.projects.find(params[:project_id])
    @sprint = @project.sprints.find(params[:sprint_id])
    @task = Task.new(sprint_id: @sprint.id, team_id: params[:task][:team_id],
            requirement_id: params[:task][:requirement_id])
    if @task.save
      flash[:success] = "task successfully delegated"
    else
      flash[:danger] = @task.errors.full_messages.to_sentence
    end
    redirect_to user_project_sprints_path(@user.id,@project.id)
  end
  private
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
  def correct_user
    @user = User.find(params[:user_id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
