$(document).ready(function(){
  $('#plus-workout').click(App.showWorkoutForm);
  $('#cncl-workout').click(App.hideWorkoutForm);
  $('.exercise-container').on('dragstart', function(e, ui){
    var exId = $(this).attr('data-exercise-id');
    e.data = {'exerciseId': exId};
    e.originalEvent.dataTransfer.effectAllowed = "copy";
    console.log("data: " + e.data);
  });
  $('.wo-row').on('dragover', function(e){
    if (e.preventDefault) {
      e.preventDefault();
    }
    e.originalEvent.dataTransfer.dropEffect = "copy";
    return false;
  });
  $('.wo-row').on('dragenter', function(e){
    $(this).addClass("over");
  });
  $('.wo-row').on('dragleave', function(e){
    $(this).removeClass("over");
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


