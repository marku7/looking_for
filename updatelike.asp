<!--#include file="./templates/dbconnection.asp"-->
<%

' Retrieve the values sent from the client-side JavaScript
Dim postId, likeCount
postId = Request.Form("postId")
likeCount = Request.Form("likeCount")

On Error Resume Next

If Err.Number <> 0 Then
    Response.Write "Database connection error: " & Err.Description
    Response.End
End If

' Retrieve the current likes and dislikes count from the database
sql = "SELECT num_like FROM post WHERE postid=" & postId
Set rs = cn.Execute(sql)

If Not rs.EOF Then
    currentLikeCount = rs("num_like")
    rs.Close
    
    ' Check if the likeCount or dislikeCount has been incremented or decremented
    ' If so, update the database with the new values
    If likeCount <> currentLikeCount Then
        sql = "UPDATE post SET num_like=" & likeCount & " WHERE postid=" & postId
        sql = "INSERT INTO notification (postid, ownerid, about) VALUES ('" & postId & "', '" & Session("uid") & "', '1')"
        cn.Execute sql
        
        If Err.Number <> 0 Then
            Response.Write "Database update error: " & Err.Description
        Else
            Response.Write "Database updated successfully"
        End If
    Else
        Response.Write "No changes to update"
    End If
Else
    rs.Close
    Response.Write "Post not found"
End If

' Close the database connection
cn.Close
Set cn = Nothing

On Error GoTo 0
%>
