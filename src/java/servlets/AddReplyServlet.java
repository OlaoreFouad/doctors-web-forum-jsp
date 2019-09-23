/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import data.DatabaseHandler;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.Reply;

/**
 *
 * @author hp
 */
@WebServlet(name = "AddReplyServlet", urlPatterns = {"/AddReplyServlet"})
public class AddReplyServlet extends HttpServlet {
    
    private DatabaseHandler db;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String content = req.getParameter("content");
        String did = req.getParameter("did");
        String tid = req.getParameter("tid");
        
        if (content.isEmpty() || content == null || req.getSession().getAttribute("currentUser") == null) {
            resp.sendRedirect("topic.jsp?id=" + tid);
            return;
        }
        
        db = new DatabaseHandler();
        Reply reply = new Reply();
        reply.setId(UUID.randomUUID().toString());
        reply.setContent(content);
        reply.setDid(did);
        reply.setTid(tid);
        reply.setCreatedAt(System.currentTimeMillis());
        
        db.addReply(reply);
        
        resp.sendRedirect("topic.jsp?id=" + tid);
        
    }

    
    

}
