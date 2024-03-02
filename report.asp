<!--#include file="./templates/dbConnection.asp"-->

<%
' Check if the user is logged in
If Session("uid") = "" Then
    Response.Redirect "login.asp" ' Redirect the user to the login page if not logged in
    Response.End
End If

' Get the values from the form
Dim postid, violation, others, owner
postid = Request.Form("postid")
violation = Request.Form("violation")
others = Request.Form("others")
owner = Session("uid")



    Dim sql
    If violation = "" Then
        ' Insert the report with 'others' as the reason
        sql = "INSERT INTO reports (reason, reporter, postid) VALUES ('" & others & "', '" & owner & "', '" & postid & "')"
    ElseIf others = "" Then
        ' Insert the report with 'violation' as the reason
        sql = "INSERT INTO reports (reason, reporter, postid) VALUES ('" & violation & "', '" & owner & "', '" & postid & "')"
    Else
        ' Insert the report with both 'violation' and 'others' as the reasons
        sql = "INSERT INTO reports (reason, reporter, postid) VALUES ('" & violation & ", and " & others & "', '" & owner & "', '" & postid & "')"
    End If

    ' Execute the SQL query to insert the report
    cn.Execute sql


    ' Redirect the user back to the previous page or homepage
    Response.Redirect "home.asp" ' Change this to your desired redirect URL
' If the user has already reported this post, show an error message or redirect back to the previous page
    Response.Write "You have already reported this post."
    ' Or, you can redirect back to the previous page using:
    ' Response.Redirect Request.ServerVariables("HTTP_REFERER")

%>
