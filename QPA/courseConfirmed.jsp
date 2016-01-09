<%@page import="java.sql.*" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.util.*" %>

<%
	String selectedCourse = request.getParameter("selectedCourse");
	String selectedSection = request.getParameter("section");
	String ID = (String)session.getAttribute("ID");
	String registeredStudents = request.getParameter("regStudent");
	String newSubjects = request.getParameter("newSub");

if(request.getParameter("confirm").equals("null")) 
{
	
	String selectedCourseTime = request.getParameter("selectedCourseTime");
	String selectedCourseDay = request.getParameter("selectedCourseDay");
	String selectedCourseSecStu = request.getParameter("selectedCourseSecStu");
	String selectedCourseTeacher = request.getParameter("selectedCourseTeacher");
	int subjectsTaken = Integer.parseInt(request.getParameter("courseTaken"));
	
	
	
	// end of code scope	
	%>


		<html>
		
		<head>
		
		<title>Confirmation Page</title>
		<link rel='stylesheet' type='text/css' href='css/style.css' />
		</head>
		
		<body>
		
		<center><p><img border="0" src="images/ves.jpg" width="645" height="39"></p></center><p>&nbsp;</p>
			<span id='supertitle'> .:: Course Confirmation Page ::. </span><br><br>

		
		<span id='caption'>Selected Section Information of <%=selectedCourse%>, Section # <%=selectedSection%> </span>
		<table id='courseSection' width='50%'>
		  <tr>
			<td id='tdtitle' width='40%' height='19'><b>Time</b></td>
			<td width='60%' height='19'><%=selectedCourseTime%></td></tr>
		  <tr>
			<td id='tdtitle' width='40%' height='19'><b>Day</b></td>
			<td width='60%' height='19'><%=selectedCourseDay%></td>
		  </tr>
		  <tr>
			<td id='tdtitle' width='40%' height='19'><b>Registered Students</b></td>
			<td width='60%' height='19'><%=selectedCourseSecStu%></td>
		  </tr>
		  <tr>
			<td id='tdtitle' width='40%' height='19'><b>Course Instrutor</b></td>
			<td width='60%' height='19'><%=selectedCourseTeacher%></td>
		  </tr>
		</table><br /><br />
		
		<form method="POST" action="courseConfirmed.jsp">
		<input type='hidden' name='confirm' value='ok' />
		<input type='hidden' name='newSub' value='<%=newSubjects%>' />
		<input type='hidden' name='regStudent' value='<%=registeredStudents%>' />
		<input type='hidden' name='section' value='<%=selectedSection%>' />
		<input type='hidden' name='selectedCourse' value='<%=selectedCourse%>' />

		<input type="submit" value="Confirm" name="submit"><br>
		</form>
		
		
		<%
			String visibility ="";
			if((subjectsTaken >=1) && (subjectsTaken <4))
				visibility = "enabled";
			else visibility = "disabled";
		%>
		<form method="POST" action="finishedAdvising.jsp">
		<input type='hidden' name='field_1' value='done' />
		
		<input type='hidden' name='confirm' value='ok' />
		<input type='hidden' name='newSub' value='<%=newSubjects%>' />
		<input type='hidden' name='regStudent' value='<%=registeredStudents%>' />
		<input type='hidden' name='section' value='<%=selectedSection%>' />
		<input type='hidden' name='selectedCourse' value='<%=selectedCourse%>' />

  		<p><input type="submit" <%=visibility%> value="Confirm & Finish Advising" name="finishadvising"></p>
		</form>

		<p>&nbsp;</p>
		<%
		if(visibility.equals("enabled"))
		{
		%>
		<span id="error">Remember, if this is the last course you want to add,<br />
		then click "Confirm & Finish Advising" Now.</span><br />
		<%
		}
		%>
		
	</body>
	</html>


<%
} // end of if (confirm = null)

else
{
	System.out.println("In else part, update DB");

	///////////////////////////// Creating Connection with DB Server //////////////////////////

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

	ResultSet resultSec = null;
	ResultSet resultStu = null;
	Statement select = con.createStatement();
	String querySec = "";
	String queryStu = "";

	///////////////////////////////////////////////////////////////////////////////////////////////
	
	/* 
	1. update students database of "newSubject" catinated with old 1(if any)
	2. Update section database of "studentsRegistered" catinated with old students.
	*/
	/*
    queryStu = "SELECT * FROM studentInfo";
	resultStu = select.executeQuery(queryStu);
	
	boolean	match = false;

	while(!match && resultStu.next())
	{
		if(resultStu.getString("ID").equals(ID))
		{
			match = true;
			break;
		}
	}
	System.out.println(ID + " Found : " + match );
	
	String newSubjects = resultStu.getString("newSubjects");
	System.out.println("New Subjects : " + newSubjects );
	
	
	
	
	querySec = "SELECT * FROM sectionInfo";
	resultSec = select.executeQuery(queryStu);
	boolean foundSection = false;
	String registeredStudents = "";
		
	while(!foundSection && resultSec.next())
	{
		if(resultSec.getString("courseIDsection").equals(subject_section))
		{
			foundSection = true;
			registeredStudents = resultSec.getString("studentsRegistered");
			break;
		}
	}
	System.out.println(subject_section + " ID Found : " + foundSection );
	*/

	//out.println(registeredStudents+"<br>");
	//out.println(newSubjects+"<br>");

	System.out.println("Registered STUDENTS " + registeredStudents);
	System.out.println("NEW Subjects" + newSubjects );
	System.out.println("ID : " + ID );
	String subject_section = selectedCourse + "," + selectedSection;
	String newRegStu = registeredStudents + "," + ID;
	String newSubUpdate;
	if(newSubjects.equals(""))
		newSubUpdate = selectedCourse;
	else newSubUpdate = newSubjects + "," + selectedCourse;
	
	
	querySec = "UPDATE sectionInfo SET studentsRegistered = '"+newRegStu+"' WHERE courseIDsection = '"+subject_section+"'"; 
	queryStu = "UPDATE studentInfo SET newSubjects = '"+newSubUpdate+"' WHERE ID = '"+ID+"'" ;
	
	try
	{
		System.out.println(querySec);
		System.out.println(queryStu);
		select.executeUpdate(querySec);
		select.executeUpdate(queryStu);
		//out.println("New Course Updated");
	}
	catch (Exception e)
	{
		System.out.println(e);
		out.println("<B>Error updating user information</B>");
	}
	//*/
	
	if(con!=null)
	{
		con.close();
		select.close();
	}
	//request.sendRedirect("advise.jsp");

%>
	
	<jsp:forward page="advise.jsp" />
<%

} // end of else ( update DB)
%>