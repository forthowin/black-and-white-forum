module ApplicationHelper
  MINUTE_IN_SECONDS = 60
  HOUR_IN_SECONDS = MINUTE_IN_SECONDS * 60
  DAY_IN_SECONDS = HOUR_IN_SECONDS * 24
  MONTH_IN_SECONDS = DAY_IN_SECONDS * 30
  YEAR_IN_SECONDS = MONTH_IN_SECONDS * 12

  def time_difference(dt)
    diff = TimeDifference.between(Time.zone.now, dt).in_seconds

    case
    when diff < MINUTE_IN_SECONDS
      "#{diff.to_i} " + "second".pluralize(diff.to_i) + " ago"
    when diff.between?(MINUTE_IN_SECONDS, HOUR_IN_SECONDS)
      diff = TimeDifference.between(Time.zone.now, dt).in_minutes.to_i
      "#{diff} " + "minute".pluralize(diff) + " ago"
    when diff.between?(HOUR_IN_SECONDS, DAY_IN_SECONDS)
      diff = TimeDifference.between(Time.zone.now, dt).in_hours.to_i
      "#{diff} " + "hour".pluralize(diff) + " ago"
    when diff.between?(DAY_IN_SECONDS, MONTH_IN_SECONDS)
      diff = TimeDifference.between(Time.zone.now, dt).in_days.to_i
      "#{diff} " + "day".pluralize(diff) + " ago"
    when diff.between?(MONTH_IN_SECONDS, YEAR_IN_SECONDS)
      diff = TimeDifference.between(Time.zone.now, dt).in_months.to_i
      "#{diff} " + "month".pluralize(diff) + " ago"
    when diff > YEAR_IN_SECONDS
      diff = TimeDifference.between(Time.zone.now, dt).in_years.to_i
      "#{diff} " + "year".pluralize(diff) + " ago"
    end
  end

  def display_recent_subject_or_post_time(subject)
    if subject.posts.empty?
      time_difference(subject.created_at)
    else
      time_difference(subject.posts.last.created_at)
    end
  end

  def normalize_post_number(index)
    params[:page] ||= 1
    index + 1 + 10 * (params[:page].to_i - 1)
  end
end
