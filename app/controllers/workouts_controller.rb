class WorkoutsController < ApplicationController
  before_action :authenticate_user!, except: :create

  def index
    @workouts = current_user.workouts
    @my_exercises = current_user.exercises
    @workout = Workout.new
  end

  def create
    require 'uuidtools'

    respond_to do |format|
      format.html {
        @workout = Workout.new
        @exercise_ids = params[:workout]["exercise_ids"].split(',')

        # We have two options here:
        # 1) The User is logged in, in which case we can assign the Workout to the User.
        # 2) The User is not logged in, in which case we need to generate a unique ID and assign it to the Workout.
        if user_signed_in?
          @workout.user_id = current_user.id
        else
          # Found the 'uuidtools' gem for generating a unique ID.
          # If the cookie exists, use that cookie.
          # If it does not exist, generate one.
          # Enjoy your cookies with milk!
          if cookies[:temp_id].present?
            temp_id = cookies[:temp_id]
          else
            temp_id = UUIDTools::UUID.timestamp_create.to_s
            cookies[:temp_id] = temp_id
          end
          @workout.temp_id = temp_id
        end

        @workout.save

        @exercise_ids.each do |exercise_id|
          @workout.workout_exercises.create(exercise: Exercise.find(exercise_id.to_i))
        end

        @workout.sum_duration

        if user_signed_in?
          flash[:notice] = 'Workout has been successfully saved!'
          redirect_to workout_path(@workout)
        else
          redirect_to new_user_session_path
        end
      }
      format.js {
        @workout = Workout.new(workout_params)
        @workout.user_id = current_user.id
        @workout.save
      }
    end
  end

  def show
    @workout = Workout.find(params[:id])
    @exercises = @workout.exercises
    @workout_exercises = WorkoutExercise.where(workout_id: @workout.id)
    @workout_exercises_array = []
    @workout_exercises.each do |wo_ex|
      exercise_hash = {workout_exercise_id: wo_ex.id, exercise: Exercise.find(wo_ex.exercise.id)}
      @workout_exercises_array.push(exercise_hash)
    end
  end

  def edit
    @workout = Workout.find(params[:id])
    @exercises = @workout.exercises
    @edit = true
    @workout_exercises = WorkoutExercise.where(workout_id: @workout.id)
    @workout_exercises_array = []
    @workout_exercises.each do |wo_ex|
      exercise_hash = {workout_exercise_id: wo_ex.id, exercise: Exercise.find(wo_ex.exercise.id)}
      @workout_exercises_array.push(exercise_hash)
    end
  end

  def update
    respond_to do |format|
      format.html {
        @workout = Workout.find(params[:id])
        if @workout.update(workout_params)
          redirect_to workout_path(@workout)
        else
          render :edit
        end
      }
      format.json {
        @workout = Workout.find(params[:id])
        exercise_ids = [params[:exercise_id]]
        @workout.add_exercises(exercise_ids)
        render json: @workout
      }
    end
  end

  def destroy
    workout = Workout.find(params[:id])
    workout.destroy
    redirect_to workouts_path
  end

private
  def workout_params
    params.require(:workout).permit(:name)
  end
end
