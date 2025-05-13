<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login - Rydon</title>
<link rel="stylesheet" type="text/css"
    href="${pageContext.request.contextPath}/css/login.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <div class="login-wrapper">
        <div class="left-section">
            <div class="logo">Rydon</div>
            <p class="tagline">Track, Manage & Ride Smart 🚴</p>
        </div>

        <div class="right-section">
            <h2>Sign In</h2>

            <form action="${pageContext.request.contextPath}/login" method="post">
                <div class="input-group">
                    <i class="fa fa-user"></i>
                    <input type="text" name="username" placeholder="Username" required>
                </div>
                <div class="input-group">
                    <i class="fa fa-lock"></i>
                    <input type="password" name="password" placeholder="Password" required>
                </div>

                <button type="submit">Login</button>

                <div class="extra-links">
                    <a href="${pageContext.request.contextPath}/forgotpassword">Forgot Password?</a>
                    <a href="${pageContext.request.contextPath}/register">Create Account</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>