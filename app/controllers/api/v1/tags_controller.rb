class Api::V1::TagsController < ApplicationController
  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      render json: { data: TagSerializer.one(@tag) }, status: :created
    else
      render json: { errors: @tag.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def tag_params
    params.permit(:name)
  end
end
