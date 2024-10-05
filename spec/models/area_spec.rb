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

  describe '#today_score' do
    let!(:area) { Area.create(description: 'Sample Area') }
    let!(:behavior1) { Behavior.create(description: 'Test Behavior', area: area) }
    let!(:behavior2) { Behavior.create(description: 'Test Behavior 2 ', area: area) }
    let!(:behavior3) { Behavior.create(description: 'Test Behavior 3', area: area) }
    let!(:score1) { Score.create(score: 5.0, description: 'Score 1', behavior: behavior1) }
    let!(:score2) { Score.create(score: 10.0, description: 'Score 2', behavior: behavior2) }
    let!(:score3) { Score.create(score: 2.0, description: 'Score 3', behavior: behavior3) }
    let!(:event1) { Event.create(behavior: behavior1, created_at: Date.yesterday) }
    let!(:event2) { Event.create(behavior: behavior2, created_at: Date.today) }
    let!(:event3) { Event.create(behavior: behavior3, created_at: Date.today) }

    before do
      event1.save
      event2.save
      event3.save
    end

    fit 'returns the total score of all today events for all behaviors' do
      expect(area.today_score).to eq(12.0) # 10.0 + 2.0
    end
  end
end
