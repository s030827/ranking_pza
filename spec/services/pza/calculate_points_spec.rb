require 'rails_helper'

describe PZA::CalculatePoints do
  describe 'call' do
    let(:line) { build(:line, grade: '8a') }
    let(:ascent) { build(:ascent, line: line, style: 'RP' ) }
    subject { described_class.new(ascent).call }

    it 'correctly calculates points' do
      expect(subject).to eq(700)
    end

    context 'grade not in the list' do
      let(:line) { build(:line, grade: '4c') }

      it 'returns 0' do
        expect(subject).to eq(0)
      end
    end

    context 'grade with forward slash' do
      let(:line) { build(:line, grade: '8b+/c') }

      it 'returns points for a grade before slash' do
        expect(subject).to eq(850)
      end
    end
  end
end
