<!--#include file="./templates/dbconnection.asp"-->
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel='stylesheet' type='text/css' media='screen' href='./assets/css/style.css'>
	<link rel="stylesheet" type="text/css" href="./assets/css/prof.css">
	<link rel="stylesheet" type="text/css" href="./assets/css/tarry.css">
  <link rel="stylesheet" type="text/css" href="./assets/css/profile.css">

	<title>LF - Profile</title>
</head>
<body>

	<a href="#" class="back-to-top">
  <img src="images/back-2-top-30.png" alt="Back to Top" />
  </a>


<%      
      Set rs = Server.CreateObject("ADODB.Recordset")
      rs.open "SELECT * FROM profile WHERE uid=" & Session("uid"), cn
  
      dim user, avatar
      user = rs("username")
      avatar = rs("profilepic")



 response.write"<div class='options' style='position: sticky; top: 0; z-index: 10;'>"
      response.write"<div class='option-list'>"

        if avatar = "" then
          response.write"<a href='profile.asp' style='text-decoration: none; color: black;'><img src='images/default.png' alt='' class='current-user'>"
        else
          response.write"<a href='profile.asp' style='text-decoration: none; color: black;'><img src='"& avatar & "' alt='' class='current-user'>"
        end if
        response.write"<p class='nav-list'>&nbsp;PROFILE</p></a> "
        response.write"</div>"
         
      response.write"<br>"
      response.write"<div class='option-list'>"
        response.write"<a  href='home.asp' style='text-decoration: none; color: black;'><img src='images/homeop.png' class='nav'>"
        response.write"<p class='nav-list'>&nbsp;HOME</p></a> "
      response.write"</div>"
      response.write"<br>"
      response.write"<div class='option-list'>"
        response.write"<a href='notification.asp' style='text-decoration: none; color: black;'><img src='images/notificationop.png' class='nav'>"
        response.write"<p class='nav-list' action='notification.asp'>&nbsp;NOTIFICATION</p></a> "
      response.write"</div>"
    response.write"</div>"
 

    response.write"<div class='page' style='margin-top: -300px;'>"



    response.write"<div class='d-flex'>"
      response.write"<a href='logout.asp' >"
        response.write"<button type='button' class='logout' style=' z-index: 10;'>Logout</button>"
      response.write"</a>"
    response.write"</div>"
	

      response.write"<div class='profile-card'>"
        response.write"<img src='images/back2.png' class='cover-pic' style='height: 190px; z-index: -10;'>"
      response.write"</div>"


      if avatar = "" then
          response.write"<div><img src='images/default.png' class='profile-pic' style='border: none;'></div>"
      else
          response.write"<div><img src='" & avatar & "' class='profile-pic' > </div>"
      end if     

      response.write"<div class='username' style='margin-bottom: 20px;  position: sticky; margin-top: -130px;'>" & user & "</div>"
      
        response.write"<div class='main-content'>"
          response.write"<a href='editav.asp' title='Edit account'><button class='edit_profile'>Edit Profile Picture</button></a>"          
          response.write"<a href='editprof.asp' title='Edit account'><button class='edit_profile' style='margin-left: 420px;'>Edit Account</button></a>"
          response.write"<br>"      
          response.write"<div class='user-profile'>"
            if avatar = "" then
              response.write"<img src='images/default.png' style='border: none;'>"
            else
              response.write"<img src='" & avatar & "'>"
            end if
            response.write"<div>"
              response.write"<p class='main-name'>" & user & "</p>"
            response.write"</div>"
          response.write"</div>"


              response.write "<div class='post-input-container'>"
        response.write "  <form action='post.asp' method='post'>"
          response.write "   <div style='display: flex; align-items: center;'>"
            response.write " <textarea rows='3' placeholder='Post something' name='description' required></textarea>"
            response.write "<div class='image-upload-container'>"
              response.write " <div id='custom-button' class='upload-button'>"
                response.write "   <img src='images/up.png' alt=''>"
                response.write " </div>"
                response.write " <input type='file' id='photo' accept='image/*'>"
                response.write " </div>"
                response.write "</div>"
                response.write " <img id='preview' src='#' alt='Image Preview' style='max-width: 100%; max-height: 200px; margin-top: 10px; align-items: center; display: none;'>"
                response.write " <input type='hidden' id='base64' name='base64'>"
                response.write " <button class='post-button'>Post</button>"
                response.write "</form>"
                response.write "</div>"
      response.write"</div>"

rs.close
 
