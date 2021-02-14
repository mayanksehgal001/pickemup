class DashboardsController < ApplicationController
  def index
    render inline: '', layout: 'pickemup'
  end

  def show
    render inline: '', layout: 'pickemup'
  end
end
