class Event < ActiveRecord::Base  
  def time
    if start_time and end_time
      "#{start_time} to #{end_time}"
    else
      (start_time || end_time).to_s
    end
  end
  
  def date
    if start_date and end_date
      "#{start_date} - #{end_date}"
    else
      (start_date || end_date).to_s
    end
  end
end