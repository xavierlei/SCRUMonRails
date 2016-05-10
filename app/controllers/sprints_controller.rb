class SprintsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @project = @user.projects.find(params[:project_id])
    @sprint = Sprint.new
  end
  def index
    @user = User.find(params[:user_id])
    @project = @user.projects.find(params[:project_id])
    @sprints = @project.sprints.all
  end
  def create
    @user = User.find(params[:user_id])
    @project = @user.projects.find(params[:project_id])
    begin_date = Date.new(params[:begin][:year].to_i,params[:begin][:month].to_i,params[:begin][:day].to_i)
    end_date = Date.new(params[:end][:year].to_i,params[:end][:month].to_i,params[:end][:day].to_i)
    @sprint = @project.sprints.new(:project_id =>params[:project_id],:begin => begin_date, :end => end_date)
    if @sprint.save
      flash[:success] = "sprint successfuly added"
    else
      flash[:danger] = @sprint.errors.full_messages.to_sentence
    end
    redirect_to user_project_sprints_path(@user.id,@project.id)
  end

end
