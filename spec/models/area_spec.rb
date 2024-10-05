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

  describe '#day_score' do
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

    it 'returns the total score of all today events for all behaviors' do
      expect(area.day_score(Date.today)).to eq(12.0) # 10.0 + 2.0
    end
  end

  describe '#areas day average' do
    let!(:health) { Area.create(description: 'Health') }
    let!(:finances) { Area.create(description: 'Finances') }
    let!(:work) { Area.create(description: 'Work') }
    let!(:exercises) { Behavior.create(description: 'Exercices', area: health) }
    let!(:eat_clean) { Behavior.create(description: 'Eat clean', area: health) }
    let!(:conciliation) { Behavior.create(description: 'Bank accounts conciliation', area: finances) }
    let!(:pay_bills) { Behavior.create(description: 'Pay all bills', area: finances) }
    let!(:pomodoros) { Behavior.create(description: '3 pomodoros', area: work) }
    let!(:score1) { Score.create(score: 2.0, behavior: exercises) }
    let!(:score2) { Score.create(score: 3.0, behavior: eat_clean) }
    let!(:score3) { Score.create(score: 2.0, behavior: conciliation) }
    let!(:score4) { Score.create(score: 1.0, behavior: pay_bills) }
    let!(:score5) { Score.create(score: 3.0, behavior: pomodoros) }
    let!(:event1) { Event.create(behavior: exercises, created_at: Date.yesterday) }
    let!(:event2) { Event.create(behavior: pay_bills, created_at: Date.yesterday) }
    let!(:event3) { Event.create(behavior: pomodoros, created_at: Date.yesterday) }
    let!(:event4) { Event.create(behavior: exercises, created_at: Date.today) }
    let!(:event5) { Event.create(behavior: eat_clean, created_at: Date.today) }
    let!(:event6) { Event.create(behavior: conciliation, created_at: Date.today) }
    let!(:event7) { Event.create(behavior: pay_bills, created_at: Date.today) }
    let!(:event8) { Event.create(behavior: pomodoros, created_at: Date.today) }

    before do
      event1.save
      event2.save
      event3.save
      event4.save
      event5.save
      event6.save
    end

    it 'returns the total score of all today events for all behaviors' do
      expect(Area.average(Date.yesterday)).to eq(2)
      expect(Area.average(Date.today)).to eq(3.667)
    end
  end
end
