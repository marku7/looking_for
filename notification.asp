<!--#include file="./templates/dbconnection.asp"-->
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel='stylesheet' type='text/css' media='screen' href='./assets/css/style.css'>
	<link rel="stylesheet" type="text/css" href="./assets/css/prof.css">
	<!-- <link rel="stylesheet" type="text/css" href="./assets/css/tarry.css"> -->
  <link rel="stylesheet" type="text/css" href="./assets/css/notificationtrial.css">

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

.main-content{
flex-basis: 30%;
display: inline-block;
align-items: right;
justify-content: center;
width: 100%;
max-width: 100%;
background: #9bb4a0;
padding: 10px 10% ;
box-shadow: 0 0 20px #083411;
border-color: 0 0 50px #007f3d;
margin-inline-start: 20px;

}

.options{
width: 300px;
height: 250px;
background: #9bb4a0;
border-radius: 8px;
columns: #626262;
flex-basis: 30%;
box-shadow: 0 0 5px #083411;
border-color: 50 50 50px #007f3d;
border: 5px solid #007f3d;
margin-inline-start: 20px;
margin-top: 30px;
margin-left: 30px;
margin-bottom: 20px;
position: sticky;
}


.post-container {
  display: flex;
  align-items: center;
  font-size: 20px;
  margin-bottom: 20px;
  width: 1000px;
}

.notifi-info {
  display: flex;
  align-items: center;

}

.notifi-pic {
  border-radius: 50%;
  width: 70px;
  margin-right: 10px;
  margin-top: 10px;
}

.notifi-name {

  margin-right: 10px;
}

.notifi-about {

  margin-right: 10px;
}


.go-button {
  margin-left: 10px;
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


.lfsearch{
    border-color: white;
    width: 50px;
    display: inline-table;
    background-color: #9bb4a0;
   /* margin-right: 5px;
    margin-left: 50px; */
/*    margin-top: 30px;  */
    
}

.search{
    border-color: #9bb4a0;
    width: 200px;
    height: 30px;
    display: inline-table;
    background-color: white;
}


.saerchbox{
width: 400px;
height: 100px;
background: #9bb4a0;
border-radius: 8px;
columns: #626262;
flex-basis: 30%;
/*display: inline-block;*/
box-shadow: 0 0 5px #083411;
border-color: 50 50 50px #007f3d;
border: 50px;
margin-inline-start: 20px;
margin-top: 50px;
margin-left: 50px;
margin-bottom: 20px;
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

.logout{
    background-color: #007f3d;
    margin-top: 10px;
    margin-left: 730px;
    width: 150px;
    height: 30px;
    border-radius: 5px;
    position: absolute;
    margin-bottom: -100px;
}

.icon{
  margin-left: 400px;
  margin-top: 20px;
  margin-bottom: -150px;
  height: 60px;
  width: 60px;
  border-radius: 50%;
  border-color: whitesmoke;
  box-shadow: 5px;
  display: flex;
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
</style>
<body>

	<a href="#" class="back-to-top">
  <img src="images/back-2-top-30.png" alt="Back to Top" />
  </a>



<% 

      set rs = server.createobject("ADODB.recordset")
        rs.open "SELECT * FROM profile WHERE uid=" & Session("uid"), cn

        dim user, avatar
      user = rs("username")
      avatar = rs("profilepic")

      rs.close
      set rs = Nothing

 response.write"<div class='options' style='position: sticky;  z-index: 100; margin-top: 50px;'>"
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
        response.write"<p class='nav-list' action='notification.asp'>&nbsp;NOTIFICATION</p></a>"
      response.write"</div>"
    response.write"</div>"


    response.write"<div class='page' style='margin-top: -300px;'>"



  response.write"<form class='d-flex' >"
    response.write"<a href='logout.asp'>"
      response.write"<button type='button' class='logout' style=' margin-top: 100px; z-index: 10;'>Logout</button>"
    response.write"</a>"
  response.write"</form>"
  

      response.write"<div class='profile-card' >"
        response.write"<img src='images/back2.png' class='cover-pic' style='height: 150px; z-index: -10;'>"
      response.write"</div>"



      if avatar = "" then
          response.write"<div><img src='images/default.png' class='profile-pic' style='border: none;'></div>"
      else
          response.write"<div><img src='"& avatar &"' class='profile-pic' > </div>"
      end if
     
           
 
      response.write"<br>"
      response.write"<br>"       

      response.write"<div class='username' style='margin-bottom: 50px;  position: sticky; margin-top: -130px;'>" & user & "</div>"



  set nrs = server.createobject("adodb.recordset")
    nrs.open "SELECT notification.notif_id, notification.about, notification.notif_at, post.ownerid, `profile`.uid AS notifowner, post.postid, `profile`.username, `profile`.profilepic FROM notification INNER JOIN post ON notification.postid = post.postid INNER JOIN `profile` ON notification.ownerid = `profile`.uid ORDER BY notif_at DESC", cn 
 

  do until nrs.eof
  dim prof, uname, notif, ownerid, date, notifid, pid
  prof = nrs("profilepic")
  uname = nrs("username")
  notif = nrs("about")
  ownerid = nrs("notifowner")
  date = nrs("notif_at")  
  notifid = nrs("notif_id")    
  pid = nrs("postid")    


  response.write "<div class='post-container' style='margin-left: 50px;'>"
    response.write "<div class='notifi-info'>"
      if prof = "" then
        response.write "<a href='message.asp?id=" & ownerid & "' style='text-decoration: none;'><img src='images/default.png' class='notifi-pic' title='Visit Prfile'></a>"
      else 
        response.write "<a href='message.asp?id=" & ownerid & "' style='text-decoration: none;'><img src='" & prof & "' class='notifi-pic' title='Visit Prfile'></a>"
      end if
      
      response.write "<a href='message.asp?id=" & ownerid & "' class='notifi-name' style='text-decoration: none;' title='Visit Prfile'>" & uname & "&nbsp;</a>"
    response.write "</div>"

    response.write "<div class='notifi-about'>"
      if notif = 1 then
        response.write "liked your post at &nbsp;"
      elseif notif = 2 then
        response.write "commented on your post at&nbsp;"
      elseif notif = 3 then
        response.write "shared your post at&nbsp;"
      elseif notif = 4 then
        response.write "reported your post at&nbsp;"
      else
      response.write "Invalid notification"
      end if

    response.write "</div>"

    response.write "<div class='notifi-at'>" & date & "&nbsp;</div>"

    response.write "<div class='go-button'>"
      response.write "<a href='viewpost.asp?id=" & pid & "' style='text-decoration: none;'><img src='./images/go.png' title='Visit Post'></a>"
    response.write "</div>"
    
  response.write "</div>"
  response.write "<div class='del-button' style='margin-left: 850px; margin-bottom: 10px;'>"
    response.write "<a href='delnotif.asp?id=" & notifid & "' style='text-decoration: none;'><img src='./images/delete.png' title='Remove Notification'></a>"
  response.write "</div>"
  response.write "<hr>"
nrs.movenext

loop 
nrs.close
response.write"</div>"
%>

   
              
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


</script>