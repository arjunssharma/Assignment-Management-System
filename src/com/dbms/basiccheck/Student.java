package com.dbms.basiccheck;
 
 import java.sql.Connection;
 import java.sql.PreparedStatement;
 import java.sql.ResultSet;
 import java.util.ArrayList;
 import java.util.List;
 import java.util.Scanner;
 
 public class Student {
 	
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
 			
 			try{
 				stmt=con.prepareStatement("SELECT col_name FROM MENU_OPTIONS where role = ? and menu_name = ? order by display_order");
 				 stmt.setString(1, "S");
 			     stmt.setString(2, "Home");
 
 			 rs = stmt.executeQuery();
 			 
 			 while(rs.next()){
 				 options.add(rs.getString("col_name"));
 			 }
 			 cg.closeStatement(stmt);
 			 cg.closeResult(rs);
 			for(int i=1; i <= options.size();i++){
 				System.out.println(i + ": " + options.get(i-1));
 			}
 			
 			int optionNo = sc.nextInt();
 			String optionSelected = options.get(optionNo-1);
 			if(optionSelected.equals("Logout") || optionSelected.equals("Log out")){
 				//Entry.startPage();
 			}
 			else if(optionSelected.equals("View Courses")){
 				//System.out.println("View/Add Courses");
 				viewAddCourses();
 			}
 			else if(optionSelected.equals("View Profile") || optionSelected.equals("View/Edit Profile")){
 				//System.out.println("View Profile");
 				viewProfile();
 			}
 		        
 			}
 			catch(Exception e){
 				e.printStackTrace();
 			}
 		}
 
 		private static void viewAddCourses() {
 			// TODO Auto-generated method stub
 			
 		}
 
 		private static void viewProfile() {
 
 
 			// TODO Auto-generated method stub
 			PreparedStatement stmt = null;
 			ResultSet rs = null;
 			System.out.println("Press 0 to go back");
 			String name = "";
 
 			try{
 				stmt=con.prepareStatement("SELECT name FROM STUDENT where STUDENT_ID = ?");
 				stmt.setString(1, username);
 				 
 				 rs = stmt.executeQuery();
 				 while(rs.next()){
 					 name = rs.getString("name"); 
 				 }
 			    
 			     }
 			catch(Exception e){
 			   e.printStackTrace();	
 			}
 			cg.closeStatement(stmt);
 			cg.closeResult(rs);
 			String [] nameBreak = name.split("\\s");
 			String fname = nameBreak[0];
 			String lname = "";
 			if(nameBreak.length > 1){
 				lname = nameBreak[1];
 			}
 			System.out.println("First Name: "  + fname);
 			System.out.println("Last Name: "  + lname);
 			String lastOption = "";
 			try{
 				stmt=con.prepareStatement("SELECT col_name FROM MENU_OPTIONS where role = ? and menu_name = ? order by display_order");
 				 stmt.setString(1, "S");
 			     stmt.setString(2, "Profile");
 			     
 			    rs = stmt.executeQuery();
 			    while(rs.next()){
 			    	lastOption = rs.getString("col_name");
 			    }
 			}
 			catch(Exception e){
 				e.printStackTrace();
 			}
 			cg.closeStatement(stmt);
 			cg.closeResult(rs);
 			System.out.println(lastOption + ": " + username);
 			int isZero = 1;
 			while(isZero != 0){
 				isZero = sc.nextInt();
 				}
 			homePage();
 			
 		}
 
 }