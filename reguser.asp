<!--#include file="./templates/dbconnection.asp"-->


<%

dim username, messenger, pword, status
username= request.form("username")
messenger= request.form("messenger")
pword= request.form("pword")
status= request.form("status")
base64 = Request.form("base64")


sql="INSERT INTO profile (username, messenger, pword, profilepic, status) VALUES ('" & username & "','" & messenger & "','" & pword & "', '" & base64 & "', 1  )"

on error resume next
cn.Execute sql,recaffected

if err<>0 then
	Response.Write("No update permissions!")
	response.write err.description
else
	response.redirect("index.html")
end if


cn.close
%>

