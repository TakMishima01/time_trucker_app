class AddOngoingToStudySessions < ActiveRecord::Migration[6.1]
  def change
    add_column :study_sessions, :ongoing, :boolean, default: false
  end
end
