class PostsController < ApplicationController
  before_filter :require_user, only: [:new, :create, :upvote, :downvote]

  def index
  	@posts = Post.all.sort_by(&:vote_number).reverse
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post])
    @post.user_id = current_user.id
    if @post.save
      redirect_to(posts_path, :notice => 'Post was successfully created.')
    else
      render 'new'
    end
  end

  def show
  	@post = Post.find(params[:id])
    @comment = @post.comments.build
  end

  def upvote
    post = Post.find(params[:id])
    vote = post.votes.build
    vote.direction = "up"
    vote.user_id = current_user.id
    vote.save
    redirect_to posts_path
  end

  def downvote
    post = Post.find(params[:id])
    vote = post.votes.build
    vote.direction = "down"
    vote.user_id = current_user.id
    vote.save
    redirect_to posts_path
  end    

end
