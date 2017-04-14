class StaticPagesController < ApplicationController
  def index
  end

  def current
    render json: current_user
  end
end
