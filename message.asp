<!--#include file="./templates/dbconnection.asp"-->
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel='stylesheet' type='text/css' media='screen' href='./assets/css/style.css'>
	<link rel="stylesheet" type="text/css" href="./assets/css/prof.css">
  <link rel="stylesheet" type="text/css" href="./assets/css/tarry.css">
  <link rel="stylesheet" type="text/css" href="./assets/css/home.css">

	<title></title>
</head>
<style type="text/css">


.message{
    background-color: #007f3d;
    margin-top: 20px;
    margin-bottom: 20px;
    margin-left: 730px;
    width: 150px;
    height: 30px;
    border-radius: 5px;
    position: absolute;
}

/* Show the button when scrolling */
body.scrollTop-show .back-to-top,
html.scrollTop-show .back-to-top {
  display: block;
}
</style>
<body>

	<a href="#" class="back-to-top">
  <img src="images/back-2-top-30.png" alt="Back to Top" />
  </a>

 
<%
dim userav
set userav = server.CreateObject("ADODB.Recordset")
userav.open "SELECT profilepic FROM profile WHERE uid=" & Session("uid"), cn

dim dp
dp = userav("profilepic")

userav.close
set userav = Nothing

  dim oid, pf
  oid = request.querystring("id")

  set pf = server.CreateObject("ADODB.Recordset")
  pf.open "SELECT * FROM profile WHERE uid=" & oid, cn

    dim user, avatar, mes
    user = pf("username")
    avatar = pf("profilepic")
    mes = pf("messenger")

    pf.close
    set pf = Nothing

    response.write"<div class='options' style='position: sticky; top: 0; z-index: 10; margin-top: 50px;'>"
      response.write"<div class='option-list'>"
        
        if dp = "" then
          response.write"<a href='profile.asp' style='text-decoration: none;'><img src='images/default.png' alt='' class='current-user'>"
        else 
          response.write"<a href='profile.asp' style='text-decoration: none;'><img src='"& dp &"' alt='' class='current-user'>"
        end if
        
        response.write"<p class='nav-list' style='color: black;'>&nbsp;PROFILE</p></a> "
        response.write"</div>"

        response.write"<br>"
        response.write"<div class='option-list'>"
          response.write"<a  href='home.asp' style='text-decoration: none; color: black;'><img src='images/homeop.png' class='nav'>"
          response.write"<p class='nav-list'>&nbsp;HOME</p></a> "
        response.write"</div>"
        response.write"<br>"
        response.write"<div class='option-list'>"
          response.write"<a href='notification.asp' style='text-decoration: none; color: black;'><img src='images/notificationop.png' class='nav'>"
          response.write"<p class='nav-list' action='notification.asp'>&nbsp;NOTIFICATION</p></a>"
        response.write"</div>"
      response.write"</div>"

set rs = server.createobject("adodb.recordset")

  rs.open "SELECT post.postid, post.ownerid, post.post, post.image, post.date_posted, post.num_share, post.num_like, `profile`.username, `profile`.profilepic  AS ownerpostpic, `profile`.uid FROM post INNER JOIN `profile` ON post.ownerid = `profile`.uid WHERE ownerid="& oid &" ORDER BY date_posted DESC", cn 


%>
<!-- PAGE BOX -->
<div class="page" style="position: sticky; top: 0; z-index: 100; margin-top: -280px;">


<!-- LOGOUT -->
  <form class="d-flex" >
    <a href="logout.asp"><button type="button" class="logout" style="position: sticky; top: 0; z-index: 30;">Logout</button></a>
  </form>
	
   <!-- 'COVER PHOTO -->
 <div class="profile-card">
  <img src="images/back.png" class="cover-pic" >
</div>


  <div>
    <%
    if avatar = "" then
      response.write "<img src='images/default.png' class='profile-pic' style='border: none;'>"
    else 
    response.write "<img src='"& avatar &"' class='profile-pic'>"
    end if
   %>
  </div>
          
      
  <div class="username" style='margin-bottom: 50px;  position: sticky;'><%= user %></div>

