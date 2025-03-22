class DishesController < ApplicationController
  before_action :set_menu
  before_action :set_dish, only: [:show, :update, :destroy]

  def index
    render json: @menu.dishes, status: :ok
  end

  def show
    render json: @dish, status: :ok
  end

  def create
    dish = @menu.dishes.new(dish_params)

    if dish.save
      render json: dish, status: :created
    else
      render json: { errors: dish.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @dish.update(dish_params)
      render json: @dish, status: :ok
    else
      render json: { errors: @dish.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @dish.destroy
      render json: { message: "Dish deleted successfully" }, status: :ok
    else
      render json: { errors: "Something went wrong" }, status: :unprocessable_entity
    end
  end

  private

  def set_menu
    @menu = Menu.find_by(restaurant_id: params[:restaurant_id])
    render json: { error: "Menu not found" }, status: :not_found unless @menu
  end

  def set_dish
    @dish = @menu.dishes.find_by(id: params[:id])
    render json: { error: "Dish not found" }, status: :not_found unless @dish
  end

  def dish_params
    params.require(:dish).permit(:name, :price)
  end
end
