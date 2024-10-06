require 'rails_helper'

RSpec.describe TodayHelper, type: :helper do
  fdescribe '#average_greater_than_previous_day?' do
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
end
