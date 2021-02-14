class StatisticsService
  include ActiveModel::Model

  attr_accessor :errors, :statistics, :current_user

  def initialize(attributes = {})
    super
    @statistics = {}
    @errors = {}
  end

  def call
    @statistics[:questions_answered] = @current_user.answered_questions.count
    @statistics[:correct_answers] = @current_user.correct_answers.count
    @statistics[:wrong_answers] = @current_user.wrong_answers.count
    if @statistics[:questions_answered] > 0
      @statistics[:score] = (@statistics[:correct_answers] * 100).to_f / @statistics[:questions_answered]
    else
      @statistics[:score] = 0
    end
    return @statistics
  end
end

