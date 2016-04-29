class ProjectsController < ApplicationController

  def new
    @user = User.find(params[:user_id])
    @project = Project.new
  end

  def create
    @user = User.find(params[:user_id])
    @project = @user.projects.new(project_params)
    if @project.save
      flash[:success] = "Project successfuly created"
      redirect_to @user
    else
      flash.now[:danger] = 'Project creation failed'
      render 'new'
    end
  end

  private
    def project_params
      params.require(:project).permit(:name, :description)
    end

end
