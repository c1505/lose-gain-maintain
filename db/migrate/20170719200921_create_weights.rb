class CreateWeights < ActiveRecord::Migration[5.1]
  def change
    create_table :weights do |t|
      t.float :pounds

      t.timestamps
    end
  end
end
