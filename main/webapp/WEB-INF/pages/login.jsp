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

            <form action="${pageContext.request.contextPath}/login" method="post" onsubmit="return validateLogin();">
                <div class="input-group">
                    <i class="fa fa-user"></i>
                    <input type="text" name="username" id="username" placeholder="Username" required>
                </div>
                <div class="input-group">
                    <i class="fa fa-lock"></i>
                    <input type="password" name="password" id="password" placeholder="Password" required>
                </div>

                <button type="submit">Login</button>

                <div class="extra-links">
                    <a href="${pageContext.request.contextPath}/forgotpassword">Forgot Password?</a>
                    <a href="${pageContext.request.contextPath}/register">Create Account</a>
                </div>
            </form>
        </div>
    </div>

    <script>
        function validateLogin() {
            const username = document.getElementById("username").value.trim();
            const password = document.getElementById("password").value;

            if (username === "") {
                alert("Please enter your username.");
                return false;
            }

            if (password === "") {
                alert("Please enter your password.");
                return false;
            }

            if (password.length < 6) {
                alert("Password must be at least 6 characters long.");
                return false;
            }

            return true;
        }
    </script>
</body>
</html>
