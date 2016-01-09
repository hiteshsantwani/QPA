<%@page import="java.sql.*" %>
<%@page import="java.sql.Statement" %>



<%

if(request.getParameter("courseID")==null)
{	%>

<html>
<title>Change course contents.</title>
<head>
<link rel='stylesheet' type='text/css' href='css/style.css' />
</head>
<body>
<center><p><img border="0" src="images/ves.jpg" width="645" height="109"></p></center>
	<span id='supertitle'> .:: Course Description Change Form ::. </span><br><br>
<form action='changeCourseDescription.jsp' method='post'>
    <p>
	<table border='0'>
		<tr><td id='tdtitle'>Course ID : </td><td><input type='text' name='courseID' size="20" /> </td><td id='tdguide'>Enter Course ID in CAPITAL LETTERS</td></tr>
		<tr><td id='tdtitle'>New Description : </td><td><textarea name="courseDescription" cols="40" rows="6" ></textarea> </td><td id='tdguide'>Enter new Course Description. [MAX - 255 Characters] </td></tr>		
		
		<tr><td bordercolor="#FFFFFF"><input type='submit' value='.:: Submit ::.' /></td><td bordercolor="#FFFFFF"><input type='submit' value='.:: Reset ::.' /></td></tr>
	</table>
    </p>
</form>
<br /><b>Go back to <a href="adminControl.jsp">Control Panel.</a></b>
</body>
</html> 

<% }



else
{

////////////////////////////////////////////////////////////////////////////

	Connection con = null;
	try
	{
		//Class.forName("org.gjt.mm.mysql.Driver").newInstance();
		Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
		//String protocol = "jdbc:mysql://localhost:3306/NSURS?user=reza&password=reza";
		//con = DriverManager.getConnection(protocol);
		con = DriverManager.getConnection("jdbc:odbc:" + "nsursDatabase", "","");
	} 
	catch (Exception e)
	{
		System.out.println(e);
		out.println("error getting connection");
	}				

	ResultSet result = null;
	Statement select = con.createStatement();
	String query ="";

	String courseID = request.getParameter("courseID");
	String courseDescription = request.getParameter("courseDescription");
	

///////////////////////////////////////////////////////////////////////////////
	query = "SELECT * FROM courseInfo";

	result = select.executeQuery(query);
	String courseName="", courseDes="", courseCredits="", courseFaculty="", coursePreReq="";	
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
			coursePreReq = result.getString("coursePreReq");
			
			break;
		}		
	}


	// Tracing in console
	System.out.println("Course Description : " + courseDes);

	if(match)
	{
		query = "UPDATE courseInfo SET courseDescription = '"+courseDescription+"' WHERE courseID = '"+courseID+"'";

		try{
			select.executeUpdate(query);
			//coursePreReq=result.getString("newCoursePreReq");
%>

<html>
<title>Change Description.</title>
<head>
<link rel='stylesheet' type='text/css' href='css/style.css' />
</head>
<body>
<center><p><img border="0" src="images/ves.jpg" width="645" height="109"></p></center>

<br><span id='supertitle'> .:: Confirmation ::. </span><br><br>
<br><span id='title'> New course description has been changed successfully.<br></span>
<B>Old Course Description : <%=courseDes%></B>
<br>
Updated Course Info :</span><br>

<table id='courseInfo' width='100%'>
  <tr>
    <td id='td1' width='20%' height='19'><b>Course ID</b></td>
    <td width='80%' height='19'><%=courseID%></td></tr>
  <tr>
    <td id='td1' width='20%' height='19'><b>Course Name</b></td>
    <td width='80%' height='19'><%=courseName%></td>
  </tr>
  <tr>
    <td id='td1' width='20%' height='91'><b>Course Description</b></td> 
    <td width='80%' height='91'><%=courseDescription%></td> 
  </tr> 
  <tr> 
    <td id='td1' width='20%' height='19'><b>Credits</b></td> 
    <td width='80%' height='19'><%=courseCredits%></td> 
  </tr> 
  <tr> 
    <td id='td1' width='20%' height='19'><b>Prerequisites</b></td> 
    <td width='80%' height='19'><%=coursePreReq%></td> 
  </tr> 
  <tr> 
    <td id='td1' width='20%' height='19'><b>Course Instructor</b></td> 
    <td width='80%' height='19'><%=courseFaculty%></td> 
  </tr> 
</table><br>

<br /><b>Go back to <a href="adminControl.jsp">Control Panel.</a></b>

</body>
</html>


<%
			}
			catch (Exception e)
			{
				System.out.println(e);
				out.println("Error updating");
			}
		} // End of if (match)
		
		else
		{ // if the entered course ID is not found in data base
%>
<html>
<title>Change course Description.</title>
<head>
<link rel='stylesheet' type='text/css' href='css/style.css' />
</head>
<body>
<center><p><img border="0" src="images/ves.jpg" width="645" height="109"></p></center>
<span id='error'>Sorry ! Your Given Course ID was not found in our database.<br>
Please re-check the course ID.<br>
Note : Course ID is always in CAPITAL letters. eg. CSE115<br></span>
<br><a href="changeCourseDescription.jsp">Go Back</a> to change the course description.<br />
or, <b>Go back to <a href="adminControl.jsp">Control Panel.</a></b>
		
<%
		} // end of else of if(match)
} // End of else
%>