# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @posts = if params[:tag]
               Post.tagged_with(params[:tag]).page(params[:page]).order('created_at DESC')
             else
               Post.page(params[:page]).order('created_at DESC')
             end
  end
end
