class AddConstraintsToExercises < ActiveRecord::Migration
  def up
    change_table :exercises do |t|
      t.change :name, :string, null: false
      t.change :description, :text, null: false
      t.change :seconds_duration, :integer, null: false
    end
  end

  def down
    change_table :exercises do |t|
      t.change :name, :string
      t.change :description, :text
      t.change :seconds_duration, :integer
    end
  end
end
