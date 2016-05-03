class RequirementsController < ApplicationController
  before_action :logged_in_user, only: [:create,:edit,:update,:destroy]
  before_action :correct_user,   only: [:create,:edit,:update,:destroy]
  def new
    @user = User.find(params[:user_id])
    @project = @user.projects.find(params[:project_id])
    @requirement = Requirement.new
  end

  def edit
    @user = User.find(params[:user_id])
    @project = @user.projects.find(params[:project_id])
    @requirement = @project.requirements.find(params[:id])
  end

  def destroy
    @user = User.find(params[:user_id])
    @project = @user.projects.find(params[:project_id])
    @requirement = @project.requirements.find(params[:id])
    if @requirement.destroy
      flash[:success] = "requirement successfuly destroyed"
      redirect_to user_project_path(@user.id,@project.id)
    else
      flash[:danger] = "requirement delete failed"
    end

  end

  def create
    @user = User.find(params[:user_id])
    @project = @user.projects.find(params[:project_id])
    @requirement = @project.requirements.new(requirement_params)
    if @requirement.save
      flash[:success] = "requirement added to project"
      redirect_to user_project_path(@user.id,@project.id)
    else
      flash[:danger] = "requirement creation failed"
    end
  end

  def update
    @user = User.find(params[:user_id])
    @project = @user.projects.find(params[:project_id])
    @requirement = @project.requirements.find(params[:id])
    if @requirement.update_attributes(requirement_params)
      flash[:success] = "requirement successfuly updated"
      redirect_to user_project_path(@user.id,@project.id)
    else
      flash[:danger] = "requirement edition failed"
    end
  end

  private
    def requirement_params
      params.require(:requirement).permit(:description)
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
