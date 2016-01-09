<%@page import="java.sql.*" %>
<%@page import="java.sql.Statement" %>



<%

if(request.getParameter("courseID")==null)
{	%>


<form action='course.jsp' method='post'>
	<b>courseID :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    </b>&nbsp;<input type='text' name='courseID' size="20" /> <br />
	<b>courseName :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
    <input type='text' name='courseName' size="20" /> <br />
	<b>courseDescription :&nbsp; </b>&nbsp;<input type='text' name='courseDescription' size="20" /> <br />
	<b>courseCredits :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </b>&nbsp;<input type='text' name='courseCredits' size="20" /> <br />
	<b>coursePreReq :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </b>&nbsp;<input type='text' name='coursePreReq' size="20" /> <br />
	<b>courseInstructor :</b>&nbsp;&nbsp;&nbsp;&nbsp; 
    <input type='text' name='courseInstructor' size="20" />
    <p> <br />
	<input type='submit' value='Add' /> </p>
</form>

<% }

else
{

	Connection con = null;
	try{
		Class.forName("org.gjt.mm.mysql.Driver").newInstance();
		String protocol = "jdbc:mysql://localhost:3306/NSURS?user=reza&password=reza";
		con = DriverManager.getConnection(protocol);
	} catch (Exception e){
		System.out.println(e);
		out.println("error getting connection");
	}		

	ResultSet result = null;
	Statement select = con.createStatement();
	String query ="";

	String courseID = request.getParameter("courseID");
	String courseName = request.getParameter("courseName");
	String courseDescription = request.getParameter("courseDescription");
	String courseCredits = request.getParameter("courseCredits");
	String coursePreReq = request.getParameter("coursePreReq");
	String courseInstructor = request.getParameter("courseInstructor");


	query = "INSERT INTO courseInfo values('"+courseID+"','"+courseName+"','"+courseDescription+"',"+courseCredits+",'"+coursePreReq+"','"+courseInstructor+"')";

	try{
		select.executeQuery(query);
		out.println("<br>Infos are successfully added !!<br><a href = 'course.jsp'> Insert another course </a>");
	}catch (Exception e){
		System.out.println(e);
		out.println("Error inserting");
	}
}
%>