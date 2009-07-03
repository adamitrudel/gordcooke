class ReplaceDateWithStartDateAndEndDateTimeWithStartTimeAndEndTimeForEvents < ActiveRecord::Migration
  def self.up
    remove_column :events, :date
    remove_column :events, :time
    
    add_column :events, :start_date, :date
    add_column :events, :end_date, :date
    
    add_column :events, :start_time, :string
    add_column :events, :end_time, :string
  end

  def self.down
    add_column :events, :date, :string
    add_column :events, :time, :string
    
    remove_column :events, :start_date
    remove_column :events, :end_date
    
    remove_column :events, :start_time
    remove_column :events, :end_time
  end
end
