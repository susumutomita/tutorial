# add reset digest to users
class AddResetDigestToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :reset_digest, :string
  end
end
