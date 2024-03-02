<!--#include file="./templates/dbConnection.asp"-->

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" type="text/css" href="../assets/css/home.css">
	<title>AuthoRevw - Administrator</title>

</head>
<body style="background-color: #E6DCDC">

<!--#include file="./templates/adminheader.asp"-->
<div class="collapse navbar-collapse" id="navbarColor01">
    <ul class="navbar-nav me-auto">
      <li class="nav-item">
        <a class="nav-link" href="admin.asp">Manage Posts
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link active" href="adminreports.asp">Manage Reports</a>
        <span class="visually-hidden">(current)</span>
      </li>
      <li class="nav-item">
          <a class="nav-link" href="accounts.asp">Manage Accounts</a>
        </li>
      <li class="nav-item">
          <a class="nav-link" href="logout.asp">Logout</a>
        </li>
    </ul>
    
  </div>
</div>
</nav>
<div class="container">

<h1 class="text-center"><br>Manage Reports</h1><br>

<form  method="get" action="reports.asp">
    Search: <input type="text" name="txtSearch" placeholder="Submitted by / Post Owner  / Reason" style="min-width: 300px;">
</form><br>
<div class="form-group">
	<label for="sort">Order by: &nbsp;</label>
	<select name="sort" id="sort">
	  <option value="">Newest</option>
	  <option value="Oldest">Oldest</option>
	</select>
  </div>
<br>

<%
	set rs = server.createobject("adodb.recordset")

	Dim sortBy
	sortBy = request.querystring("sortby")
	Dim sortclause

	if sortBy = "Oldest" then
		sortclause = " ORDER BY date_reported ASC"        
	else
		sortclause = " ORDER BY date_reported DESC"
	end if

	if request.querystring("txtSearch") = "" then
		rs.open "SELECT post.postid, post.post, `profile`.username, post.image, reporterprof.username AS reporteruname, reports.reason, reports.date_reported, reporterprof.uid, `profile`.uid FROM post INNER JOIN `profile` ON post.ownerid = `profile`.uid INNER JOIN reports ON post.postid = reports.postid INNER JOIN `profile` AS reporterprof ON reports.reporter = reporterprof.uid" & sortclause, cn
	else
		rs.open "SELECT posts.postid, posts.description, profiles_owner.`status`, `profiles_owner`.complete_name AS owner_complete_name, posts.image, `profiles_submitter`.complete_name AS submitter_complete_name, reports.reportid, reports.reason, reports.date_submitted, profiles_owner.userid FROM posts INNER JOIN reports ON posts.postid = reports.postid INNER JOIN `profiles` AS `profiles_owner` ON posts.`owner` = `profiles_owner`.userid INNER JOIN `profiles` AS `profiles_submitter` ON reports.submittedby = `profiles_submitter`.userid WHERE profiles_owner.complete_name like '%" & request.querystring("txtSearch") & "%' OR profiles_submitter.complete_name like '%" & request.querystring("txtSearch") & "%' OR reason like '%" & request.querystring("txtSearch") & "%'" & sortclause , cn
	end if
	response.write "<table class='table table-hover'>"
	response.write "<thead>"
	response.write "<tr class='table-info'>"
	response.write "<th class='text-center'>Image</th>"
	response.write "<th>Owner</th>"
	response.write "<th>Description</th>"
	response.write "<th class='text-center' style='font-size: 12px;'>Reported By</th>"
	response.write "<th>Reason</th>"
	response.write "<th>Date Submitted</th>"
	response.write "<th>Action</th>"
	response.write " </tr>"
	response.write "</thead>"
	response.write "<tbody>"

if rs.eof then
	response.write "<tr>"
	response.write "<td colspan='9' align='center'>No reports found.</td>"
	response.write "</tr>"
else
	do until rs.eof

	Dim photo_base64
	photo_base64 = rs("image")

	response.write " <tr class='table-secondary'>"
	if photo_base64 = "" then
		response.write "<td class='text-center'><img src='images/noimage.png' alt='' height='100px'></td>"
	else
		response.write "<td class='text-center'><img src='" & photo_base64 & "' alt='' height='100px'></td>"
	end if
	response.write "<td>"& rs.fields("username") &"</td>"
	response.write "<td style='font-size: 12px;'>"& rs.fields("post")&"</td>"
	response.write "<td class='text-center'>" & rs.fields("reporteruname") & "</td>"
	response.write "<td>"& rs.fields("reason") &"</td>"	
	response.write "<td style='font-size: 12px;'>"& rs.fields("date_reported") &"</td>"
	response.write "<td>"
	response.write " <a href='delpost.asp?id=" & rs.fields("postid") & "'><img src='images/delete.png' alt='' title='Remove Post'></a>"
	response.write " <a href='deletereport.asp?id=" & rs.fields("postid") & "'><img src='images/discard.png' alt='' title='Discard Report'></a></td>"
	response.write "</tr>"
	response.write "</tbody>"

	rs.movenext
	loop
end if
rs.close
response.write "</table>"
%>

<script>
	// script for filter genre
	const sortDropdown = document.getElementById('sort');
	let selectedSort = getSelectedSort();

	// Set the initial selected genre
	sortDropdown.value = selectedSort;

	// Listen for the change event on the genre dropdown
	sortDropdown.addEventListener('change', function() {
		const newSelectedSort = this.value;
		if (newSelectedSort !== selectedSort) {
		updateSelectedSort(newSelectedSort);
		submitSortForm();
		}
	});

	// Function to get the currently selected genre from the URL query parameter
	function getSelectedSort() {
		const urlParams = new URLSearchParams(window.location.search);
		return urlParams.get('sortby') || '';
	}

	// Function to update the selected genre in the URL query parameter
	function updateSelectedSort(sort) {
		const urlParams = new URLSearchParams(window.location.search);
		urlParams.set('sortby', sort);
		const newUrl = `${window.location.pathname}?${urlParams.toString()}`;
		window.history.replaceState({}, '', newUrl);
		selectedSort = sort;
	}

	// Function to submit the filter form
	function submitSortForm() {
		const form = document.querySelector('form');
		form.submit();
		location.reload(); // Refresh the page
	}
</script>
