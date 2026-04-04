class Api::V1::Users::ProjectsController < ApplicationController
  allow_unauthenticated_access only: %i[index show]
  before_action :set_user
  before_action :set_project, only: %i[show]


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

  private

  def set_user
    @user = User.find_by!(username: params[:user_username])
  end

  def set_project
    @project = @user.projects.find(params[:id])
  end

  def filtered_projects
    scope = @user.projects
    scope = scope.where(featured: params[:featured]) if params[:featured].present?
    scope = scope.order(updated_at: :desc).page(params[:page]).per(params[:per_page] || 20)

    scope
  end
end
