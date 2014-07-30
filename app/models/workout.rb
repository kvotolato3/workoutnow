class Workout < ActiveRecord::Base
  has_many :workout_exercises, dependent: :destroy
  has_many :exercises, through: :workout_exercises
  belongs_to :user

  def sum_duration
    self.duration = self.exercises.sum(:seconds_duration)/60
    self.save
  end

  def add_exercises(exercise_ids)
    exercise_ids.each do |id|
      if self.workout_exercises.where(exercise_id: id).any? != true
        WorkoutExercise.create(workout_id: self.id, exercise_id: id)
      else
        # do nothing
      end
    end
    self.sum_duration
  end
end