<!-- MESSENGER -->
    <a href="<%= mes %>"><button class="message">Message</button></a>
    <br>     
 
    <%

    do until rs.eof
    dim prof, posid, image, ownerid
    prof = rs("ownerpostpic")
    posid = rs.fields("postid")
    image = rs("image")
    ownerid = rs("ownerid")

    response.write"<div class='post-container'>"
      response.write"<div class='user-profile1'>"

        if prof = "" then
          response.write"<a href='message.asp?id=" & oid & "'><img src='images/default.png'></a>"
        else
          response.write"<a href='message.asp?id=" & oid & "'><img src='"& prof &"'></a>"
        end if
        response.write"<div>"
          response.write"<a href='message.asp?id=" & oid & "' style='text-decoration: none;'><p class='main-name'>"& rs.fields("username") & "</p></a>"
          response.write"<span>"& rs.fields("date_posted") & "</span>"
        response.write"</div>"
      response.write"</div>"
    
      if image <> "" then
    response.write"<div class='write-post-containers' style='margin-bottom: 20px;'>"
      response.write"<p class='post-text'>"& rs.fields("post") & "</p>"
        response.write"<img src='"& image &"' class='image' style='width: 700px; height: 100%;'>"
        response.write "<div class='rbuttons'>"
          response.write"<div class='react-container1'  style='margin-left: 100px; margin-top: 10px;'>"
            response.write "<span id='likeCount_" & posid & "' style='margin-right: 10px; margin-top: 5px;'>"& rs.fields("num_like") &"</span>"
          response.write "<button id='likeButton_"& posid &"' onclick='like(" & posid & ")'><img src='images/heart.png' title='Like Post'></button>"
          response.write"</div>"
          
      
          dim cr
          Set cr = Server.CreateObject("ADODB.Recordset")
          cr.Open "SELECT COUNT(*) AS total_comments FROM comment WHERE postid=" & posid, cn
      
          Dim total_comments
          total_comments = cr("total_comments")
          cr.Close
          Set cr = Nothing
      
      
          response.write"<div class='react-container2' style='margin-left: 300px; margin-top: 10px;'>"
            response.write "<span id='comCount_" & posid & "' style='margin-right: 10px; margin-top: 5px;'>"& total_comments&"</span>"
            response.write"<a href='comment.asp?id=" & posid & "'>"
              response.write"<button class='react-buttons'  type='button'>"
                response.write"<img src='images/commented.png' title='View comments' >"
              response.write"</button>"
            response.write"</a>"
          response.write"</div>" 
         
          response.write"<div class='react-container3'  style='margin-left: 500px; margin-top: 10px;'>"
            response.write "<div> "& rs.fields("num_share") &"</div>"
              response.write"<a href='shareport.asp?id="& posid &"'>"
                  response.write"<img src='images/share.png' title='Share Post'>"
                  response.write"</a>"
          response.write"</div>"
        
            response.write"<div class='react-container4'  style='margin-left: 680px;'>"
              response.write"<a href='rep.asp?id="& posid &"'>"
                response.write"<img src='images/rep.png' title='Report Post'>"
                  response.write"</a>"
            response.write"</div>"
    
            response.write"<div class='comment-user-profile'>"
              if avatar = "" then
                response.write"<img class='comment-profile' src='images/default.png'>" 
              else 
                response.write"<img class='comment-profile' src='"& avatar &"'>" 
              end if
              
                response.write"<form action='submitcomment.asp' method='post' >"
                response.write"<textarea rows='3' class='comment-input-container' name='comment' placeholder='Write a comment...' required>"
                response.write"</textarea>" 
                response.write "<input type='hidden' name='id' value='"& posid &"'>"
                
            response.write"</div>"
            response.write"<button class='submit-btn' type='submit' name='submit'>"
            response.write"<img src='images/comment_arrow.png' class='submit-comment' action='submit'>"
            response.write"</button>"
            response.write"</form>"
          response.write "</div>"
          
    else
    response.write"<div class='write-post-containers' style='margin-bottom: 20px; height: 300px;'>"
      response.write"<p class='post-text' style='margin-top: 50px;'>"& rs.fields("post") & "</p>"
        response.write "<div class='rbuttons' style='margin-top: 100px;'>"
          response.write"<div class='react-container1'  style='margin-left: 100px; margin-top: 10px;'>"
            response.write "<span id='likeCount_" & posid & "' style='margin-right: 10px; margin-top: 5px;'>"& rs.fields("num_like") &"</span>"
          response.write "<button id='likeButton_"& posid &"' onclick='like(" & posid & ")'><img src='images/heart.png' title='Like Post'></button>"
          response.write"</div>"
          
      
          dim ncr
          Set ncr = Server.CreateObject("ADODB.Recordset")
          ncr.Open "SELECT COUNT(*) AS total_comments FROM comment WHERE postid=" & posid, cn
      
          Dim total_commentss
          total_commentss = ncr("total_comments")
          ncr.Close
          Set ncr = Nothing
      
      
          response.write"<div class='react-container2' style='margin-left: 300px; margin-top: 10px;'>"
            response.write "<span id='comCount_" & posid & "' style='margin-right: 10px; margin-top: 5px;'>"& total_commentss &"</span>"
            response.write"<a href='comment.asp?id=" & posid & "'>"
              response.write"<button class='react-buttons'  type='button'>"
                response.write"<img src='images/commented.png' title='View comments' >"
              response.write"</button>"
            response.write"</a>"
          response.write"</div>" 
         
          response.write"<div class='react-container3'  style='margin-left: 500px; margin-top: 10px;'>"
            response.write "<div> "& rs.fields("num_share") &"</div>"
              response.write"<a href='shareport.asp?id="& posid &"'>"
                  response.write"<img src='images/share.png' title='Share Post'>"
                  response.write"</a>"
          response.write"</div>"
        
            response.write"<div class='react-container4'  style='margin-left: 680px;'>"
              response.write"<a href='rep.asp?id="& posid &"'>"
                response.write"<img src='images/rep.png' title='Report Post'>"
                  response.write"</a>"
            response.write"</div>"
    
            response.write"<div class='comment-user-profile'>"
              if avatar = "" then
                response.write"<img class='comment-profile' src='images/default.png'>" 
              else 
                response.write"<img class='comment-profile' src='"& avatar &"'>" 
              end if
              
                response.write"<form action='submitcomment.asp' method='post' >"
                response.write"<textarea rows='3' class='comment-input-container' name='comment' placeholder='Write a comment...' required>"
                response.write"</textarea>" 
                response.write "<input type='hidden' name='id' value='"& posid &"'>"
                
            response.write"</div>"
            response.write"<button class='submit-btn' type='submit' name='submit'>"
            response.write"<img src='images/comment_arrow.png' class='submit-comment' action='submit'>"
            response.write"</button>"
            response.write"</form>"
          response.write "</div>"
      end if
      response.write"</div>"
    response.write"</div>"

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