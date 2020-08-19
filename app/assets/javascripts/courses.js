//= require notifications.js

$(document).on('turbolinks:load', function() {
  
  $('#apply-course').on('click',function(e){ 
    e.preventDefault();
    e.stopPropagation();

    const slug = $(this).data('slug')
    const cuid = $(this).data('cuid')
    apply_course(slug,cuid)
  });

  $("[admit-student]").on('click',function(e){ 
    e.preventDefault();
    e.stopPropagation();
    const sid = $(this).data('sid');
    const cid = $(this).data('cid');
    respond_application(sid, cid, 'admit')
    getUser(sid).then(function(res) {
        $("#student-list").append( `<tr id="student-`+sid+`">
        <th scope="row">`+($('#student-list tr').length + 1)+`</th>
        <td>`+res.name+`</td>
        <td>`+res.email+`</td></tr>` );
    })
  });

  $("[decline-student]").on('click',function(e){ 
    e.preventDefault();
    e.stopPropagation();
    const sid = $(this).data('sid');
    const cid = $(this).data('cid');
    respond_application(sid, cid, 'decline')
  });

});

function apply_course(slug, cuid){
  $.ajax({
    method: 'GET',
    url: "/apply/course/"+slug+"/"+cuid,
    success: function()
    {
      display_notification("Successfully applied for a spot!", "The course instructor will review your application.", "success", ".notifications");
      $("#apply-course").html('Pending');
      $("#apply-course").attr("disabled", true);
    }
  });
}

function respond_application(sid, cid, event_name){
  $.ajax({
    method: 'GET',
    url: "/"+event_name+"/"+sid+"/"+cid,
    success: function()
    {
      display_notification("Success!", "Student list updated", "success", ".notifications");
      $("#student-"+sid).remove();
    }
  });
}

function getUser(sid) { 
  return $.ajax({
    url: "/user/"+sid,
    type: 'GET',
  });
};
