class ExercisesController < ApplicationController
  before_action :set_exercise, only: [:edit, :update]

  def index
    # After logging in, this is where the User is always redirected.
    # This is a good place to check if any temporary Workouts have been stored.
    # If cookies[:temp_id] exists and it's not a blank string and the user is logged in...
    if cookies[:temp_id].present? && user_signed_in?
      # Get all temporarily saved Workouts for the User.
      workouts = Workout.where(temp_id: cookies[:temp_id])
      # Get rid of temporary identifier.
      cookies.delete :temp_id
      # Ensure all the temporarily saved Workouts for the User and now assigned to the User.
      workouts.each do |workout|
        workout.user_id = current_user.id
        workout.temp_id = nil
        workout.save
      end
      redirect_to workout_path(workouts.last)
    end

    if params[:desired_category].present? && params[:desired_duration].present?
      @exercises = Exercise.timed_set(params[:desired_category], params[:desired_duration])
      @workout = Workout.new
    end
  end

  def new
    @exercise = Exercise.new
  end

  def create
    @exercise = Exercise.new(exercise_params)
    @exercise.user_id = current_user.id

    if @exercise.save
      flash[:notice] = "Exercise created successfully"
      redirect_to workouts_path
    else
      render action: "new"
    end
  end

  def edit
  end

  def update
    if @exercise.update(exercise_params)
      flash[:notice] = "Exercise updated successully"
      redirect_to workouts_path
    else
      render action: "edit"
    end
  end

private
  def set_exercise
    @exercise = Exercise.find(params[:id])
  end

  def exercise_params
    params.require(:exercise).permit(:name, :description, :seconds_duration, :repetitions, :photo_url, :category, :source_url)
  end

end

