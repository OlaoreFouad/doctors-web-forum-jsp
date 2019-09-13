/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import data.DatabaseHandler;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.Doctor;
import models.Topic;

/**
 *
 * @author hp
 */
@WebServlet(name = "CreateTopicServlet", urlPatterns = {"/CreateTopicServlet"})
public class CreateTopicServlet extends HttpServlet {
    
    private String title, content;
    private String tags, category;
    
    private List<String> errors;
    private Doctor doctor;

    private DatabaseHandler db;
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        title = req.getParameter("title");
        content = req.getParameter("content");
        tags = req.getParameter("tags");
        category = req.getParameter("category");
        
        errors = new ArrayList();
        db = new DatabaseHandler();
        
        if (validate()) {
            doctor = (Doctor) req.getSession().getAttribute("currentUser");
            if (doctor != null) {
                addTopic();
                close();   
            }
            resp.sendRedirect("");
        } else {
            HttpSession session = req.getSession();
            session.setAttribute("errors", errors);
            
            resp.sendRedirect("create-topic.jsp");
        }
        
    }
    
    private void addTopic() {
        Topic topic = new Topic();
        topic.setId(UUID.randomUUID().toString());
        topic.setCategories(category);
        topic.setContent(content);
        topic.setTitle(title);
        topic.setCreatedAt(System.currentTimeMillis());
        topic.setTags(tags);
        topic.setDid(doctor.getId());
        topic.setViews(0);
        
        db.addTopic(topic);
        
    }
    
    private boolean validate() {
        boolean valid = true;
        
        if (title.isEmpty()) {
            errors.add("Title is empty!");
        }
        
        if (content.isEmpty()) {
            errors.add("Content is empty!");
        }
        
        if (!errors.isEmpty()) {
            valid = false;
        }
        
        return valid;
    }
    
    private void close() {
        try {
            db.close();
        } catch(SQLException e) {
            e.printStackTrace();
        }
    }

    
}
