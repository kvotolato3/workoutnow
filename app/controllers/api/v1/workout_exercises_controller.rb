module Api
  module V1
    class WorkoutExercisesController < ApplicationController
      respond_to :json
      def destroy
        respond_with WorkoutExercise.destroy(params[:id])
      end
    end
  end
end
