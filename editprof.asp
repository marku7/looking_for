<!--#include file="./templates/dbconnection.asp"-->
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Login Form</title>
    <link rel="stylesheet" href="assets/css/login.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<style>
 
.texts{
    text-align: center;
    margin-left: 280px;
    color: black;
}
.textss{
    text-align: center;
    margin-left: 280px;
    color: black;
    margin-top: 20px;
}

.titles {
    margin-bottom: 50px;
    margin-left: 280px;
    text-align: center;
    color: #02523a;
    height: 30px;
    margin-top: 150px;
}
body {
    --color-primary-dark: #007f3d;
    --color-primary: #3b871a;
    --color-secondary: #6a3925;
    --color-error: #cc3333;
    --color-success: #083411;
    --border-radius: 4px;

  /*  align-items: center;
    justify-content: center;*/
    font-size: 20px;
    margin: 0;
    height: 600px;
    background-size: auto;
    background-image: url('images/samplebackground.png');
    background-repeat: no-repeat;
    background-attachment: fixed;
  background-size: cover;
    border-color: white;
/*    background-color: #6eb07a;*/
    display: flex;
}




.box {
    width: 300px;
    height: 300px;
    max-width: 450px;
    margin-left: 10px;
    margin: auto;
    padding: 50pt;
    box-shadow: 0 0 40px rgba(23, 13, 2, 0.2);
    border-radius: var(--border-radius);
    background: #c1cb99;
    display: flex;
    flex-direction: column; /* Added: To arrange items vertically */
        justify-content: center; /* Added: To center items vertically */
        align-items: center;
}


.title {
    margin-bottom: 2rem;
    text-align: center;
    color: #02523a;
}

.message {
    text-align: center;
    margin-bottom: 1rem;
}


.error {
    color: var(--color-error);
}


.input-group {
    margin-bottom: 1rem;
}

.input {
    display: block;
    width: 400px;
    padding: 13pt;
    box-sizing: border-box;
    border-radius: var(--border-radius);
    border: 1px solid #b8acac;
    outline: none;
    background: #eeebe7;
}
.input:focus {
    border-color: var(--color-primary);
    background: #ffffff;
}


.error_message {
    margin-top: 0.5rem;
    font-size: 0.85rem;
    color: var(--color-error);
}


.button {
    width: 100%;
    padding: 1rem 2rem;
    font-weight: bold;
    font-size: 16px;
    color: #d9d8b7;
    border: none;
    border-radius: var(--border-radius);
    outline: none;
    background: rgb(1, 82, 40);
}
.button:hover {
    background: var(--color-primary);
}
.button:active {
    transform: scale(0.98);
}



.text {
    text-align: center;
    color: #007f3d;
}

.box,
.input,
.button {
    font: 500 1rem 'Quicksand', sans-serif;
}


.link {
    color: rgb(5, 71, 31);
    cursor: pointer;
    text-decoration: underline;
}

.logo{
    height: 70px;
    margin-bottom: 20px;
}
</style>
<%


' Get user id from query string
    Dim pid
    pid = Session("uid")

' Check if form has been submitted
    If Request.Form("submit") <> "" Then

    ' Get form data

    dim username,messenger, pword
    username= request.form("username")
    messenger= request.form("messenger")
    pword= request.form("pword")
   

    ' Open recordset for updating user information
    Set rs = Server.Createobject("ADODB.Recordset")
    rs.Open "SELECT * FROM profile WHERE uid=" & pid, cn, 3, 3

    ' Update user information
    rs.Fields("username") = username
    rs.Fields("messenger") = messenger
    rs.Fields("pword") = pword
    

    rs.Update

    ' Close recordset
    rs.Close

    ' Redirect to view user page after editing
    Response.Redirect("profile.asp?uid=" & id)
Else
    ' Open recordset for displaying user information
    set rs = server.createobject("ADODB.Recordset")
    rs.open "SELECT * FROM profile WHERE uid=" & pid, cn

    ' Display form for editing user information

   Response.write "<body>"
    Response.write "<div class='box' style='height: 500px; margin-top: 70px;'>"
        Response.write "<form class='form hidden' id='createAccount' method='post'>"
            Response.write "<h1 class='title' style='margin-top: -10px;'>Edit Account</h1>"
            Response.write "<div class='message error'></div>"
            
            
            Response.write "<div class='input-group'>"
                Response.write"<p>Username:</p>"
                Response.write "<input type='text' class='input' name='username' value='" & rs.fields("username") &"'/>"
                Response.write "<div class='error_message'></div>"
            Response.write "</div>"

            Response.write "<div class='input-group'>"
                Response.write"<p>Messenger:</p>"
                Response.write "<input type='text' class='input' name='messenger' value='" & rs.fields("messenger") &"' />"
                Response.write "<div class='error_message'></div>"
            Response.write "</div>"

            Response.write "<div class='input-group'>"
                Response.write"<p>Password:</p>"
                Response.write "<input type='password' class='input' name='pword' value='" & rs.fields("pword") &"'/>"
                Response.write "<div class='error_message'></div>"
            Response.write "</div>"


            Response.write"<div>"
   
            
           Response.write "<input type='submit' class='button' name='submit' value='Save'>"
           Response.write "<br>"
    Response.Write "<a href='profile.asp'> <br><input type='button' class='button' value='Cancel' ></a>"
    Response.write "</form>"
    Response.write "</div>"
    Response.write "</div>" 
        
    
                
        Response.write "</form>"       
   Response.write "</div>"

   end if

   %>
</body>
</html>
