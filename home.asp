<!--#include file="./templates/dbconnection.asp"-->
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel='stylesheet' type='text/css' media='screen' href='./assets/css/style.css'>
	 <link rel="stylesheet" type="text/css" href="./assets/css/tarry.css">
   <link rel="stylesheet" href="./assets/css/home.css">
   
	<title>LF</title>
  <style>
    .image-upload-container input[type="file"] {
    display: none;
    }
  .image-upload-container {
    display: flex;
    align-items: center;
  }
  </style>
</head>

<body>
  
	<a href="#" class="back-to-top">
  <img src="images/back-2-top-30.png" alt="Back to Top" />
  </a>


	<!-- SEARCH BOX -->

  
  <form method="get" action="home.asp" style="margin-left: 10 px;"><input type="text" name="txtSearch" class="search" placeholder="Looking for...">
    <input type="submit" value="Search">
</form>
<br>



<%
    Function HasReportedPost(postId)
    Dim rsReportCheck
    Set rsReportCheck = Server.CreateObject("ADODB.Recordset")
    rsReportCheck.Open "SELECT * FROM reports WHERE postid=" & postId & " AND reporter='" & Session("uid") & "'", cn
    HasReportedPost = Not rsReportCheck.EOF
    rsReportCheck.Close
    Set rsReportCheck = Nothing
    End Function



  dim pf
  set pf = server.CreateObject("ADODB.Recordset")
  pf.open "SELECT * FROM profile WHERE uid=" & Session("uid"), cn

    dim user, avatar
    user = pf("username")
    avatar = pf("profilepic")

    pf.close
    set pf = Nothing

response.write"<div class='options' style='position: sticky; top: 0; z-index: 10; margin-top: 50px;'>"
      response.write"<div class='option-list'>"

        if avatar = "" then
            response.write"<a href='profile.asp' style='text-decoration: none;'><img src='./images/default.png' alt='' class='current-user'>"
        else
            response.write"<a href='profile.asp' style='text-decoration: none;'><img src='"& avatar &"' alt='' class='current-user'>"
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

  if request.querystring("txtSearch") = "" then
    rs.open "SELECT post.postid, post.ownerid, post.post, post.image, post.date_posted, post.num_share, post.num_like, `profile`.username, `profile`.profilepic  AS ownerpostpic, `profile`.uid FROM post INNER JOIN `profile` ON post.ownerid = `profile`.uid ORDER BY date_posted DESC", cn 
  else
    rs.open "SELECT post.postid, post.ownerid, post.post, post.image, post.date_posted, post.num_share, post.num_like, `profile`.username, `profile`.profilepic  AS ownerpostpic, `profile`.uid FROM post INNER JOIN `profile` ON post.ownerid = `profile`.uid WHERE post.post LIKE '%"  & Request.QueryString("txtSearch")  & "%'", cn
  end if


  response.write"<div class='page' style='position: sticky; top: 0; z-index: 100; margin-top: -400px;''>"
    response.write "<div>"
    response.write"<a href='logout.asp'>"
      response.write"<button type='button' class='logout' style='position: sticky; margin-top: 10px;'>Logout</button>"
    response.write"</a>"
    response.write"</div>"
    response.write"<div class='write-post-container'>"
    	response.write"<div class='user-profile'>"

        if avatar = "" then
            response.write"<img src='images/default.png'>"
        else
          response.write"<img src='"& avatar &"'>"
        end if
        response.write"<div>"
          response.write"<p class='main-name'>"& user &"</p>"
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

  do until rs.eof
  dim prof, posid, image, oid
  prof = rs("ownerpostpic")
  posid = rs.fields("postid")
  image = rs("image")
  oid = rs("ownerid")

  response.write"<div class='post-container'>"
    response.write"<div class='user-profile1'>"

      if prof = "" then
        if oid = Session("uid") then
          response.write"<a href='profile.asp'><img src='images/default.png'></a>"
          response.write"<div>"
            response.write"<a href='profile.asp' style='text-decoration: none;'><p class='main-name'>"& rs.fields("username") & "</p></a>"
        else
          response.write"<a href='message.asp?id=" & oid & "'><img src='images/default.png'></a>"
          response.write"<div>"
            response.write"<a href='message.asp?id=" & oid & "' style='text-decoration: none;'><p class='main-name'>"& rs.fields("username") & "</p></a>"
        end if
        
      else
        response.write"<a href='message.asp?id=" & oid & "'><img src='"& prof &"'></a>"
        response.write"<div>"
          response.write"<a href='message.asp?id=" & oid & "' style='text-decoration: none;'><p class='main-name'>"& rs.fields("username") & "</p></a>"
      end if
     
        response.write"<span>"& rs.fields("date_posted") & "</span>"
      response.write"</div>"
    response.write"</div>"
  
    if image <> "" then
    response.write"<div class='write-post-containers' style='margin-bottom: 20px;'>"
      response.write"<p class='post-text'>"& rs.fields("post") & "</p>"
        response.write"<img src='"& image &"' class='image' style='width: 700px; height: 100%;'>"
        response.write "<div class='rbuttons'>"
          response.write"<div class='react-container1'  style='margin-left: 100px;'>"
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
      
      
          response.write"<div class='react-container2' style='margin-left: 300px;'>"
            response.write "<span id='comCount_" & posid & "' style='margin-right: 10px; margin-top: 5px;'>"& total_comments&"</span>"
            response.write"<a href='comment.asp?id=" & posid & "'>"
              response.write"<button class='react-buttons'  type='button'>"
                response.write"<img src='images/commented.png' title='View comments' >"
              response.write"</button>"
            response.write"</a>"
          response.write"</div>" 
         
          response.write"<div class='react-container3'  style='margin-left: 500px;'>"
            response.write "<div> "& rs.fields("num_share") &"</div>"
              response.write"<a href='shareport.asp?id="& posid &"'>"
                  response.write"<img src='images/share.png' title='Share Post'>"
                  response.write"</a>"
          response.write"</div>"
        
          Dim issOwner
          issOwner = (oid <> Session("uid"))
          
          if issOwner Then
							' Check if the user has reported the post
							Dim hassReported
							hassReported = HasReportedPost(posid)
							
              If hassReported Then
              ' The user has reported the post, so display the reported status
              response.write"<div class='react-container4' style='margin-left: 680px;'>"
              response.write"<span style='color: red;'>Reported</span>"
              response.write"</div>"
              Else
              ' The user has not reported the post, so display the report button
              response.write"<div class='react-container4' style='margin-left: 680px;'>"
              response.write"<a href='rep.asp?id="& posid &"'>"
              response.write"<img src='images/rep.png' title='Report Post'>"
              response.write"</a>"
              response.write"</div>"
              End If
						end if
    
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
          response.write"<div class='react-container1'  style='margin-left: 100px;'>"
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
      
      
          response.write"<div class='react-container2' style='margin-left: 300px;'>"
            response.write "<span id='comCount_" & posid & "' style='margin-right: 10px; margin-top: 5px;'>"& total_commentss &"</span>"
            response.write"<a href='comment.asp?id=" & posid & "'>"
              response.write"<button class='react-buttons'  type='button'>"
                response.write"<img src='images/commented.png' title='View comments' >"
              response.write"</button>"
            response.write"</a>"
          response.write"</div>" 
         
          response.write"<div class='react-container3'  style='margin-left: 500px;'>"
            response.write "<div> "& rs.fields("num_share") &"</div>"
              response.write"<a href='shareport.asp?id="& posid &"'>"
                  response.write"<img src='images/share.png' title='Share Post'>"
                  response.write"</a>"
          response.write"</div>"
        
          Dim isOwner
          isOwner = (oid <> Session("uid"))
          
          if isOwner Then
							' Check if the user has reported the post
							Dim hasReported
							hasReported = HasReportedPost(posid)
							
              If hasReported Then
              ' The user has reported the post, so display the reported status
              response.write"<div class='react-container4' style='margin-left: 680px;'>"
              response.write"<span style='color: red;'>Reported</span>"
              response.write"</div>"
              Else
              ' The user has not reported the post, so display the report button
              response.write"<div class='react-container4' style='margin-left: 680px;'>"
              response.write"<a href='rep.asp?id="& posid &"'>"
              response.write"<img src='images/rep.png' title='Report Post'>"
              response.write"</a>"
              response.write"</div>"
              End If
						end if
            
    
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
  
