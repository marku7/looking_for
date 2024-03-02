<!--#include file="./templates/dbconnection.asp"-->

<%
    Dim username
	dim password

    username = Request.Form("username")
    password = Request.Form("pword")
    
    If username = "admin" And password = "root" Then
        Response.Redirect("admin.asp")
    Else
        Set rs = Server.CreateObject("adodb.recordset")
        rs.Open "SELECT * FROM profile WHERE username='" & username & "' AND pword='" & password & "'", cn

        If rs.EOF Then
            Response.Write "Login failed"
            Response.Write Err.Description
        Else
            i = i + 1
            Session("uid") = rs.Fields("uid")
            rs.MoveNext
        End If

        rs.Close
        cn.Close

        If i <> 0 Then
            Response.Redirect("home.asp")
        End If
    End If
%>
