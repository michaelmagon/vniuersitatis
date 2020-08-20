function course_tab(content) {
  const course_contents =
      `<div class="row">
      <div class="col-md-7">
        <a href="`+content.url+`">
          <img class="img-fluid rounded mb-3 mb-md-0" src="https://picsum.photos/750/300" alt="">
        </a>
      </div>
      <div class="col-md-5">
        <h3>`+content.title+`</h3>
        <h4>`+content.teacher+`</h4>
        <p>`+content.summary+`</p>
        <a class="btn btn-primary" href="`+content.url+`">View Course</a>
      </div>
    </div>
    <hr>`

    return course_contents
}

const empty_courses = `<div class="row">
<div class="col-8 mx-auto mt-3" style="width: fit-content;">
    <h3>No course found that matches the filter.</h3>
</div>
</div>`