set prs = server.createobject("adodb.recordset")
 prs.open "SELECT * FROM post WHERE ownerid="& Session("uid") &" ORDER BY date_posted DESC ", cn 

 do until prs.eof
 dim posid
 posid = prs("postid")
 image = prs("image")
      response.write"<div class='post-container'>"
        response.write"<div class='user-profile1'>"

          if avatar = "" then
            response.write"<img src='images/default.png'>"
          else
            response.write"<img src='" & avatar &"' style='border: none;'>"
          end if

          response.write"<div>"
          response.write"<p class='main-name'>"& user &"</p>"
          response.write"<p>"& prs.fields("date_posted") & "</p>"
          response.write"</div>"
          
        response.write"</div>"

        if image <> "" then
          response.write"<div class='write-post-containers' style='margin-bottom: 20px;'>"
            response.write "<div class='actions'>"
              response.write "<a href='editpost.asp?id=" & posid & "' title='Edit post'><img src='images/ed.png' alt=''></a>"
              response.write "<a href='editimage.asp?id=" & posid & "' title='Edit post image'><img src='images/img.png' alt=''></a>"
              response.write "<a href='delete.asp?id=" & posid & "' title='Delete post'><img src='images/delete.png' alt=''></a>"
              response.write "</div>"
            response.write"<p class='post-text'>"& prs.fields("post") & "</p>"

            
              response.write"<img src='"& image &"' class='image' style='width: 700px; height: 100%;'>"
            
            
        
            response.write "<div class='rbuttons'>"
            response.write"<div class='react-container1'  style='margin-left: 100px; margin-top: 10px;'>"
              response.write "<span id='likeCount_" & posid & "' style='margin-right: 10px; margin-top: 5px;'>"& prs.fields("num_like") &"</span>"
            response.write "<button id='likeButton_"& posid &"' onclick='like(" & posid & ")'><img src='images/heart.png' title='Like Post'></button>"
            response.write"</div>"
            
        
            dim crr
            Set crr = Server.CreateObject("ADODB.Recordset")
            crr.Open "SELECT COUNT(*) AS total_comments FROM comment WHERE postid=" & posid, cn
        
            Dim total_commentss
            total_commentss = crr("total_comments")
            crr.Close
            Set crr = Nothing
        
        
            response.write"<div class='react-container2' style='margin-left: 300px; margin-top: 10px; '>"
              response.write "<span id='comCount_" & posid & "' style='margin-right: 10px; margin-top: 5px;'>"& total_commentss&"</span>"
              response.write"<a href='comment.asp?id=" & posid & "'>"
                response.write"<button class='react-buttons'  type='button'>"
                  response.write"<img src='images/commented.png' title='View comments' >"
                response.write"</button>"
              response.write"</a>"
            response.write"</div>" 
           
            response.write"<div class='react-container3'  style='margin-left: 500px; margin-top: 10px;'>"
              response.write "<div> "& prs.fields("num_share") &"</div>"
                response.write"<a href='shareport.asp?id="& posid &"'>"
                    response.write"<img src='images/share.png' title='Share Post'>"
                    response.write"</a>"
            response.write"</div>"
          
      
          
           
            response.write "</div>"
        
          response.write"</div>"
          else

          response.write"<div class='write-post-containers' style='margin-bottom: 20px; height: 200px;'>"
            response.write "<div class='actions'>"
              response.write "<a href='editpost.asp?id=" & posid & "' title='Edit post'><img src='images/ed.png' alt=''></a>"
              response.write "<a href='editimage.asp?id=" & posid & "' title='Edit post image'><img src='images/img.png' alt=''></a>"
              response.write "<a href='delete.asp?id=" & posid & "' title='Delete post'><img src='images/delete.png' alt=''></a>"
              response.write "</div>"
            response.write"<p class='post-text' style='margin-top: 50px;'>"& prs.fields("post") & "</p>"
            response.write "<div class='rbuttons' style='margin-top: 90px;'>"
            response.write"<div class='react-container1'  style='margin-left: 100px; margin-top: 10px;'>"
              response.write "<span id='likeCount_" & posid & "' style='margin-right: 10px; margin-top: 5px;'>"& prs.fields("num_like") &"</span>"
            response.write "<button id='likeButton_"& posid &"' onclick='like(" & posid & ")'><img src='images/heart.png' title='Like Count'></button>"
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
              response.write "<div> "& prs.fields("num_share") &"</div>"
                response.write"<a href='shareport.asp?id="& posid &"'>"
                    response.write"<img src='images/share.png' title='Share Post'>"
                    response.write"</a>"
            response.write"</div>"
          
      
          
           
            response.write "</div>"
        
          response.write"</div>"
          end if

        prs.movenext
        loop
prs.close
response.write"</div>"
%>
    </div>

</body>
</html>

<script src="./assets/js/image.js"></script>
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

</script>