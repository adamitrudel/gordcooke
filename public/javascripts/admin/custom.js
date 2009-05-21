jQuery(function ($) {
  // New user form
  $('#user_admin').attr('checked', null).click( function () {
    $('#user_developer').attr('checked', !$(this).attr('checked'));
  });
  
  $('#user_developer').attr('checked', 'checked').click( function () {
    $('#user_admin').attr('checked', !$(this).attr('checked'));
  });  
});