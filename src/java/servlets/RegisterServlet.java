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
import utils.Encode;

/**
 *
 * @author hp
 */
@WebServlet(name = "RegisterServlet", urlPatterns = {"/RegisterServlet"})
public class RegisterServlet extends HttpServlet {
    
    String fullname, username, email, pwd, profession;
    String[] qualifications, awards;
    int exp;
    
    private DatabaseHandler db;
    private Doctor doctor;
    
    List<String> errors;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        fullname = req.getParameter("name");
        username = req.getParameter("username");
        email = req.getParameter("email");
        pwd = req.getParameter("pwd");
        
        qualifications = req.getParameterValues("qualifications");
        profession = req.getParameter("professions");
        awards = req.getParameterValues("awards");
        exp = Integer.parseInt(req.getParameter("experience"));
        
        
        errors = new ArrayList<>();
        db = new DatabaseHandler();
        
        if (validate()) {
            populate();
            db.addUser(doctor);
            if (db.doctorExists(username, req, pwd)) {
                resp.sendRedirect("");
                close();
            }
        } else {
            HttpSession session = req.getSession();
            session.setAttribute("errors", errors);
            
            resp.sendRedirect("auth/register");
            
            close();
        }
        
        
    }
    
    
    private void populate() {
        doctor = new Doctor();
        
        try {
            doctor.setId(UUID.randomUUID().toString());
            doctor.setEmail(email);
            doctor.setExperience(exp);
            
            if (awards != null) {
                doctor.setAwards(String.join(", ", awards));
            }
            
            doctor.setFullname(fullname);
            doctor.setPassword(Encode.encode(pwd));
            doctor.setProfessions(profession);
            doctor.setUsername(username);
            
            if (qualifications != null) {
                doctor.setQualifications(String.join(", ", qualifications));
            }
            
        } catch(NullPointerException e) {}
        
        
    }
    
    private boolean validate() {
        boolean valid = true;
        
        if (fullname.isEmpty()) {
            errors.add("Fullname is empty");
        }
        
        if (username.isEmpty()) {
            errors.add("Username is empty!");
        }
        
        if (email.isEmpty()) {
            errors.add("Email is empty!");
        }
        
        if (!isValid(email)) {
            errors.add("Email is not valid!");
        }
        
        if (pwd.isEmpty()) {
            errors.add("Password is empty!");
        }
        
        if (db.usernameExists(username)) {
            errors.add("Username " + username + " already exists!");
        }
        
        if (!errors.isEmpty()) {
            valid = false;
        }
        
        return valid;
    }
    

    static boolean isValid(String email) {
      String regex = "^[\\w-_\\.+]*[\\w-_\\.]\\@([\\w]+\\.)+[\\w]+[\\w]$";
      return email.matches(regex);
   }
    
    private void close() {
        try {
            db.close();
        } catch(SQLException e) {
            e.printStackTrace();
        }
    }
    
}
