class AddStatusIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :status_id, :integer
  end
end
