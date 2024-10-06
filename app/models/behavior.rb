class Behavior
  include Mongoid::Document
  include Mongoid::Timestamps

  field :description, type: String

  has_many :scores
  has_many :events
  belongs_to :area

  validates :description, presence: true

  def latest_score
    scores.order_by(created_at: :desc).first
  end

  def performed_at?(date)
    day_range = date.beginning_of_day..date.end_of_day
    events.where(created_at: day_range).exists?
  end

  def delete_events_at(date)
    day_range = date.beginning_of_day..date.end_of_day
    day_events = events.where(created_at: day_range)
    day_events.each(&:destroy!)
  end
end
