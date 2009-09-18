class Event < ActiveRecord::Base  
  
  validates_presence_of :start_date
  validates_presence_of :start_time
  validates_presence_of :description
  validates_presence_of :location
  
  default_scope :order => 'start_date DESC'
  
  def to_json
    hash = attributes
    hash['time'] = time
    hash['date'] = date
    hash.to_json
  end
  
  def time
    s = (!start_time.blank? and !end_time.blank?) ?
      "#{start_time} to #{end_time}" :      
      (start_time || end_time).to_s
      
    s.gsub!(/\s0/, ' ')
    s.gsub!(/^0/, '')
  end
  
  def date
    s = start_date && start_date.strftime("%b, %d, %Y")
    e = end_date && end_date.strftime("%b, %d, %Y")
    
    return s if s == e
    
    if s and e
      "#{s} - <br /> #{e}"
    else
      (s || e).to_s
    end
  end
end