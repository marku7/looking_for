<!--#include file="./templates/dbConnection.asp"-->
<%
	dim uid
	uid = request.querystring("id")

	sql = "UPDATE profile SET status = 0 WHERE uid=" & uid
	
	on error resume next
	cn.Execute sql

	if err<>0 then
		response.write ("No update permissions!")
		response.write err.description
	else
		response.redirect("admin.asp")
	end if

cn.close
%>

