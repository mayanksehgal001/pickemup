class Api::Admin::StatisticsController < Api::BaseController

  def show
    statistics = StatisticsService.new({current_user: current_user}).call
    json_response({ data: statistics})
  end
end
