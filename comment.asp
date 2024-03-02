<!--#include file="./templates/dbconnection.asp"-->

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
</head>
<style>
  /* Style inputs with type="text", select elements and textareas */
input[type=text], select, textarea {
  width: 100%; /* Full width */
  padding: 12px; /* Some padding */ 
  border: 1px solid #ccc; /* Gray border */
  border-radius: 4px; /* Rounded borders */
  box-sizing: border-box; /* Make sure that padding and width stays in place */
  margin-top: 6px; /* Add a top margin */
  margin-bottom: 16px; /* Bottom margin */
  resize: vertical /* Allow the user to vertically resize the textarea (not horizontally) */
}

/* Style the submit button with a specific background color etc */
input[type=submit] {
  background-color: #04AA6D;
  color: white;
  padding: 12px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

/* When moving the mouse over the submit button, add a darker green color */
input[type=submit]:hover {
  background-color: #45a049;
}

/* Add a background color and some padding around the form */
.container {
  border-radius: 5px;
  background-color: #f2f2f2;
  padding: 20px;
}

</style>
<body>
  
<%
Dim id
id = Request.QueryString("id")

' Retrieve the total number of comments for the post
Dim rs
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open "SELECT COUNT(*) AS total_comments FROM comment WHERE postid=" & id, cn

Dim total_comments
total_comments = rs("total_comments")
rs.Close
Set rs = Nothing

%>

<div class="container mt-5 mb-5">
    <div class="row height d-flex justify-content-center align-items-center">
      <div class="col-md-7">
        <div class="card">
          <div class="p-3">
            <a href="javascript:history.back()">
            <img src="images/gb.png" height="40px" alt="" style="margin-left: 10px;" title="Go back"></a>
            <h6 style="margin-top: 10px;"><%= total_comments %> Comment/s</h6>
          </div><hr>

          <%
          set rs = Server.CreateObject("adodb.recordset")
          rs.Open "SELECT `comment`.time_commented, `comment`.`comment`, `comment`.ownerid, `profile`.username, `profile`.profilepic, post.postid FROM `comment` INNER JOIN `profile` ON `comment`.ownerid = `profile`.uid INNER JOIN post ON `comment`.postid = post.postid WHERE comment.postid=" & id &" ORDER BY time_commented DESC", cn
      
          do until rs.eof
            Dim photo, name, user, oid
            photo = rs("profilepic")
            name = rs("username")
            user = Session("uid")
            oid = rs("ownerid")

            response.write "<div class='mt-2'>"
            response.write "<div class='d-flex flex-row p-3'>"
              if photo = "" then
                response.write "<a href='message.asp?id=" & oid & "'><img src='images/default.png' width='40' height='40' class='rounded-circle mr-3'></a>"
              else 
                response.write "<a href='message.asp?id=" & oid & "'><img src='" & photo & "' width='40' height='40' class='rounded-circle mr-3'></a>"
              end if
            
            response.write "<div class='w-100'>"
              response.write "<div class='d-flex justify-content-between align-items-center'>"
                response.write "<div class='d-flex flex-row align-items-center'>"
                  response.write "<small class='c-badge'><a class='name-link' href='message.asp?id=" & oid & "'>" & name & "</a></small>"
                  response.write "</div>"                  
                response.write "<div class='d-flex flex-row align-items-center'>"
                  response.write "<small><i>" & rs.fields("time_commented") & "</i></small>"          
                response.write "</div>"
              response.write "</div>" 
                
              response.write "<p class='text-justify comment-text mb-0'>"& rs.fields("comment") &"</p>"
              response.write "<div class='d-flex flex-row user-feed'>"
              response.write "</div>"
            response.write "</div>"
            response.write "</div>"
            response.write "</div>"
            rs.movenext
          loop
          rs.close
          %>  
        </div>
      </div>
    </div>
</div>

</body>
</html>

