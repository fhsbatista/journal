module TodayHelper
  def average_greater_than_previous_day?(date)
    date_average = Area.average(date)
    date_before_average = Area.average(date - 1)

    date_average > date_before_average
  end
end
