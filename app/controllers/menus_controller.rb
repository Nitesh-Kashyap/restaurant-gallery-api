class MenusController < ApplicationController
  before_action :set_restaurant

  def show
    render json: @restaurant.menu, status: :ok
  end

  def create
    menu = @restaurant.build_menu(menu_params)
    if menu.save
      render json: menu, status: :created
    else
      render json: { errors: menu.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @restaurant.menu.update(menu_params)
      render json: @restaurant.menu, status: :ok
    else
      render json: { errors: @restaurant.menu.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @restaurant.menu.destroy
      render json: { message: "Menu deleted successfully" }, status: :ok
    else
      render json: { errors: "Something went wrong" }, status: :unprocessable_entity
    end
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def menu_params
    params.require(:menu).permit(:name)
  end
end
