# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    description { Faker::Lorem.paragraph(sentence_count: 2, supplemental: true) }
    choice1 { Faker::Lorem.word }
    choice2 { Faker::Lorem.word }
    correct_choice { [1,2].sample }
  end
end
