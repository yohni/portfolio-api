class Api::V1::ProjectsController < ApplicationController
  before_action :set_project, only: %i[show destroy update]

  def create
    @project = current_user.projects.build(project_params)
    if @project.save
      render json: { data: ProjectSerializer.one(@project) }, status: :created
    else
      render json: { errors: @project.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    @projects = filtered_projects

    render json: {
      data: ProjectSerializer.collection(@projects),
      pagination: PageSerializer.one(@projects)
    }
  end

  def show
    render json: { data: ProjectSerializer.one(@project) }
  end

  def update
    if @project.update(project_params)
      render json: { data: ProjectSerializer.one(@project) }, status: :ok
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
    @project = current_user.projects.find(params[:id])
  end

  def filtered_projects
    scope = current_user.projects
    scope = scope.order(updated_at: :desc).page(params[:page]).per(params[:per_page] || 20)

    scope
  end
end
