class Api::V4::Games::CategoriesController < Api::V4::ApplicationController
  before_action :set_game, only: [:index, :show]
  before_action :set_category, only: [:show]

  def index
    render json: @game.categories, each_serializer: Api::V4::CategorySerializer
  end

  def show
    render json: @category, serializer: Api::V4::CategorySerializer
  end

  private

  def set_category
    @category = @game.categories.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render not_found(:category, params[:id])
  end
end
