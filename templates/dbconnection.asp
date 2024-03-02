<%
  set cn= server.createobject("adodb.connection")
  cn.connectionstring="Driver={MySQL ODBC 8.0 UNICODE Driver}; Server=localhost; Database=lf; User=root; Password=root; Port=3306;"
  cn.open
%>
