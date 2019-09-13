<%-- 
    Document   : create-topic.jsp
    Created on : Sep 10, 2019, 4:12:16 PM
    Author     : hp
--%>

<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <!-- icon -->
        <link rel="stylesheet" href="fonts/icons/main/mainfont/style.css">
        <link rel="stylesheet" href="fonts/icons/font-awesome/css/font-awesome.min.css">

        <!-- Vendor -->
        <link rel="stylesheet" href="vendor/bootstrap/v3/bootstrap.min.css">
        <link rel="stylesheet" href="vendor/bootstrap/v4/bootstrap-grid.css">
        <!-- Custom -->
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/create-topic.css"/>
        <title>Create Topic</title>
    </head>
    <body>
        
        <% 
            if (session.getAttribute("currentUser") != null) {
                Doctor doctor = (Doctor) session.getAttribute("currentUser");
                int awards = doctor.getAwards().split(",").length;
            } else {
                response.sendRedirect("");
            }

              List<String> errors = null;

              if (session.getAttribute("errors") != null) {
                  errors = (List<String>) session.getAttribute("errors");
              }
        %>
        
        <%@ include file="shared/header/header.jsp" %>
        
        <!-- MAIN -->
    <main>
        <div class="container">
            <form action="CreateTopicServlet" method="post">
                <div class="create">
                    <div class="create__head">
                        <div class="create__title"><img src="fonts/icons/main/New_Topic.svg" alt="New topic">Create New Topic</div>
                    </div>
                    <div class="errors-pane">
                        <%
                            if (errors != null) {
                                for (String error: errors) {
                        %>
                            <span class="error-msg"><%= error %></span><br/>
                        <%
                                }
                                session.setAttribute("errors", null);
                            }
                        %>
                    </div>
                    <div class="create__section">
                        <label class="create__label" for="title">Title</label>
                        <input type="text" class="form-control" id="title" name="title" placeholder="Add here">
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="create__section">
                                <label class="create__label" for="category">Select Category</label>
                                <label class="custom-select">
                                    <select id="category" name="category">
                                        <option>Cat 1</option>
                                        <option>Cat 2</option>
                                        <option>Cat 3</option>
                                    </select>
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="create__section create__textarea">
                        <label class="create__label" for="content">Content</label>
                        <textarea class="form-control" id="content" name="content" placeholder="thread content goes here...."></textarea>
                    </div>
                    <div class="create__section">
                        <label class="create__label" for="tags">Add Tags</label>
                        <input type="text" class="form-control" name="tags" id="tags" placeholder="e.g. nature, science">
                    </div>
                    <div class="create__footer">
                        <a href="#" class="create__btn-cansel btn">Cancel</a>
                        <button type="submit" style="background-color: transparent; outline: none; border: none">
                            <a class="create__btn-create btn btn--type-02">Create Thread</a>
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </main>
        
    </body>
    <!-- JAVA SCRIPT -->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/velocity/velocity.min.js"></script>
    <script src="js/app.js"></script>
</html>
