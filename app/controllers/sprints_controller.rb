class SprintsController < ApplicationController
  before_action :logged_in_user, only: [:create,:destroy]
  before_action :correct_user, only: [:create,:destroy]
  before_action :check_user_permission, only: :index

  # CRUMBS ----------------
  before_filter :load_data, :only=>'index'
  add_crumb(:user_name, :only=>'index'){[:user]}
  add_crumb(:project_name, :only=>'index'){[:user, :project]}
  add_crumb("Scrum Board", :only=>"index"){|instance| instance.send :user_project_sprints_path}
  def load_data
    @user_name = User.find(params[:user_id]).name
    @user = User.find(params[:user_id])
    @project = @user.projects.find(params[:project_id])
    @project_name = @user.projects.find(params[:project_id]).name
  end
  # CRUMBS ----------------
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
  def destroy
    @user = User.find(params[:user_id])
    @project = @user.projects.find(params[:project_id])
    @sprint = @project.sprints.find(params[:id])
    if @sprint.destroy
      flash[:success] = "sprint successfuly deleted"
    else
      flash[:notice] = @sprint.errors.full_messages.to_sentence
    end
    redirect_to user_project_sprints_path(@user.id,@project.id)
  end
  def begin_date
    Date.new(params[:begin_date][:year].to_i,params[:begin_date][:month].to_i,params[:begin_date][:day].to_i)
  end
  def end_date
    Date.new(params[:end_date][:year].to_i,params[:end_date][:month].to_i,params[:end_date][:day].to_i)
  end
  def create
    @user = User.find(params[:user_id])
    @project = @user.projects.find(params[:project_id])
    @sprint = @project.sprints.new(:project_id =>params[:project_id],:begin_date => begin_date, :end_date => end_date)
    if @sprint.save
      flash[:success] = "sprint successfuly added"
    else
      flash[:danger] = @sprint.errors.full_messages.to_sentence
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
  def check_user_permission
    contribution_project_ids = current_user.teams.map(&:project_id)
    own_projects_ids = current_user.projects.map(&:id)
    redirect_to(root_url) unless contribution_project_ids.include?(params[:project_id].to_i) || own_projects_ids.include?(params[:project_id].to_i)
  end

end
