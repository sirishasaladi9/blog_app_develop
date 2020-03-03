class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def new
    @post = Post.new
    render layout: "admin"
  end

  def create
    @post = Post.new({title: params['title'], small_description: params["small_description"], post_cover: params["file"]["0"]})
    if @post.save
      flash[:success] = "Post saved successfuly."
      @post = Post.new
      redirect_to new_post_path
    else
      flash[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def index
    @search_term = params["search"]
    @posts = if @search_term.present?
               Post.search_by_title(params["search"])
             else
               Post.all
             end
    @posts = @posts.order(created_at: :desc)
    if params["seq_filter"].present?
      @seq_filter = params["seq_filter"]
      mth = "#{params["seq_filter"]}?".to_sym
      @posts = @posts.partition { |r| r.id.send(mth) }.first
    end
    @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(30)

    respond_to do |format|
      format.js
      format.html
    end
  end

  def search
    @search_term = params["search"]
    @posts = Post.search_by_title(params["search"])
    @posts = @posts.order(created_at: :desc)
    if params["seq_filter"].present?
      @seq_filter = params["seq_filter"]
      mth = "#{params["seq_filter"]}?".to_sym
      @posts = @posts.partition { |r| r.id.send(mth) }.first
    end
    @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(30)
    respond_to do |format|
      format.js
      format.html
    end
  end

  def odd_even_filter
    @search_term = params["search"]
    @posts = if @search_term.present?
               Post.search_by_title(params["search"])
             else
               Post.all
             end
    @posts = @posts.order(created_at: :desc)
    if params["seq_filter"].present?
      @seq_filter = params["seq_filter"]
      mth = "#{params["seq_filter"]}?".to_sym
      @posts = @posts.partition { |r| r.id.send(mth) }.first
    end
    @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(30)
    respond_to do |format|
      format.js
      format.html
    end
  end

  private

  def post_params
    params.require(:post).permit!
  end
end
