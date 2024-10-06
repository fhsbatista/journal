class BehaviorsController < ApplicationController
  def delete_events_today
    behavior = Behavior.find(params[:id])
    behavior.delete_events_at(Date.current)
    head :no_content
  rescue Mongoid::Errors::DocumentNotFound
    render json: { error: 'Behavior not found' }, status: :not_found
  end

  def create_event_today
    behavior = Behavior.find(params[:id])
    Event.create(behavior: behavior)
    head :no_content
  rescue Mongoid::Errors::DocumentNotFound
    render json: { error: 'Behavior not found' }, status: :not_found
  end
end
