<%-- 
    Document   : profile
    Created on : Sep 6, 2019, 7:51:46 AM
    Author     : hp
--%>

<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="data.DatabaseHandler"%>
<%@page import="models.Topic"%>
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
        <link rel="stylesheet" href="vendor/bootstrap/v3/bootstrap.min.css">
        <link rel="stylesheet" href="vendor/bootstrap/v4/bootstrap-grid.css">
        
        <%
            Doctor doctor = null;
            int awards = 0;
            List<Topic> topics = null;
            DatabaseHandler db = null;
            
            if (session.getAttribute("currentUser") != null) {
                doctor = (Doctor) session.getAttribute("currentUser");
                awards = doctor.getAwards().split(",").length;
                
                db = new DatabaseHandler();
                topics = db.getTopicsByUser(doctor.getId());
            } else {
                response.sendRedirect("");
            }
        %>
        
        <!-- Custom -->
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/profile.css"/>
        <title>Profile - <%= doctor.getUsername() %></title>
    </head>
    <body>
        <%@ include file="shared/header/header.jsp" %>
        
        
        
        <section class="section-profile">
            <h3 class="raleway-regular">Profile</h3>
            <div class="profile-data-grid">
                <div class="profile-data-first">
                    <div class="profile-data">
                        <div class="profile-data-top">
                            
                            <img src="<%= "fonts/icons/avatars/" + doctor.getUsername().toUpperCase().charAt(0) + ".svg" %>"/><br/>
                            <span class="profile-fullname">
                                <b><%= doctor.getFullname() %></b>
                            </span><br/>
                            <span class="profile-profession"><%= doctor.getProfessions() %></span><br/>
                        </div>
                        <div class="profile-data-bottom">
                            <div class="other-data">
                                <span class="other-data-key">Posts</span>
                                <span class="other-data-value">0</span>
                            </div>
                            <div class="other-data">
                                <span class="other-data-key">Experience (years)</span>
                                <span class="other-data-value"><%= doctor.getExperience() %></span>
                            </div>
                            <div class="other-data">
                                <span class="other-data-key">Awards</span>
                                <span class="other-data-value"><%= awards %></span>
                            </div>
                        </div>
                    </div>
                    <div class="profile-data-about">
                        <p>About Me</p>
                        <div class="about-data">
                            <span class="about-data-key">Email</span><br/>
                            <span class="about-data-value"><%= doctor.getEmail() %>!</span>
                        </div>
                        <div class="about-data">
                            <span class="about-data-key">Qualifications</span><br/>
                            <span class="about-data-value"><%= doctor.getQualifications() %></span>
                        </div>
                        <div class="about-data">
                            <span class="about-data-key">Awards</span><br/>
                            <span class="about-data-value"><%= doctor.getAwards() %></span>
                        </div>
                        
                    </div>
                </div>
                <div class="profile-data-activity">
                    <p>Activity</p>
                    <% if (topics.isEmpty()) { %><span>No posts yet!</span><% } %>
                    <div class="posts">
                        <%
                            if (!topics.isEmpty()) {
                                for (Topic topic: topics) {
                        %>
                        <div class="post">
                            <div class="post-top">
                                <img class="post-image" src="<%= "fonts/icons/avatars/" + d.getUsername().toUpperCase().charAt(0) + ".svg" %>"/>
                                <p class="post-data">
                                    <span class="post-author"><%= topic.getTitle() %></span><br/>
                                    <span class="post-date"><%= new SimpleDateFormat("dd/mm/yyyy").format(new Date(topic.getCreatedAt())) %></span>
                                </p><br/>
                            </div>
                            <div class="post-bottom">
                                <p class="post-content">
                                    <%= topic.getContent() %>
                                </p>
                                <p class="post-comments">
                                    Comments (<%= db.getReplies(topic.getId()).size() %>)
                                </p>
                            </div>
                        </div>
                        <%
                                }
                            }
                        %>
                    </div>
                </div>
            </div>
        </section>
    </body>
    
    <!-- JAVA SCRIPT -->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/velocity/velocity.min.js"></script>
    <script src="js/app.js"></script>
</html>
