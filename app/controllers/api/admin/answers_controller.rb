class Api::Admin::AnswersController < Api::Admin::ResourceController
  validate_schema true

  def create
    @answer_form = AnswerForm.new(permitted_resource_params)
    if @answer_form.save
      handle_response(@answer_form.answered_question, :created)
    else
      error_response(@answer_form.errors_hash)
    end
  end

  private

  def model_name
    'AnsweredQuestion'
  end

  def serializer_class
    AnsweredQuestionSerializer
  end

  def permitted_resource_params
    params.require(:answer).permit(
      :user_id, :question_id, :selected_choice
    )
  end
end
