$(document).ready(function(){
  $('#plus-workout').click(App.showWorkoutForm);
  $('#cncl-workout').click(App.hideWorkoutForm);
  $('.wo-ex-remove').click(App.destroyWorkoutExercise);
  $('.exercise-container').on('dragstart', function(e, ui){
    var exId = $(this).attr('data-exercise-id');
    e.originalEvent.dataTransfer.effectAllowed = "copy";
    e.originalEvent.dataTransfer.setData('text', exId);
  });
  $('.wo-row').on('dragover', function(e){
    if (e.preventDefault) {
      e.preventDefault();
    }
    e.originalEvent.dataTransfer.dropEffect = "copy";
    return false;
  });
  $('.wo-row').on('dragenter', function(){
    $(this).addClass("over");
  });
  $('.wo-row').on('dragleave', function(){
    $(this).removeClass("over");
  });
  $('.wo-row').on('drop', function(e){
    var woId = $(this).attr('data-workout-id');
    var exId = e.originalEvent.dataTransfer.getData('text');
    if (e.preventDefault) {
      e.preventDefault();
    }
    if (e.stopPropagation) {
      e.stopPropagation();
    }
    $(this).removeClass("over");
    $.ajax({
      url: '/workouts/' + woId,
      type: 'PATCH',
      data: {'exercise_id': exId},
      dataType: 'json'
    });
  });
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


