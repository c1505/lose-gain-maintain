class CreateGoals < ActiveRecord::Migration[5.1]
  def change
    create_table :goals do |t|
      t.float :weight
      t.datetime :start_date
      t.datetime :target_date
      t.float :tolerence_above
      t.float :tolerence_below
      t.references :user, foreign_key: true
      
      t.timestamps
    end
  end
end
