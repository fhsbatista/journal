require 'rails_helper'

RSpec.describe Event, type: :model do
  let!(:area) { Area.create(description: 'Sample Area') }
  let!(:behavior) { Behavior.create(description: 'Sample Behavior', area_id: area.id) }
  let!(:score) { Score.create(score: 8.0, description: 'Test Score', behavior: behavior) }

  it 'is valid with a behavior and calculates the score' do
    event = Event.create(behavior: behavior)
    expect(event).to be_valid
    expect(event.score).to eq(8.0)
  end

  it 'is invalid without a behavior' do
    event = Event.create(behavior: nil)
    expect(event).to be_invalid
    expect(event.errors[:behavior]).to include("can't be blank")
  end

  it 'is invalid if behavior has no scores' do
    event = Event.create(behavior: behavior)
    behavior.scores = []
    expect(event).to be_invalid
    expect(event.errors[:behavior]).to include("must have a latest score")
  end

  it 'does not allow score to be set directly' do
    event = Event.create(score: 5.0, behavior: behavior)
    expect(event.score).to eq(8.0) # Should take the latest score
    expect(event).to be_valid
  end
end
