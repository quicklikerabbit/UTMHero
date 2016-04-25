$(function() {
  var submitButton = $("#lndpg-submit-button");
  submitButton.on('click',function(){
    $('#create-link-overlay').removeClass('hidden');
  });
  var anotherOne = $("#make-another");
  anotherOne.on('click',function(){
    $('#create-link-overlay').addClass('hidden');
  });
});
