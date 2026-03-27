class Api::V1::ProjectsController < ApplicationController
  allow_unauthenticated_access only: %i[index show]
  before_action :set_project, only: %i[show destroy update]

  def create
    @project = current_user.projects.build(project_params)
    if @project.save
      render json: ProjectSerializer.one(@project), status: :created
    else
      render json: { errors: @project.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    @projects = filtered_projects

    render json: ProjectSerializer.collection(@projects)
  end

  def show
    render json: ProjectSerializer.one(@project)
  end

  def update
    if @project.update(project_params)
      render json: ProjectSerializer.one(@project), status: :ok
    else
      render json: { errors: @project.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @project.destroy
      render json: { message: "Project deleted successfully" }, status: :ok
    else
      render json: { errors: @project.errors.full_messages }, status: :unprocessable_entity
    end
  end


  private

  def project_params
    params.permit(:title, :description, :live_url, :github_url, :thumbnail_url, :position, :featured, tech_stack: [])
  end

  def set_project
    @project = Project.find(params[:id])
  end

  def filtered_projects
    scope = Project.all
    scope = scope.where(user_id: params[:user_id]) if params[:user_id].present?
    scope = scope.where(featured: params[:featured]) if params[:featured].present?

    scope
  end
end
