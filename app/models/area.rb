class Area
  include Mongoid::Document
  include Mongoid::Timestamps

  field :description, type: String

  has_many :behaviors

  validates :description, presence: true

  def day_score(date)
    Event.collection.aggregate([
      { "$match": {
          created_at: { "$gte": date.beginning_of_day, "$lte": date.end_of_day },
          behavior_id: { "$in": behaviors.pluck(:id) }
        }
      },
      { "$group": {
          _id: nil,
          total_score: { "$sum": "$score" }
        }
      }
    ]).first&.dig('total_score') || 0
  end

  def self.average(date)
    scores = Event.collection.aggregate([
      { "$match": {
          created_at: { "$gte": date.beginning_of_day, "$lte": date.end_of_day }
        }
      },
      { "$group": {
          _id: "$behavior_id",
          total_score: { "$sum": "$score" }
        }
      }
    ])

    total_score = scores.sum { |score| score['total_score'] }
    area_count = Area.count

    (area_count.zero? ? 0 : (total_score / area_count.to_f)).round(3)
  end


  def self.days_average(since:, days:)
    total_averages = (0...days).sum do |i|
      average(since - i)
    end

    (days.zero? ? 0 : (total_averages / days)).round(3)
  end

end
