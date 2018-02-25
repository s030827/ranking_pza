require 'rails_helper'

describe PZA::CalculateYearPoints do
  describe '#call' do
    let(:user) { create(:user) }
    let(:line) { create(:line) }
    before do
      11.times do |n|
        date = Date.parse('2018-01-01') + 1.month
        user.ascents << create(:ascent, line: line, date: date, kind: 'b', points: 100)
      end
    end
    subject { described_class.new(user, '2018', 'b').call }

    it '10 times 100 is 1000 points' do
      expect(subject).to eq(1000)
    end
  end
end
