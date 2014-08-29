$(document).ready(function(){
  $('#plus-workout').click(App.showWorkoutForm);
  $('#cncl-workout').click(App.hideWorkoutForm);
  $('.wo-ex-remove').click(App.removeWorkoutExercise);
});

var App = App || {};

App.showWorkoutForm = function() {
  $('#workout-form').slideToggle();
  $('#plus-workout').hide();
};

App.hideWorkoutForm = function() {
  $('#workout-form').slideToggle();
  $('#plus-workout').show();
};

App.clearWorkoutForm = function() {
  $('input[name="workout[name]"]').val("");
};

App.removeWorkoutExercise = function() {
  if (window.confirm('Remove exercise from workout?') === true) {
    var $woExId = $(this).data("id");
    var $editWoId = $('#wo-heading').data("id");
    $.ajax({
      url: '/api/v1/workout_exercises/' + $editWoId,
      type: 'DELETE',
      data: {'workout_exercise_id': $woExId},
      dataType: 'json'
    });
  } else {
    // do nothing
  }
};


