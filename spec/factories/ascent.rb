FactoryBot.define do
  factory :ascent, class: Ascent do
    user
    line
    style 'RP'
    date '2018-02-13'
    kind 'b'
    belayer ''
  end
end
