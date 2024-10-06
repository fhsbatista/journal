module TodayHelper
  def average_greater_than_previous_day?(date)
    date_average = Area.average(date)
    date_before_average = Area.average(date - 1)

    date_average > date_before_average
  end

  def average_7days_greater_than_previous_day?(date)
    days = 7
    date_average = Area.days_average(since: date, days: days)
    date_before_average = Area.days_average(since: date - 1, days: days)

    date_average > date_before_average
  end

  def score_area_greater_than_previous_day?(date, area)
    date_score = area.day_score(date)
    date_before_score = area.day_score(date - 1)

    date_score > date_before_score
  end
end
