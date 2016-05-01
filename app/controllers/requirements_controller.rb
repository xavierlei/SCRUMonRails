class RequirementsController < ApplicationController
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

end
