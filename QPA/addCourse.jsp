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

<center><p><img border="0" src="images/ves.jpg" width="645" height="109"></p></center>
	<span id='supertitle'> .:: Course Information Add Form ::. </span><br><br>
	<form action='addCourse.jsp' method='post'>
	<table>
		<tr><td id='tdtitle'>courseID : </td> <td><input type='text' name='courseID' size="30" /></td>
		<tr><td id='td1'>courseName :</td> <td><input type='text' name='courseName' size="30" /> </td>
		<tr><td id='td1'>courseDescription :</td><td><textarea rows="5" name="courseDescription" cols="30"></textarea></td>
		<tr><td id='td1'>courseCredits :</td><td><input type='text' name='courseCredits' size="30" /></td>
		<tr><td id='td1'>coursePreReq :</td><td><input type='text' name='coursePreReq' size="30" /> </td>
		<tr><td id='td1'>courseInstructor :</td><td><input type='text' name='courseInstructor' size="30" /></td>
		<tr><td id='td1'>Total Sections :</td><td><input type='text' name='totalSections' size="10" /></td>
		<tr><td id='td1'>visitor link :</td><td><input type='text' name='visitorlink' size="1000" /></td>
		<tr><td id='td1'>editor link :</td><td><input type='text' name='editorlink' size="1000" /></td>
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
	String query ="",query1="";

	String courseID = request.getParameter("courseID");
	String courseName = request.getParameter("courseName");
	String courseDescription = request.getParameter("courseDescription");
	String courseCredits = request.getParameter("courseCredits");
	String coursePreReq = request.getParameter("coursePreReq");
	String courseInstructor = request.getParameter("courseInstructor");
	String sections = request.getParameter("totalSections");
	String visitorlink = request.getParameter("visitorlink");
	String editorlink = request.getParameter("editorlink");
	//int totalSections=Integer.parseInt(sections);


	query = "INSERT INTO courseInfo values('"+courseID+"','"+courseName+"','"+courseDescription+"',"+courseCredits+",'"+coursePreReq+"','"+courseInstructor+"','"+sections+"','"+visitorlink+"')";
    
    query1 = "INSERT INTO editors values('"+courseID+"','"+editorlink+"')";


	try{
		select.executeUpdate(query);
		select.executeUpdate(query1);
		%>
		
		<html>
		<head>
		<link rel='stylesheet' type='text/css' href='css/style.css' />
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		</head>
		<body>

<center><p><img border="0" src="images/ves.jpg" width="645" height="109"></p></center>
		<br>Infos are successfully added !!<br><a href = 'addCourse.jsp'> Insert another course </a>
		<br /><b>Go back to <a href="adminControl.jsp">Control Panel.</a></b>
	<%
	
	}catch (Exception e){
		System.out.println(e);
		out.println("Error inserting");
	}
}
%>