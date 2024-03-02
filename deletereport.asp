<!--#include file="./templates/dbconnection.asp"-->
<%
	dim uid
	uid = request.querystring("id")

	sql = "DELETE FROM reports WHERE postid=" & uid

	on error resume next
	cn.Execute sql

	if err<>0 then
		response.write ("No update permissions!")
		response.write err.description
	else
		response.redirect("adminreports.asp")
	end if

cn.close
%>