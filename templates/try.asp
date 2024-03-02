<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="https://bootswatch.com/4/sandstone/bootstrap.min.css">
	<link rel='stylesheet' type='text/css' media='screen' href='./assets/css/style.css'>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>LF</title>
  <style type="text/css">
    .navbar{
      position: sticky;
      top: 0;
      z-index: 1;
    }


  </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark" style="position: sticky; top: 0; z-index: 100;">
  <div class="container-fluid" >
   
    <div class="nav-item" >
          <img src="assets/images/logo.png" style="width: 75px; height: 75px; border-radius: 1%;"> </a>
          <span class="visually-hidden"></a>
        </div>

  		<div class="nav-item" >
          <a class="nav-link" href="trialprof.asp"><img src="assets/images/wprofile30.png"> </a>
            <span class="visually-hidden"></a>
        </div>
        <div class="nav-item" >
          <a class="nav-link" href="trialhome.asp"><img src="assets/images/whome30.png"> </a>
            <span class="visually-hidden"></a>
        </div>
        <div class="nav-item" >
          <a class="nav-link" href="trialnotif.asp"><img src="assets/images/wnotification30.png"></a>
        </div>
        <!-- <div class="nav-item" >
          <a class="nav-link" href="trialmessage.asp"><img src="assets/images/wmessage30.png"> </a>
            <span class="visually-hidden"></a>
        </div> -->
      <form class="d-flex" >
        <a href="logout.asp"><button type="button" class="logout">Logout</button></a>
      </form>
    </div>
  </div>
</nav>
  
  

</body>
</html>
<%
  set cn= server.createobject("adodb.connection")
  cn.connectionstring="Driver={MySQL ODBC 5.3 UNICODE Driver}; Server=malachedaugan.cmu-online.tech; Database=cmuonine_dauganmdb; User=cmuon_dauganm; Password=d1?cw71V; Port=3306;"
  cn.open
%>