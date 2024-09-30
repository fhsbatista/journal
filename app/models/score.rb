class Score
  include Mongoid::Document
  include Mongoid::Timestamps

  field :score, type: Float
  field :description, type: String

  belongs_to :behavior

  validates :score, presence: true
  validates :behavior, presence: true
end
