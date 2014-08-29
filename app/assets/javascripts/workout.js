$(document).ready(function(){
  $('#plus-workout').click(App.showWorkoutForm);
  $('#cncl-workout').click(App.hideWorkoutForm);
  $('.wo-ex-remove').click(App.destroyWorkoutExercise);
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

App.destroyWorkoutExercise = function(event) {
  if (window.confirm('Remove exercise from workout?') === true) {
    var $woExId = $(this).data("id");
    $.ajax({
      url: '/api/v1/workout_exercises/' + $woExId,
      type: 'DELETE',
      dataType: 'json'
    }).success(App.hideWorkoutExercise($woExId));
  }
};

App.hideWorkoutExercise = function(id) {
  $('#wo-exercise-'+ id).slideUp();
};


