class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :update, :destroy]

  def index
    restaurants = Restaurant.all
    render json: restaurants, status: :ok
  end

  def show
    render json: @restaurant, status: :ok
  end

  def create
    restaurant = Restaurant.new(restaurant_params)

    if restaurant.save
      render json: restaurant, status: :created
    else
      render json: { errors: restaurant.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @restaurant.update(restaurant_params)
      render json: @restaurant, status: :ok
    else
      render json: { errors: @restaurant.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @restaurant.destroy
      render json: { message: "Restaurant deleted successfully" }, status: :ok
    else
      render json: { errors: "Something went wrong" }, status: :unprocessable_entity
    end
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find_by(id: params[:id])
    render json: { error: "Restaurant not found" }, status: :not_found unless @restaurant
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :description)
  end
end
