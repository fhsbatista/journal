class TodayController < ApplicationController
  include TodayHelper

  def index
    @areas = Area.all
  end
end
