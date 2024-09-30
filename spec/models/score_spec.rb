require 'rails_helper'

RSpec.describe Score, type: :model do
  it 'is valid with a score and a behavior' do
    behavior = Behavior.new(description: 'Test Behavior')
    score = Score.new(score: 10.0, description: 'Test Score', behavior: behavior)
    expect(score).to be_valid
  end

  it 'is invalid without a score' do
    behavior = Behavior.new(description: 'Test Behavior')
    score = Score.new(score: nil, behavior: behavior)
    expect(score).to be_invalid
  end

  it 'is invalid without a behavior' do
    score = Score.new(score: 10.0, behavior: nil)
    expect(score).to be_invalid
  end

  it 'belongs to a behavior' do
    behavior = Behavior.new(description: 'Test Behavior')
    score = Score.new(score: 10.0, description: 'Test Score', behavior: behavior)

    expect(score.behavior).to eq(behavior)
  end
end
