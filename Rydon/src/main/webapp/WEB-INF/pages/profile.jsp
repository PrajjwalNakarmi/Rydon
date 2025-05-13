<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Profile - Rydon</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/profile.css" />
</head>
<body>

  <!-- Include header -->
    <jsp:include page="header.jsp" />

<!-- Profile Section -->
<section class="profile-section">
    <div class="profile-card">
        <img src="${pageContext.request.contextPath}/images/default-avatar.png" alt="User Avatar" class="avatar" />
        <h2>John Doe</h2>
        <p class="email">johndoe@example.com</p>
        <p class="role">User</p>
    </div>

    <div class="profile-info">
        <h3>Account Information</h3>
        <form action="${pageContext.request.contextPath}/updateProfile" method="post" class="profile-form">
            <label for="fullname">Full Name</label>
            <input type="text" id="fullname" name="fullname" value="John Doe" required />

            <label for="email">Email</label>
            <input type="email" id="email" name="email" value="johndoe@example.com" required />

            <label for="phone">Phone</label>
            <input type="text" id="phone" name="phone" value="123-456-7890" />

            <label for="password">Change Password</label>
            <input type="password" id="password" name="password" placeholder="••••••••" />

            <button type="submit">Update Profile</button>
        </form>
    </div>
</section>

</body>
</html>
