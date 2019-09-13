<%-- 
    Document   : login
    Created on : Aug 28, 2019, 6:52:43 AM
    Author     : hp
--%>

<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login to your account</title>
        <link rel="stylesheet" href="./login.css">
        
        <!-- icon -->
        <link rel="stylesheet" href="../../fonts/icons/main/mainfont/style.css">
        <link rel="stylesheet" href="../../fonts/icons/font-awesome/css/font-awesome.min.css">
    </head>
    <body>
        
        <%
            if (session.getAttribute("currentUser") != null) {
                response.sendRedirect("");
            }
        %>
        
        <a href="../..">
            <button class="back-button">
                <i class="fa fa-arrow-left"></i> Back
            </button>
        </a>
        
        <%
            List<String> errors = null;
            if (session.getAttribute("errors") != null) {
                errors = (List<String>) session.getAttribute("errors");
                session.invalidate();
            }
        %>
        <h1 class="login-header raleway-regular">Login.</h1>
        <div class="login-header-secondary"><small class="raleway-regular">continue from where you left off!</small></div>
        <div class="login-card">
            <form method="post" action="../../LoginServlet">
                <input type="text" name="username" placeholder="e.g John Doe" class="login-fields"/>
                <input type="password" name="pwd" placeholder="e.g your password" class="login-fields"/>
                <input value="isAdmin" name="isAdmin" type="checkbox"/>  I am an administrator<br>
                <%
                    if (errors != null) {
                        out.println("<div>");
                        for (String error: errors) {
                            out.println("<span class=\"error-msg\">" + error + "</span><br/>");
                        }
                        out.println("</div>");
                    }
                %>
                
                <button class="btn" type="submit">Login</button><br>
                <a href="../register" class="signup-link">
                    <small>Don't have an account? Sign up.</small>
                </a>
            </form>
        </div>
    </body>
</html>
