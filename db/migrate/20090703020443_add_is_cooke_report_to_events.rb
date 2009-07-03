class AddIsCookeReportToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :is_cooke_report, :boolean
  end

  def self.down
    remove_column :events, :is_cooke_report
  end
end
