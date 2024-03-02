<!--#include file="./templates/dbconnection.asp"-->
<!DOCTYPE html>
<html>
<head>
  <link rel="stylesheet" type="text/css" href="https://bootswatch.com/4/sandstone/bootstrap.min.css">
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel='stylesheet' type='text/css' media='screen' href='./assets/css/guest.css'>
  <!-- <link rel="stylesheet" type="text/css" href="./assets/css/tarry.css"> -->
  <title>GUEST</title>
</head>

  <style>
.back-to-top {
  position: fixed;
  bottom: 20px;
  right: 20px;
  display: none;
  z-index: 9999;
}

.back-to-top img {
  width: 40px;
  height: 40px;
}

/* Show the button when scrolling */
body.scrollTop-show .back-to-top,
html.scrollTop-show .back-to-top {
  display: block;
}

.submit-comments {
margin-left: 1070px;
margin-top: -130px; 
height: 22px;
width: 22px;
position: absolute;
}
.submit-btn{
  margin-left: 1070px;
margin-top: -145px; 
height: 22px;
width: 22px;

}

  </style>


<body>

<a href="#" class="back-to-top">
  <img src="images/back-2-top-30.png" alt="Back to Top" />
  </a>





<%
set rs = server.createobject("adodb.recordset")

if request.querystring("q") = "" then
  rs.open " SELECT post.postid, post.ownerid, post.date_posted, post.post, `profile`.username, `profile`.profilepic, `profile`.uid FROM post INNER JOIN `profile` ON post.ownerid = `profile`.uid", cn 
else
  rs.open "SELECT * FROM post INNER JOIN `profile` ON post.ownerid = `profile`.uid where post like '%" & request.querystring("q") & "%'", cn
end if
response.write"<br>"
response.write"<form  class='d-flex' method='get' action='signup.html'><button class='lfsearch' type='submit'>Search</button><input  class='search' type='search' placeholder='Looking for...' ></form>"
   ' response.write"<div class='main-content'>"
    response.write"<div class='write-post-container'>"
      response.write"<div class='user-profile'>"
        response.write"<img src='images/guest.jpg'>"
        response.write"<div>"
          response.write"<p class='main-name'>Guest</p>"
        response.write"</div>"
      response.write"</div>"
      response.write"<div class='post-input-container' > <form action='signup.html'><textarea rows='3' placeholder='What are you looking for?'></textarea>"
        response.write"<button class='post-button'>Post</button></form>"
      response.write"</div>"
    response.write"</div>"


    do until rs.eof
    response.write"<div class='post-container'>"
      response.write"<div class='user-profile1'>"
        response.write"<a href='signup.html'><img src='"& rs.fields("profilepic") & "'></a>"
        response.write"<div>"
          response.write"<a href='signup.html'><p class='main-name'>"& rs.fields("username") & "</p></a>"
          response.write"<span>"& rs.fields("date_posted") & "</span>"
        response.write"</div>"
      response.write"</div>"
      response.write"<div class='write-post-containers'>"
      response.write"<p class='post-text'>"& rs.fields("post") & "</p>"
      response.write"</div>"
      response.write"</div>"

' likes button
      response.write"<span class='react-container1'>"
        response.write"<a href='signup.html'><button class='react-buttons' type='button'>" 
        response.write"<img src='images/heart.png' >"
       response.write"</button></a>"
       response.write"</span>"

       response.write"<br>"

' comment button
       response.write"<span class='react-container2'>"
        response.write"<a href='signup.html'> <button class='react-buttons' type='button' >"
        response.write"<img src='images/commented.png' >"
        response.write"</button></a>"
        response.write"</span>"

        response.write"<br>"

' share button     
        response.write"<span class='react-container3'>"
        response.write"<a href='signup.html'><button action='signup.html' class='react-buttons' type='button'>"
        response.write"<img src='images/share.png' >"
      response.write"</button></a>"
      response.write"</span>"

  ' comment box
      response.write"<div class='comment-user-profile'>"
          response.write"<img class='comment-profile' src='images/guest.jpg'><form action='signup.html' class='comment-input-container'><textarea rows='3' placeholder='Write a comment...' onkeydown='submitForm(event)'></textarea></form>"
          response.write"</div>"
          response.write"<a href='signup.html' class='submit-btn'><img src='images/comment_arrow.png' class='submit-comments'></a>"

    response.write"</div>"
  response.write"</div>"  
response.write"</div>"
rs.movenext

loop 
rs.close
%>   
         
</tbody>
</body>
</html>

<script>
  // Add event listener to show/hide the button when scrolling
window.addEventListener("scroll", function() {
  var backToTopBtn = document.querySelector(".back-to-top");
  if (window.scrollY > 500) {
    backToTopBtn.style.display = "block";
  } else {
    backToTopBtn.style.display = "none";
  }
});

function submitForm(event) {
    if (event.keyCode === 13 && !event.shiftKey) { // 13 kay ang Enter key
      event.preventDefault(); // Prevents the default behavior of submitting the form
      document.querySelector('.comment-input-container').submit();
    }
  }
</script>
