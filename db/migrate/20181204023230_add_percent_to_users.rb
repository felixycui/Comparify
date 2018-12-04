class AddPercentToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :percent, :integer
  end
end
