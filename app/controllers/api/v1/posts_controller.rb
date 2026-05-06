class Api::V1::PostsController < ApplicationController
  before_action :set_post, only: %i[show update destroy]
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      render json: { data: PostSerializer.one(@post) }, status: :created
    else
      render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    render json: { data: PostSerializer.one(@post) }
  end

  def index
    @posts = filtered_posts
    render json: {
      data: PostSerializer.collection(@posts),
      pagination: PageSerializer.one(@posts)
    }
  end

  def update
    if @post.update(post_params)
      render json: { data: PostSerializer.one(@post) }, status: :ok
    else
      render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @post.destroy
      render json: { message: "Post deleted successfully" }, status: :ok
    else
      render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.permit(:title, :content, :cover_image_url, :status, :published_at, :tag_ids)
  end

  def set_post
    @post = current_user.posts.find(params[:id])
  end

  def filtered_posts
    scope = current_user.posts
    scope = scope.order(updated_at: :desc).page(params[:page]).per(params[:per_page] || 20)

    scope
  end
end
