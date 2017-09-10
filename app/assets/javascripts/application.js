//= require jquery
//= require jquery_ujs
//= require_tree .

$(function(){
  $('#ask-button').click(function(){
    $('#ask-form').slideToggle(300);
    return false;
  });
});