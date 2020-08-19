function display_notification(header, message, status, location_class) {
  close_button = '';


  close_button = "<span class='close-notif'>&times;</span>";
  
  $( location_class ).append( `<div class='alert alert-`+ status + ` alert-dismissible fade show' role='alert'>
  <strong>`+ header+`</strong> `+ message +`.
  <button type='button' class='close' data-dismiss='alert' aria-label='Close'>
    <span aria-hidden='true'>&times;</span>
  </button>
</div>` );
  
  if ($('.notif').length > 0) {
    $('.notif')  .delay(5000).fadeOut(400);
  }
}
