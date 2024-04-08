class SubredditsController < ApplicationController
  before_action :set_subreddit, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: %i[ new edit create update destroy ]

  # GET /subreddits or /subreddits.json
  def index
    @subreddits = Subreddit.all
  end
  def search
    if params[:title_search].present?
      @subreddits = Subreddit.where("title ILIKE ?", "%#{params[:title_search]}%")
    else
      @subreddits = [] # Or any other behavior you want when the search term is empty
    end
    
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update("search_results", partial: "subreddits/search_results", locals: { subreddits: @subreddits })
      end 
    end
  end

  def my_subreddits
    if current_user
      @user_memberships = current_user.memberships
    end

  end
  # GET /subreddits/1 or /subreddits/1.json
  def show
    @membership = Membership.new
    @posts = @subreddit.posts
  end

  # GET /subreddits/new
  def new
    @subreddit = Subreddit.new
  end

  # GET /subreddits/1/edit
  def edit
  end

  # POST /subreddits or /subreddits.json
  def create
    @subreddit = Subreddit.new(subreddit_params)

    respond_to do |format|
      if @subreddit.save
        format.html { redirect_to subreddit_url(@subreddit), notice: "Subreddit was successfully created." }
        format.json { render :show, status: :created, location: @subreddit }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @subreddit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subreddits/1 or /subreddits/1.json
  def update
    if current_user && current_user.id == @subreddit.user_id
    respond_to do |format|
      if @subreddit.update(subreddit_params)
        format.html { redirect_to subreddit_url(@subreddit), notice: "Subreddit was successfully updated." }
        format.json { render :show, status: :ok, location: @subreddit }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @subreddit.errors, status: :unprocessable_entity }
      end
    end
  end
end
  # DELETE /subreddits/1 or /subreddits/1.json
  def destroy
    if current_user && current_user.id == @subreddit.user_id
    @subreddit.destroy!

    respond_to do |format|
      format.html { redirect_to subreddits_url, notice: "Subreddit was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subreddit
      @subreddit = Subreddit.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def subreddit_params
      params.require(:subreddit).permit(:title, :body, :user_id)
    end
end
