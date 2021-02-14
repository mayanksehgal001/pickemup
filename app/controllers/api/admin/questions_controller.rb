class Api::Admin::QuestionsController < Api::Admin::ResourceController

  def index
    question_ids = current_user.answered_questions.pluck(:question_id)
    @questions = Question.where.not(id: question_ids)
    @questions = @questions.ransack(params[:filter]).result
    @questions = sort_query if params[:sort].present?
    @questions = @questions.page(params[:page]).per(per_page_value)
    handle_response(@questions, :ok, pagination_meta_info(@questions))
  end
end
