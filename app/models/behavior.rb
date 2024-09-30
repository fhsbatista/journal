class Behavior
  include Mongoid::Document
  include Mongoid::Timestamps

  field :description, type: String

  has_many :scores

  validates :description, presence: true

  def latest_score
    scores.order_by(created_at: :desc).first
  end
end
