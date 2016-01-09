<%@page import="java.sql.*" %>
<%@page import="java.sql.Statement" %>

<%

if(request.getParameter("courseID")==null)
{	

%>

<html>
<head>
<link rel='stylesheet' type='text/css' href='css/style.css' />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>

	<center><p><img border="0" src="images/ves.jpg" width="645" height="39"></p></center><p>&nbsp;</p>
	<span id='supertitle'> .:: Change Section Limit Form ::. </span><br><br>
	<form action='changeSectionLimit.jsp' method='post'>
	<table>
		<tr><td id='tdtitle'>CourseID : </td> <td><input type='text' name='courseID' size="30" /></td>
		<tr><td id='td1'>Course Section :</td> <td><input type='text' name='courseSection' size="10" /> </td>
		<tr><td id='td1'>New Section Limit :</td><td><input type='text' name='newLimit' size="10" /> </td>
    </table><br />
	<input type='submit' value='.:: Change ::.' /> &nbsp;&nbsp;&nbsp;&nbsp;
    <input type="reset" value=".:: Reset ::."></p>
	</form>
</body>
</html>

<% 
} // end of IF (when page first time loaded)

else
{

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
	String course_section = "";

	String courseID = request.getParameter("courseID");
	String courseSection = request.getParameter("courseSection");
	String newLimit = request.getParameter("newLimit");
	boolean foundSection = false;
	
	
	course_section = courseID + "," + courseSection;
	System.out.println("Finding infos for " + course_section);
				
	query = "SELECT * FROM sectionInfo";
	result = select.executeQuery(query);
	String classTime="",day="",sectionLimit="",sectionTeacher="";	

		while(!foundSection && result.next())
		{
			if(result.getString("courseIDsection").equals(course_section))
			{
				foundSection = true;
				classTime = result.getString("classTime");
				day = result.getString("day");
				sectionLimit=result.getString("sectionLimit");
				sectionTeacher = result.getString("sectionInstructor");
				break;
			}
		}

	if(foundSection)
	{
		query = "UPDATE sectionInfo SET sectionLimit = '"+newLimit+"' WHERE courseIDsection = '"+course_section+"'";
		
		try
		{
			System.out.println(query);
			select.executeUpdate(query);
		}
		catch(Exception e)
		{
			System.out.println(e);
			out.println("Error updating");
		}
		
		%>

	
		
		<html>
		<head>
		<link rel='stylesheet' type='text/css' href='css/style.css' />
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		</head>
		<body>
		<br /><br />		
		<br /><span id='caption'>Updated Information of <%=course_section%> </span>
		<table id='courseSection' width='50%'>
		  <tr>
			<td width='40%' height='19'><b>Time</b></td>
			<td width='60%' height='19'><%=classTime%></td></tr>
		  <tr>
			<td width='40%' height='19'><b>Day</b></td>
			<td width='60%' height='19'><%=day%></td>
		  </tr>
		  <tr>
			<td width='40%' height='19'><b>Section Limit [old]</b></td>
			<td width='60%' height='19'><%=sectionLimit%></td>
		  </tr>
		  <tr>
			<td width='40%' height='19'><b>Section Limit [new]</b></td>
			<td width='60%' height='19'><%=newLimit%></td>
		  </tr>
		  <tr>
			<td width='40%' height='19'><b>Course Instrutor</b></td>
			<td width='60%' height='19'><%=sectionTeacher%></td>
		  </tr>

		  
		</table><br>
		
		<%
		} //end of if !!
		
		else 
		{
		%>
					
			<html>
			<head>
			<link rel='stylesheet' type='text/css' href='css/style.css' />
			<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
			</head>
			<body>
			<br /><br />
			<br / >
			<span id='error'>Sorry, you have provided wrong information.<br />
			<a href="javascript:history.back(1)">Click</a> Back and try with Valid Course ID and section</span>

		<%
		} // end of else
		
		%>
		
	<p>&nbsp;</p>
	<p>&nbsp;</p>
	<center><hr size="2" color="#FFCC00"><br><center>
	<font face="Times New Roman" size="2">Copyright © Hossain & Ifti. All Rights Reserved
	2004.</font></center>
	
	
	</body>
	</html>

<%
		// closing the connection
	if(con!=null)
	{
		con.close();
	}
} //end of else (not 1st time in this page)
%>