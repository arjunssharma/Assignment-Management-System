package com.dbms.basiccheck;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

public class Entry {

	static ConnectionGetter cg = null;
	static Connection con = null;
	static Scanner sc = null;
	static String username = null;
	static String role = null;

	private static void getConnection() {
		cg = new ConnectionGetter();
		con = cg.getConnection();

	}

	public static void main(String[] args) {
		sc = new Scanner(System.in);
		getConnection();
		startPage();
		sc.close();
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	static void startPage() {
		System.out.println("Start Menu");
		System.out.println("1. Login");
		System.out.println("2. Exit");
		int no = sc.nextInt();
		if (no == 2) {

			return;
		} else {
			loginPage();
		}

	}

	private static void loginPage() {
		System.out.println("UserName: ");
		username = sc.next();
		System.out.println("Password: ");
		String password = sc.next();

		// Statement stmt = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		role = "";
		try {
			stmt = con.prepareStatement("SELECT ROLE FROM ROLE where user_id = ? and PASSWORD = ?");
			stmt.setString(1, username);
			stmt.setString(2, password);
			int ct = 0;
			rs = stmt.executeQuery();
			while (rs.next()) {
				ct++;
				role = rs.getString("ROLE");

			}
			if (ct > 1) {
				System.out.println("Would you like to be TA or Student? Enter t or s");
				role = sc.next();
			}

		} catch (Exception e) {
			e.printStackTrace();
			role = "Error";
		}

		cg.closeResult(rs);
		cg.closeStatement(stmt);
		if (role.equals("Error") || role.equals("")) {
			System.out.println("Invalid Credentials, try again.");
			startPage();
		} else {
			if (role.equals("p")) {
				Professor.cg = cg;
				Professor.sc = sc;
				Professor.con = con;
				Professor.username = username;
				Professor.homePage();
			} else if (role.equals("s")) {
				Student.cg = cg;
				Student.sc = sc;
				Student.con = con;
				Student.username = username;
				Student.homePage();
			} else {
				TA.cg = cg;
				TA.sc = sc;
				TA.con = con;
				TA.username = username;
				TA.homePage();
			}
		}
	}
}