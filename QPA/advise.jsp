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

<center><p><img border="0" src="images/ves.jpg" width="645" height="39"></p></center><p>&nbsp;</p>
	<span id='supertitle'> .:: Editing Form ::. </span><br><br>
<form action='advise.jsp' method='post'>
<p>  Enter Course  : <input type="text" name="course1" size="20"></p><br>
<input type="submit" value="Submit" name="submit"><input type="reset" value="Reset" name="reset"><br>


</form>

</body>

</html>


<% }


else
{

///////////////////////////// Creating Connection with DB Server //////////////////////////
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
	ResultSet resultSection = null;
	Statement select = con.createStatement();
	String query ="";
	String query2 ="";
	
	String registeredStudent="";
	String newSubjectsThisSemester = "";
	int subjectsTaken = 0;

/////////////////////////////////////////////

	String course1 = request.getParameter("course1");
	System.out.println("Selected Course = " + course1);
	//out.println("Course = " + course1);

//	out.println(ID);

     query = "SELECT * FROM studentInfo";

	// out.println(query);
	result = select.executeQuery(query);
	boolean	match = false;
	
	int numberOfStudentInTheSection;
	int currentSectionLimit;

	while(!match && result.next())
	{
		if(result.getString("ID").equals(ID))
		{
			match = true;
			break;
		}
	}
    
	/*********************************************/	
	String subjects;
	boolean alreadyAdvised = true;
	String alreadyAdv = "";
	/*********************************************/
	
		
	System.out.println("ID found in DB : " + match);
	// getting the core subjects done by the Student
	alreadyAdv = result.getString("alreadyAdvised");
	subjects = result.getString("coreDone");
	String tempNewSubjects = result.getString("newSubjects");

	System.out.println("Student already advised ?? --->>>  "+alreadyAdv);
	
	//if(result.getString("newSubjects") == null)
	if(tempNewSubjects==null)
		newSubjectsThisSemester = "";
	else newSubjectsThisSemester = tempNewSubjects; // result.getString("newSubjects");
	System.out.println("NEW SUBJECTS ------------------  "+newSubjectsThisSemester);
	
	/*************** Spliting all the subjects taken by the student during advising *****************/
		StringTokenizer stkn = new StringTokenizer(newSubjectsThisSemester, "," );
		subjectsTaken = stkn.countTokens();
		String subjectsNowTaken[] = new String[subjectsTaken];
		int temp_i=0;
		
		while(stkn.hasMoreTokens())
		{
			subjectsNowTaken[temp_i++] = stkn.nextToken();
		}
	/*************************************************************************************************/		
	
	System.out.println("NEW SUBJECTS ### -------  "+ subjectsTaken);
	
	// catanating all the course done by the Student
    subjects=(""+subjects+","+result.getString("othersDone"));
    System.out.println("All courses " + subjects);   

	
	if(alreadyAdv.equals("False") )
	{
		alreadyAdvised = false;
		System.out.println("Inside : if(alreadyAdv.equals(False) ) -->> True [NOT ADVISED]");
	}
	else
	{
		alreadyAdvised = true;
		System.out.println("Inside : else of if(alreadyAdv.equals(False) ) -->> False [ADVISED] ");
	}

	/************ if already advised, do not proceed ****************/
	if(!alreadyAdvised)
	{
	
		/*Separating each subject by String tokenizer */
		StringTokenizer stk = new StringTokenizer(subjects,",");
		int studentCourse = stk.countTokens(); 
		System.out.println("Number of subjects done by Student :  " + studentCourse);
			
		String s[] = new String[studentCourse];
		int i=0;
		while(stk.hasMoreTokens())
		{
		  s[i++]=stk.nextToken();
		}
	
		/*********************************************/
		boolean preReqFullfilled = false;
		boolean courseAlreadyDone = false;
		/*********************************************/
	
		
		// matching if the course is already done b4 by the student
		for(i=0;i<studentCourse; i++)
		{
			if( s[i].equals(course1) )
			{
				courseAlreadyDone = true;
				break;
			}
		}

		// matching if the course is already taken by the student during the advising process.
		for(i=0;i<subjectsTaken; i++)
		{
			if(subjectsNowTaken[i].equals(course1) )
			{
				courseAlreadyDone = true;
				break;
			}
		}


		
		/************* If the requested course is not done by the student **************/
		if(!courseAlreadyDone)
		{
				// course is not done by the student before, now go on....
			String courseQuery = "";
			String coursePreReq= "";
			courseQuery = "SELECT * FROM courseInfo";
		
			result = select.executeQuery(courseQuery);
			
			boolean	courseMatch = false;
			String courseName="", courseDes="", courseCredits="", courseFaculty="", courseSections="";
			int numberofSections=0;
		
			while(result.next() && !courseMatch)
			{
				if(result.getString("courseID").equals(course1))
				{
					courseMatch = true;
					coursePreReq=result.getString("coursePreReq");
					courseName=result.getString("courseName");
					courseDes=result.getString("courseDescription");
					courseCredits=result.getString("courseCredits");
					courseFaculty=result.getString("courseInstructor");
					courseSections=result.getString("numberofSection");
					numberofSections = Integer.parseInt(courseSections);
					break;
				}		
			}
			
			
		
			System.out.println("Course Found : "+courseMatch);
			System.out.println("Course AvailAble Sections : "+ numberofSections);
			
			// Separating the prerequisite
			stk = new StringTokenizer(coursePreReq,",");
			int preCourse = stk.countTokens();
			System.out.println("Numner of prereq : " + preCourse);	
			
			String pre[] = new String[preCourse];
			int j=0;
			while(stk.hasMoreTokens())
			{
				 pre[j]=stk.nextToken();
				 System.out.print(pre[j] + " ->  ");
				 j++;
			}
			int numberOfMatchedCourse = 0; // for checking if every pre-requisite fullfilled
			for(i=0; i<preCourse; i++)
			{
				for(j=0; j<studentCourse; j++)
				{
					if(pre[i].equals(s[j]))
					{
						numberOfMatchedCourse++; // 1 pre requisite matched
						break;
						// do matching
					}
				}
			}
			
			if(numberOfMatchedCourse == preCourse)
			{
				preReqFullfilled = true;
			}
			else if(pre[0].equals("None") )
			{
				preReqFullfilled = true;
			}
		
			if(courseMatch)
			{
				if(preReqFullfilled)
				{
					//query = "UPDATE studentInfo SET newSubjects = '"+course1+"' WHERE ID = '"+ID+"'" ;
					
					
			
		%>
		
		<html>
		
		<head>
		
		<title>Enter Course</title>
		<link rel='stylesheet' type='text/css' href='css/style.css' />
		</head>
		
		<body>
		
		<center><p><img border="0" src="images/ves.jpg" width="645" height="39"></p></center><p>&nbsp;</p>
			<span id='supertitle'> .:: Course Add Form ::. </span><br><br>
		
		
		<form action='advise.jsp' method='post'>
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
		</table>
		<p>&nbsp;</p>
		
		<%
			/* Course information showed, now section information will be showed */
			String course_section="";
			numberOfStudentInTheSection=0;
			String classTime="",day="",sectionLimit="",sectionTeacher="";
			boolean foundSection;
			for(int temp = 1; temp<= numberofSections; temp++)
			{
				// creating string course+section to access information
				course_section = course1 + "," + temp;
				System.out.println("Finding infos for " + course_section);
				
				foundSection = false;
				query2 = "SELECT * FROM sectionInfo";
				resultSection = select.executeQuery(query2);
		
				while(!foundSection && resultSection.next())
				{
					if(resultSection.getString("courseIDsection").equals(course_section))
					{
						foundSection = true;
						classTime = resultSection.getString("classTime");
						day = resultSection.getString("day");
						sectionLimit=resultSection.getString("sectionLimit");
						registeredStudent = resultSection.getString("studentsRegistered");
						sectionTeacher = resultSection.getString("sectionInstructor");
						break;
					}
				}
				stk = new StringTokenizer(registeredStudent,",");
		
				numberOfStudentInTheSection = stk.countTokens();
				currentSectionLimit = Integer.parseInt(sectionLimit);
				System.out.println("Number of registered students " + numberOfStudentInTheSection);
				System.out.println("Found infos for " + course_section + " :-> " + foundSection );
				
				if(numberOfStudentInTheSection == currentSectionLimit)
				{
		%>		
		<span id='error'>Sorry <%=course_section%> section is full</span><br>
		<%
				} // end of if ( where section is full )
				else
				{
		%>
		
		<span id='caption'>Additional Information of <%=course_section%> </span>
		<table id='courseSection' width='50%'>
		  <tr>
			<td width='40%' height='19'><b>Time</b></td>
			<td width='60%' height='19'><%=classTime%></td></tr>
		  <tr>
			<td width='40%' height='19'><b>Day</b></td>
			<td width='60%' height='19'><%=day%></td>
		  </tr>
		  <tr>
			<td width='40%' height='19'><b>Section Capacity</b></td>
			<td width='60%' height='19'><%=sectionLimit%></td>
		  </tr>
		  <tr>
			<td width='40%' height='19'><b>Registered Students</b></td>
			<td width='60%' height='19'><%=numberOfStudentInTheSection%></td>
		  </tr>
		  <tr>
			<td width='40%' height='19'><b>Course Instrutor</b></td>
			<td width='60%' height='19'><%=sectionTeacher%></td>
		  </tr>

		  
		</table><br>
		
		<%	
				}// end of else ( where section is not overloaded )
					
			} // end of for loop (where printing the section information)

		
		%>
		
			<form method="POST" action="courseConfirmed.jsp">
			
			<input type='hidden' name='confirm' value='null' />
			<input type='hidden' name='newSub' value='<%=newSubjectsThisSemester%>' />
			<input type='hidden' name='courseTaken' value='<%=""+subjectsTaken%>' />
			<input type='hidden' name='regStudent' value='<%=registeredStudent%>' />
			<input type='hidden' name='selectedCourse' value='<%=course1%>' />
			<input type='hidden' name='selectedCourseTime' value='<%=classTime%>' />
			<input type='hidden' name='selectedCourseDay' value='<%=day%>' />
			<input type='hidden' name='selectedCourseSecStu' value='<%=numberOfStudentInTheSection%>' />
			<input type='hidden' name='selectedCourseTeacher' value='<%=sectionTeacher%>' />
			  <p><i><b>Please Select your<br>
			  Desired Section :</b></i><br>
			  <select size="1" name="section">
			  <option selected>1</option>
			  
			  <%{
			  
			  int x = Integer.parseInt(courseSections);
			  for(int tmp=2; tmp<= x ; tmp++)
			  out.println("<option>"+ tmp +"</option>");
			  
			  }
			  %>
			  </select></p>
			  
			  <p><input type="submit" value="Submit" name="B1"></p>
			</form>
		
		</body>
		
		</html>
		
		<%
					/* offffffffffffffff jaaaaaaaa
					try
					{
						System.out.println(query);
						select.executeUpdate(query);
						out.println("New Course Updated");
					}
					catch (Exception e)
					{
						System.out.println(e);
						out.println("<B>Error updating user information</B>");
					}
					*/
					
				} // end of if ! pre-req are full-filled
				
			
				else
				{
							
				%>
					<html>
					<head>
						<link rel='stylesheet' type='text/css' href='css/style.css' />
						<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
					</head>
					
					<body>
						<center><p><img border="0" src="images/ves.jpg" width="645" height="39"></p></center><p>&nbsp;</p>
						<h2><font color="#FF0000"> ErRor !!! </font></h2>
						<span id='title'><b>Sorry haven't done all the pre-requisite required by the course.<br>
						<a href="javascript:history.back(1)"><b>Click back</a></b> and try with another course ID.</b><br>
						Note : Course names are <i><u>case sensetive</u></i> and all are in UPPER CASE.</span>
					</body>
					</html>
				
				<% 
			
				} // end of else ( all the pre-requisite is not fullfilled ) 
				
			} // end of if ! where requested course is found in DB
			
			/* if the requested course is not found in the courseDB then -> */
			else
			{
				%>
			<html>
			<head>
				<link rel='stylesheet' type='text/css' href='css/style.css' />
				<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
			</head>
			
			<body>
				<center><p><img border="0" src="images/ves.jpg" width="645" height="39"></p></center><p>&nbsp;</p>
				<h2> ErRor !!! </h2>
				<span id='title'>Course is not listed in the database / Course doesn't exist.<br>
				<a href="javascript:history.back(1)">Click back</a> and try with valid course ID.<br>
				Check the course list in the <a href='viewCourseInfo.html' target="_blank">Course Information</a> page.<br>
				Note : Course names are case sensetive and all are in UPPER CASE.</span>
			</body>
			</html>
		
			<% 
			} // end of else (course not found)
			
		} // end of if ( where course is not done previously )
		
		else
		{
			/* course is already done by the student
			   so re-taking case ! forwarded to Advisor. */
			
						%>
			<html>
			<head>
				<link rel='stylesheet' type='text/css' href='css/style.css' />
				<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
			</head>
			
			<body>
				<center><p><img border="0" src="images/ves.jpg" width="645" height="39"></p></center><p>&nbsp;</p>
				<h2> ErRor !!! </h2>
				<span id='title'><b>Sorry you have already done the course.<br>
				or, You have already taken the course during the advising process <br>
				If you really want to retake the course, please contuct with your Advisor.
				or, <br /><a href="javascript:history.back(1)">Click</a> back and try with another course ID.</b><br>
				Note : Course names are case sensetive and all are in UPPER CASE.</span>
			</body>
			</html>
		
			<% 
			
		} // end of else ( student wanted to re-take )
		
	} // end of if ( student has not advised earlier ) 

	else
	{
		/* Student has already advised for this semester. */
		
						%>
			<html>
			<head>
				<link rel='stylesheet' type='text/css' href='css/style.css' />
				<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
			</head>
			
			<body>
				<center><p><img border="0" src="images/ves.jpg" width="645" height="39"></p></center><p>&nbsp;</p>
				<h2> ErRor !!! </h2>
				<span id='title'><b>Sorry, our database record says that<br>
				you are already advised for this semster.<br>
				If you have any question or problem regarding this,<br>
				please contact Administrator or Advisor.</b><br /></span>

				<p>&nbsp;</p>
				<center><b> Please <a href="logout.html">LOG OUT</a> and Close this window before leaving.</b></center>

			</body>
			</html>
		
			<% 
			
	} // end of else ( student has already advised for this semester )


	if(con!=null)
	{
		con.close();
	}

}


%>