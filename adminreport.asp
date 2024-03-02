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
	margin-left: 60px;

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
<h1 class="manage-users">Manage Reports</h1>
<div class="lsearch" method="get" action="adminreport.asp">
	<form class="d-flex">
		<button class="btn btn-secondary my-2 my-sm-0" type="submit">Search</button>
  		<input class="form-control me-sm-2" name="txtSearch" type="search" placeholder="Search">
	</form>
</div>

<%
	set rs = server.createobject("adodb.recordset")
	if request.querystring("txtSearch") = "" then
		rs.open "SELECT post.postid, post.description, `profile_owner`.username AS owner_username, post.image, `profile_submitter`.username AS submitter_username, report.reportid, report.reason, report.date_submitted, profile_owner.uid FROM post INNER JOIN report ON post.postid = report.postid INNER JOIN `profile` AS `profile_owner` ON post.`ownerid` = `profile_owner`.userid INNER JOIN `profile` AS `profile_submitter` ON report.submittedby = `profile_submitter`.userid ORDER BY date_submitted DESC", cn
	else
		rs.open "SELECT post.postid, post.description, `profile_owner`.username AS owner_username, post.image, `profile_submitter`.username AS submitter_username, report.reportid, report.reason, report.date_submitted, profile_owner.uid FROM post INNER JOIN report ON post.postid = report.postid INNER JOIN `profile` AS `profile_owner` ON post.`ownerid` = `profile_owner`.userid INNER JOIN `profile` AS `profile_submitter` ON report.submittedby = `profile_submitter`.userid WHERE profile_owner.username like '%" & request.querystring("txtSearch") & "%' OR profile_submitter.username like '%" & request.querystring("txtSearch") & "%' OR reason like '%" & request.querystring("txtSearch") & "%'" , cn
	end if
	response.write "<table class='table'>"
	response.write "<thead>"
	response.write "<tr class='table-tr'>"
	response.write "<th class='table-tr'>Image</th>"
	response.write "<th class='table-tr'>Owner</th>"
	response.write "<th class='table-tr'>Description</th>"
	response.write "<th class='table-tr'>Submittrd by</th>"
	response.write "<th class='table-tr'>Reason</th>"
	response.write "<th class='table-tr'>Date Sumitted</th>"
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

	response.write " <tr class='table-secondary'>"
	if photo_base64 = "" then
		response.write "<td class='text-center'><img src='./assets/images/book.png' alt='' height='100px'></td>"
	else
		response.write "<td class='text-center'><img src='" & photo_base64 & "' alt='' height='100px'></td>"
	end if

	response.write "<td class='table-td'>"& rs.fields("owner_complete_name") &"</td>"
	response.write "<td class='table-td'>"

	response.write "<td class='table-td'>" & rs.fields("username")&"</td>"
	response.write "<td class='table-td'>" & rs.fields("messenger") & "</td>"
	response.write "<td class='table-td'>" & rs.fields("pword") &"</td>"
	response.write "<td class='table-td'>"& rs.fields("date_created") &"</td>"
	response.write "<td class='table-td'>report account</td>"

	if rs.fields("status") = 0 then
    response.write "<td class='table-td'><a href='adminenable.asp?id=" & rs.fields("uid") & "'><img src='./assets/images/off.png' alt='' title='Enable Account'></a> Disabled </td>"
  else
  response.write "<td class='table-td'><a href='admindisable.asp?id=" & rs.fields("uid") & "'><img src='./assets/images/on.png' alt='' title='Disable Account'></a> Active </td>"
  end if

	
	response.write "<td class='table-td'><a href='adminremove.asp?id=" & rs.fields("uid") & "'><img src='./assets/images/rem.png' alt='' title='Remove Account'></a></td>"
	response.write "</tr>"
	response.write "</tbody>"

	rs.movenext
	loop
end if
rs.close
response.write "</table>"
%>

<!--#include file="./templates/footer.asp"-->
