<!--#include file="./templates/dbconnection.asp"-->
<%
Dim id
id = Request.Form("id")

    Dim newComment
    newComment = Request.Form("comment")
    
    ' Insert the new comment into the database
    On Error Resume Next ' Enable error handling
    cn.Execute "INSERT INTO comment (comment, postid, ownerid) VALUES ('" & Replace(newComment, "'", "''") & "', " & id & ", " & Session("uid") & ")"
    cn.Execute "INSERT INTO notification (postid, ownerid, about) VALUES ('" & id & "', '" & Session("uid") & "', '2')"
    If Err.Number <> 0 Then ' Check for errors during database interaction
        Response.Write "Error occurred while submitting the comment. Please try again later."
        Err.Clear ' Clear the error to prevent it from affecting subsequent code
    Else
        Response.Redirect "home.asp" ' Redirect to home page after submitting the comment
    End If
    On Error GoTo 0 ' Disable error handling
%>
