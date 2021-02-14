class AnswerForm < BaseForm
  attr_reader :answered_question

  def initialize(params, answered_question = nil)
    @answered_question = answered_question || AnsweredQuestion.new
    super(params)
  end

  def save
    return false unless valid?

    AnsweredQuestion.transaction do
      assign_attributes
      return saved_to_db
    end
  end

  def self.save(params, answered_question = nil)
    obj = new(params, answered_question)
    obj.save
    obj
  end

  private

  def assign_attributes
    @answered_question.assign_attributes(
      @params.output
    )
    @answered_question.correct = correct?
  end

  def correct?
    question = Question.find(@params[:question_id])
    @answered_question.selected_choice == question.correct_choice
  end

  def saved_to_db
    unless @answered_question.save
      @errors.add_hash(@answered_question.errors.messages)
      return false
    end
    true
  end

  def assign_params(params)
    schema_klass.call(params)
  end

  def schema_klass
    AnsweredQuestionSchema::Create
  end
end
