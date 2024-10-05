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
end
