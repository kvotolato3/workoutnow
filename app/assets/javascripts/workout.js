$(document).ready(function(){
  $('#plus-workout').click(App.showWorkoutForm);
  $('#cncl-workout').click(App.hideWorkoutForm);
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


