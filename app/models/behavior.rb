class Behavior
  include Mongoid::Document
  include Mongoid::Timestamps

  field :description, type: String

  has_many :scores

  validates :description, presence: true
end
