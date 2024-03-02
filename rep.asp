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

  <%
    dim uid
    uid = request.querystring("id")
  %>
  <div class="box">
    <div>
    <h1 style="margin-left: 30px; margin-top: -10px;">Select Violation</h1>
    <form id="reportForm" method="post" action="report.asp">
      <input type="hidden" name="postid" id="postid" value="<%= uid %>">
      <fieldset class="form-group" style="border: none;">
        <div class="form-check">
          <input class="form-check-input" type="checkbox" name="violation" value="Inappropriate or Abusive" id="abusive">
          <label class="form-check-label" for="abusive">
            Inappropriate/Abusive
          </label>
        </div>
        <div class="form-check">
          <input class="form-check-input" type="checkbox" name="violation" value="Offensive" id="offensive">
          <label class="form-check-label" for="offensive">
            Offensive
          </label>
        </div>
        <div class="form-check">
          <input class="form-check-input" type="checkbox" name="violation" value="False Information" id="false">
          <label class="form-check-label" for="false">
            False Information
          </label>
        </div>
      </fieldset>
      <label for="exampleTextarea" class="form-label mt-4">Others:</label>
      <div class="form-group">
        
        <textarea class="form-control" id="exampleTextarea" rows="3" name="others" spellcheck="false" style="width: 300px;"></textarea>
      </div>
      <div>
      <button class="button" type="submit" value="Login">Submit</button>
    </div>
    <div style="margin-top: 10px;">
      <a href="home.asp"><button class="button" type="button" value="Cancel">Cancel</button></a>
    </div>
    </form>


  </div>
  
    </div>
</body>
</html>
