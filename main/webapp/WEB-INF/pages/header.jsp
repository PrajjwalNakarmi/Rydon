<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/header.css" />

<div class="navbar">
    <div class="logo">Rydon</div>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/home">Home</a>
        <a href="${pageContext.request.contextPath}/product">Rent a Bike</a>
        <a href="${pageContext.request.contextPath}/myrentals">My Rentals</a>
        <a href="${pageContext.request.contextPath}/aboutus">About Us</a>
        <a href="${pageContext.request.contextPath}/contactus">Contact Us</a>

        <c:choose>
            <c:when test="${not empty sessionScope.loggedInUser}">
                <div class="profile-menu">
                    <div class="profile-header">
                        <span class="profile-icon">👤</span>
                        <span class="profile-name">${sessionScope.loggedInUser.fullName}</span>
                    </div>
                    <div class="dropdown-menu">
                        <a href="${pageContext.request.contextPath}/profile">View Profile</a>
                        <a href="${pageContext.request.contextPath}/profile">Edit Profile</a>
                        <a href="${pageContext.request.contextPath}/logout">Logout</a>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/login">Login</a>
                <a href="${pageContext.request.contextPath}/register">Signup</a>
            </c:otherwise>
        </c:choose>
    </div>
</div>
