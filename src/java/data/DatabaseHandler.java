/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package data;

import utils.DBUtils;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import models.Doctor;
import models.Topic;
import utils.Encode;

/**
 *
 * @author hp
 */
public class DatabaseHandler {
    
    private Connection connection;
    private PreparedStatement statement;
    
    private DateFormat dateFormat;
    
    /**
     * Constructor for the database handler, instantiates the connection object and uses the SQLServerDriver.
    */
    public DatabaseHandler() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost/webForum", "root", "");
        } catch(ClassNotFoundException|SQLException e) {
            System.out.println("Problem encountered!");
            e.printStackTrace();
        }
    }
    
    /*
        Register a new user and adding the credentials to the database!
    */
    public void addUser(Doctor doctor) {
        
        String insertQuery = "INSERT INTO doctors VALUES(?, ?, ?, ?, ?, ?, ?, ? ,?, ?)";
        
        if (connection != null) {
            System.out.println("Reaching here!");
                try {
                    System.out.println("Reaching here too!");
                    statement = connection.prepareStatement(insertQuery);

                    statement.setString(DBUtils.KEY_ID, doctor.getId());
                    statement.setString(DBUtils.KEY_AWARDS, doctor.getAwards());
                    statement.setString(DBUtils.KEY_EMAIL, doctor.getEmail());
                    statement.setInt(DBUtils.KEY_EXP, doctor.getExperience());
                    statement.setString(DBUtils.KEY_FULLNAME, doctor.getFullname());
                    statement.setString(DBUtils.KEY_USERNAME, doctor.getUsername().toLowerCase());
                    statement.setString(DBUtils.KEY_PROF, doctor.getProfessions());
                    statement.setString(DBUtils.KEY_QUAL, doctor.getQualifications());
                    statement.setString(DBUtils.KEY_PASSWORD, doctor.getPassword());
                    statement.setInt(DBUtils.KEY_ISADMIN, 0);

                    int a = statement.executeUpdate();
                } catch(SQLException e) {
                    e.printStackTrace();
                }
        }
    }
    
    /*
        This method retrieves a user instance to know if they actually exist, and returns the instance
    */
    public boolean doctorExists(String username, HttpServletRequest req, String password) {
        Doctor doctor = null;
        
        if (connection != null) {
                try {
                statement = connection.prepareStatement("SELECT * FROM doctors WHERE username = ? AND password = ?");
                statement.setString(1, username);
                statement.setString(2, Encode.encode(password));

                ResultSet rs = statement.executeQuery();
                if (rs != null) {
                    if (rs.next()) {
                        doctor = new Doctor();
                        doctor.setAwards(rs.getString(DBUtils.KEY_AWARDS));
                        doctor.setEmail(rs.getString(DBUtils.KEY_EMAIL));
                        doctor.setExperience(rs.getInt(DBUtils.KEY_EXP));
                        doctor.setFullname(rs.getString(DBUtils.KEY_FULLNAME));
                        doctor.setId(rs.getString(DBUtils.KEY_ID));
                        doctor.setPassword(rs.getString(DBUtils.KEY_PASSWORD));
                        doctor.setProfessions(rs.getString(DBUtils.KEY_PROF));
                        doctor.setQualifications(rs.getString(DBUtils.KEY_QUAL));
                        doctor.setUsername(rs.getString(DBUtils.KEY_USERNAME));
                        doctor.setIsAdmin(rs.getInt(DBUtils.KEY_ISADMIN) == 0 ? false : true);

                        HttpSession session = req.getSession();
                        session.setAttribute("currentUser", doctor);
                    }
                }
            } catch(SQLException e) {
                e.printStackTrace();
            }
        }
        
        if (doctor != null) {
            return true;
        } else {
            return false;
        }
        
    }
    
    public boolean doctorExists(String username, HttpServletRequest req, String password, boolean isAdmin) {
        Doctor doctor = null;
        
        if (connection != null) {
                try {
                
                if (isAdmin) {
                    statement = connection.prepareStatement("SELECT * FROM doctors WHERE username = ? AND password = ? AND isAdmin = ?");
                    statement.setString(1, username);
                    statement.setString(2, Encode.encode(password));
                    statement.setInt(3, isAdmin ? 1 : 0);
                } else {
                    statement = connection.prepareStatement("SELECT * FROM doctors WHERE username = ? AND password = ?");
                    statement.setString(1, username);
                    statement.setString(2, Encode.encode(password));
                }

                ResultSet rs = statement.executeQuery();
                if (rs != null) {
                    if (rs.next()) {
                        doctor = new Doctor();
                        doctor.setAwards(rs.getString(DBUtils.KEY_AWARDS));
                        doctor.setEmail(rs.getString(DBUtils.KEY_EMAIL));
                        doctor.setExperience(rs.getInt(DBUtils.KEY_EXP));
                        doctor.setFullname(rs.getString(DBUtils.KEY_FULLNAME));
                        doctor.setId(rs.getString(DBUtils.KEY_ID));
                        doctor.setPassword(rs.getString(DBUtils.KEY_PASSWORD));
                        doctor.setProfessions(rs.getString(DBUtils.KEY_PROF));
                        doctor.setQualifications(rs.getString(DBUtils.KEY_QUAL));
                        doctor.setUsername(rs.getString(DBUtils.KEY_USERNAME));
                        doctor.setIsAdmin(rs.getInt(DBUtils.KEY_ISADMIN) == 0 ? false : true);

                        HttpSession session = req.getSession();
                        session.setAttribute("currentUser", doctor);
                    }
                }
            } catch(SQLException e) {
                e.printStackTrace();
            }
        }
        
        if (doctor != null) {
            return true;
        } else {
            return false;
        }
        
    }
    
    public boolean usernameExists(String username) {
        boolean exists = false;
        
        if (connection != null) {
            System.out.println("Connection inst is not null!");
            try {
                statement = connection.prepareStatement("SELECT * FROM doctors WHERE username = ?");
                statement.setString(1, username);
                
                ResultSet rs = statement.executeQuery();
                if (rs != null) {
                    System.out.println("ResultSet is not null!");
                    while(rs.next()) {
                        System.out.println(rs.getString(DBUtils.KEY_USERNAME));
                        exists = true;
                    }
                }
            } catch(SQLException e) {}
        }
        
        return exists;
    }
    
    public void addTopic(Topic topic) {
        try {
            statement = connection.prepareStatement("INSERT INTO topics VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
            
            statement.setString(DBUtils.KEY_TOPIC_ID, topic.getId());
            statement.setString(DBUtils.KEY_TOPIC_TITLE, topic.getTitle());
            statement.setString(DBUtils.KEY_TOPIC_CONTENT, topic.getContent());
            statement.setLong(DBUtils.KEY_TOPIC_CREATEDAT, topic.getCreatedAt());
            statement.setString(DBUtils.KEY_TOPIC_CATEGORIES, topic.getCategories());
            statement.setString(DBUtils.KEY_TOPIC_TAGS, topic.getTags());
            statement.setString(DBUtils.KEY_DID, topic.getDid());
            statement.setInt(DBUtils.KEY_TOPIC_VIEWS, topic.getViews());
            
            int a = statement.executeUpdate();
        } catch(SQLException e) {
            e.printStackTrace();
        }
    }
    
    public List<Topic> getTopics() {
        List<Topic> topics = new ArrayList<>();
        
        try {
            statement = connection.prepareStatement("SELECT * FROM topics");
            
            ResultSet rs = statement.executeQuery();
            
            if (rs != null) {
                while(rs.next()) {
                    Topic topic = new Topic();
                    
                    topic.setCategories(rs.getString(DBUtils.KEY_TOPIC_CATEGORIES));
                    topic.setContent(rs.getString(DBUtils.KEY_TOPIC_CONTENT));
                    topic.setCreatedAt(rs.getLong(DBUtils.KEY_TOPIC_CREATEDAT));
                    topic.setTitle(rs.getString(DBUtils.KEY_TOPIC_TITLE));
                    topic.setDid(rs.getString(DBUtils.KEY_DID));
                    topic.setTags(rs.getString(DBUtils.KEY_TOPIC_TAGS));
                    topic.setId(rs.getString(DBUtils.KEY_TOPIC_ID));
                    topic.setViews(rs.getInt(DBUtils.KEY_TOPIC_VIEWS));
                    
                    topics.add(topic);
                }
                close();
            }
            
        } catch(SQLException e) {
            e.printStackTrace();
        }
        return topics;
        
    }
    
    public List<Topic> getTopicsByUser(String did) {
        List<Topic> topics = new ArrayList<>();
        
        if (connection != null) {
            try {
                statement = connection.prepareStatement("SELECT * FROM topics WHERE did = ?");
                System.out.println("Did: " + did);
                statement.setString(1, did);
                
                ResultSet rs = statement.executeQuery();
                
                if (rs != null) {
                    while(rs.next()) {
                        Topic topic = new Topic();
                        
                        topic.setDid(did);
                        topic.setContent(rs.getString(DBUtils.KEY_TOPIC_CONTENT));
                        topic.setTitle(rs.getString(DBUtils.KEY_TOPIC_TITLE));
                        topic.setCategories(rs.getString(DBUtils.KEY_TOPIC_CATEGORIES));
                        topic.setTags(rs.getString(DBUtils.KEY_TOPIC_TAGS));
                        topic.setId(rs.getString(DBUtils.KEY_TOPIC_ID));
                        topic.setCreatedAt(rs.getLong(DBUtils.KEY_TOPIC_CREATEDAT));
                        topic.setViews(rs.getInt(DBUtils.KEY_TOPIC_VIEWS));
                        
                        topics.add(topic);
                    }
                }
                close();
                
            } catch(SQLException e) {
                e.printStackTrace();
            }
        }
        
        return topics;
    }
    
    public void close() throws SQLException {
        if (connection != null) {
            connection.close();
        }
    }
    
}
