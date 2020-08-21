//= require notifications.js
//= require courses_filter.js

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

  $(".filter-btn").on('click', function(e){
    e.preventDefault();
    e.stopPropagation();
    const filter = $(this).data('filter');
    $(".filter-btn").removeClass('active');
    $("[data-filter="+filter+"]").addClass('active');
    retrieve_courses($(this).data('filter'));
  })
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
    },
    error: function(data){
      console.log(data)
      display_notification("Failed to apply!", data.responseText, "danger", ".notifications");
    }
  });
}

function retrieve_courses(filter){
  $.ajax({
    method: 'GET',
    url: "/courses/?filter="+filter,
    success: function(data)
    {
        $("#courses-list").empty();
        if (data.length === 0){
          $("#courses-list").append(empty_courses);
        } else {
          data.forEach(function(content) { $("#courses-list").append(course_tab(content));});
        }
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
