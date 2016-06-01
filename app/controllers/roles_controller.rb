class RolesController < ApplicationController
  before_action :logged_in_user, only: [:create,:destroy]
  before_action :correct_user, only: [:create,:destroy]

  def new
    @user = User.find(params[:user_id])
    @project = @user.projects.find(params[:project_id])
    @team = @project.teams.find(params[:team_id])
    @role = Role.new
  end

  def destroy
    @user = User.find(params[:user_id])
    @project = @user.projects.find(params[:project_id])
    @team = @project.teams.find(params[:team_id])
    @role = Role.find(params[:id])
    @role.destroy
      respond_to do |format|
        format.html{redirect_to user_project_team_path(@user.id,@project.id,@team.id)}
        format.json { head :ok }
        format.js
      end
  end
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
      else
        flash[:danger] = @role.errors.full_messages.to_sentence
      end
    else
      flash[:danger] = "the user doesn't exist"
    end
    redirect_to user_project_team_path(@user.id,@project.id,@team.id)
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
