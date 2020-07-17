# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.page(params[:page]).order('created_at DESC')
  end
end
