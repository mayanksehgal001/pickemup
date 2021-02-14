class AnsweredQuestionSerializer < BaseSerializer
  set_type :answered_question
  set_id :id
  attributes :correct, :user_id, :question_id, :selected_choice

  belongs_to :user
  belongs_to :question
end
