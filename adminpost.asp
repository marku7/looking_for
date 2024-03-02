<!--#include file="./templates/dbconnection.asp"-->

<!--#include file="./templates/adminheader.asp"-->
<!DOCTYPE html>
<html>
<head>
  <link rel="stylesheet" type="text/css" href="https://bootswatch.com/4/flatly/bootstrap.min.css">
  <link rel='stylesheet' type='text/css' media='screen' href='./assets/css/style.css'>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>LF Administrator</title>
</head>
<style type="text/css">
	.table{
	width:1250px;
	height: auto;
	margin-left: 30px;

	margin-top:50px;
}

	.table-tr{
		background-color: gray;
		color: white;
	}

	.table-td{
		background-color: white;
		align-items: center;
	}

	.table-td:hover{
		background-color: gray;
	}
</style>
<h1 class="manage-users">Manage Posts</h1>
<div class="lsearch" method="get" action="admin.asp">
	<form class="d-flex">
		<button class="btn btn-secondary my-2 my-sm-0" type="submit">Search</button>
  		<input class="form-control me-sm-2" name="txtSearch" type="search" placeholder="Search">
	</form>
</div>

<%
	set rs = server.createobject("adodb.recordset")
	if request.querystring("txtSearch") = "" then
		rs.open " SELECT post.postid, post.ownerid, post.post, post.image, post.date_posted, post.num_share, post.num_like, post.num_comment, `profile`.username, `profile`.profilepic, `profile`.uid FROM post INNER JOIN `profile`ON post.ownerid = `profile`.uid ORDER BY date_posted DESC", cn
	else
  	rs.open " SELECT post.postid, post.ownerid, post.post, post.image, post.date_posted, post.num_share, post.num_like, post.num_comment, `profile`.username, `profile`.profilepic, `profile`.uid FROM post INNER JOIN `profile`ON post.ownerid = `profile`.uid WHERE username like '%" & request.querystring("txtSearch") & "%' OR post like '%" & request.querystring("txtSearch") & "%'" , cn
	end if
	response.write "<table class='table'>"
	response.write "<thead>"
	response.write "<tr class='table-tr'>"
	response.write "<th class='table-tr'>Owner</th>"
	response.write "<th class='table-tr'>Image</th>"
	response.write "<th class='table-tr'>Description</th>"
	response.write "<th class='table-tr'>Date Posted</th>"
	response.write "<th class='table-tr'>Action</th>"
	response.write " </tr>"
	response.write "</thead>"
	response.write "<tbody>"

if rs.eof then
	response.write "<tr>"
	response.write "<td colspan='9' align='center'>No records found.</td>"
	response.write "</tr>"
else
	do until rs.eof

	Dim photo_base64
	photo_base64 = rs("image")

	response.write " <tr class='record'>"
	response.write "<td class='table-td'>"& rs.fields("username") &"</td>"

	if photo_base64 = "null" then
		response.write "<td class='table-td'><img src='images/nophoto.jpg' alt='' style='border-radius: 0%;' height='50px'></td>"
	else
		response.write "<td class='table-td'><img src='image/" & photo_base64 & "' alt='' height='50px' style='border-radius: 0%;'></td>"
	end if

	response.write "<td class='table-td'>" & rs.fields("post")&"</td>"
	response.write "<td class='table-td'>" & rs.fields("date_posted") & "</td>"
	response.write "<td class='table-td'><a href='admindelete.asp?id=" & rs.fields("uid") & "'><img src='images/delete.png' alt='' title='Remove Post'></a></td>"

	response.write "</tr>"
	response.write "</tbody>"

	rs.movenext
	loop
end if
rs.close
response.write "</table>"
%>

<!--#include file="./templates/footer.asp"-->
