require 'rails_helper'

RSpec.describe Area, type: :model do
  it'is valid with a description' do
    area = Area.new(description: 'Sample Area')
    expect(area).to be_valid
  end

  it 'is invalid without a description' do
    area = Area.new(description: nil)
    expect(area).to be_invalid
    expect(area.errors[:description]).to include("can't be blank")
  end

  it 'has many behaviors' do
    area = Area.new(description: 'Sample Area')
    behavior1 = Behavior.new(description: 'Behavior 1', area:)
    behavior2 = Behavior.new(description: 'Behavior 2', area:)

    expect(area.behaviors).to include(behavior1, behavior2)
  end
end
