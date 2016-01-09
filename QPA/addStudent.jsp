<%@page import="java.sql.*" %>
<%@page import="java.sql.Statement" %>



<%

if(request.getParameter("ID")==null)
{	
%>

<html>
<head>
<link rel='stylesheet' type='text/css' href='css/style.css' />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>

<center><p><img border="0" src="images/ves.jpg" width="645" height="109"></p></center>
	<span id='supertitle'> .:: Student Add Form ::. </span><br><br>
	<form action='addStudent.jsp' method='post'>
	<table>
		<tr><td id='tdtitle'>Student ID : </td> <td><input type='text' name='ID' size="30" /></td><td id='tdguide'> Enter student's 9 digit ID.</td></tr>
		<tr><td id='tdtitle'>Password : </td> <td><input type='text' name='password' size="30" /></td><td id='tdguide'> Enter student's initial password.</td></tr>
		<tr><td id='tdtitle'>First Name : </td> <td><input type='text' name='firstName' size="30" /></td><td id='tdguide'> Enter student's first name.</td></tr>
		<tr><td id='tdtitle'>Last name : </td> <td><input type='text' name='lastName' size="30" /></td><td id='tdguide'> Enter student's last name.</td></tr>
		<tr><td id='tdtitle'>CGPA : </td> <td><input type='text' name='CGPA' size="30" /></td><td id='tdguide'> Enter student's current CGPA</td></tr>
		<tr><td id='tdtitle'>Core Course : </td> <td><input type='text' name='coreDone' size="30" /></td><td id='tdguide'> Enter core courses done by the student.</td></tr>
		<tr><td id='tdtitle'>Other Course : </td> <td><input type='text' name='othersDone' size="30" /></td><td id='tdguide'> Enter other courses done by the student.</td></tr>
		<tr><td id='tdtitle'>Address : </td> <td><input type='text' name='address' size="30" /></td><td id='tdguide'> Enter student's address. (Without any line break)</td></tr>
		<tr><td id='tdtitle'>Phone : </td> <td><input type='text' name='phone' size="30" /></td><td id='tdguide'> Enter student's primary phone number.</td></tr>
		<tr><td id='tdtitle'>e-mail : </td> <td><input type='text' name='email' size="30" /></td><td id='tdguide'> Enter student's e-mail address (if any)</td></tr>
    	</table>

    	<br />
	<input type='submit' value='.:: Add ::.' /> &nbsp;&nbsp;&nbsp;&nbsp;
    	<input type="reset" value=".:: Reset ::."></p>
	</form>
	
	<br /><b>Go back to <a href="adminControl.jsp">Control Panel.</a></b>
</html>
</head>

<% }

else
{
////////////////////////////////////////////////////////////////////////////

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

	String ID = request.getParameter("ID");
	String password = request.getParameter("password");
	String firstName = request.getParameter("firstName");
	String lastName = request.getParameter("lastName");
	String CGPA = request.getParameter("CGPA");
	String coreDone = request.getParameter("coreDone");
	String othersDone = request.getParameter("othersDone");
	String address = request.getParameter("address");
	String phone = request.getParameter("phone");
	String email = request.getParameter("email");
	String newSubjects ="";
	String alreadyAdvised = "False";

////////////////////////////////////////////////////////////////////////////

	query = "INSERT INTO studentInfo values('"+ID+"','"+password+"','"+firstName+"','"+lastName+"',"+CGPA+",'"+coreDone+"','"+othersDone+"','"+address+"','"+phone+"','"+email+"','"+newSubjects+"','"+alreadyAdvised+"')";

	try{
		select.executeUpdate(query);
	%>	
	
	
		<html>
		<head>
		<link rel='stylesheet' type='text/css' href='css/style.css' />
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		</head>
		<body>

<center><p><img border="0" src="images/ves.jpg" width="645" height="109"></p></center>
		<br>Infos are successfully added !!<br><a href = 'addStudent.jsp'> Insert another student's information </a>
		<br /><b>Go back to <a href="adminControl.jsp">Control Panel.</a></b>
	<%
		
	}catch (Exception e){
		System.out.println(e);
		out.println("Error inserting");
	}
}
%>