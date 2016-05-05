class RolesController < ApplicationController
  before_action :logged_in_user, only: [:create]
  before_action :correct_user, only: [:create]
  def new
    @user = User.find(params[:user_id])
    @project = @user.projects.find(params[:project_id])
    @team = @project.teams.find(params[:team_id])
    @role = Role.new
  end

  #@post = Post.new(:text => params[:post][:text])
  #Permission.find_by(user_id: params[:user_id], project_id: params[:project_id])
  def create
    @user = User.find(params[:user_id])
    @project = @user.projects.find(params[:project_id])
    @team = @project.teams.find(params[:team_id])
    @member = User.find_by(email: params[:role][:email])
    if !@member.nil?
      @role = Role.new(user_id: @member.id, team_id: @team.id,
              description: params[:role][:description], email: params[:role][:email])
      if @role.save
        flash[:success] = "member successfuly added"
        redirect_to user_project_team_path(@user.id,@project.id,@team.id)
      else
        flash[:danger] = "member adition failed"
        redirect_to user_project_team_path(@user.id,@project.id,@team.id)
      end
    else
      flash[:danger] = "the user doesn't exist"
      redirect_to user_project_team_path(@user.id,@project.id,@team.id)
    end
  end


  private
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
