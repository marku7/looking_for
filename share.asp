<!--#include file="./templates/dbconnection.asp"-->
<link rel="stylesheet" type="text/css" href="assets/css/share.css">
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel='stylesheet' type='text/css' media='screen' href='assets/css/style.css'>
  <!-- <link rel="stylesheet" type="text/css" href="assets/css/prof.css"> -->
   <!-- <link rel="stylesheet" type="text/css" href="assets/css/tarry.css"> -->
  <title></title>
</head>
<style type="text/css">
body {
    background-color: #6eb07a;
    --color-primary-dark: #007f3d;
    --color-primary: #3b871a;
    --color-secondary: #9bb4a0;
    --color-success: #083411;
    --border-radius: 4px;
}


.page{
width: 900px;
background: #9bb4a0;
border-radius: 8px;
columns: #626262;
flex-basis: 30%;
box-shadow: 0 0 5px #083411;
border-color: 50 50 50px #007f3d;
border: 5px solid #007f3d;
/*margin-inline-start: 20px;*/
margin-top: -400px;
margin-left: 360px;
margin-bottom: 20px;
padding: 5px;
}


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

.post{
    background-color: #007f3d;
    margin-top: -30px;
    margin-bottom: 20px;
    margin-left: 1070px;
    width: 150px;
    height: 30px;
    border-radius: 5px;
    position: absolute;
}

.option-list{
  margin-left: 20px;
  margin-top: 30px;

}


.main-content{
  width: 645px;
  box-shadow: 0px ;
  flex-basis: 30%;
  align-items: right;
  background: #9bb4a0;
  padding: 10px 10% ;
  box-shadow: 0 0 5px #083411;
  border-color: 0 0 50px #007f3d;
  margin-inline-start: 20px;
  margin-top: 60px;
  border-radius: 10px;
  margin-left: 38px;
}

.current-user{
  border-radius: 10%;
  width: 50px;
  height: 50px;
  margin-top: -8px;
  margin-left: 15px;
}
.nav{
  border-radius: 10%;
  width: 45px;
  height: 45px;
  margin-left: 15px;
  display: flex;
}
.nav-list{
  margin-top: -30px;
  margin-left: 95px;
}
/* Show the button when scrolling */
body.scrollTop-show .back-to-top,
html.scrollTop-show .back-to-top {
  display: block;
}

.image{
  width:700px;
  height: 440px;
  margin-left: -70px;
}
</style>
<body>

  <a href="#" class="back-to-top">
  <img src="images/back-2-top-30.png" alt="Back to Top" />
  </a>

<%

set rs = server.createobject("adodb.recordset")
 ' if request.querystring("q") = "" then
 '    rs.open " SELECT `post`.postid, `post`.ownerid,  `post`.post, `post`.image, `post`.date_posted, `post`.num_share,  `post`.num_like, `post`.num_comment, `profile`.username,  `profile`.profilepic, `profile`.uid FROM post INNER JOIN `profile` ON  post.ownerid =  `profile`.uid", cn 
 '  else
    rs.open "SELECT * FROM post INNER JOIN `profile` ON  post.ownerid =  `profile`.uid WHERE postid LIKE '%"  & Request.QueryString("q") & "%'", cn
  ' end if

      Dim userpostpic, userpostname, posttime
      userpostpic = rs.fields("profilepic")
      userpostname = rs.fields("username")
      posttime = rs.fields("date_posted")   

