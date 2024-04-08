class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts or /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1 or /posts/1.json
  def show

    @comment = Comment.new

    @comments = Comment.where(post_id: @post.id)
    @vote = Vote.new
  end


  # GET /posts/new
  def new
    @post = Post.new
    @subreddit = Subreddit.friendly.find(params[:subreddit_id])
    
  end

  def create_comment

    @post = Post.friendly.find(params[:id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id

    respond_to do |format|
    if @comment.save
      redirect_to @post, notice: "Created your Comment"
    else
      redirect_to @post, notice: "Failed to create comment"
    end
  end
end
#

    def comment_params
    params.require(:comment).permit(:content)
    end
  def upvote

    @post = Post.find_by(slug: params[:id])
    @vote = current_user.votes.find_or_initialize_by(post: @post)
    @vote.value = 1
    @vote.save
    redirect_to @post

  end


  def downvote
    @post = Post.find_by(slug: params[:id])
    @vote = current_user.votes.find_or_initialize_by(post: @post)
    @vote.value = -1
    @vote.save
    redirect_to @post

  end
  # GET /posts/1/edit
  def edit

    @subreddit = @post.subreddit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    if current_user && current_user.id == @post.user_id
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end
end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    if current_user && current_user.id == @post.user_id
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end

  end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body, :user_id, :subreddit_id, :image)
    end
end
