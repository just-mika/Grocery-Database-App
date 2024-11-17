package src;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final  long serialVersionUID = 1L;

  
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = "jdbc:mysql://@localhost:3306/grocery_database";
        String user = "root";
        String password = "123456"; //just edit this to put whatever password you set for your local MySQL server 

		try { //Needed because exceptions will be encountered which is pain
            System.out.println("Connecting to database...");
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(url, user, password);

            System.out.println("Successfully connected to database.");
            String pass=request.getParameter("Password"); //input from user through jsp
            
            PreparedStatement check=connection.prepareStatement("SELECT password FROM securitycheck WHERE password=?"); //sql + java statement for getting values from database
            check.setString(1, pass); //(1 -- first "?", <input from user>)
            ResultSet rs = check.executeQuery(); //Result checker for line 38, returns Boolean
           
            if(rs.next()) { //If true, then login successful, else false
            	RequestDispatcher rd=request.getRequestDispatcher("Home.jsp"); //Takes user to Home Page
            	rd.forward(request, response);
            	
            }
            else {
            	RequestDispatcher rd=request.getRequestDispatcher("Login.jsp"); //Returns user to Login Page
            	rd.forward(request, response);
            }
            connection.close(); //Has to be at the end of the try block to avoid exception issues
        }
        catch (Exception e){
            System.out.println(e);
        }
	}

}
