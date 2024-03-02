<!--#include file="./templates/dbconnection.asp"-->
<%
Dim description, owner, image

description = Request.Form("description")
owner = Session("uid")
image = request.form("base64")


sql = "INSERT INTO post (post, ownerid, image, num_share, num_like) VALUES ('" & description & "', '" & owner & "', '" & image & "', '0', '0')"

On Error Resume Next
cn.Execute sql, recaffected

If Err <> 0 Then
	Response.Write("No update permissions!")
	Response.Write(Err.Description)
Else
	'Response.Write("<h3>" & recaffected & " record added</h3>")
	Response.Redirect("home.asp")
End If

cn.Close
%>
