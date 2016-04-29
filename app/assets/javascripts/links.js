$(function() {
  $("#get-started-button").click(function() {
    $('html, body').animate({
        scrollTop: $("#link-form").offset().top
    }, 1000);
  });
  $( document ).ajaxComplete(function() {
    $('#create-link-overlay').removeClass('hidden');
  });
  var anotherOne = $("#make-another");
  anotherOne.on('click',function(){
    $('#create-link-overlay').addClass('hidden');
  });
});
