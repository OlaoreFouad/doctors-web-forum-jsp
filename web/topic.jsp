<%-- 
    Document   : topic
    Created on : Sep 16, 2019, 8:26:10 PM
    Author     : hp
--%>
<%@page import="models.Reply"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="models.Topic"%>
<%@page import="data.DatabaseHandler" errorPage="index.jsp"%>
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
        <!-- Custom -->
        <link rel="stylesheet" href="css/style.css">
        <title>Topic Title</title>
        <style>
            
        </style>
    </head>
    <body>
        
        <%
            
            String topicId = null;
            topicId = request.getParameter("id");
            
            Topic topic = null;
            DatabaseHandler db;
            
            String[] tagsBg = { "bg-4f80b0", "bg-424ee8", "bg-36b7d7" };
            db = new DatabaseHandler();
            topic = db.getTopic(topicId);
            
            db.addView(topic.getId(), topic.getViews());
            Doctor doc = db.getDoctor(topic.getDid());
            
            List<Reply> replies = db.getReplies(topicId);
            
            Doctor doctor = (Doctor) session.getAttribute("currentUser");

        %>
        
        <%@include file="shared/header/header.jsp" %>
        
        <div class="container">
            <div class="topics">
                <div class="topics__heading">
                    <h2 class="topics__heading-title"><%= topic.getTitle() %></h2>
                    <div class="topics__heading-info">
                        <a href="#" class="category"><i class="bg-3ebafa"></i> <%= topic.getCategories() %></a>
                        <% String[] tags = topic.getTags().split(", ");  %>
                        <div class="tags">
                            <% for(String tag: tags) { %>
                            <a href="#" class="<%= tagsBg[(int)Math.floor(Math.random() * 3)] %>"><%= tag %></a>
                            <% } %>
                        </div>
                    </div>
                </div>
                <div class="topics__body">
                    <div class="topics__content">
                        <div class="topic">
                            <div class="topic__head">
                                <div class="topic__avatar">
                                    <a href="#" class="avatar">
                                        <img src="<%= "fonts/icons/avatars/" + doc.getUsername().toUpperCase().charAt(0) + ".svg" %>" alt="avatar">
                                    </a>
                                </div>
                                <div class="topic__caption">
                                    <div class="topic__name">
                                        <a href="#"><%= doc.getFullname() %></a>
                                    </div>
                                        <div class="topic__date">
                                            <i class="icon-Watch_Later"></i><%= new SimpleDateFormat("dd MMM, yyyy").format(new Date(topic.getCreatedAt())) %>
                                        </div>
                                </div>
                            </div>  
                            <div class="topic__content">
                                <div class="topic__text">
                                    <p>
                                        <%= topic.getContent() %>
                                    </p>
                                </div>
                                <div class="topic__footer">
                                    <div class="topic__footer-likes">
                                        <div>
                                            <a href="#"><i class="icon-Watching"></i></a>
                                            <span><%= topic.getViews()+1 %></span>
                                        </div>
                                    </div>
                                    <div class="topic__footer-share">
                                        <div data-visible="desktop">
                                            <a href="#"><i class="icon-Share_Topic"></i></a>
                                            <a href="#"><i class="icon-Flag_Topic"></i></a>
                                            <a href="#"><i class="icon-Bookmark"></i></a>
                                        </div>
                                        <div data-visible="mobile">
                                            <a href="#"><i class="icon-More_Options"></i></a>
                                        </div>
                                        <a href="#"><i class="icon-Reply_Fill"></i></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <% if (!replies.isEmpty()) { %>
                        <% out.println("<h5>Replies (" + replies.size() + ")</h5>"); for(Reply reply: replies) { %>
                        <div class="topic">
                            <div class="topic__head">
                                <div class="topic__avatar">
                                    <a class="avatar"><img src="<%= "fonts/icons/avatars/" + db.getDoctor(reply.getDid()).getUsername().toUpperCase().charAt(0) + ".svg" %>" alt="avatar"></a>
                                </div>
                                <div class="topic__caption">
                                    <div class="topic__name">
                                        <a href="#"><%= db.getDoctor(reply.getDid()).getFullname() %></a>
                                    </div>
                                    <div class="topic__date">
                                        <div class="topic__user topic__user--pos-r">
                                            <i class="icon-Reply_Fill"></i>
                                            <a href="#" class="avatar"><img src="<%= "fonts/icons/avatars/" + db.getDoctor(topic.getDid()).getUsername().toUpperCase().charAt(0) + ".svg" %>" alt="avatar"></a>
                                            <a href="#" class="topic__user-name"><%= db.getDoctor(topic.getDid()).getFullname() %></a>
                                        </div>
                                            <i class="icon-Watch_Later"></i><%= new SimpleDateFormat("dd MMM, yyyy").format(new Date(reply.getCreatedAt())) %>
                                    </div>
                                </div>
                            </div>
                            <div class="topic__content">
                                <div class="topic__text">
                                    <p><%= reply.getContent() %></p>
                                </div>
                            </div>
                        </div>
                        <% }} %>
                    </div>
                </div>
            </div>
            <div class="add-reply">
                <form action="AddReplyServlet" method="post">
                <div class="create">
                    <input type="hidden" name="did" value="<%= doctor.getId() %>"/>
                    <input type="hidden" name="tid" value="<%= topic.getId() %>"/>
                    <div class="create__head">
                        <div class="create__title"><img src="fonts/icons/main/New_Topic.svg" alt="New topic">Add a reply.</div>
                    </div>
                    <div class="create__section create__textarea">
                        <label class="create__label" for="content">Your Reply</label>
                        <textarea class="form-control" id="content" name="content" placeholder="content goes here...."></textarea>
                    </div>
                    <div class="create__footer">
                        <button type="submit" style="background-color: transparent; outline: none; border: none">
                            <a class="create__btn-create btn btn--type-02">Reply</a>
                        </button>
                    </div>
                </div>
            </form>
            </div>
        </div>
                    <!-- JAVA SCRIPT -->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/velocity/velocity.min.js"></script>
    <script src="js/app.js"></script>
    </body>
</html>
