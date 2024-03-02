<!--#include file="./templates/dbconnection.asp"-->
<%
dim base64, id

base64 = Request.Form("base64")
id = Session("uid")

sql = "UPDATE profile SET profilepic = '" & base64 & "' WHERE uid = " & id

On Error Resume Next
cn.Execute sql, recaffected

If Err <> 0 Then
	Response.Write("No update permissions!")
	Response.Write Err.Description
Else
	Response.Redirect("profile.asp")
End If

cn.Close
%>