' Open recordset for displaying user information
  set rs = server.createobject("adodb.recordset")

  if request.querystring("q") = "" then
    rs.open " SELECT `share`.shareid, `profile`.profilepic, `profile`.username, post.post,  post.date_posted, post.ownerid, `share`.time_shared,  FROM `share` INNER JOIN `profile` ON  `share`.ownerid = `profile`.uid INNER JOIN post ON `share`.shared_post = post.postid", cn

  else
    rs.open "SELECT * FROM `share` INNER JOIN `profile` ON  `share`.ownerid = `profile`.uid INNER JOIN post ON `share`.shared_post = post.postid where shared_post like '%" & request.querystring("q") & "%'", cn
  end if




  ' Dim profilepic, user, sharedon, postpic, postname, postdate
  '     profilepic = rs("`profile`.profilepic")
  '     user = rs("`profile`.username")
  '     sharedon = rs("`share`.time_shared")
  '     userpostpic = rs("post.ownerid.`profile`.profilepic")
  '     userpostname = rs("post.ownerid.username")
  '     posttime = rs("post.date_posted")


  do until rs.eof
  response.write"<div class='share-write-post-container'>"
    response.write"<div class='share-user-profile'>"
      response.write"<img src='images/" & userpostpic & "'>"
        response.write"<div>"
          response.write"<p class='main-name'>"& rs.fields("username") & "</p>"
          response.write"<p>"& rs.fields("date_posted") & "</p>"
        response.write"</div>"
    response.write"</div>"
  response.write"<div>"

    response.write"<div class='post-container'>"
      response.write"<div class='share-user-profile1'>"
        response.write"<img src='images/"& userpostpic & "'>"
        response.write"<div>"
          response.write"<p class='main-name'>"& rs.fields("username") & "</p>"
          response.write"<span>"& rs.fields("date_posted") & "</span>"
        response.write"</div>"
      response.write"</div>"
      response.write"<br>"
      response.write"<div class='share-write-post-containers'>"
      response.write"<p class='share-post-text'>"& rs.fields("post") & "</p>"
      response.write"<img src='images/bh.jpg' class='image'>"
      response.write"</div>"
      response.write"</div>"

' likes button
      response.write"<span class='share-react-container1'>"
        response.write"<form action='react.asp'><button class='share-react-buttons' type='button'>" 
        response.write"<img src='images/heart.png' >"
       response.write"</button></form>"
       response.write"</span>"

       response.write"<br>"

' comment button
       response.write"<span class='share-react-container2'>"
        response.write"<button class='share-react-buttons' type='button'>"
        response.write"<img src='images/commented.png' >"
        response.write"</button>"
        response.write"</span>"

        response.write"<br>"

' share button     
        response.write"<span class='share-react-container3'>"
        response.write"<form action='react.asp'><button class='share-react-buttons' type='button'>"
        response.write"<img src='images/share.png' >"
      response.write"</button></form>"
      response.write"</span>"

' comment box
    response.write"<div class='share-comment-user-profile'>"
        response.write"<img class='share-comment-profile' src='images/" & Session ("profile") & "'> <form action='comment.asp' class='share-comment-input-container' ><textarea rows='3' placeholder='Write a comment...'></textarea> </form>"
        response.write"</div>"
        response.write"<button class='share-submit-btn'><img src='images/comment_arrow.png' class='share-submit-comment' action='submit'></button>"

        response.write"</div>"

        response.write"</div>"
    Response.Write "</form >"

     ' ' Redirect to view user page after editing
     '    Response.Redirect("share.asp?uid=" & id)
rs.movenext

loop 
rs.close
%>  
  
</div>
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

    // Add smooth scrolling behavior when clicking the button
    document.querySelector(".back-to-top").addEventListener("click", function(e) {
    e.preventDefault();
    window.scrollTo({
      top: 0,
      behavior: "smooth"
    });
    });


function num_like(postid) {
  // Send an AJAX request to update the upvote count in the database
  const xhr = new XMLHttpRequest();
  xhr.open('POST', 'like.asp');
  xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
  xhr.onreadystatechange = function() {
    if (xhr.readyState === 4 && xhr.status === 200) {
    // Success! Update the like count on the page
    const num_likeElement = document.getElementById(`num_like-${postId}`);
    if (num_likeElement) {
      num_likeElement.innerText = parseInt(num_likeElement.innerText) + 1;
    }
    }
  };
  xhr.send('postid=' + postid);
  }

</script> 