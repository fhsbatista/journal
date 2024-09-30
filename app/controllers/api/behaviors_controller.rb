module Api
  class BehaviorsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
      @behaviors = Behavior.all
      render json: @behaviors
    end

    def show
      @behavior = Behavior.find(params[:id])
      render json: @behavior
    rescue Mongoid::Errors::DocumentNotFound
      render json: { error: 'Behavior not found' }, status: :not_found
    end

    def create
      @behavior = Behavior.new(behavior_params)
      if @behavior.save
        render json: @behavior, status: :created
      else
        render json: @behavior.errors, status: :unprocessable_entity
      end
    end

    def update
      @behavior = Behavior.find(params[:id])
      if @behavior.update(behavior_params)
        render json: @behavior
      else
        render json: @behavior.errors, status: :unprocessable_entity
      end
    rescue Mongoid::Errors::DocumentNotFound
      render json: { error: 'Behavior not found' }, status: :not_found
    end

    def destroy
      @behavior = Behavior.find(params[:id])
      @behavior.destroy
      head :no_content
    rescue Mongoid::Errors::DocumentNotFound
      render json: { error: 'Behavior not found' }, status: :not_found
    end

    def latest_score
      behavior = Behavior.find(params[:id])
      latest_score = behavior.latest_score

      if latest_score
        render json: latest_score
      else
        render json: { message: 'No scores found for this behavior' }, status: :not_found
      end
    rescue Mongoid::Errors::DocumentNotFound
      render json: { error: 'Behavior not found' }, status: :not_found
    end

    def create_event
      behavior = Behavior.find(params[:id])
      event = Event.new(behavior: behavior)

      if event.save
        render json: event, status: :created
      else
        render json: { errors: event.errors.full_messages }, status: :unprocessable_entity
      end
    rescue Mongoid::Errors::DocumentNotFound
      render json: { error: 'Behavior not found' }, status: :not_found
    end

    private

    def behavior_params
      params.require(:behavior).permit(:description)
    end
  end
end
