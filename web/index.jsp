<%-- 
    Document   : index
    Created on : Aug 27, 2019, 3:03:01 PM
    Author     : Foodie Olaore
--%>

<%@page import="models.Reply"%>
<%@page import="models.Topic"%>
<%@page import="java.util.List"%>
<%@page import="data.DatabaseHandler"%>
<%@page import="models.Doctor"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en-US">
    <head>
        <link href="https://fonts.googleapis.com/css?family=Nunito+Sans:300,400,600,700,800" rel="stylesheet">

        <!-- icon -->
        <link rel="stylesheet" href="fonts/icons/main/mainfont/style.css">
        <link rel="stylesheet" href="fonts/icons/font-awesome/css/font-awesome.min.css">

        <!-- Vendor -->
        <link rel="stylesheet" href="vendor/bootstrap/v3/bootstrap.min.css">
        <link rel="stylesheet" href="vendor/bootstrap/v4/bootstrap-grid.css">
        
        <!-- Custom -->
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/index.css"/>
        
        <title>Doctor's Web Forum</title>
    </head>
    <body>
        
        <%
            Doctor doctor;
            if (session.getAttribute("currentUser") != null) {
                doctor = (Doctor) session.getAttribute("currentUser");
            }

            DatabaseHandler db = new DatabaseHandler();
            List<Topic> topics = db.getTopics();

        %>
        
        <%@ include file="shared/header/header.jsp" %>
        <%
            if (session.getAttribute("currentUser") != null) {
        %>
        <section class="section-disclaimer">
            <h4> <img src="fonts/icons/main/Pinned.svg" /> &nbsp;&nbsp;Welcome to the Community!</h4>
            <p>
                Congratulations, you have found the Community!
                Before you make a new topic or post, please read community guidelines.
            </p>
        </section>
        <% } %>
        
        <section class="section-posts container">
            <%
                if (topics == null || topics.isEmpty()) {
                    out.println("<span>No topics are available!</span>");
                }
            %>
            <div class="posts">
                <div class="posts__head">
                    <div class="posts__topic">Topic</div>
                    <div class="posts__category">Category</div>
                    <div class="posts__users">User</div>
                    <div class="posts__replies">Replies</div>
                    <div class="posts__views">Views</div>
                    <div class="posts__activity">Activity</div>
                </div>
                <%
                    for (Topic topic: topics) {
                        List<Reply> replies = db.getReplies(topic.getId());
                        Doctor doc = db.getDoctor(topic.getDid());
                %>
                <div class="posts__body">
                    <div class="posts__item">
                        <div class="posts__section-left">
                            <div class="posts__topic">
                                <div class="posts__content">
                                    <a href="<%= "topic.jsp?id=" + topic.getId() %>">
                                        <h3><%= topic.getTitle() %></h3>
                                    </a>
                                </div>
                            </div>
                            <div class="posts__category"><a href="#" class="category"><i class="bg-368f8b"></i><%= topic.getCategories() %></a></div>
                        </div>
                        <div class="posts__section-right">
                            <div class="posts__users">  
                                <div>
                                    <a href="#" class="avatar"><img 
                                            src="<%= "fonts/icons/avatars/" + doc.getUsername().toUpperCase().charAt(0) + ".svg" %>" 
                                            alt="avatar"></a>
                                </div>
                            </div>
                            <div class="posts__replies"><%= replies.size()  %></div>
                            <div class="posts__views"><%= topic.getViews() %></div>
                            <div class="posts__activity">0</div>
                        </div>
                    </div>
                </div>
                <%
                    }
                %>
            </div>
        </section>
        
        <!-- JAVA SCRIPT -->
        <script src="vendor/jquery/jquery.min.js"></script>
        <script src="vendor/velocity/velocity.min.js"></script>
        <script src="js/app.js"></script>
    </body>
</html>
