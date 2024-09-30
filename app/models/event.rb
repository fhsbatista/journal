class Event
  include Mongoid::Document
  include Mongoid::Timestamps

  field :score, type: Float

  belongs_to :behavior

  validates :score, presence: true
  validates :behavior, presence: true
  validate :behavior_must_have_latest_score

  before_validation :set_score

  def initialize(attributes = {})
    super(attributes.except(:score))
  end

  private

  def set_score
    self.score = behavior.latest_score&.score if behavior
  end

  def behavior_must_have_latest_score
    if behavior && behavior.latest_score.nil?
      errors.add(:behavior, 'must have a latest score')
    end
  end
end
