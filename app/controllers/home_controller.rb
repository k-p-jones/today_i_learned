# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @posts = Post.page(params[:page]).order('created_at DESC')
  end
end
