$(document).ready(function(){
  $('#plus-workout').click(App.showWorkoutForm);
  $('#cncl-workout').click(App.hideWorkoutForm);
  $('#inline-workout-form').submit(App.saveWorkout);
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

App.saveWorkout = function() {
  event.preventDefault();
  var $name = $('input[name=workout_name]').val();
  $.ajax({
    url: '/api/v1/workouts',
    type: 'POST',
    data: {'workout': {'name': $name}},
    dataType: 'json'
  }).done(App.appendMyWorkouts);
};

App.appendMyWorkouts = function(result) {
  console.log(result);
  var newElement = $('<tr><td></td><td></td></tr>');
  console.log(newElement);

};
