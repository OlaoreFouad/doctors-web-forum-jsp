/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import data.DatabaseHandler;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author hp
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    private List<String> errors;
    private DatabaseHandler db;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String pwd = req.getParameter("pwd");
        
        String[] isAdmin = req.getParameterValues("isAdmin");
        
        HttpSession session = req.getSession();
        
        if (validate(username, pwd)) {
            db = new DatabaseHandler();
            if (db.doctorExists(username, req, pwd, isAdmin == null ? false : true)) {
                resp.sendRedirect("");
            } else {
                errors.add("User does not exist or you are not an admin!");
                session.setAttribute("errors", errors);
                resp.sendRedirect("auth/login");
            }
        } else {
            session.setAttribute("errors", errors);
            resp.sendRedirect("auth/login");
        }
    }
    
    private boolean validate(String username, String pwd) {
        boolean valid = false;
        errors = new ArrayList<>();
        
        if (username.isEmpty()) {
            errors.add("Username is empty!");
        }
        
        if (pwd.isEmpty()) {
            errors.add("Password is empty!");
        }
        
        if (errors.isEmpty()) {
            valid = true;
            return valid;
        }
        
        return valid;
        
    }
    
    
    
}
