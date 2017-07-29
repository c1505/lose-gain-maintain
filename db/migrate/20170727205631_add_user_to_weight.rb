class AddUserToWeight < ActiveRecord::Migration[5.1]
  def change
    add_reference :weights, :user, index: true
  end
end