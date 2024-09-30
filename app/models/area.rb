class Area
  include Mongoid::Document
  include Mongoid::Timestamps

  field :description, type: String

  has_many :behaviors

  validates :description, presence: true
end
