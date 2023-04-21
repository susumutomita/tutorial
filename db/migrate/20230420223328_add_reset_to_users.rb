# reset_sent_at: Time.zone.now
class AddResetToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :reset_sent_at, :datetime
  end
end
