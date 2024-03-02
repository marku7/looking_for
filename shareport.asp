<!--#include file="./templates/dbconnection.asp"-->

<%
' Check if the user is logged in
If Session("uid") = "" Then
    Response.Redirect "index.html" ' Redirect the user to the login page if not logged in
    Response.End
End If

' Get the values from the form
Dim owner, pid
owner = Session("uid")
pid = Request.querystring("id")

Dim sql

    ' Insert the report with both 'violation' and 'others' as the reasons
    sql = "INSERT INTO share (ownerid, shared_post) VALUES ('" & owner & "', '" & pid & "')"
    sql = "INSERT INTO notification (postid, ownerid, about) VALUES ('" & pid & "', '" & Sowner & "', '3')"

' Execute the SQL query to insert the report
cn.Execute sql

' Redirect the user back to the previous page or homepage
Response.Redirect "home.asp" ' Change this to your desired redirect URL
%>
