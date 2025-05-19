<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<meta charset="UTF-8">
<title>Admin Panel</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/admin/adminHeader.css" />


<div class="navbar">
    <div class="logo">Rydon Admin</div>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/dashboard">Dashboard</a>
        <a href="${pageContext.request.contextPath}/manageuser">Manage Users</a>
        <a href="${pageContext.request.contextPath}/manageproduct">Manage Rentals</a>

        <div class="profile-menu">
            <div class="profile-header">
                <span class="profile-icon">👤</span>
                <span class="profile-name">${sessionScope.loggedInUser.fullName}</span>
            </div>
            <div class="dropdown-menu">
                <a href="${pageContext.request.contextPath}/profile">View Profile</a>
                <a href="${pageContext.request.contextPath}/admin/profile/edit">Edit Profile</a>
                <a href="${pageContext.request.contextPath}/logout">Logout</a>
            </div>
        </div>
    </div>
</div>



