<!--#include file="./templates/dbconnection.asp"-->

<link rel="stylesheet" href="./assets/css/comment.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-alpha1/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="./assets/css/comment.css">
<style>
  .name-link {
    text-decoration: none;
    color: inherit;
  }

</style>

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
          rs.Open "SELECT `comment`.time_commented, `comment`.comid, `comment`.`comment`, `comment`.ownerid, `profile`.username, `profile`.profilepic, post.postid FROM `comment` INNER JOIN `profile` ON `comment`.ownerid = `profile`.uid INNER JOIN post ON `comment`.postid = post.postid WHERE comment.postid=" & id &" ORDER BY time_commented DESC", cn
      
          do until rs.eof
            Dim photo, name, user
            photo = rs("profilepic")
            name = rs("username")
            user = Session("uid")

            response.write "<div class='mt-2'>"
            response.write "<div class='d-flex flex-row p-3'>"
            response.write "<a href='#'><img src='" & photo & "' width='40' height='40' class='rounded-circle mr-3'></a>"
            response.write "<div class='w-100'>"
              response.write "<div class='d-flex justify-content-between align-items-center'>"
                response.write "<div class='d-flex flex-row align-items-center'>"
                  response.write "<small class='c-badge'><a class='name-link' href='#'>" & name & "</a></small>"
                  response.write "</div>"                  
                response.write "<div class='d-flex flex-row align-items-center'>"
                  response.write "<small><i>" & rs.fields("time_commented") & "</i></small>"
                  response.write "<a href='delcom.asp?id=" & rs.fields("comid") & "' title='Remove comment' style='margin-left: 5px;'><img src='images/delete.png' alt=''></a>"          
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
