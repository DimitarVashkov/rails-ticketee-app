class ProjectsController < ApplicationController
  def index

  end

  def new
    @project = Project.new
  end
  def create
    @project = Project.new(project_params)
    if @project.save
      flash[:success] = "Project has been created."
      redirect_to @project
    else
      flash[:danger] = "Project was NOT created."
      render 'new'
    end
  end

  def project_params
    params.require(:project).permit(:name, :description)
  end
  def show
    @project = Project.find(params[:id])
  end

end
