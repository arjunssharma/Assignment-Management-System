package com.dbms.basiccheck;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Scanner;

import oracle.jdbc.OracleTypes;

class Exercise {
	int exid;
	String name;

	public Exercise(int id, String name) {
		this.exid = id;
		this.name = name;
	}
}

class InnerStudent {
	String id;
	String name;

	public InnerStudent(String id, String name) {
		this.id = id;
		this.name = name;
	}
}

public class Professor {

	public static ConnectionGetter cg = null;
	public static Connection con = null;
	public static Scanner sc = null;
	public static String username = null;

	public static void homePage() {

		PreparedStatement stmt = null;
		ResultSet rs = null;
		List<String> options = new ArrayList<String>();

		try {
			stmt = con.prepareStatement(
					"SELECT col_name FROM MENU_OPTIONS where role = ? and menu_name = ? order by display_order");
			stmt.setString(1, "P");
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
			sc.nextLine();
			String optionSelected = options.get(optionNo - 1);
			if (optionSelected.equals("Logout") || optionSelected.equals("Log out")) {
				Entry.startPage();
			} else if (optionSelected.equals("View Profile") || optionSelected.equals("View/Edit Profile")) {
				// System.out.println("View Profile");
				viewProfile();
			} else if (optionSelected.equals("View/Add Courses")) {
				// System.out.println("View/Add Courses");
				viewAddCourses();
			} else if (optionSelected.equals("Enroll/Drop A Student")) {
				// System.out.println("Enroll/Drop A Student");
				enrollDropOption();
			} else if (optionSelected.equals("Search/Add questions to Question Bank")) {
				addQuestionToBank();
				// System.out.println("Search/Add questions to Question Bank");
			}

		} catch (Exception e) {
			e.printStackTrace();
			homePage();
		}
	}

	private static void viewReport() {

	}