<script src="./assets/js/image.js"></script>
<script>
  

  //report

  // Function to handle the report button click
 

  //end report

    // Function to handle the like button click

      
    // Initialize liked and disliked objects from local storage
    var liked = JSON.parse(localStorage.getItem('liked')) || {};

    // Update the like and dislike counts on page load
    updateCounts();

    function updateCounts() {
      for (var postId in liked) {
        document.getElementById('likeCount_' + postId).innerHTML = liked[postId];
      }
    }

    // Function to handle the like button click
    function like(postId) {
  var likeCount = parseInt(document.getElementById('likeCount_' + postId).innerHTML);

  if (liked[postId]) {
    // User wants to undo the like
    likeCount--;
    delete liked[postId];
  } else {
    // User wants to like
    likeCount++;
    liked[postId] = likeCount;

    // If the user has previously disliked, undo the dislike
  }

  document.getElementById('likeCount_' + postId).innerHTML = likeCount;
  updateLocalStorage();
  updatelike(postId, likeCount); // Call the function to update the database
}

    

    // Function to update the local storage with the current liked and disliked counts
    function updateLocalStorage() {
      localStorage.setItem('liked', JSON.stringify(liked));
    }

    // Function to update the likes and dislikes in the database
   function updatelike(postId, likeCount) {

      // Send an AJAX request to the server to update the database
      var xhr = new XMLHttpRequest();
      xhr.open('POST', 'updatelike.asp', true);
      xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
      xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
          // Handle the response from the server if needed
          console.log(xhr.responseText);
        }
      };
      xhr.send('postId=' + postId + '&likeCount=' + likeCount);
    } 
</script>
</body>
</html>