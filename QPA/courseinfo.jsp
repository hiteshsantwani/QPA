
<%@page import="java.io.*" %>
<%@page import="java.sql.*" %>
<%@page import="java.sql.Statement" %>





<%


	Connection con = null;
	try{
		//Class.forName("org.gjt.mm.mysql.Driver").newInstance();
		Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
		//String protocol = "jdbc:mysql://localhost:3306/NSURS?user=reza&password=reza";
		//con = DriverManager.getConnection(protocol);
		con = DriverManager.getConnection("jdbc:odbc:" + "nsursDatabase", "","");
	} catch (Exception e){
		System.out.println(e);
		out.println("error getting connection");
	}		

	ResultSet result = null;
	Statement select = con.createStatement();
	String query ="";




	String courseID = request.getParameter("courseID");
	String courseName="", courseDes="", courseCredits="", courseFaculty="", coursePreReq="", courselink="";

	query = "SELECT * FROM courseInfo";

	// out.println(query);
	result = select.executeQuery(query);
	
	boolean	match = false;

	while(result.next() && !match)
	{
		if(result.getString("courseID").equals(courseID))
		{
			match = true;
			
			courseName=result.getString("courseName");
			courseDes=result.getString("courseDescription");
			courseCredits=result.getString("courseCredits");
			courseFaculty=result.getString("courseInstructor");
			coursePreReq=result.getString("coursePreReq");
			courselink=result.getString("link");
			break;
		}		
	}

	System.out.println(match);
	if(match)
	{
%>


<html>
<head>
<title>Login</title>
<link rel='stylesheet' type='text/css' href='css/style.css' />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>

<center><p><img border="0" src="images/ves.jpg" width="645" height="109"></p></center>

<p><b><i><font size="4">&quot;List of all the courses.&quot;</font></i></b></p>


<table border="1" cellpadding="0" cellspacing="0" bordercolor="#444444" width="58%" id="courseList">
  <tr>
    <td width="33%" align="center"><a href="CSC.html" target="_blank">CSC/CEG</a></td>
    <td width="33%" align="center"><a href="bba.html" target="_blank">BBA</a></td>
    <td width="34%" align="center"><a href="economics.html" target="_blank">ECO</a></td>
  </tr>
</table>


<br>

<b>Enter any course number and view its details. <BR></b>

<form action='courseinfo.jsp' method='post'>
	<b>Course ID</b> <input type='text' name='courseID' size="20" /> <br />
	<br>
	<input type='submit' value='Submit' />
</form>

	<span id='title'>Requested Course details !!</span> <br />
	<span id='caption'>Course Information for <%=courseName%> </span>


<table id='courseInfo' width='100%'>
  <tr>
    <td width='20%' height='19'><b>Course ID</b></td>
    <td width='80%' height='19'><%=courseID%></td></tr>
  <tr>
    <td width='20%' height='19'><b>Course Name</b></td>
    <td width='80%' height='19'><%=courseName%></td>
  </tr>
  <tr>
    <td width='20%' height='91'><b>Course Description</b></td> 
    <td width='80%' height='91'><%=courseDes%></td> 
  </tr> 
  <tr> 
    <td width='20%' height='19'><b>Credits</b></td> 
    <td width='80%' height='19'><%=courseCredits%></td> 
  </tr> 
  <tr> 
    <td width='20%' height='19'><b>Prerequisites</b></td> 
    <td width='80%' height='19'><%=coursePreReq%></td> 
  </tr> 
  <tr> 
    <td width='20%' height='19'><b>Course Instructor</b></td> 
    <td width='80%' height='19'><%=courseFaculty%></td> 
  </tr> 
  <tr> 
    <td width='20%' height='19'><b>Course Link</b></td> 
    <td width='80%' height='19'><a href="<%=courselink%>">Link</a></td> 
  </tr> 
</table>

</body>
</html>
	
<%
	}
	else
	{
	%>

	<html>
	<head>
		<link rel='stylesheet' type='text/css' href='css/style.css' />
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	</head>
	
	<body>
<center><p><img border="0" src="images/ves.jpg" width="645" height="109"></p></center>
		<h2> ErRor !!! </h2>
		<span id='title'>Course is not listed in the database / Course doesn't exist.<br>
		Check the course list in the <a href='viewCourseInfo.html'>Course Information</a> page.<br>
		Note : Course names are case sensetive and all are in UPPER CASE.</span>
	</body>
	</html>

	
<% }

	if(con!=null){
		con.close();
	}

%>
