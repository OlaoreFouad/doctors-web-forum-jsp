<%-- 
    Document   : register
    Created on : Aug 28, 2019, 6:56:59 AM
    Author     : hp
--%>

<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register</title>
        
        <!-- icon -->
        <link rel="stylesheet" href="../../fonts/icons/main/mainfont/style.css">
        <link rel="stylesheet" href="../../fonts/icons/font-awesome/css/font-awesome.min.css">
        
        <link rel="stylesheet" href="register.css"/>
    </head>
    <body>
        
        <%
            if (session.getAttribute("currentUser") != null) {
                response.sendRedirect("../../");
            }
        %>
        
        <%! 
            private String[] qualifications = { 
                "Master of Clinical Medicine(MCM)", "Master of Medical Science (MMSc, MMedSc)",
                "Master of Medicine (MM, MMed)", "Master of Philosophy (MPhil)",
                "Master of Surgery (MS, MSurg, MChir, MCh, ChM, CM)", "Doctor of Clinical Medicine (DCM)"
            };

            private String[] professions = {
                "Physicians", "Nurses", "Optometrists", "Psychologists", "Pharmacists", "Physical therapists", "Paramedics"
            };


            private String[] awards = {
                "Albany Medical Center Prize", "APUA Leadership Award", "Baly Medal", "John Howland Award",
                "Canada Gairdner Wightman Award", "Cloëtta Prize", "Albert Lasker Award for Basic Medical Research",
                "Lasker-Koshland Special Achievement Award in Medical Science"
            };

            private int[] exps = { 0, 1, 2, 3, 4 };

            private String[] experience = {
                "Less than a year", "1+ years", "2+ years", "3+ years", "Above 4 years"
            };
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
        <h1 class="register-header raleway-regular">Register.</h1>
        <div class="register-header-secondary"><small class="raleway-regular">happy to have you onboard</small></div>
        <div class="register-card">
            <form method="post" action="../../RegisterServlet">
                
                <%
                    if (errors != null) {
                        out.println("<div>");
                        for (String error: errors) {
                            out.println("<span class=\"error-msg\">" + error + "</span><br/>");
                        }
                        out.println("</div>");
                    }
                %>
                
                <input type="text" name="name" placeholder="Full name" class="register-fields"/>
                <input type="text" name="username" placeholder="Username" class="register-fields"/>
                <input type="text" name="email" placeholder="Email" class="register-fields"/>
                <input type="password" name="pwd" placeholder="Password" class="register-fields"/>
                <label class="exp-label"><strong>Your Qualifications</strong></label><br>
                
                <%
                    for (String qual: qualifications) {
                %>
                
                <input type="checkbox" name="qualifications" value="<%= qual %>"/> <%= qual %> <br>
                
                <%
                    }
                %><br>
                
                <label class="exp-label"><strong>Your Profession</strong></label><br>
                
                <%
                    for (String prof: professions) {
                %>
                
                <input type="radio" name="professions" value="<%= prof %>"/> <%= prof %> <br>
                
                <%
                    }
                %>
                <br/>
                <label class="exp-label"><strong>I have been awarded: </strong></label><br>
                
                <%
                    for (String award: awards) {
                %>
                
                <input type="checkbox" name="awards" value="<%= award %>"/> <%= award %> <br>
                
                <%
                    }
                %>
                
                <br/>
                
                <label class="exp-label"><strong>Experience</strong></label><br><br>
                <select name="experience">
                <%
                    for (int i = 0; i < experience.length; i++) {
                %>
                
                <option value="<%= exps[i] %>"><%= experience[i] %></option>
                
                <%
                    }
                %>
                </select><br/>
                
                <button class="btn" type="submit">Register</button><br>
                <a href="../login" class="login-link">
                    <small>Already have an account? Login.</small>
                </a>
            </form>
        </div>
    </body>
</html>
