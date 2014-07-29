module Api
  module V1
    class WorkoutsController < ApplicationController
      respond_to :json

      def index
        respond_with Workout.all
      end

      def show
        respond_with Workout.find(params[:id])
      end

      def create
        @workout = Workout.new(workout_params)
        @workout.user_id = current_user.id
        if @workout.save
          respond_with @workout
        end
      end

      def update
        respond_with Workout.update(workout_params)
      end

      def destroy
        respond_with Workout.destroy(params[:id])
      end

      private
      def workout_params
        params.require(:workout).permit(:name)
      end
    end # class WorkoutsController
  end # module v1
end # module api
