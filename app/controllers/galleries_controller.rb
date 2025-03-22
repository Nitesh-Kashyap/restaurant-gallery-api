class GalleriesController < ApplicationController
  before_action :set_restaurant
  before_action :set_gallery, only: [:show, :update, :destroy]

  def index
    render json: @restaurant.galleries.as_json(methods: :image_urls), status: :ok
  end

  def show
    render json: @gallery.as_json(methods: :image_urls), status: :ok
  end

  def create
    gallery = @restaurant.galleries.new(gallery_params)

    if gallery.save
      render json: gallery.as_json(methods: :image_urls), status: :created
    else
      render json: { errors: gallery.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @gallery.update(gallery_params)
      render json: @gallery.as_json(methods: :image_urls), status: :ok
    else
      render json: { errors: @gallery.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @gallery.destroy
      render json: { message: "Gallery deleted successfully" }, status: :ok
    else
      render json: { errors: "Something went wrong" }, status: :unprocessable_entity
    end
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find_by(id: params[:restaurant_id])
    render json: { error: "Restaurant not found" }, status: :not_found unless @restaurant
  end

  def set_gallery
    @gallery = @restaurant.galleries.find_by(id: params[:id])
    render json: { error: "Gallery not found" }, status: :not_found unless @gallery
  end

  def gallery_params
    params.require(:gallery).permit(:name, :description, images: [])
  end
end
