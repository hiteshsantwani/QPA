<%@page import="java.sql.*" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.util.*" %>

<%
String ID = (String)session.getAttribute("ID");
if(ID==null || ID.length() ==0){ 
response.sendRedirect("login.html");

}

if(request.getParameter("course1")==null)
{
	%>


	<html>

<head>

<title>Enter Desired Course</title>
<link rel='stylesheet' type='text/css' href='css/style.css' />
</head>

<body>

<center><p><img border="0" src="images/ves.jpg" width="645" height="109"></p></center>
	<span id='supertitle'> .:: Editing Form ::. </span><br><br>
<form action='changedocs.jsp' method='post'>
<p>  Enter Course  : <input type="text" name="course1" size="20"></p><br>
<input type="submit" value="Submit" name="submit"><input type="reset" value="Reset" name="reset"><br>


</form>

</body>

</html>


<% }


else
{

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

int subjectsTaken = 0;

String course1 = request.getParameter("course1");
	System.out.println("Selected Course = " + course1);

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
    
    String subjects;

    System.out.println("ID found in DB : " + match);


    subjects = result.getString("coreDone");

    subjects=(""+subjects+","+result.getString("othersDone"));

    StringTokenizer stkn = new StringTokenizer(subjects, "," );

    int studentCourse = stkn.countTokens();

    subjectsTaken = stkn.countTokens();

    String subjectsNowTaken[] = new String[subjectsTaken];
		int temp_i=0,i;
		
		while(stkn.hasMoreTokens())
		{
			subjectsNowTaken[temp_i++] = stkn.nextToken();
		
		}


		    
		        System.out.println("All courses " + subjects);   

boolean courseAlreadyDone = false;

for(i=0;i<studentCourse; i++)
		{
			if( subjectsNowTaken[i].equals(course1) )
			{
				courseAlreadyDone = true;
				break;
			}
		}



		if(courseAlreadyDone){


String courseQuery = "";
courseQuery = "SELECT * FROM courseInfo";
		
			result = select.executeQuery(courseQuery);
			
			boolean	courseMatch = false;
			String courseName="", courseDes="", courseCredits="", courseFaculty="", courseSections="";

			while(result.next() && !courseMatch)
			{
				if(result.getString("courseID").equals(course1))
				{
					courseMatch = true;
					//coursePreReq=result.getString("coursePreReq");
					courseName=result.getString("courseName");
					courseDes=result.getString("courseDescription");
					courseCredits=result.getString("courseCredits");
					courseFaculty=result.getString("courseInstructor");
					courseSections=result.getString("numberofSection");
					//numberofSections = Integer.parseInt(courseSections);
					break;
				}		
			}
			


String courseQuery1 = "SELECT * FROM editors";

result = select.executeQuery(courseQuery1);
			
			boolean	courseMatch1 = false;
			String link="";

			while(result.next() && !courseMatch1)
			{
				if(result.getString("courseID").equals(course1))
				{
					courseMatch1 = true;
					//coursePreReq=result.getString("coursePreReq");
					link=result.getString("link");

					//numberofSections = Integer.parseInt(courseSections);
					break;
				}		
			}




			System.out.println("Course Found : "+courseMatch);


				%>

	<html>
		
		<head>
		
		<title>Enter Course</title>
		<link rel='stylesheet' type='text/css' href='css/style.css' />
		</head>
		
		<body>
		
<center><p><img border="0" src="images/ves.jpg" width="645" height="109"></p></center>
			<span id='supertitle'> .:: Course Add Form ::. </span><br><br>
		
		
		<form action='changedocs.jsp' method='post'>
			<p>  Enter Another Course ID : <input type="text" name="course1" size="20"></p><br>
			<input type="submit" value="Submit" name="submit"><input type="reset" value="Reset" name="reset"><br>
		</form>

		<p>&nbsp;</p>
		
		<span id='caption'>Course Information for <%=courseName%> </span>
		<table id='courseInfo' width='100%'>
		  <tr>
			<td id='tdtitle' width='20%' height='19'><b>Course ID</b></td>
			<td width='80%' height='19'><%=course1%></td></tr>
		  <tr>
			<td id='tdtitle' width='20%' height='19'><b>Course Name</b></td>
			<td width='80%' height='19'><%=courseName%></td>
		  </tr>
		  <tr>
			<td id='tdtitle' width='20%' height='91'><b>Course Description</b></td> 
			<td width='80%' height='91'><%=courseDes%></td> 
		  </tr> 
		  <tr> 
			<td id='tdtitle' width='20%' height='19'><b>Credits</b></td> 
			<td width='80%' height='19'><%=courseCredits%></td> 
		  </tr> 
		  <tr> 
			<td id='tdtitle' width='20%' height='19'><b>Sections Available</b></td> 
			<td width='80%' height='19'><%=courseSections%></td> 
		  </tr> 
		  <tr> 
			<td id='tdtitle' width='20%' height='19'><b>Course Instructor</b></td> 
			<td width='80%' height='19'><%=courseFaculty%></td> 
		  </tr> 

		  <tr> 
			<td id='tdtitle' width='20%' height='19'><b>Editor Link</b></td> 
			<td width='80%' height='19'><a href="<%=link%>">Link</a></td> 
		  </tr>
		</table>
		<p>&nbsp;</p>
		

	<%		
	}
	
	

	else { %>

				<html>
                <p>YOU R NOT ELIGIBLE TO EDIT GOOGLE DOC </p>
                </html>






<% }


}%>






	