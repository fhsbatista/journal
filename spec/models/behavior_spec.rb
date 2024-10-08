require 'rails_helper'

RSpec.describe Behavior, type: :model do
  let(:area) { Area.create(description: 'Sample Area') }

  it 'is valid with a description' do
    behavior = Behavior.new(description: 'Test Behavior', area_id: area.id)
    expect(behavior).to be_valid
  end

  it 'is invalid without a description' do
    behavior = Behavior.new(description: nil)
    expect(behavior).to be_invalid
  end

  it 'has many scores' do
    behavior = Behavior.new(description: 'Test Behavior', area_id: area.id)
    score1 = Score.new(score: 10.0, description: 'First score', behavior:)
    score2 = Score.new(score: 8.5, description: 'Second score', behavior:)

    expect(behavior.scores).to include(score1, score2)
  end

  describe '#latest_score' do
    let!(:behavior) { Behavior.create(description: 'Sample Behavior', area_id: area.id) }
    let!(:score1) { Score.create(score: 5.0, description: 'Good', behavior:) }
    let!(:score2) { Score.create(score: 6.0, description: 'Great', behavior:) }

    it 'returns the latest score' do
      expect(behavior.latest_score).to eq(score2)
    end

    it 'returns nil if no scores exist' do
      behavior.scores.delete_all # Remove all scores
      expect(behavior.latest_score).to be_nil
    end
  end

  describe '#performed_at?' do
    let!(:behavior) { Behavior.create(description: 'Sample Behavior', area_id: area.id) }
    let!(:score1) { Score.create(score: 5.0, description: 'Good', behavior:) }

    before do
      Event.create(behavior: behavior)
    end

    it { expect(behavior.performed_at?(Date.current)).to eq(true) }
    it { expect(behavior.performed_at?(Date.yesterday)).to eq(false) }
  end

  describe '#delete_events_at' do
    let!(:behavior) { Behavior.create(description: 'Sample Behavior', area_id: area.id) }
    let!(:score1) { Score.create(score: 5.0, description: 'Good', behavior:) }

    it 'destroy all events in given date' do
      Event.create(behavior: behavior)

      behavior.delete_events_at(Date.current)

      range = Date.current.beginning_of_day..Date.current.end_of_day
      events = behavior.events.where(created_at: range)
      expect(events).to be_empty
    end
  end
end
