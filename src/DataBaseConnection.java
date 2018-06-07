
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Alexandra Spanou, icsd09134
 */
public class DataBaseConnection {
    private String serverURL;
    private String serverPort;
    private String serverSID;
    private String username;
    private String password;
    
    protected Connection conn;
    
    // --------------------------  Constructors --------------------------
    
    /**
     * Default values tou server
     */
    public DataBaseConnection(){
        serverURL = "";
        serverPort = "";
        serverSID = "";
        username = "";
        password = "";
    }

    /**
     * Pairnw oles tis times apo tin JSP
     * @param serverURL
     * @param serverPort
     * @param serverSID
     * @param username
     * @param password 
     */
    public DataBaseConnection(String serverURL, String serverPort, String serverSID, String username, String password) {
        this.serverURL = serverURL;
        this.serverPort = serverPort;
        this.serverSID = serverSID;
        this.username = username;
        this.password = password;
    }
    
    
    // -------------------------- Methods -------------------------- 
    
    /**
     * Methodos pou kanw establish to connection me tin PL/SQL
     */
    public boolean ConnectToDB(){
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver").newInstance();
            String connectionURL = "jdbc:oracle:thin:@" + serverURL + ":" + serverPort + ":" + serverSID;
//            System.out.println("Conn URL: " + connectionURL);
//            System.out.println("user: " + username + " pass: " + password);
            conn = DriverManager.getConnection(connectionURL, username, password);
            return true;
        
        } catch (ClassNotFoundException | InstantiationException | IllegalAccessException | SQLException ex) {
            Logger.getLogger(DataBaseConnection.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    
    
    
    
    
    
    
    // ------------- Getters & Setters -------------
    
    public Connection getConn() {
        return conn;
    }

    public void setConn(Connection conn) {
        this.conn = conn;
    }
}
