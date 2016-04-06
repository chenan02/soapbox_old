class AddFrequencyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :frequency, :integer
  end
end
