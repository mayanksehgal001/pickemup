class Question < ApplicationRecord
  validates  :description, :choice1, :choice2, presence: true
  validates  :correct_choice, presence: true, inclusion: { in: [1,2] }
end
