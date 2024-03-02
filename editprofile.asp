<link rel="stylesheet" href="./assets/css/signup.css"> 

<style>
    .form-wrapper {
      display: flex;
      justify-content: center;
      height: 100vh;
    }
  
    .signup-box {
      text-align: center;
    }
  
    .image-container {
      margin-bottom: 20px;
    }
  
    .avatar-circle {
      border-radius: 50%;
    }
  </style>
  

<%


  set cn= server.createobject("adodb.connection")
  cn.connectionstring="Driver={MySQL ODBC 5.3 UNICODE Driver}; Server=malachedaugan.cmu-online.tech; Database=cmuonine_dauganmdb; User=cmuon_dauganm; Password=d1?cw71V; Port=3306;"
  cn.open

' Get user id from query string
    Dim pid
    pid = Request.QueryString("id")

' Check if form has been submitted
    If Request.Form("submit") <> "" Then

    ' Get form data

    dim username,messenger, pword, base64
    username= request.form("username")
    messenger= request.form("messenger")
    pword= request.form("pword")
    base64 = Request.form("base64")

    ' Open recordset for updating user information
    Set rs = Server.Createobject("ADODB.Recordset")
    rs.Open "SELECT * FROM profile WHERE uid=" & pid, cn, 3, 3

    ' Update user information
    rs.Fields("username") = username
    rs.Fields("messenger") = messenger
    rs.Fields("pword") = pword
    rs.Fields("profilepic") = base64

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
    
    Response.write "<div class='form-wrapper'>"
    Response.write "<div class='signup-box'>"
    Response.write "<h1>Edit Account</h1>"
    Response.write "<form method='post'>"
    Response.write "<label>Full Name</label>"
    Response.write "<input type='text' name='username' value='" & rs.fields("username") &"'/>"
    Response.write "<label>Messenger</label>"
    Response.write "<input type='email' name='messenger' value='" & rs.fields("messenger") &"' />"
    Response.write "<label>Password</label>"
    Response.write "<input type='password' name='pword' value='" & rs.fields("pword") &"'/>"
   
    Response.write "<div class='image-container'>"
    Response.write "<label>Photo</label>"
    Response.write "<img id='preview' src='#' alt='Image Preview' class='avatar-circle'  style='width: 100px; height: 100px; border-radius: 50%; display: none;'>"
    Response.write "&nbsp;&nbsp;"
    Response.write "<input type='file' name='photo' id='photo' onchange='uploadAndProcessImage(event)'/>"
    Response.write "<input type='hidden' name='base64' value='" & rs.fields("profilepic") &"' style='width: 100px; height: 100px; border-radius: 50%; display: none;'/>"
    


    Response.write "<input type='submit' name='submit' value='Save'>"
    Response.Write "<a href='profile.asp'><input type='button' value='Cancel' ></a>"
    Response.write "</form>"
    response.write "<P></p>"
    Response.write "</div>"
    Response.write "</div>"

    ' Close recordset
    rs.Close
End If
%>
<script>
       const uploadAndProcessImage = async (event) => {
    const file = event.target.files[0];
    const img = new Image();
    img.src = URL.createObjectURL(file);
    img.onload = function() {
      cropAndCompressImage(this);
      document.querySelector("#preview").style.display = "block";
      document.querySelector("#preview").src = URL.createObjectURL(file);
    }
    console.log(file);
  }
  
    
      function cropAndCompressImage(img) {
        const aspectRatio = img.width / img.height;
        let cropWidth, cropHeight, cropX, cropY;
    
        if (aspectRatio > 1) {
          cropWidth = img.height;
          cropHeight = img.height;
          cropX = (img.width - cropWidth) / 2;
          cropY = 0;
        } else {
          cropWidth = img.width;
          cropHeight = img.width;
          cropX = 0;
          cropY = (img.height - cropHeight) / 2;
        }
        
    const canvas = document.createElement('canvas');
          canvas.width = 800;
          canvas.height = 800;
    
          const ctx = canvas.getContext('2d');
          ctx.drawImage(img, cropX, cropY, cropWidth, cropHeight, 0, 0, canvas.width, canvas.height);
    
          const jpegURL = canvas.toDataURL('image/jpeg', 0.8);
          document.querySelector("#base64").value = jpegURL;
      console.log(jpegURL); // Added console log to see the base64 string
    }
    </script>