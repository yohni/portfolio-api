class Api::V1::UploadsController < ApplicationController
  def create
    unless params[:file].present?
      return render json: { errors: [ "File can't be blank" ] }, status: :unprocessable_entity
    end

    @upload = Upload.new(
      og_filename: params[:file].original_filename,
      file_type: params[:file].content_type,
      file_size: params[:file].size
    )
    @upload.file.attach(params[:file])

    if @upload.save
      render json: {
        id: @upload.id,
        file_url: url_for(@upload.file),
        og_filename: @upload.og_filename,
        file_type: @upload.file_type,
        file_size: @upload.file_size
      }, status: :created
    else
      render json: { errors: @upload.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @upload = Upload.find(params[:id])
    if @upload.destroy
      render json: { message: "Upload deleted successfully" }, status: :ok
    else
      render json: { errors: @upload.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
