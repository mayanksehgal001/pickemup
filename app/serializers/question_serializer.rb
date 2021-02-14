class QuestionSerializer < BaseSerializer
  set_type :question
  set_id :id
  attributes :description, :choice1, :choice2
end
