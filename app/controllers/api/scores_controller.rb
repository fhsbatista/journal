module Api
  class ScoresController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
      @scores = Score.all
      render json: @scores
    end

    def show
      @score = Score.find(params[:id])
      render json: @score
    rescue Mongoid::Errors::DocumentNotFound
      render json: { error: 'Score not found' }, status: :not_found
    end

    def create
      @score = Score.new(score_params)
      if @score.save
        render json: @score, status: :created
      else
        render json: @score.errors, status: :unprocessable_entity
      end
    end

    def update
      @score = Score.find(params[:id])
      if @score.update(score_params)
        render json: @score
      else
        render json: @score.errors, status: :unprocessable_entity
      end
    rescue Mongoid::Errors::DocumentNotFound
      render json: { error: 'Score not found' }, status: :not_found
    end

    def destroy
      @score = Score.find(params[:id])
      @score.destroy
      head :no_content
    rescue Mongoid::Errors::DocumentNotFound
      render json: { error: 'Score not found' }, status: :not_found
    end

    private

    def score_params
      params.require(:score).permit(:score, :description, :behavior_id)
    end
  end
end
