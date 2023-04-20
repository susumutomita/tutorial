# Adds reset users
class AddResetToUsers < ActiveRecord::Migration[7.0]
  def change
    # Add a reset digest to users
    add_column :users, :reset_digest, :string
  end
end
