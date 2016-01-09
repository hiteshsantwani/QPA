<%@page import="java.sql.*" %>
<%@page import="java.sql.Statement" %>



<%

if(request.getParameter("studentID")==null)
{	%>

<html>
<title>..... Student Information .....</title>
<head>
<link rel='stylesheet' type='text/css' href='css/style.css' />
</head>
<body>
<center><p><img border="0" src="images/ves.jpg" width="645" height="109"></p></center>
	<span id='supertitle'> .:: Stuent Information Request Form ::. </span><br><br>
<form action='viewStudentInfo.jsp' method='post'>
    <p>
	<table border='0'>
		<tr><td id='tdtitle'>Student ID : </td><td><input type='text' name='studentID' size="20" /> </td><td id='tdguide'>Enter 9 digit Student ID</td></tr>
		<tr><td><input type='submit' value='.:: Submit ::.' /></td><td><input type='submit' value='.:: Reset ::.' /></td></tr>
	</table>
    </p>
</form>
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

	String studentID = request.getParameter("studentID");

///////////////////////////////////////////////////////////////////////////////
	query = "SELECT * FROM studentInfo";

	result = select.executeQuery(query);

	boolean	match = false;


	while(!match && result.next())
	{
		if(result.getString("ID").equals(studentID))
		{
			match = true;
			break;
		}
	}

	System.out.println("ID was found in database : " + match);
	if(match)
	{
%>

<html>
<head>
<title>... Student Information ...</title>
<link rel='stylesheet' type='text/css' href='css/style.css' />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
<center><p><img border="0" src="images/ves.jpg" width="645" height="109"></p></center>
	<span id='title'> Welcome!! </span> <br /> <br />
	<span id='caption'>User Information for #<%=studentID%>
		<table id='studentInfoTable'>
		    <tr><td id='td1' colspan='2'> Basic Information </td></tr>
		    <tr><td> Name </td> <td> 	<%=result.getString("firstName")%>
						<%=result.getString("lastName")%> </td></tr>
		    <tr><td> Address </td><td> <%=result.getString("address")%></td></tr>  	
		    <tr><td> Phone </td><td> <%=result.getString("phone")%> </td></tr>  
		    <tr><td> e-mail </td><td> <%=result.getString("email")%> </td></tr>  

		    <tr><td id='td1' colspan='2'> Academic Information </td></tr> 
		    <tr><td> Core Course Done </td><td> <%=result.getString("coreDone")%> </td> </tr>
		    <tr><td> Additional Course Done </td><td> <%=result.getString("othersDone")%> </td></tr>
		    <tr><td> CGPA  </td><td> <%=result.getString("CGPA")%> </td></tr> 
		</table><br>
	<br><a href='adminControl.jsp'>Go Back</a><b> to Control Pannel.</b><br>
<%
		} // End of if (match)
		
		else
		{ // if the entered student ID is not found in data base
%>
<html>
<title>Student Information - <Error !></title>
<head>
<link rel='stylesheet' type='text/css' href='css/style.css' />
</head>
<body>
<center><p><img border="0" src="images/ves.jpg" width="645" height="109"></p></center>
<span id='error'>Sorry ! Your Given student ID was not found in our database.<br>
Please re-check the student ID.<br>
Note : Student ID is always a 9 digit number. eg. 021007040<br></span>
<br><a href="viewStudentInfo.jsp">Go Back</a> to re-Enter correct ID.		
		
<%
		} // end of else of if(match)

	// Closing the created connection
	if(con!=null)
	{
		con.close();
	}

} // End of else


%>