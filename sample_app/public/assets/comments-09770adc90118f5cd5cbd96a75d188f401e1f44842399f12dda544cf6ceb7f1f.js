$(document).ready(function(){
  $('.new_comment').bind('ajax:complete', function(){
    $(this).find('#comment_content').val("");
  });
})
;
