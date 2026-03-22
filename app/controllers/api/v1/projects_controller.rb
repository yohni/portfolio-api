class Api::V1::ProjectsController < ApplicationController
  allow_unauthenticated_access only: :index

  before_action :set_project, only: %i[show]
  def create
    @project = current_user.projects.build(project_params)
    if @project.save
      render json: { id: @project.id, title: @project.title, description: @project.description }, status: :created
    else
      render json: { errors: @project.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    @projects = Project.all

    render json: @projects
  end

  def show
    render json: { id: @project.id, title: @project.title, description: @project.description }
  end



  private

  def project_params
    params.permit(:title, :description)
  end

  def set_project
    @project = Project.find(params[:id])
  end
end
