class HomeController < ApplicationController
  def index
    redirect_to '/api/v1/probes/current_position'
  end
end
