var ready;

ready = function() {
  $("#posts").click(function(){
    $("#archive").removeClass('active');
    $(this).addClass('active');
  });

  $("#archive").click(function(){
    $("#posts").removeClass('active');
    $(this).addClass('active');
  });
};

$(document).ready(ready);
$(document).on('turbolinks:load', ready);