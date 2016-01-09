<%@page import="java.sql.*" %>
<%@page import="java.sql.Statement" %>



<%

if(request.getParameter("courseID")==null)
{	%>


<form action='test.jsp' method='post'>
	<b>courseID : </b>&nbsp;<input type='text' name='courseID' size="20" /> <br />
	<input type='submit' value='Add' /> </p>
</form>

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
	String query ="";

	String courseID = request.getParameter("courseID");
	String IDx = (String)session.getAttribute("ID");
	out.println(courseID);
	out.println(IDx);
	String New_Name="Haua", ID = "032034040";
	query = "UPDATE studentInfo SET firstName = '"+New_Name+"' WHERE ID = '"+ID+"'";

	try{
		select.executeUpdate(query);
		out.println("<br>Infos are successfully added !!<br><a href = 'test.jsp'> Insert another course </a>");
	}catch (Exception e){
		System.out.println(e);
		out.println("Error updating");
	}
}
%>