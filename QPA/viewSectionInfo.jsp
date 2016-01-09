<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
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

<center><p><img border="0" src="images/ves.jpg" width="645" height="109"></p></center>
	<span id='supertitle'> .:: View Section Information ::. </span><br><br>
	<form action='viewSectionInfo.jsp' method='post'>
	<table>
		<tr><td id='tdtitle'>CourseID : </td> <td><input type='text' name='courseID' size="30" /></td>
		<tr><td id='td1'>Course Section :</td> <td><input type='text' name='courseSection' size="10" /> </td>
    </table><br />
	<input type='submit' value='.:: View ::.' /> &nbsp;&nbsp;&nbsp;&nbsp;
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
	boolean foundSection = false;
	
	
	course_section = courseID + "," + courseSection;
	System.out.println("Finding infos for " + course_section);
				
	query = "SELECT * FROM sectionInfo";
	result = select.executeQuery(query);
	String classTime="",day="",sectionLimit="",sectionTeacher="",regStudent="";

		while(!foundSection && result.next())
		{
			if(result.getString("courseIDsection").equals(course_section))
			{
				foundSection = true;
				classTime = result.getString("classTime");
				day = result.getString("day");
				sectionLimit=result.getString("sectionLimit");
				sectionTeacher = result.getString("sectionInstructor");
				regStudent = result.getString("studentsRegistered");
				System.out.println(course_section + " << found and saved data ");
				break;
			}
		}

	if(foundSection)
	{
		
		%>
		
		<html>
		<head>
		<link rel='stylesheet' type='text/css' href='css/style.css' />
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		</head>
		<body>
<center><p><img border="0" src="images/ves.jpg" width="645" height="109"></p></center>
		<br /><br />		
		<br /><span id='caption'>Section Information of <%=course_section%> </span>
		<table id='courseSection' width='50%'>
		  <tr>
			<td width='40%' height='19'><b>Time</b></td>
			<td width='60%' height='19'><%=classTime%></td></tr>
		  <tr>
			<td width='40%' height='19'><b>Day</b></td>
			<td width='60%' height='19'><%=day%></td>
		  </tr>
		  <tr>
			<td width='40%' height='19'><b>Section Limit</b></td>
			<td width='60%' height='19'><%=sectionLimit%></td>
		  </tr>
		  <tr>
			<td width='40%' height='19'><b>Course Instrutor</b></td>
			<td width='60%' height='19'><%=sectionTeacher%></td>
		  </tr>
		</table><br>
		
		<b> The list of registered Students is given beleow : </b><br />
		
<%

		StringTokenizer st = new StringTokenizer(regStudent, "," );
		int totalStudents = st.countTokens();
		
		String studentIDs[] = new String[totalStudents];
		int i=0;
		while(st.hasMoreTokens())
		{
			studentIDs[i]=st.nextToken();
%>



		<table id='subjects' width='20%'>
		  <tr>
		  <td width="15%"><%=(i+1)%></td><td width="85%"><%=studentIDs[i]%></td>
		  </tr>
		</table>

	  
<%	
			i++;
		} //end of while (printing the student IDs)

%>
<br /> <a href="javascript:history.back(1)">Click</a> Back and view another section information.<br/>

<%

		} //end of if !! (section found)
		
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