package com.dbms.basiccheck;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class TA {

	public static ConnectionGetter cg = null;
	public static Connection con = null;
	public static Scanner sc = null;
	public static String username = null;

	public static void homePage() {
		// TODO Auto-generated method stub

		// TODO Auto-generated method stub
		PreparedStatement stmt = null;
		ResultSet rs = null;
		List<String> options = new ArrayList<String>();

		try {
			stmt = con.prepareStatement(
					"SELECT col_name FROM MENU_OPTIONS where role = ? and menu_name = ? order by display_order");
			stmt.setString(1, "T");
			stmt.setString(2, "Home");

			rs = stmt.executeQuery();

			while (rs.next()) {
				options.add(rs.getString("col_name"));
			}
			cg.closeStatement(stmt);
			cg.closeResult(rs);
			for (int i = 1; i <= options.size(); i++) {
				System.out.println(i + ": " + options.get(i - 1));
			}

			int optionNo = sc.nextInt();
			String optionSelected = options.get(optionNo - 1);
			if (optionSelected.equals("Logout") || optionSelected.equals("Log out")) {
				// Entry.startPage();
			} else if (optionSelected.equals("View Profile") || optionSelected.equals("View/Edit Profile")) {
				// System.out.println("View Profile");
				viewProfile();
			} else if (optionSelected.equals("View/Add Courses")) {
				// System.out.println("View/Add Courses");
				viewAddCourses();
			} else if (optionSelected.equals("Enroll/Drop A Student")) {
				enrollDropOption();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private static void enrollDropOption() {
		// TODO Auto-generated method stub
		System.out.println("select 0 to go to home page.");
		System.out.println("1: Enroll Student");
		System.out.println("2: Drop Student");
		int choice = sc.nextInt();
		sc.nextLine();
		if (choice == 0) {
			homePage();
		}
		if (choice == 1) {
			enrollStudent();
		}
		if (choice == 2) {
			enrollDropStudent();
		}
		homePage();

	}

	private static void enrollStudent() {
		 			// TODO Auto-generated method stub
		 			PreparedStatement stmt = null;
		 			ResultSet rs = null;
		 			List<String> courses = new ArrayList<String>();
		 			System.out.println("Select Course to enroll Student.");
		 			try{
		 				stmt=con.prepareStatement("SELECT COURSE_ID from TA where STUDENT_ID = ?");
		 				stmt.setString(1, username);
		 			   	rs = stmt.executeQuery();
		 			   	while(rs.next()){
		 			   		courses.add(rs.getString("COURSE_ID"));
		 			   	}
		 				 for(int i=1; i <= courses.size();i++){
		 					 System.out.println(i + ": " + courses.get(i-1));
		 				 }
		 				 System.out.println("select 0 to go to home page.");
		 				 int choice  = sc.nextInt();
		 				 sc.nextLine();
		 				 if(choice == 0){
		 					 homePage();
		 				 }
		 				 else{
		 					 String course = courses.get(choice-1);
		 					 DisplayStudents(course);
		 				 }
		 			}
		 			catch(Exception e){
		 				e.printStackTrace();
		 			}
		 			
		 		}
		 
		 
		 		private static void DisplayStudents(String course) {
		 			// TODO Auto-generated method stub
		 			PreparedStatement stmt = null;
		 			ResultSet rs = null;
		 			List<String> students = new ArrayList<String>();
		 			System.out.println("Select student to enroll/drop from :" + course);
		 			try{
		 				stmt=con.prepareStatement("SELECT STUDENT_ID from STUDENT ");
		 				//stmt.setString(1, course);
		 			   	rs = stmt.executeQuery();
		 			   	while(rs.next()){
		 			   		students.add(rs.getString("STUDENT_ID"));
		 			   	}
		 			   	System.out.println("select 0 to go to previous page.");
		 			   	for(int i=1; i <= students.size();i++){
		 					 System.out.println(i + ": " + students.get(i-1));
		 				 }
		 			   	int choice  = sc.nextInt();
		 				 sc.nextLine();
		 				 if(choice == 0){
		 					 homePage();
		 				 }
		 				 else{
		 					 String studentId = students.get(choice-1);
		 					 EnrollStudentToCourse(studentId,course);
		 					 DisplayStudents(course);
		 				 }
		 			}
		 			catch(Exception e){
		 				e.printStackTrace();
		 			}
		 			
		 		}
		 
		 		private static void EnrollStudentToCourse(String studentId, String course) {
		 			PreparedStatement stmt = null;
		 			ResultSet rs = null;
		 			try{
		 				stmt = con.prepareStatement("INSERT into COURSE_STUDENT values (?,?)");
		 				stmt.setString(1, course);
		 				stmt.setString(2, studentId);
		 				stmt.executeUpdate();
		 				System.out.println("Enrolled  "+studentId +" to "+course);
		 			}
		 			catch(Exception e){
		 				System.out.println(e.getMessage());
		 			}
		 					
		 		}
		 
		 		private static void enrollDropStudent() {
		 			// TODO Auto-generated method stub
		 			PreparedStatement stmt = null;
		 			ResultSet rs = null;
		 			List<String> courses = new ArrayList<String>();
		 			System.out.println("Select Course to drop Student.");
		 			try{
		 				stmt=con.prepareStatement("SELECT COURSE_ID from TA where STUDENT_ID = ?");
		 				stmt.setString(1, username);
		 			   	rs = stmt.executeQuery();
		 			   	while(rs.next()){
		 			   		courses.add(rs.getString("COURSE_ID"));
		 			   	}
		 				 for(int i=1; i <= courses.size();i++){
		 					 System.out.println(i + ": " + courses.get(i-1));
		 				 }
		 				 System.out.println("select 0 to go to previous page.");
		 				 int choice  = sc.nextInt();
		 				 sc.nextLine();
		 				 if(choice == 0){
		 					 homePage();
		 				 }
		 				 else{
		 					 String course = courses.get(choice-1);
		 					 DisplayEnrolledStudents(course);
		 					 
		 				 }
		 			}
		 			catch(Exception e){
		 				e.printStackTrace();
		 			}
		 			
		 		}
		 
		 		private static void DisplayEnrolledStudents(String course) {
		 			// TODO Auto-generated method stub
		 			//System.out.println(course  "Display students");
		 			PreparedStatement stmt = null;
		 			ResultSet rs = null;
		 			List<String> students = new ArrayList<String>();
		 			System.out.println("Select student to enroll/drop from :" + course);
		 			try{
		 				stmt=con.prepareStatement("SELECT STUDENT_ID from COURSE_STUDENT where COURSE_ID = ?");
		 				stmt.setString(1, course);
		 			   	rs = stmt.executeQuery();
		 			   	while(rs.next()){
		 			   		students.add(rs.getString("STUDENT_ID"));
		 			   	}
		 			   	if(students.size()==0){
		 			   		System.out.println("No students enrolled");
		 			   		
		 			   		
		 			   	}
		 			   	System.out.println("select 0 to go to previous page.");
		 			   	for(int i=1; i <= students.size();i++){
		 					 System.out.println(i + ": " + students.get(i-1));
		 				 }
		 				 
		 				 int choice  = sc.nextInt();
		 				 sc.nextLine();
		 				 if(choice == 0){
		 					 homePage();
		 				 }
		 				 else{
		 					 String studentId = students.get(choice-1);
		 					 DropStudentFromCourse(studentId,course);
		 					 DisplayEnrolledStudents(course);
		 					 
		 				 }
		 			}
		 			catch(Exception e){
		 				e.printStackTrace();
		 			}
		 			homePage();
		 			
		 		}
		 
		 		private static void DropStudentFromCourse(String studentId, String course) {
		 			// TODO Auto-generated method stub
		 			PreparedStatement stmt = null;
		 			ResultSet rs = null;
		 			try{
		 				stmt=con.prepareStatement("delete from COURSE_STUDENT where COURSE_ID = ? and STUDENT_ID= ?");
		 				stmt.setString(1, course);
		 				stmt.setString(2, studentId);
		 				stmt.executeUpdate();
		 				cg.closeStatement(stmt);
		 			   	System.out.println("Successfully dropped");
		 			}
		 			catch(Exception e){
		 				e.printStackTrace();
		 			}
		 			
		 		}
		 
	
	private static void viewAddCourses() {
		// TODO Auto-generated method stub

	}

	private static void viewProfile() {
		PreparedStatement stmt = null;
		ResultSet rs = null;
		System.out.println("Press 0 to go back");
		String name = "";

		try {
			stmt = con.prepareStatement("SELECT name FROM STUDENT where STUDENT_ID = ?");
			stmt.setString(1, username);

			rs = stmt.executeQuery();
			while (rs.next()) {
				name = rs.getString("name");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		cg.closeStatement(stmt);
		cg.closeResult(rs);
		String[] nameBreak = name.split("\\s");
		String fname = nameBreak[0];
		String lname = "";
		if (nameBreak.length > 1) {
			lname = nameBreak[1];
		}
		System.out.println("First Name: " + fname);
		System.out.println("Last Name: " + lname);
		String lastOption = "";
		try {
			stmt = con.prepareStatement(
					"SELECT col_name FROM MENU_OPTIONS where role = ? and menu_name = ? order by display_order");
			stmt.setString(1, "T");
			stmt.setString(2, "Profile");

			rs = stmt.executeQuery();
			while (rs.next()) {
				lastOption = rs.getString("col_name");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		cg.closeStatement(stmt);
		cg.closeResult(rs);
		System.out.println(lastOption + ": " + username);
		int isZero = 1;
		while (isZero != 0) {
			isZero = sc.nextInt();
		}
		homePage();

	}

}