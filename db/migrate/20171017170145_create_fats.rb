class CreateFats < ActiveRecord::Migration[5.1]
  def change
    create_table :fats do |t|
      t.float :skinfold
      t.float :percentage
      t.references :user
      t.datetime :date

      t.timestamps
    end
  end
end
