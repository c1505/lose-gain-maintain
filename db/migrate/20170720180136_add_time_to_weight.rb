class AddTimeToWeight < ActiveRecord::Migration[5.1]
  def change
    add_column :weights, :date, :datetime
  end
end
