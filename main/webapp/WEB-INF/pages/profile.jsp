<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<c:if test="${empty sessionScope.loggedInUser}">
    <c:redirect url="/login" />
</c:if>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Profile - Rydon</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/profile.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/header.css" />
</head>
<body>

<!-- Include header -->
<jsp:include page="header.jsp" />

<!-- Profile Section -->
<section class="profile-section">
    <div class="profile-card">
        <c:choose>
		    <c:when test="${not empty sessionScope.loggedInUser.imagePath}">
		        <!-- Load the image from resources/images -->
		        <img src="${pageContext.request.contextPath}/resources/images/${sessionScope.loggedInUser.imagePath}" alt="User Avatar" class="avatar" />
		    </c:when>
		    <c:otherwise>
		        <img src="${pageContext.request.contextPath}/resources/images/npc.jpg" alt="Default Avatar" class="avatar" />
		    </c:otherwise>
		</c:choose>


        <h2><c:out value="${sessionScope.loggedInUser.fullName}" /></h2>
        <p class="email"><c:out value="${sessionScope.loggedInUser.email}" /></p>
        <p class="role">
            <c:choose>
                <c:when test="${sessionScope.loggedInUser.roleId == 1}">Admin</c:when>
                <c:otherwise>User</c:otherwise>
            </c:choose>
        </p>
    </div>

    <div class="profile-info">
        <h3>Account Information</h3>
        <c:if test="${not empty param.success}">
		    <div class="success-message">${param.success}</div>
		</c:if>
		
		<c:if test="${not empty error}">
		    <div class="error-message">${error}</div>
		</c:if>
        <form action="${pageContext.request.contextPath}/update" method="post" class="profile-form">
		    <label for="fullname">Full Name</label>
		    <input type="text" id="fullname" name="fullName" value="${sessionScope.loggedInUser.fullName}" required />
		
		    <label for="email">Email</label>
		    <input type="email" id="email" name="email" value="${sessionScope.loggedInUser.email}" required />
		
		    <label for="phone">Phone</label>
		    <input type="text" id="phone" name="phoneNumber" value="${sessionScope.loggedInUser.phoneNumber}" />
		
		    <label for="address">Address</label>
		    <input type="text" id="address" name="address" value="${sessionScope.loggedInUser.address}" />
		
		    <label for="password">Change Password</label>
		    <input type="password" id="password" name="password" placeholder="••••••••" />
		
		    <!-- Optional: Show username but readonly, as typically username isn't changed -->
		    <label for="username">Username</label>
		    <input type="text" id="username" name="username" value="${sessionScope.loggedInUser.username}" readonly />
		
		    <button type="submit">Update Profile</button>
		</form>

    </div>
</section>
<script>
    // Function to get query params
    function getQueryParam(name) {
        const url = new URL(window.location.href);
        return url.searchParams.get(name);
    }

    window.onload = function () {
        const success = getQueryParam("success");
        const error = getQueryParam("error");

        if (success) {
            alert(success);
            // Remove param from URL
            window.history.replaceState({}, document.title, window.location.pathname);
        }

        if (error) {
            alert("Error: " + error);
            window.history.replaceState({}, document.title, window.location.pathname);
        }
    };
</script>

</body>
</html>
