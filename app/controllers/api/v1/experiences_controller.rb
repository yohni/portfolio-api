class Api::V1::ExperiencesController < ApplicationController
  before_action :set_experience, only: %i[show update destroy]
  def create
    @experience = current_user.experiences.build(experience_params)
    if @experience.save
      render json: { data: ExperienceSerializer.one(@experience) }, status: :created
    else
      render json: { errors: @experience.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    @experiences = filtered_experiences

    render json: {
      data: ExperienceSerializer.collection(@experiences),
      pagination: PageSerializer.one(@experiences)
    }
  end

  def show
    render json: { data: ExperienceSerializer.one(@experience) }, status: :ok
  end

  def update
    if @experience.update(experience_params)
      render json: { data: ExperienceSerializer.one(@experience) }, status: :ok
    else
      render json: { errors: @experience.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @experience.destroy
      render json: { message: "Experience deleted successfully" }, status: :ok
    else
      render json: { errors: @experience.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_experience
    @experience = current_user.experiences.find(params[:id])
  end

  def experience_params
    params.permit(:company, :position, :start_date, :end_date, :current, :role, :description, :location)
  end

  def filtered_experiences
    scope = current_user.experiences
    scope = scope.order(updated_at: :desc).page(params[:page]).per(params[:per_page] || 20)

    scope
  end
end
