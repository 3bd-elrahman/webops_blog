class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]

  # GET /posts
  def index
    page = params[:page]
    @posts = Post.page(params[:page])

    render json: @posts ,each_serializer:PostSerializer ,key_transform: :underscore
  end

  # GET /posts/1
  def show
    render json: @post ,Serializer:PostSerializer,key_transform: :underscore
  end

  # POST /posts
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      render json: @post ,Serializer:PostSerializer,key_transform: :underscore
    else
      render json: @post.errors, status: :unprocessable_entity
    end
    
  end

  # PATCH/PUT /posts/1
  def update
    authorize @post
    if @post.update(post_params)
      render json: @post ,Serializer:PostSerializer,key_transform: :underscore
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    authorize @post

    if @post.destroy
      render json:{message:"post was successfully deleted"},status:200
    else
      render json:@post.errors,status: :unprocessable_entity

    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def post_params
      params.require(:post).permit(:title,:body,tag_ids:[])
    end
end
