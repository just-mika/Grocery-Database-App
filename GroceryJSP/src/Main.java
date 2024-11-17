import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class Main {
    public static void main(String[] args) {
        String url = "jdbc:mysql://@localhost:3306/grocery_database";
        String user = "root";
        String password = "123456"; //just edit this to put whatever password you set for your local MySQL server 

        try {
            System.out.println("Connecting to database...");
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(url, user, password);

            System.out.println("Successfully connected to database.");

            // sample statement
            // Statement statement = connection.createStatement();
            // ResultSet resultSet = statement.executeQuery(""select * from products");

            connection.close();
        }
        catch (Exception e){
            System.out.println(e);
        }
    }
}
