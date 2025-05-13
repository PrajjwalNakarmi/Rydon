<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register - Rydon</title>
<link rel="stylesheet" type="text/css"
    href="${pageContext.request.contextPath}/css/register.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <div class="register-container">
        <div class="header">
            <div class="logo">Rydon</div>
        </div>

        <div class="form-card">
            <h2>Create Account</h2>

            <form action="${pageContext.request.contextPath}/register" method="post">

                <div class="input-group">
                    <i class="fa fa-user"></i>
                    <input type="text" name="name" placeholder="Full Name" required>
                </div>

                <div class="input-group">
                    <i class="fa fa-user-circle"></i>
                    <input type="text" name="username" placeholder="Username" required>
                </div>
                
                <div class="input-group">
                    <i class="fa fa-lock"></i>
                    <input type="password" name="password" placeholder="Password" required>
                </div>

                <div class="input-group">
                    <i class="fa fa-envelope"></i>
                    <input type="email" name="email" placeholder="Email" required>
                </div>

                <div class="input-group">
                    <i class="fa fa-phone"></i>
                    <input type="text" name="phoneNumber" placeholder="Phone Number" required>
                </div>

                <div class="input-group">
                    <i class="fa fa-map-marker-alt"></i>
                    <input type="text" name="address" placeholder="Address" required>
                </div>

                

                <button type="submit">Create Account</button>

                <div class="extra-links">
                    <a href="${pageContext.request.contextPath}/login">Already have an account? Login</a>
                </div>

            </form>
        </div>
    </div>
</body>
</html>
