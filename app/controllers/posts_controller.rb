# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_post, except: %i[new create]

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = 'New post created.'
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:notice] = 'Post updated.'
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    if @post.destroy
      flash[:notice] = 'Post deleted.'
    else
      flash[:alert] = 'There was a problem deleting your post.'
    end
    redirect_to user_root_path
  end

  private

  def set_post
    @post = Post.find_by_id(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :tag_list)
  end
end
