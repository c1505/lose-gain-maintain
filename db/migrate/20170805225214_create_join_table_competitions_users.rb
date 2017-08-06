class CreateJoinTableCompetitionsUsers < ActiveRecord::Migration[5.1]
  def change
    create_join_table :users, :competitions do |t|
      t.index [:user_id, :competition_id]
    end
  end
end

