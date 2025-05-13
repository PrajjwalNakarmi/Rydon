<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/header.css?v=4" />

<div class="navbar">
    <div class="logo">Rydon</div>
    <div class="nav-links">
        <a href="<%=request.getContextPath()%>/home">Home</a>
        <a href="<%=request.getContextPath()%>/product">Rent a Bike</a>
        <a href="<%=request.getContextPath()%>/myrentals">My Rentals</a>

        <%
            Object userObj = session.getAttribute("user");
            boolean isLoggedIn = userObj != null && !userObj.toString().trim().isEmpty();

            if (isLoggedIn) {
        %>
            <!-- Show profile dropdown -->
            <div class="profile-menu">
                <div class="profile-header">
                    <span class="profile-icon">👤</span>
                    <span class="profile-name"><%= userObj.toString() %></span>
                </div>
                <div class="dropdown-menu">
                    <a href="<%=request.getContextPath()%>/profile">View Profile</a>
                    <a href="<%=request.getContextPath()%>/profile/edit">Edit Profile</a>
                    <a href="<%=request.getContextPath()%>/logout">Logout</a>
                </div>
            </div>
        <%
            } else {
        %>
            <!-- Show login/signup if not logged in -->
            <a href="<%=request.getContextPath()%>/login">Login</a>
            <a href="<%=request.getContextPath()%>/signup">Signup</a>
        <%
            }
        %>
    </div>
</div>
