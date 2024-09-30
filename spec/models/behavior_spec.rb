require 'rails_helper'

RSpec.describe Behavior, type: :model do
  it 'is valid with a description' do
    behavior = Behavior.new(description: 'Test Behavior')
    expect(behavior).to be_valid
  end

  it 'is invalid without a description' do
    behavior = Behavior.new(description: nil)
    expect(behavior).to be_invalid
  end

  it 'has many scores' do
    behavior = Behavior.new(description: 'Test Behavior')
    score1 = Score.new(score: 10.0, description: 'First score', behavior: behavior)
    score2 = Score.new(score: 8.5, description: 'Second score', behavior: behavior)

    expect(behavior.scores).to include(score1, score2)
  end
end
