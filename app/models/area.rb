class Area
  include Mongoid::Document
  include Mongoid::Timestamps

  field :description, type: String

  has_many :behaviors

  validates :description, presence: true

  def today_score
    behaviors.includes(:events)
             .flat_map(&:events)
             .select { |event| event.created_at.to_date == Date.today }
             .sum(&:score)
  end
end
