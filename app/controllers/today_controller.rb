class TodayController < ApplicationController
  include TodayHelper

  def index
    @areas = []
  end
end
