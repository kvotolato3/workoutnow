module Api
  module V1
    class WorkoutExercisesController < ApplicationController
      respond_to :json
      def destroy
        respond_with WorkoutExercise.destroy(params[:workout_exercise_id])
      end
    end
  end
end
