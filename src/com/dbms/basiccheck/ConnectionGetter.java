package com.dbms.basiccheck;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class ConnectionGetter {
public static void main(String[] args) {
	System.out.println("Hi");
	Connection con = null;
	Statement stmt = null;
	ResultSet rs = null;
	try {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		
		con = DriverManager.getConnection("jdbc:oracle:thin:@orca.csc.ncsu.edu:1521:orcl01","Enter unity id here","Enter student id here");
		stmt = con.createStatement();
		rs = stmt.executeQuery("SELECT * FROM course");
	} catch (ClassNotFoundException | SQLException e) {
		e.printStackTrace();
	}
	finally{
		try {
			rs.close();
			stmt.close();
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}

public Connection getConnection(){
	Connection con = null;
	try {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		con = DriverManager.getConnection("jdbc:oracle:thin:@orca.csc.ncsu.edu:1521:orcl01","Enter unity id here","Enter student id here");
		} catch (ClassNotFoundException | SQLException e) {
		e.printStackTrace();
	}
	
	return con;
	
}

public void closeConnection(Connection con){
	try {
		con.close();
	} catch (SQLException e) {
		e.printStackTrace();
	}
}

public void closeStatement(Statement st){
	try {
		st.close();
	} catch (SQLException e) {
		e.printStackTrace();
	}
}

public void closeResult(ResultSet rs){
	try {
		rs.close();
	} catch (SQLException e) {
		e.printStackTrace();
	}
}
}
