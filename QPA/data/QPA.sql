# phpMyAdmin MySQL-Dump
# version 2.2.3
# http://phpwizard.net/phpMyAdmin/
# http://phpmyadmin.sourceforge.net/ (download page)
#
# Host: localhost
# Generation Time: May 23, 2004 at 08:14 AM
# Server version: 3.23.49
# PHP Version: 4.2.2
# Database : `NSURS`
# --------------------------------------------------------

#
# Table structure for table `courseinfo`
#

DROP TABLE IF EXISTS courseinfo;
CREATE TABLE courseinfo (
  courseID varchar(12) NOT NULL default '',
  courseName varchar(50) NOT NULL default '',
  courseDescription varchar(150) NOT NULL default '',
  courseCredits int(11) NOT NULL default '0',
  coursePreReq varchar(50) NOT NULL default '',
  courseInstructor varchar(4) NOT NULL default '',
  PRIMARY KEY  (courseID)
) TYPE=MyISAM;

#
# Dumping data for table `courseinfo`
#

INSERT INTO courseinfo VALUES ('CSE231', 'Digital Logic', 'Digital Logic and System Design Digital Logic and System Design Digital Logic and System Design', 3, 'CSE173,CSE225', 'LHq');
INSERT INTO courseinfo VALUES ('CSE232', 'Digital Logic', 'Digital Logic and System Design Digital Logic and System Design Digital Logic and System Design', 3, 'CSE173,CSE225', 'LHq');
INSERT INTO courseinfo VALUES ('CSE173', 'Discrete Math', 'Discrete Mathematics and Combeterial Math by Ralph', 3, 'CSE 225', 'PPD');
INSERT INTO courseinfo VALUES ('CSE135', 'Object Oriented Programming', 'Introduction to Java and C++', 3, 'CSE115', 'TIm');
INSERT INTO courseinfo VALUES ('ENG103', 'Composition', '', 3, 'ENG103', 'SHq');
# --------------------------------------------------------

#
# Table structure for table `facultyinfo`
#

DROP TABLE IF EXISTS facultyinfo;
CREATE TABLE facultyinfo (
  initial char(3) NOT NULL default '',
  password varchar(15) NOT NULL default '',
  facultyName varchar(50) NOT NULL default '',
  Description varchar(255) NOT NULL default '',
  PRIMARY KEY  (initial)
) TYPE=MyISAM;

#
# Dumping data for table `facultyinfo`
#

# --------------------------------------------------------

#
# Table structure for table `studentinfo`
#

DROP TABLE IF EXISTS studentinfo;
CREATE TABLE studentinfo (
  ID double NOT NULL default '0',
  password varchar(15) NOT NULL default '',
  firstName varchar(50) NOT NULL default '',
  lastName varchar(50) NOT NULL default '',
  CGPA float NOT NULL default '0',
  coreDone varchar(255) NOT NULL default '',
  othersDone varchar(255) NOT NULL default '',
  address varchar(255) NOT NULL default '',
  phone varchar(15) NOT NULL default '',
  email varchar(100) NOT NULL default '',
  PRIMARY KEY  (ID)
) TYPE=MyISAM;

#
# Dumping data for table `studentinfo`
#

INSERT INTO studentinfo VALUES ('32034040', 'hossain', 'Hossain', 'Khan', '2.74', 'CSE115,CSE135,CSE225,MAT120,MAT130,CHE101', 'ENG103,ENG105,CEG100', 'Malibagh, Dhaka', '9348463', 'hossain@dhakabd.com');
INSERT INTO studentinfo VALUES ('993239040', 'reza', 'Hassan', 'Khan', '0', '', '', 'Mouchaq,Dhaka 1217', '9348463', 'reza@dhakabd.com');
INSERT INTO studentinfo VALUES ('32263040', 'kompany', 'M Iftekher', 'Chowdhury', '3.118', 'CSE115,CSE135,CSE225,MAT120,MAT125,MAT130,CHE101', 'ENG103,ENG105,CEG100,CEG243', 'uttara', '8960549', 'yPHtekhar@yahoo.com');
INSERT INTO studentinfo VALUES ('32190040', 'rolu', 'Ahmed Faisal', 'Islam', '2.43', 'CSE115,CSE135,CSE225,MAT120,MAT130', 'ENG103,CEG100,CEG243', 'khilgao', '7212735', 'afislam@agni1.net');

