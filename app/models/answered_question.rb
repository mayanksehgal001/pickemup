class AnsweredQuestion < ApplicationRecord
  belongs_to :user
  belongs_to :question
  validates :selected_choice, presence: true
end
