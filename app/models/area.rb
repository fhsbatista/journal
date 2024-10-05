class Area
  include Mongoid::Document
  include Mongoid::Timestamps

  field :description, type: String

  has_many :behaviors

  validates :description, presence: true

  def day_score(date)
    behaviors.includes(:events)
             .flat_map(&:events)
             .select { |event| event.created_at.to_date == date }
             .sum(&:score)
  end

  def self.average(date)
    scores = Area.all.map { |area| area.day_score(date) }
    average = (scores.sum / Area.count.to_f)
    average.round(3)
  end
end
