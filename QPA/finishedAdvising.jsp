<%@page import="java.sql.*" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.util.*" %>





<%

String ID = (String)session.getAttribute("ID");
if(ID==null || ID.length() ==0){ 
response.sendRedirect("login.html");
}

if(request.getParameter("field_1").equals("done"))
{

	String selectedCourse = request.getParameter("selectedCourse");
	String selectedSection = request.getParameter("section");
	String registeredStudents = request.getParameter("regStudent");
	String newSubjects = request.getParameter("newSub");

	Connection con = null;
	try{
		//Class.forName("org.gjt.mm.mysql.Driver").newInstance();
		Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
		//String protocol = "jdbc:mysql://localhost:3306/NSURS?user=reza&password=reza";
		//con = DriverManager.getConnection(protocol);
		con = DriverManager.getConnection("jdbc:odbc:" + "nsursDatabase", "","");
	} 
	catch (Exception e)
	{
		System.out.println(e);
		out.println("<b>Error getting connection. please reconfigure your DB srver</b>");
	}				


	ResultSet result = null;
	Statement select = con.createStatement();
	String query ="";
	String querySec ="";
	String queryStu ="";
	
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

	
     query = "SELECT * FROM studentInfo";

	// out.println(query);
	result = select.executeQuery(query);
	boolean	match = false;

	while(!match && result.next())
	{
		if(result.getString("ID").equals(ID))
		{
			match = true;
			break;
		}
	}
		
	System.out.println(ID + " # ID found in DB : " + match);
	
	// getting the new advised subjects done by the Student
	newSubjects = result.getString("newSubjects");
	//String subjects = result.getString("coreDone");
%>


<html>

<head>

<title>Enter Course 1</title>
<link rel='stylesheet' type='text/css' href='css/style.css' />
</head>

<body>

<center><p><img border="0" src="images/ves.jpg" width="645" height="39"></p></center><p>&nbsp;</p>
	<span id='supertitle'> .:: Advising Done ::. </span><br /><br />
	<span id='caption'>You have selected the following course.</span>
<%

	StringTokenizer st = new StringTokenizer(newSubjects, "," );
	int subjectsTaken = st.countTokens();
		
	String subjects[] = new String[subjectsTaken];
	int i=0;
	while(st.hasMoreTokens())
	{
		subjects[i]=st.nextToken();
%>



		<table id='subjects' width='50%'>
		  <tr>
		  <td width="10%"><%=(i+1)%></td><td width="90%"><%=subjects[i]%></td>
		  </tr>
		</table>

	  
<%	
		i++;
	}
	
	String True = "True";
	query = "UPDATE studentInfo SET alreadyAdvised = '"+True+"' WHERE ID = '"+ID+"'";	

	try
	{
		System.out.println(query);
		select.executeUpdate(query);
		//out.println("New Course Updated");
	}
	catch (Exception e)
	{
		System.out.println(e);
		out.println("<B>Error updating user information</B>");
	}



%>

	<br /><br />
	Thank you ! <ID> , you are successfully advised for this Semester.<br />
	Here is your information regarding the advising.<br />
	Please print this page for further use.<br />
	Thank you ! <br />

	<p>&nbsp;</p>
	<center><b> Please <a href="logout.html">LOG OUT</a> and Close this window before leaving.</b></center>


</body>

</html>

<%
	if(con!=null)
	{
		con.close();
		select.close();
	}
} // end of if -> request.getParameter("field_1").equals("done")

%>