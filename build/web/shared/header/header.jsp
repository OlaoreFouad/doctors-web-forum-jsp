<%-- 
    Document   : header
    Created on : Aug 27, 2019, 3:05:28 PM
    Author     : hp
--%>

<%@page import="models.Doctor"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1">
        <meta name="keywords" content="HTML5 Template">
        <meta name="description" content="Responsive HTML5 Template">
        <meta name="author" content="author.com">
        <title>Doctor's Web Forum</title>
        <link rel="stylesheet" href="shared/header/header.css"/>
    </head>
    <body>
        <!-- HEADER -->
        
        <%
            Doctor d = null;
            if (session.getAttribute("currentUser") != null) {
                d = (Doctor) session.getAttribute("currentUser");
            }
        %>
        
        <header>
        <div class="header js-header js-dropdown">
            <div class="container">
                <div class="header__logo">
                    <h1>
                        <img src="fonts/icons/main/Logo_Forum.svg" alt="logo">
                    </h1>
                    <div class="header__logo-btn" data-dropdown-btn="logo">
                        Dokies<i class="icon-Arrow_Below"></i>
                    </div>
                </div>
                <div class="header__search">
                    <form action="#">
                        <label>
                            <i class="icon-Search js-header-search-btn-open"></i>
                            <input type="search" placeholder="Search all forums" class="form-control">
                        </label>
                    </form>
                    <div class="header__search-close js-header-search-btn-close"><i class="icon-Cancel"></i></div>
                </div>
                <%
                    if (session.getAttribute("currentUser") == null) {
                        
                %>
                <div class="auth-buttons">
                    <a href="auth/login">
                        <button type="button" class="btn btn-login">Login</button>
                    </a>
                    <a href="auth/register">
                        <button type="button" class="btn btn-register">Register</button>
                    </a>
                </div><% } %>
                <%
                    if (d != null) {
                        
                %>
                <div class="header__user">
                    <div class="header__user-btn" data-dropdown-btn="user">
                        <img src="<%= "fonts/icons/avatars/" + d.getUsername().toUpperCase().charAt(0) + ".svg" %>" alt="avatar">
                        <%= d.getUsername() %>
                    </div>
                    <nav class="dropdown dropdown--design-01" data-dropdown-list="user">
                        <div>
                            <ul class="dropdown__catalog">
                                <li><a href="profile.jsp">Profile</a></li>
                                <% if (d.getIsAdmin()) { %><li><a href="LogoutServlet">Admin Dashboard</a></li><% } %>
                                <li><a href="LogoutServlet">Logout</a></li>
                            </ul>
                        </div>
                    </nav>
                </div><% } %>
            </div>
            <%
                if (session.getAttribute("currentUser") != null) {
            %>
            <div class="header__offset-btn">
                <a href="create-topic.jsp"><img src="fonts/icons/main/New_Topic.svg" alt="New Topic"></a>
            </div>
            <%
                }
            %>
        </div>
    </header>
    </body>
</html>
