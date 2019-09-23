<%-- 
    Document   : admin
    Created on : Sep 23, 2019, 11:16:12 AM
    Author     : hp
--%>

<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <link href="https://fonts.googleapis.com/css?family=Nunito+Sans:300,400,600,700,800" rel="stylesheet">

        <!-- icon -->
        <link rel="stylesheet" href="fonts/icons/main/mainfont/style.css">
        <link rel="stylesheet" href="fonts/icons/font-awesome/css/font-awesome.min.css">

        <!-- Vendor -->
<!--        <link rel="stylesheet" href="vendor/bootstrap/v3/bootstrap.min.css">
        <link rel="stylesheet" href="vendor/bootstrap/v4/bootstrap-grid.css">-->
        
        <link rel="stylesheet" href="css/bootstrap/dist/css/bootstrap.min.css" />
        
        <!-- Custom -->
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/admin.css">
        <title>Admin Dashboard</title>
        
        <%
            
            Doctor doctor = null;

            if (session.getAttribute("currentUser") != null) {
                doctor = (Doctor) session.getAttribute("currentUser");
                if (!doctor.getIsAdmin()) {
                    response.sendRedirect("");
                }
                
            } else {
                response.sendRedirect("");
            }

        %>
        
    </head>
    <body>
        
        <%@include file="shared/header/header.jsp" %>
        
        <%

            List<Doctor> doctors = data.getDoctors();
            out.println("<h3>Welcome, " + doctor.getFullname() + "</h3>");

        %>
        
        
        <div class="container">
            <table class="table table-bordered">
                <thead>
                  <tr>
                    <th scope="col">#</th>
                    <th scope="col">Fullname</th>
                    <th scope="col">Username</th>
                    <th scope="col">Profession</th>
                    <th scope="col">Email</th>
                    <th scope="col">Action</th>
                  </tr>
                </thead>
                <tbody>
                    <%
                    if (doctors != null || !doctors.isEmpty()) {
                        int count = 0;
                        for (Doctor doc: doctors) {
                            ++count;
                    %>
                  <tr>
                    <th scope="row">${ count }</th>
                    <td><%= doc.getFullname() %></td>
                    <td><%= doc.getUsername() %></td>
                    <td><%= doc.getProfessions()%></td>
                    <td><%= doc.getEmail()%></td>
                            <td> <button class="btn btn-danger">
                                <a href="<%= "DeleteUserServlet?id=" + doc.getId() %>">Delete</a>
                        </button> </td>
                  </tr>
                  <% }} %>
                </tbody>
            </table>
        </div>
                <!-- JAVA SCRIPT -->
        <script src="vendor/jquery/jquery.min.js"></script>
        <script src="vendor/velocity/velocity.min.js"></script>
        <script src="js/app.js"></script>
    </body>
</html>
