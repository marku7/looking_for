<!--#include file="./templates/dbconnection.asp"-->

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" type="text/css" href="../assets/css/ad.css">
	<title>LF - Administrator</title>
	<style>
		.imp-links {
		display: flex;
		justify-content: right;
		margin-bottom: -70px;
	}

	.left-btn {
		margin: 10px 0;
		padding: 10px;
		border-radius: 8px;
		box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
		background-color: #ccc6c6;
		border: none;
		color: black;
		font-size: 12px;
		cursor: pointer;
		transition: background-color 0.3s ease;
	}
	</style>

</head>
<body style="background-color: #E6DCDC">

<!--#include file="./templates/adminheader.asp"-->

<div class="collapse navbar-collapse" id="navbarColor01">
	<ul class="navbar-nav me-auto">
	  <li class="nav-item">
		<a class="nav-link active" href="admin.asp">Manage Posts
		  <span class="visually-hidden">(current)</span>
		</a>
	  </li>
	  <li class="nav-item">
		<a class="nav-link" href="adminreports.asp">Manage Reports</a>
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
	
	<h1 class="text-center"><br>Manage Posts</h1><br>

	<form  method="get" action="admin.asp">
		Search: <input type="text" name="txtSearch" placeholder="Owner / Post Description" style="min-width: 300px;">
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
		sortclause = "ORDER BY date_posted ASC"        
	else
		sortclause = "ORDER BY date_posted DESC"
	end if

	if request.querystring("txtSearch") = "" then
		rs.open "SELECT post.postid, post.post, post.image, post.date_posted, `profile`.username, `profile`.profilepic AS ownerpostpic, `profile`.uid, `profile`.pword FROM post INNER JOIN `profile` ON post.ownerid = `profile`.uid "& sortclause, cn
	else
		rs.open "SELECT post.postid, post.post, post.image, post.date_posted, `profile`.username, `profile`.profilepic AS ownerpostpic, `profile`.uid, `profile`.pword FROM post INNER JOIN `profile` ON post.ownerid = `profile`.uid WHERE username LIKE '%" & request.querystring("txtSearch") & "%' OR post LIKE '%" & request.querystring("txtSearch") & "%' "& sortclause, cn
	end if

	response.write "<table class='table table-hover'>"
	response.write "<thead>"
	response.write "<tr class='table-info'>"
	response.write "<th class='text-center'>Image</th>"
	response.write "<th class='text-center'>Owner</th>"
	response.write "<th class='text-center'>Description</th>"
	response.write "<th class='text-center'>Date Posted</th>"
	response.write "<th class='text-center'>Action</th>"
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
		response.write "<td class='text-center'><img src='images/noimage.png' alt='' height='100px'></td>"
	else
		response.write "<td class='text-center'><img src='" & photo_base64 & "' alt='' height='100px'></td>"
	end if
	response.write "<td class='text-center'>"& rs.fields("username") &"<br><i>"& rs("pword")&"</i></td>"
	response.write "<td class='text-center'>"& rs.fields("post") &"</td>"
	response.write "<td class='text-center'>"& rs.fields("date_posted") &"</td>"
	response.write "<td class='text-center'><a href='admindelete.asp?id=" & rs.fields("postid") & "'><img src='images/delete.png' alt='' title='Remove Post'></a></td>"
	response.write "</tr>"
	response.write "</tbody>"

	rs.movenext
	loop
	end if
	rs.close
	response.write "</table>"
	%>

	</div>
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

<!--#include file="./templates/footer.asp"-->
