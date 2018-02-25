require 'rails_helper'

describe PZA::CalculatePoints do
  describe 'call' do
    let(:line) { build(:line, grade: '8a') }
    let(:ascent) { build(:ascent, line: line, style: 'RP' ) }
    subject { described_class.new(ascent).call }

    it 'correctly calculates points' do
      expect(subject).to eq(700)
    end
  end
end
