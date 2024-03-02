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
    margin-left: 50px;
    margin: auto;
    padding: 50pt;
    box-shadow: 0 0 40px rgba(23, 13, 2, 0.2);
    border-radius: var(--border-radius);
    background: #c1cb99;
    display: flex;
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
    width: 100%;
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
<body>

  <div class="box">
    <%
    ' Get user id from query string
        Dim pid
        pid = Request.QueryString("id")
    
    ' Check if form has been submitted
        If Request.Form("submit") <> "" Then
    
    ' Get form data
        dim description
        description = Request.Form("description")
    
    ' Open recordset for updating user information
        Set rs = Server.Createobject("ADODB.Recordset")
        rs.Open "SELECT * FROM post WHERE postid=" & pid, cn, 3, 3
    
    ' Update user information
        rs.Fields("post") = description
        rs.Update
    
    ' Close recordset
        rs.Close
    
    ' Redirect to view user page after editing
        Response.Redirect("profile.asp?uid=" & pid)
        Else
    ' Open recordset for displaying user information
        set rs = server.createobject("ADODB.Recordset")
        rs.open "SELECT * FROM post WHERE postid=" & pid, cn
    
    ' Display form for editing user information
        Response.Write "<div class='container'>"
        Response.Write "<div class='row justify-content-center'>"
        Response.Write "<div class='col-md-6'>"
        Response.Write "<h1 class='text-center' style='margin-top: 10px;'>Edit Post</h1>"
        Response.Write "<form method='post'>"
        Response.Write "<div>"
    
        Response.Write "<div style='margin-bottom: 10px;'>"
            Response.Write "<p>Description:</p>"
            Response.Write "<input type='text' name='description' value='asa' style='width: 300px; height: 50px;'></input>"
        Response.Write "</div>"
        Response.Write "</div>"
        %>
        <div>
            <button class="button" type="submit" name='submit' value="Save">Save</button>
          </div>
          <div style="margin-top: 10px;">
            <a href="profile.asp"><button class="button" type="button" value="Cancel">Cancel</button></a>
          </div>
          </form>

          <%
        Response.write "</div>"
        Response.write "</div>"
        Response.write "</div>"
    
        
    
    ' Close recordset
        rs.Close
        End If
    %>
  
    </div>
</body>
</html>
