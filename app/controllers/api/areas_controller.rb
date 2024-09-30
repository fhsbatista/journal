class Api::AreasController < ApplicationController
  def index
    areas = Area.all
    render json: areas, status: :ok
  end

  def show
    area = Area.find(params[:id])
    render json: area, status: :ok
  rescue Mongoid::Errors::DocumentNotFound
    render json: { error: 'Area not found' }, status: :not_found
  end

  def create
    area = Area.new(area_params)
    if area.save
      render json: area, status: :created
    else
      render json: { errors: area.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    area = Area.find(params[:id])
    if area.update(area_params)
      render json: area, status: :ok
    else
      render json: { errors: area.errors.full_messages }, status: :unprocessable_entity
    end
  rescue Mongoid::Errors::DocumentNotFound
    render json: { error: 'Area not found' }, status: :not_found
  end

  def destroy
    area = Area.find(params[:id])
    area.destroy
    head :no_content
  rescue Mongoid::Errors::DocumentNotFound
    render json: { error: 'Area not found' }, status: :not_found
  end

  private

  def area_params
    params.require(:area).permit(:description)
  end
end