	private static void addQuestionToBank() {

		PreparedStatement stmt = null;
		ResultSet rs = null;
		List<String> courses = new ArrayList<String>();
		System.out.println("Select course to view question bank.");
		try {
			stmt = con.prepareStatement("SELECT COURSE_ID from COURSE where PROFESSOR_ID = ?");
			stmt.setString(1, username);
			rs = stmt.executeQuery();
			while (rs.next()) {
				courses.add(rs.getString("COURSE_ID"));
			}
			for (int i = 1; i <= courses.size(); i++) {
				System.out.println(i + ": " + courses.get(i - 1));
			}
			System.out.println("select 0 to go to previous page.");
			int choice = sc.nextInt();
			sc.nextLine();
			if (choice == 0) {
				homePage();
			} else {
				String course = courses.get(choice - 1);
				displayQuestions(course);

			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	private static void displayQuestions(String course) {

		PreparedStatement stmt = null;
		ResultSet rs = null;
		List<Integer> questions = new ArrayList<Integer>();
		// System.out.println("Select course to view question bank.");
		try {
			stmt = con.prepareStatement(
					"select q.QUESTION_ID, q.QUESTION_TEXT, q.DIFFICULTY_LEVEL, q.TOPIC_ID from QUESTION_BANK qb inner join QUESTION q on qb.QUESTION_ID = q.QUESTION_ID where qb.COURSE_ID = ?");
			stmt.setString(1, course);
			rs = stmt.executeQuery();
			int i = 1;
			while (rs.next()) {
				questions.add(rs.getInt("QUESTION_ID"));
				System.out.println(i + " Question ID: " + rs.getString("QUESTION_ID") + " Question TEXT: "
						+ rs.getString("QUESTION_TEXT") + " Difficulty Level: " + rs.getString("DIFFICULTY_LEVEL")
						+ " Topic ID: " + rs.getString("TOPIC_ID"));
				i++;
			}
			cg.closeResult(rs);
			cg.closeStatement(stmt);
			System.out.println("For deleting press 1");
			System.out.println("For adding press 2");
			System.out.println("Press 0 to go to previous screen.");
			int choice = sc.nextInt();
			sc.nextLine();
			if (choice == 0) {
				addQuestionToBank();
			} else if (choice == 1) {
				System.out.println("Enter choice to delete");
				int choice2 = sc.nextInt();
				sc.nextLine();
				int questionDelete = questions.get(choice2 - 1);
				stmt = con.prepareStatement("delete from QUESTION_BANK where QUESTION_ID = ? and COURSE_ID = ?");
				stmt.setInt(1, questionDelete);
				stmt.setString(2, course);
				stmt.executeUpdate();
				cg.closeStatement(stmt);
				System.out.println("Successfully deleted");
				displayQuestions(course);

			} else if (choice == 2) {
				addNewQuestions(course);
				displayQuestions(course);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	private static void addNewQuestions(String course) {

		PreparedStatement stmt = null;
		ResultSet rs = null;
		CallableStatement callableStatement = null;
		try {
			System.out.println("Enter Question Type (P/F)");
			String type = sc.nextLine();
			System.out.println("Enter Question Text (For P type, enter param placeholder as <?>)");
			String text = sc.nextLine();
			System.out.println("Enter topic");
			String topic = sc.nextLine();
			System.out.println("Enter difficulty level (1-6)");
			int dl = sc.nextInt();
			sc.nextLine();
			System.out.println("Enter Hint");
			String hint = sc.nextLine();
			System.out.println("Explanation");
			String exp = sc.nextLine();
			String retrieveQuestionId = "{call INSERT_QUESTION_AND_RETURN_ID(?,?,?,?,?,?,?)}";
			callableStatement = con.prepareCall(retrieveQuestionId);
			callableStatement.setString(1, type);
			callableStatement.setString(2, text);
			callableStatement.setString(3, topic);
			callableStatement.setInt(4, dl);
			callableStatement.setString(5, hint);
			callableStatement.setString(6, exp);
			callableStatement.registerOutParameter(7, OracleTypes.CURSOR);
			callableStatement.executeUpdate();
			rs = (ResultSet) callableStatement.getObject(7);
			int questionId = 0;
			while (rs.next()) {
				questionId = rs.getInt("ret_id");
			}
			cg.closeResult(rs);
			cg.closeStatement(callableStatement);
			stmt = con.prepareStatement("INSERT into QUESTION_BANK values (?,?)");
			stmt.setString(1, course);
			stmt.setInt(2, questionId);
			stmt.executeUpdate();
			cg.closeStatement(stmt);
			if (type.equals("P")) {
				System.out.println("How many sets of parameters?");
				int no = sc.nextInt();
				sc.nextLine();
				String params = "";
				System.out.println("Enter parameters one-by-one as comma separated values");
				for (int i = 1; i <= no; i++) {
					System.out.println("Enter Parameter set no: " + i);
					params = sc.nextLine();
					String qrp = combine(text, params);
					System.out.println("Enter the number of correct answers: ");
					int nc = sc.nextInt();
					sc.nextLine();
					for (int j = 1; j <= nc; j++) {
						System.out.println("Enter correct answer no:" + j);
						String ans = sc.nextLine();
						stmt = con.prepareStatement(
								"INSERT into QUESTION_PARAM_ANSWERS (QUESTION_ID, QUESTION, ANSWER, CORRECT) values (?,?,?,1)");
						stmt.setInt(1, questionId);
						stmt.setString(2, qrp);
						stmt.setString(3, ans);
						stmt.executeUpdate();
						cg.closeStatement(stmt);
					}
					System.out.println("Enter the number of incorrect answers: ");
					int nic = sc.nextInt();
					sc.nextLine();
					for (int j = 1; j <= nic; j++) {
						System.out.println("Enter incorrect answer no:" + j);
						String ans = sc.nextLine();
						stmt = con.prepareStatement(
								"INSERT into QUESTION_PARAM_ANSWERS (QUESTION_ID, QUESTION, ANSWER, CORRECT) values (?,?,?,0)");
						stmt.setInt(1, questionId);
						stmt.setString(2, qrp);
						stmt.setString(3, ans);
						stmt.executeUpdate();
						cg.closeStatement(stmt);
					}

				}

			} else {
				System.out.println("Enter the number of correct answers: ");
				int nc = sc.nextInt();
				sc.nextLine();
				for (int j = 1; j <= nc; j++) {
					System.out.println("Enter correct answer no:" + j);
					String ans = sc.nextLine();
					stmt = con.prepareStatement(
							"INSERT into QUESTION_PARAM_ANSWERS (QUESTION_ID, QUESTION, ANSWER, CORRECT) values (?,?,?,1)");
					stmt.setInt(1, questionId);
					stmt.setString(2, text);
					stmt.setString(3, ans);
					stmt.executeUpdate();
					cg.closeStatement(stmt);
				}
				System.out.println("Enter the number of incorrect answers: ");
				int nic = sc.nextInt();
				sc.nextLine();
				for (int j = 1; j <= nic; j++) {
					System.out.println("Enter incorrect answer no:" + j);
					String ans = sc.nextLine();
					stmt = con.prepareStatement(
							"INSERT into QUESTION_PARAM_ANSWERS (QUESTION_ID, QUESTION, ANSWER, CORRECT) values (?,?,?,0)");
					stmt.setInt(1, questionId);
					stmt.setString(2, text);
					stmt.setString(3, ans);
					stmt.executeUpdate();
					cg.closeStatement(stmt);
				}
			}

			// String q = sc.nextLine();

		} catch (Exception e) {
			e.printStackTrace();
			homePage();
		}
	}

	private static String combine(String text, String params) {

		String[] sArray = params.split(",");
		int ct = 0;
		while (text.indexOf("<?>") != -1) {
			// text = text.replaceFirst("<?>",sArray[ct]);
			int fIndex = text.indexOf("<?>");
			text = text.substring(0, fIndex) + sArray[ct] + text.substring(fIndex + 3);
			ct++;
		}
		return text;
	}

	private static void viewAddCourses() {

		PreparedStatement stmt = null;
		ResultSet rs = null;
		List<String> courses = new ArrayList<String>();
		try {
			stmt = con.prepareStatement("SELECT COURSE_ID from COURSE where PROFESSOR_ID = ?");
			stmt.setString(1, username);

			rs = stmt.executeQuery();
			while (rs.next()) {
				courses.add(rs.getString("COURSE_ID"));
			}

		} catch (Exception e) {
			e.printStackTrace();
			homePage();
			return;
		}
		System.out.println("Couses you added: ");
		for (int i = 1; i <= courses.size(); i++) {
			System.out.println(i + ": " + courses.get(i - 1));
		}
		int newOption = courses.size() + 1;
		boolean done = false;

		while (!done) {
			System.out.println("Enter number to view the course");
			System.out.println("Press " + newOption + " to add a new course");
			System.out.println("Press 0 to go back to previous menu");
			int selOption = sc.nextInt();
			sc.nextLine();
			if (selOption == newOption) {
				done = true;
				System.out.println("add course");
				addCourse();
			} else if (selOption == 0) {
				done = true;
				homePage();
			}

			else if (selOption <= courses.size()) {
				done = true;
				// System.out.println("view specific course");
				viewSpecificCourse(courses.get(selOption - 1));
			}

		}
	}

	private static void viewSpecificCourse(String courseId) {

		String getRelevantOptions = "{call SELECT_PROFESSOR_OPTIONS(?,?,?,?)}";
		CallableStatement callableStatement = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			callableStatement = con.prepareCall(getRelevantOptions);
			callableStatement.setString(1, courseId);
			callableStatement.setString(2, username);
			callableStatement.setString(3, "View Course");
			callableStatement.registerOutParameter(4, OracleTypes.CURSOR);
			callableStatement.executeUpdate();
			rs = (ResultSet) callableStatement.getObject(4);
			List<String> options = new ArrayList<String>();
			while (rs.next()) {

				// System.out.println(rs.getString("col_name"));
				options.add(rs.getString("col_name"));

			}
			cg.closeResult(rs);
			cg.closeStatement(callableStatement);
			stmt = con.prepareStatement("SELECT COURSE_NAME, START_DATE, END_DATE FROM COURSE where COURSE_ID = ?");
			stmt.setString(1, courseId);
			rs = stmt.executeQuery();
			String courseName = "";
			String stDate = "";
			String endDate = "";
			while (rs.next()) {
				courseName = rs.getString("COURSE_NAME");
				stDate = rs.getString("START_DATE");
				endDate = rs.getString("END_DATE");
			}
			cg.closeResult(rs);
			cg.closeStatement(stmt);
			System.out.println("Course Name: " + courseName);
			System.out.println("Start Date: " + stDate);
			System.out.println("End Date: " + endDate);
			for (int i = 4; i <= options.size(); i++) {
				System.out.println(i + ": " + options.get(i - 1));
			}
			System.out.println("Press 0 to go to previous page");

			int selOption = sc.nextInt();
			sc.nextLine();
			if (selOption == 0) {
				viewAddCourses();
			} else {
				String option = options.get(selOption - 1);
				if (option.equals("View Exercise")) {
					viewExercise(courseId);
				} else if (option.equals("ADD Exercise")) {
					addExercise(courseId);
				} else if (option.equals("View TA")) {
					viewTA(courseId);
				} else if (option.equals("Add TA")) {
					addTA(courseId);
				} else if (option.equals("Enroll/Drop Student")) {
					enrollDrop(courseId);
				} else if (option.equals("View Report")) {
					viewReport(courseId);
				}
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			viewSpecificCourse(courseId);
		}

	}

	private static int finalScore(int exercise_id, String username2) {
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String scoringPolicy = null;
		int pointFinal = -1;
		try {
			stmt = con.prepareStatement("SELECT SCORING_POLICY from EXERCISE where EXERCISE_ID = ?");
			stmt.setInt(1, exercise_id);
			rs = stmt.executeQuery();
			while (rs.next()) {
				scoringPolicy = rs.getString("SCORING_POLICY");
			}
			if (scoringPolicy == null || scoringPolicy.equals("")) {
				return -1;
			}
			stmt = null;
			rs = null;
			if (scoringPolicy.equalsIgnoreCase("max")) {

				stmt = con.prepareStatement(
						"SELECT MAX(POINTS) as MAX_POINTS from ATTEMPT_SUBMISSION where EXERCISE_ID = ? AND STUDENT_ID = ?");
				stmt.setInt(1, exercise_id);
				stmt.setString(2, username2);
				rs = stmt.executeQuery();
				while (rs.next()) {
					pointFinal = rs.getInt("MAX_POINTS");
				}
				return pointFinal;
			} else if (scoringPolicy.equalsIgnoreCase("latest")) {
				stmt = null;
				rs = null;
				stmt = con.prepareStatement(
						"SELECT POINTS from ATTEMPT_SUBMISSION where EXERCISE_ID = ? AND STUDENT_ID = ? AND ROWNUM=1 ORDER BY SUBMISSION_TIME DESC");
				stmt.setInt(1, exercise_id);
				stmt.setString(2, username2);
				rs = stmt.executeQuery();
				while (rs.next()) {
					pointFinal = rs.getInt("POINTS");
				}
				return pointFinal;
			} else if (scoringPolicy.equalsIgnoreCase("AVERAGE") || scoringPolicy.equalsIgnoreCase("avg")) {
				stmt = con.prepareStatement(
						"SELECT AVG(POINTS) AS AVG_POINT from ATTEMPT_SUBMISSION where EXERCISE_ID = ? AND STUDENT_ID = ?");
				stmt.setInt(1, exercise_id);
				stmt.setString(2, username2);
				rs = stmt.executeQuery();
				while (rs.next()) {
					pointFinal = rs.getInt("AVG_POINT");
				}
				return pointFinal;
			} else {
				return -1;
			}

		} catch (Exception e) {
			System.out.println("Error Fetching final Score:");
			e.printStackTrace();
			return -1;
		}

		// return -1;
	}

	private static void viewReport(String courseId) {

		try {
			CallableStatement callableStatement = null;
			ResultSet rs = null;
			String getReport = "{call RETURN_REPORT(?,?)}";
			callableStatement = con.prepareCall(getReport);
			callableStatement.setString(1, courseId);
			callableStatement.registerOutParameter(2, OracleTypes.CURSOR);
			callableStatement.executeUpdate();
			rs = (ResultSet) callableStatement.getObject(2);

			while (rs.next()) {
				System.out.println("Exercise ID: " + rs.getInt("Ex") + " Exercise Name: " + rs.getString("eNm")
						+ " Student ID: " + rs.getString("St") + " Student Name: " + rs.getString("Nm") + " Score: "
						+ rs.getDouble("score"));
			}
			cg.closeResult(rs);
			cg.closeStatement(callableStatement);

			int zer = 1;
			while (zer != 0) {
				System.out.println("Enter 0 to go to previous page.");
				zer = sc.nextInt();
				sc.nextLine();
			}
			viewSpecificCourse(courseId);
		} catch (Exception e) {
			e.printStackTrace();
			homePage();
		}

	}

	private static void enrollDrop(String courseId) {

	}

	private static void addExercise(String courseId) {

		try {
			System.out.println("1. Modify existing exercises");
			System.out.println("2. Create new Exercise");
			System.out.println("0. Go back to previous page");
			int opt = sc.nextInt();
			sc.nextLine();
			if (opt == 0) {
				viewSpecificCourse(courseId);
			} else if (opt == 1) {
				modifyExistingExercises(courseId);
			} else if (opt == 2) {
				System.out.println("Enter Mode of the exercise: (STANDARD/ ADAPTIVE)");
				String mode = sc.nextLine();
				System.out.println("Enter name for this exercise: ");
				String name = sc.nextLine();
				System.out.println("Enter Deadline :");
				String deadline = sc.nextLine();
				System.out.println("Enter total number of questions");
				int noQuestions = sc.nextInt();
				sc.nextLine();
				System.out.println("Enter Retries");
				int ret = sc.nextInt();
				sc.nextLine();
				System.out.println("Enter Start Date: ");
				String stDate = sc.nextLine();
				System.out.println("Enter End Date: ");
				String endDate = sc.nextLine();
				System.out.println("Enter Points per question");
				int points = sc.nextInt();
				sc.nextLine();
				System.out.println("Enter Penalty");
				int penalty = sc.nextInt();
				sc.nextLine();
				System.out.println("Enter Scoring Policy");
				String sp = sc.nextLine();
				PreparedStatement stmt = null;
				CallableStatement callableStatement = null;
				ResultSet rs = null;
				String retrieveQuestionId = "{call INSERT_EXERCISE_AND_RETURN_ID(?,?,?,?,?,?,?,?,?,?,?,?)}";
				callableStatement = con.prepareCall(retrieveQuestionId);
				callableStatement.setString(1, courseId);
				callableStatement.setString(2, name);
				callableStatement.setString(3, deadline);
				callableStatement.setInt(4, noQuestions);
				callableStatement.setInt(5, ret);
				callableStatement.setString(6, stDate);
				callableStatement.setString(7, endDate);
				callableStatement.setInt(8, points);
				callableStatement.setInt(9, penalty);
				callableStatement.setString(10, sp);
				callableStatement.setString(11, mode);
				callableStatement.registerOutParameter(12, OracleTypes.CURSOR);
				callableStatement.executeUpdate();
				rs = (ResultSet) callableStatement.getObject(12);
				int exId = 0;
				while (rs.next()) {
					exId = rs.getInt("ret_id");
				}
				cg.closeResult(rs);
				cg.closeStatement(callableStatement);
				// ResultSet rs = null;

				if (mode.equals("ADAPTIVE")) {
					System.out.println(
							"Mode is Adaptive so questions directly from Question Bank. Do you want to select a topic?");
					System.out.println("Press 1 for yes, 0 for no");
					int resp = sc.nextInt();
					sc.nextLine();
					if (resp == 1) {
						System.out.println("select topic id's from bellow.");
						stmt = con.prepareStatement(
								"select t.topic_id, t.name from course_topic ct inner join topic t on ct.topic_id = t.topic_id and ct.course_id = ?");
						stmt.setString(1, courseId);
						rs = stmt.executeQuery();
						while (rs.next()) {
							System.out.println(rs.getString("topic_id") + ": " + rs.getString("name"));
						}
						cg.closeResult(rs);
						cg.closeStatement(stmt);
						String topicId = sc.nextLine();
						stmt = con.prepareStatement("insert into ADAPTIVE_EXERCISE_TOPIC values (?,?)");
						stmt.setInt(1, exId);
						stmt.setString(2, topicId);
						stmt.executeUpdate();
						System.out.println("Exercise crested successfully.");
						viewSpecificCourse(courseId);

					} else if (resp == 0) {
						System.out.println("Exercise crested successfully.");
						viewSpecificCourse(courseId);
					}

				} else {
					addQuestionsToExercise(courseId, noQuestions, exId);
					viewSpecificCourse(courseId);
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
			homePage();
		}
		// if(mode.)
	}

	private static String dateConv(String start_dt) {

		start_dt = start_dt.substring(0, 10);
		String[] dArray = start_dt.split("-");

		String finalString = dArray[1] + "/" + dArray[2] + "/" + dArray[0];

		return finalString;
	}

	private static void modifyExistingExercises(String courseId) {

		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			System.out.println("Please select exercise Id to modify");
			stmt = con.prepareStatement(
					"SELECT EXERCISE_ID, NAME, DEADLINE, TOTAL_QUESTIONS, RETRIES,START_DATE, END_DATE, POINTS, PENALTY, SCORING_POLICY, SC_MODE FROM EXERCISE where COURSE_ID = ?");
			stmt.setString(1, courseId);
			rs = stmt.executeQuery();
			class ExerciseInner {
				int exid;
				String name;
				String deadline;
				int noOfQuestions;
				int retries;
				String stDate;
				String endDate;
				int points;
				int penalty;
				String sp;
				String scMode;

				public ExerciseInner(int exid, String name, String deadline, int noOfQuestions, int retries,
						String stDate, String endDate, int points, int penalty, String sp, String scMode) {
					super();
					this.exid = exid;
					this.name = name;
					this.deadline = deadline;
					this.noOfQuestions = noOfQuestions;
					this.retries = retries;
					this.stDate = stDate;
					this.endDate = endDate;
					this.points = points;
					this.penalty = penalty;
					this.sp = sp;
					this.scMode = scMode;
				}

			}
			HashMap<Integer, ExerciseInner> map = new HashMap<Integer, ExerciseInner>();
			while (rs.next()) {
				System.out.println("Exercise ID: " + rs.getInt("EXERCISE_ID") + " Exercise Name: "
						+ rs.getString("NAME") + " DEADLINE: " + rs.getString("DEADLINE") + " TOTAL_QUESTIONS: "
						+ rs.getInt("TOTAL_QUESTIONS") + " RETRIES: " + rs.getInt("RETRIES") + " START DATE: "
						+ rs.getString("START_DATE") + " END DATE: " + rs.getString("END_DATE") + " Points: "
						+ rs.getInt("POINTS") + " PENALTY: " + rs.getInt("PENALTY") + " SCORING POLICY: "
						+ rs.getString("SCORING_POLICY") + " MODE: " + rs.getString("SC_MODE"));
				ExerciseInner ei = new ExerciseInner(rs.getInt("EXERCISE_ID"), rs.getString("NAME"),
						dateConv(rs.getString("DEADLINE")), rs.getInt("TOTAL_QUESTIONS"), rs.getInt("RETRIES"),
						dateConv(rs.getString("START_DATE")), dateConv(rs.getString("END_DATE")), rs.getInt("POINTS"),
						rs.getInt("PENALTY"), rs.getString("SCORING_POLICY"), rs.getString("SC_MODE"));
				map.put(rs.getInt("EXERCISE_ID"), ei);
			}
			int selectedId = sc.nextInt();
			sc.nextLine();
			ExerciseInner ei = map.get(selectedId);
			System.out.println("Either enter new value for field or press enter if you want to keep it unchanged");
			String newName;
			String newDeadline;
			int newTotal;
			int newRetries;
			String newStartDate;
			String newEndDate;
			int newPoints;
			int newPenalty;
			String newSP;
			String newMode;
			System.out.println("enter name");
			newName = sc.nextLine();
			if (newName.equals("")) {
				newName = ei.name;
			}
			System.out.println("enter deadline");
			newDeadline = sc.nextLine();
			if (newDeadline.equals("")) {
				newDeadline = ei.deadline;
			}
			System.out.println("Enter no of questions");
			String tempTotal = sc.nextLine();
			if (tempTotal.equals("")) {
				newTotal = ei.noOfQuestions;
			} else {
				newTotal = Integer.parseInt(tempTotal);
			}
			System.out.println("Enter no of retries");
			String tempRetries = sc.nextLine();
			if (tempRetries.equals("")) {
				newRetries = ei.retries;
			} else {
				newRetries = Integer.parseInt(tempRetries);
			}
			System.out.println("Enter StartDate");
			newStartDate = sc.nextLine();
			if (newStartDate.equals("")) {
				newStartDate = ei.stDate;
			}
			System.out.println("Enter EndDate");
			newEndDate = sc.nextLine();
			if (newEndDate.equals("")) {
				newEndDate = ei.endDate;
			}
			System.out.println("Enter number of points");
			String tempPoints = sc.nextLine();
			if (tempPoints.equals("")) {
				newPoints = ei.points;
			} else {
				newPoints = Integer.parseInt(tempPoints);
			}
			System.out.println("Enter penalty");
			String tempPenalty = sc.nextLine();
			if (tempPenalty.equals("")) {
				newPenalty = ei.penalty;
			} else {
				newPenalty = Integer.parseInt(tempPenalty);
			}
			System.out.println("Enter Scoring Policy (LatestAttempt / AverageScore / MAX)");
			newSP = sc.nextLine();
			if (newSP.equals("")) {
				newSP = ei.sp;
			}
			// System.out.println("Enter Mode");
			// newMode = sc.nextLine();
			newMode = ei.scMode;

			CallableStatement callableStatement = null;
			rs = null;
			String retrieveExerciseId = "{call INSERT_EXERCISE_AND_RETURN_ID(?,?,?,?,?,?,?,?,?,?,?,?)}";
			callableStatement = con.prepareCall(retrieveExerciseId);
			callableStatement.setString(1, courseId);
			callableStatement.setString(2, newName);
			callableStatement.setString(3, newDeadline);
			callableStatement.setInt(4, newTotal);
			callableStatement.setInt(5, newRetries);
			callableStatement.setString(6, newStartDate);
			callableStatement.setString(7, newEndDate);
			callableStatement.setInt(8, newPoints);
			callableStatement.setInt(9, newPenalty);
			callableStatement.setString(10, newSP);
			callableStatement.setString(11, newMode);
			callableStatement.registerOutParameter(12, OracleTypes.CURSOR);
			callableStatement.executeUpdate();
			rs = (ResultSet) callableStatement.getObject(12);

			System.out.println("Successfully created new exercise.");
			viewSpecificCourse(courseId);

		} catch (Exception e) {
			e.printStackTrace();
			homePage();
		}

	}

	private static void addQuestionsToExercise(String courseId, int noQuestions, int exId) {

		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			for (int i = 1; i <= noQuestions; i++) {

				System.out.println("How do you want to select question no: " + i);
				System.out.println("1) Enter Question ID");
				System.out.println("2) View Question Bank");
				System.out.println("3) Enter Topic Id");
				int choice = sc.nextInt();
				sc.nextLine();
				if (choice == 1) {
					System.out.println("Enter Question ID");
					int qID = sc.nextInt();
					stmt = con.prepareStatement("INSERT INTO EXERCISE_QUESTION values (?,?)");
					stmt.setInt(1, exId);
					stmt.setInt(2, qID);
					stmt.executeUpdate();
					cg.closeStatement(stmt);

				} else if (choice == 2) {
					System.out.println("Select question id from the question bank.");
					stmt = con.prepareStatement(
							"SELECT q.QUESTION_ID, q.QUESTION_TEXT from QUESTION_BANK qb inner join QUESTION q on qb.QUESTION_ID = q.QUESTION_ID where qb.COURSE_ID = ?");
					stmt.setString(1, courseId);
					rs = stmt.executeQuery();
					while (rs.next()) {
						System.out.println(rs.getInt("QUESTION_ID") + ": " + rs.getString("QUESTION_TEXT"));
					}
					int qID = sc.nextInt();
					sc.nextLine();
					cg.closeResult(rs);
					cg.closeStatement(stmt);
					stmt = con.prepareStatement("INSERT INTO EXERCISE_QUESTION values (?,?)");
					stmt.setInt(1, exId);
					stmt.setInt(2, qID);
					stmt.executeUpdate();
					cg.closeStatement(stmt);

				} else {
					System.out.println("Enter required topic id: ");
					String tId = sc.nextLine();
					System.out.println("Select required question id: ");
					stmt = con.prepareStatement(
							"select q.QUESTION_ID, q.QUESTION_TEXT from Question q where q.topic_id = ? ");
					stmt.setString(1, tId);
					rs = stmt.executeQuery();
					while (rs.next()) {
						System.out.println(rs.getInt("QUESTION_ID") + ": " + rs.getString("QUESTION_TEXT"));
					}
					int qID = sc.nextInt();
					sc.nextLine();
					cg.closeResult(rs);
					cg.closeStatement(stmt);
					stmt = con.prepareStatement("INSERT INTO EXERCISE_QUESTION values (?,?)");
					stmt.setInt(1, exId);
					stmt.setInt(2, qID);
					stmt.executeUpdate();
					cg.closeStatement(stmt);

				}

			}

			// System.out.println("Created Exercise successfully.");

		} catch (Exception e) {
			e.printStackTrace();
			homePage();
		}

	}

	private static void viewExercise(String courseId) {

		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = con.prepareStatement(
					"SELECT EXERCISE_ID, NAME, DEADLINE, TOTAL_QUESTIONS, RETRIES,START_DATE, END_DATE, POINTS, PENALTY, SCORING_POLICY, SC_MODE FROM EXERCISE where COURSE_ID = ?");
			stmt.setString(1, courseId);
			rs = stmt.executeQuery();

			while (rs.next()) {
				System.out.println("Exercise ID: " + rs.getString("EXERCISE_ID") + " Exercise Name: "
						+ rs.getString("NAME") + " DEADLINE: " + rs.getString("DEADLINE") + " TOTAL_QUESTIONS: "
						+ rs.getString("TOTAL_QUESTIONS") + " RETRIES: " + rs.getString("RETRIES") + " START DATE: "
						+ rs.getString("START_DATE") + " END DATE: " + rs.getString("END_DATE") + " Points: "
						+ rs.getString("POINTS") + " PENALTY: " + rs.getString("PENALTY") + " SCORING POLICY: "
						+ rs.getString("SCORING_POLICY") + " MODE: " + rs.getString("SC_MODE"));

			}
			boolean done = false;
			while (!done) {

				System.out.println("Please Enter exercise Id for further details: ");
				System.out.println("Press 0 to go to previous menu ");
				String choice = sc.nextLine();
				if (isNumber(choice)) {
					int no = Integer.parseInt(choice);
					if (no == 0) {
						done = true;
						viewSpecificCourse(courseId);
					} else {
						done = true;
						viewSpecificExercise(no, courseId);
					}

				} else {
					System.out.println("Invalid input, Please try again");
				}

			}
		} catch (Exception e) {
			e.printStackTrace();
			homePage();
		}

	}

	private static void viewSpecificExercise(int exId, String courseId) {

		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = con.prepareStatement("SELECT SC_MODE FROM EXERCISE where EXERCISE_ID = ?");
			stmt.setInt(1, exId);
			rs = stmt.executeQuery();
			String mode = "";
			while (rs.next()) {
				mode = rs.getString("SC_MODE");
			}

			cg.closeResult(rs);
			cg.closeStatement(stmt);
			if (mode.equals("ADAPTIVE")) {
				stmt = con.prepareStatement(
						"SELECT t.name FROM ADAPTIVE_EXERCISE_TOPIC aet inner join Topic t on aet.topic_id = t.topic_id  where aet.EXERCISE_ID = ?");
				stmt.setInt(1, exId);
				rs = stmt.executeQuery();
				String topic = "";
				while (rs.next()) {
					topic = rs.getString("name");
				}
				cg.closeResult(rs);
				cg.closeStatement(stmt);
				System.out.println("Exercise is adaptive and topic is: " + topic);
				viewExercise(courseId);
			} else {

				System.out.println("Here are the questions: ");
				stmt = con.prepareStatement(
						"SELECT q.QUESTION_ID, q.QUESTION_TEXT from EXERCISE_QUESTION eq inner join QUESTION q on eq.QUESTION_ID = q.QUESTION_ID where eq.EXERCISE_ID = ?");
				stmt.setInt(1, exId);
				rs = stmt.executeQuery();
				while (rs.next()) {
					System.out.println(rs.getString("QUESTION_ID") + ": " + rs.getString("QUESTION_TEXT"));
				}
				cg.closeResult(rs);
				cg.closeStatement(stmt);

				System.out.println("Press 0 to go to previous screen.");
				String getRelevantOptions = "{call SELECT_PROFESSOR_OPTIONS(?,?,?,?)}";
				CallableStatement callableStatement = null;
				callableStatement = con.prepareCall(getRelevantOptions);
				callableStatement.setString(1, courseId);
				callableStatement.setString(2, username);
				callableStatement.setString(3, "viewSpecificExercise");
				callableStatement.registerOutParameter(4, OracleTypes.CURSOR);
				callableStatement.executeUpdate();
				rs = (ResultSet) callableStatement.getObject(4);
				List<String> options = new ArrayList<String>();
				while (rs.next()) {
					// System.out.println(rs.getString("col_name"));
					options.add(rs.getString("col_name"));

				}
				cg.closeResult(rs);
				cg.closeStatement(callableStatement);
				for (int i = 1; i <= options.size(); i++) {
					System.out.println(i + ": " + options.get(i - 1));
				}
				int choice = sc.nextInt();
				sc.nextLine();
				if (choice == 0) {
					viewExercise(courseId);
				} else if (choice == 1) {

					addQuestionsToExercise(courseId, 1, exId);
					System.out.println("Successfully added.");
					viewSpecificExercise(exId, courseId);

				} else if (choice == 2) {
					System.out.println("Enter the Question ID to be deleted. ");
					int id = sc.nextInt();
					sc.nextLine();
					stmt = con.prepareStatement(
							"delete from EXERCISE_QUESTION where exercise_id = ? and question_id = ?");
					stmt.setInt(1, exId);
					stmt.setInt(2, id);
					stmt.executeUpdate();
					System.out.println("Successfully deleted.");
					viewSpecificExercise(exId, courseId);
				}

			}

		} catch (Exception e) {
			e.printStackTrace();
			homePage();
			return;
		}

	}

	private static void addCourse() {
		PreparedStatement stmt = null;
		try {
			System.out.println("0. Go back to previous page");
			System.out.println("1. Create New Course");
			int opt = sc.nextInt();
			sc.nextLine();
			if (opt == 0) {
				viewAddCourses();
			} else if (opt == 1) {
				System.out.println("Enter unique Identifier for the Course: ");
				String courseId = sc.nextLine();
				System.out.println("Enter name for the course: ");
				String courseName = sc.nextLine();
				System.out.println("Enter Start Date (MM/dd/yyyy) for the Course :");
				String stDate = sc.nextLine();
				// Date startDate = null;
				java.sql.Date stDateSqlFormat = null;
				try {
					Date startDate = new SimpleDateFormat("MM/dd/yyyy").parse(stDate);
					stDateSqlFormat = new java.sql.Date(startDate.getTime());
				} catch (Exception e) {
					System.out.println("Error parsing Date");
					stDateSqlFormat = null;
				}
				System.out.println("Enter End Date (MM/dd/yyyy) for the Course");
				String endDate = sc.nextLine();
				java.sql.Date endDateSqlFormat = null;
				try {
					Date enddate = new SimpleDateFormat("MM/dd/yyyy").parse(endDate);
					endDateSqlFormat = new java.sql.Date(enddate.getTime());
				} catch (Exception e) {
					System.out.println("Error parsing End Date");
					endDateSqlFormat = null;
				}
				System.out.println("Choose the topic id's to add as comma separated list:");
				ResultSet rs = null;
				stmt = con.prepareStatement("select topic_id, name from topic");
				rs = stmt.executeQuery();
				List<String> topiclist = new ArrayList<String>();
				while (rs.next()) {
					String tid = rs.getString("topic_id");
					String name = rs.getString("name");
					System.out.println(tid + ": " + name);
					topiclist.add(tid);

				}
				String ip = sc.nextLine();
				String[] tops = ip.split(",");
				cg.closeResult(rs);
				cg.closeStatement(stmt);

				// cg.closeResult(rs);
				cg.closeStatement(stmt);
				stmt = con.prepareStatement("INSERT INTO COURSE values (?,?,?,?,?)");
				stmt.setString(1, courseId);
				stmt.setString(2, courseName);
				stmt.setDate(3, stDateSqlFormat);
				stmt.setDate(4, endDateSqlFormat);
				stmt.setString(5, username);
				stmt.executeUpdate();

				for (String t : tops) {
					stmt = con.prepareStatement("INSERT INTO COURSE_TOPIC values (?,?)");
					stmt.setString(1, courseId);
					stmt.setString(2, t);
					stmt.executeUpdate();
				}
			}
		} catch (Exception e) {
			System.out.println("Encountered Error: " + e.getMessage());
			viewAddCourses();
			return;
		}
		viewAddCourses();

	}

	private static void viewTA(String courseId) {
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = con.prepareStatement("SELECT STUDENT_ID from TA where COURSE_ID = ?");
			stmt.setString(1, courseId);
			rs = stmt.executeQuery();
			System.out.println("Choose 0 to return to course: " + courseId);

			List<String> tas = new ArrayList<String>();
			while (rs.next()) {
				tas.add(rs.getString("STUDENT_ID"));
			}
			for (int i = 1; i <= tas.size(); i++) {
				System.out.println(i + ": " + tas.get(i - 1));
			}
			System.out.println("Choose TA to remove or press 0 to return to course:" + courseId);
			int choice = sc.nextInt();
			sc.nextLine();
			if (choice == 0) {
				viewSpecificCourse(courseId);
			} else {
				String taId = tas.get(choice - 1);
				DeleteTA(taId, courseId);
				System.out.println("TA " + taId + " removed from Course: " + courseId);
				viewTA(courseId);
				// viewSpecificCourse(courseId);
			}
		} catch (Exception e) {
			System.out.println("Encountered Error: " + e.getMessage());
			viewSpecificCourse(courseId);
		}

	}

	private static void DeleteTA(String taId, String courseId) {
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = con.prepareStatement("DELETE from TA where COURSE_ID = ? AND STUDENT_ID = ?");
			stmt.setString(1, courseId);
			stmt.setString(2, taId);
			rs = stmt.executeQuery();
		} catch (Exception e) {
			System.out.println("Encountered Error: " + e.getMessage());
			viewTA(courseId);
		}

	}

	/*
	 * Add TA to a coursee
	 */
	private static void addTA(String courseId) {
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = con.prepareStatement("SELECT STUDENT_ID,NAME from STUDENT where IS_GRAD = ?");
			stmt.setInt(1, 1);
			rs = stmt.executeQuery();
			System.out.println("Choose 0 to return to course: " + courseId);
			List<String> students = new ArrayList<String>();
			while (rs.next()) {
				students.add(rs.getString("STUDENT_ID"));
			}
			for (int i = 1; i <= students.size(); i++) {
				System.out.println(i + ": " + students.get(i - 1));
			}
			System.out.println("Choose student to add as TA or press 0 to return to course:" + courseId);
			int choice = sc.nextInt();
			sc.nextLine();
			if (choice == 0) {
				viewSpecificCourse(courseId);
			} else {
				String sId = students.get(choice - 1);
				addTAtoCourse(sId, courseId);
				System.out.println("Added +" + sId + " as TA to course: " + courseId);
				viewSpecificCourse(courseId);
			}

		} catch (Exception e) {
			System.out.println("Encountered Error: " + e.getMessage());
			viewSpecificCourse(courseId);
		}
	}

	private static void addTAtoCourse(String sId, String courseId) {
		PreparedStatement stmt = null;
		try {
			stmt = con.prepareStatement("INSERT into TA (COURSE_ID,STUDENT_ID) values (?,?)");
			stmt.setString(1, courseId);
			stmt.setString(2, sId);
			stmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("Encountered Error: " + e.getMessage());
			viewSpecificCourse(courseId);
		}
	}

	private static boolean isNumber(String x) {
		try {
			Integer.parseInt(x);
		} catch (NumberFormatException ex) {
			return false;
		}
		return true;
	}

	private static void viewProfile() {

		PreparedStatement stmt = null;
		ResultSet rs = null;
		System.out.println("Press 0 to go back");
		String name = "";

		try {
			stmt = con.prepareStatement("SELECT name FROM PROFESSOR where PROFESSOR_ID = ?");
			stmt.setString(1, username);

			rs = stmt.executeQuery();
			while (rs.next()) {
				name = rs.getString("name");
			}

		} catch (Exception e) {
			e.printStackTrace();
			homePage();
			return;
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
			stmt.setString(1, "P");
			stmt.setString(2, "Profile");

			rs = stmt.executeQuery();
			while (rs.next()) {
				lastOption = rs.getString("col_name");
			}
		} catch (Exception e) {
			e.printStackTrace();
			homePage();
			return;
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

	/*
	 * Required Enrollment Methods
	 */
	private static void enrollDropOption() {

		System.out.println("select 0 to go to home page.");
		System.out.println("1: Enroll Student");
		System.out.println("2: Drop Student");
		int choice = sc.nextInt();
		sc.nextLine();
		if (choice == 0) {
			homePage();
		}

		else if (choice == 1) {
			enrollStudent();
			// homePage();
		} else if (choice == 2) {
			enrollDropStudent();
			// homePage();
		}
		// homePage();

	}

	private static void enrollStudent() {

		PreparedStatement stmt = null;
		ResultSet rs = null;
		List<String> courses = new ArrayList<String>();
		System.out.println("Select Course to enroll Student.");
		try {
			stmt = con.prepareStatement("SELECT COURSE_ID from COURSE where PROFESSOR_ID = ?");
			stmt.setString(1, username);
			rs = stmt.executeQuery();
			while (rs.next()) {
				courses.add(rs.getString("COURSE_ID"));
			}
			for (int i = 1; i <= courses.size(); i++) {
				System.out.println(i + ": " + courses.get(i - 1));
			}
			System.out.println("select 0 to go to home page.");
			int choice = sc.nextInt();
			sc.nextLine();
			if (choice == 0) {
				homePage();
			} else {
				String course = courses.get(choice - 1);
				DisplayStudents(course);
			}
		} catch (Exception e) {
			e.printStackTrace();
			homePage();
			return;
		}

	}

	private static void DisplayStudents(String course) {
		PreparedStatement stmt = null;
		ResultSet rs = null;
		List<String> students = new ArrayList<String>();
		System.out.println("Select student to enroll/drop from :" + course);
		try {
			stmt = con.prepareStatement("SELECT STUDENT_ID from STUDENT ");
			// stmt.setString(1, course);
			rs = stmt.executeQuery();
			while (rs.next()) {
				students.add(rs.getString("STUDENT_ID"));
			}
			System.out.println("select 0 to go to previous page.");
			for (int i = 1; i <= students.size(); i++) {
				System.out.println(i + ": " + students.get(i - 1));
			}
			int choice = sc.nextInt();
			sc.nextLine();
			if (choice == 0) {
				homePage();
			} else {
				String studentId = students.get(choice - 1);
				EnrollStudentToCourse(studentId, course);
				DisplayStudents(course);
			}
		} catch (Exception e) {
			e.printStackTrace();
			homePage();
			return;
		}

	}

	private static void EnrollStudentToCourse(String studentId, String course) {
		PreparedStatement stmt = null;
		try {
			stmt = con.prepareStatement("INSERT into COURSE_STUDENT values (?,?)");
			stmt.setString(1, course);
			stmt.setString(2, studentId);
			stmt.executeUpdate();
			System.out.println("Enrolled " + studentId + " to " + course);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			homePage();
			return;
		}
	}

	private static void enrollDropStudent() {
		PreparedStatement stmt = null;
		ResultSet rs = null;
		List<String> courses = new ArrayList<String>();
		System.out.println("Select Course to drop Student.");
		try {
			stmt = con.prepareStatement("SELECT COURSE_ID from COURSE where PROFESSOR_ID = ?");
			stmt.setString(1, username);
			rs = stmt.executeQuery();
			while (rs.next()) {
				courses.add(rs.getString("COURSE_ID"));
			}
			for (int i = 1; i <= courses.size(); i++) {
				System.out.println(i + ": " + courses.get(i - 1));
			}
			System.out.println("select 0 to go to previous page.");
			int choice = sc.nextInt();
			sc.nextLine();
			if (choice == 0) {
				homePage();
			} else {
				String course = courses.get(choice - 1);
				DisplayEnrolledStudents(course);

			}
		} catch (Exception e) {
			e.printStackTrace();
			homePage();
			return;
		}

	}

	private static void DisplayEnrolledStudents(String course) {
		PreparedStatement stmt = null;
		ResultSet rs = null;
		List<String> students = new ArrayList<String>();
		System.out.println("Select student to enroll/drop from :" + course);
		try {
			stmt = con.prepareStatement("SELECT STUDENT_ID from COURSE_STUDENT where COURSE_ID = ?");
			stmt.setString(1, course);
			rs = stmt.executeQuery();
			while (rs.next()) {
				students.add(rs.getString("STUDENT_ID"));
			}
			if (students.size() == 0) {
				System.out.println("No students enrolled");

			}
			System.out.println("select 0 to go to previous page.");
			for (int i = 1; i <= students.size(); i++) {
				System.out.println(i + ": " + students.get(i - 1));
			}

			int choice = sc.nextInt();
			sc.nextLine();
			if (choice == 0) {
				homePage();
			} else {
				String studentId = students.get(choice - 1);
				DropStudentFromCourse(studentId, course);
				DisplayEnrolledStudents(course);

			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		homePage();
	}

	private static void DropStudentFromCourse(String studentId, String course) {
		PreparedStatement stmt = null;
		try {
			stmt = con.prepareStatement("delete from COURSE_STUDENT where COURSE_ID = ? and STUDENT_ID= ?");
			stmt.setString(1, course);
			stmt.setString(2, studentId);
			stmt.executeUpdate();
			cg.closeStatement(stmt);
			System.out.println("Successfully dropped");
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}