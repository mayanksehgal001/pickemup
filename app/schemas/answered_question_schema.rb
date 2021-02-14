module AnsweredQuestionSchema
  Create = Dry::Schema.Params do
    required(:selected_choice).filled(:integer)
    required(:user_id).filled(:string)
    required(:question_id).filled(:string)
  end
end
