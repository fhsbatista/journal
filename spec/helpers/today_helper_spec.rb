require 'rails_helper'

RSpec.describe TodayHelper, type: :helper do
  describe '#average_greater_than_previous_day?' do
    let(:date) { Date.current }

    before do
      allow(Area).to receive(:average).with(date).and_return(current_average)
      allow(Area).to receive(:average).with(date - 1).and_return(previous_average)
    end

    context 'when current average is greater than previous average' do
      let(:current_average) { 10 }
      let(:previous_average) { 5 }

      it 'returns true' do
        expect(helper.average_greater_than_previous_day?(date)).to be true
      end
    end

    context 'when current average is less than or equal to previous average' do
      let(:current_average) { 5 }
      let(:previous_average) { 10 }

      it 'returns false' do
        expect(helper.average_greater_than_previous_day?(date)).to be false
      end
    end
  end

  describe '#average_7days_greater_than_previous_day?' do
    let(:date) { Date.current }

    before do
      allow(Area).to receive(:days_average).with(since: date, days: 7).and_return(current_7days_average)
      allow(Area).to receive(:days_average).with(since: date - 1, days: 7).and_return(previous_7days_average)
    end

    context 'when current 7 days average is greater than previous average' do
      let(:current_7days_average) { 10 }
      let(:previous_7days_average) { 5 }

      it 'returns true' do
        expect(helper.average_7days_greater_than_previous_day?(date)).to be true
      end
    end

    context 'when current 7 days average is less than or equal to previous average' do
      let(:current_7days_average) { 5 }
      let(:previous_7days_average) { 10 }

      it 'returns false' do
        expect(helper.average_greater_than_previous_day?(date)).to be false
      end
    end
  end

  describe '#score_area_greater_than_previous_day?' do
    let(:area) { Area.create(description: 'Sample Area') }
    let(:date) { Date.current }

    before do
      allow(area).to receive(:day_score).with(date).and_return(current_day_score)
      allow(area).to receive(:day_score).with(date - 1).and_return(previous_day_score)
    end

    context 'when current score is greater than previous day score' do
      let(:current_day_score) { 10 }
      let(:previous_day_score) { 5 }

      it 'returns true' do
        expect(helper.score_area_greater_than_previous_day?(date, area)).to be true
      end
    end

    context 'when current score is less than or equal previous day score' do
      let(:current_day_score) { 5 }
      let(:previous_day_score) { 10 }

      it 'returns true' do
        expect(helper.score_area_greater_than_previous_day?(date, area)).to be false
      end
    end
  end

  describe '#previous_7days_scores' do
    let(:area) { Area.create(description: 'Sample Area') }
    let(:date) { Date.current }
    let(:scores) { [1.654, 1.5, 2, 2, 2, 2, 2] }

    before do
      7.times.each do |i|
        allow(area).to receive(:day_score).with(date - i).and_return(scores[i])
      end
    end

    it 'returns array' do
      expect(helper.previous_7days_scores(date, area)).to eq scores.reverse
    end
  end
end
