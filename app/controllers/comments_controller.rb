class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :update, :destroy]
  before_action :set_post , only:[:index,:create,:update,:show]

  # GET /comments
  def index
    @comments = @post.comments

    render json: @comments ,each_serializer:CommentSerializer,key_transform: :underscore
  end

  # GET posts/:post_id/comments/:comment_id
  def show
    @comment = Comment.find_by(id:@comment.id,post_id:@post.id)
    if @comment
      render json: @comment ,serializer:CommentSerializer,key_transform: :underscore
    else
      render json:{message:"no comments for this post"}
    end
  end

  # POST /posts/:post_id/comments
  def create
    @comment = Comment.new(comment_params)
    @comment.post_id = @post.id
    @comment.user_id = current_user.id
    if @comment.save
      render json: @comment ,serializer:CommentSerializer,key_transform: :underscore
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/:post_id/comments/comment_id
  def update
    authorize(@comment)

    if @comment.update(comment_params)
      render json: @comment ,each_serializer:CommentSerializer,key_transform: :underscore
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/post_id/comments/comment_id
  def destroy
    authorize(@comment)

    if @comment.destroy
      render json:{message:"comment was successfully deleted"},status:200
    else
      render json:@comment.errors,status: :unprocessable_entity

    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def comment_params
      params.require(:comment).permit(:body)
    end

    def set_post
      @post = Post.find(params[:post_id])
    end
end
