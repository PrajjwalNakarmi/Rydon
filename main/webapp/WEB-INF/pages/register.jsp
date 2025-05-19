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

            <!-- enctype added for file upload -->
            <form action="${pageContext.request.contextPath}/register" method="post" enctype="multipart/form-data">

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

                <!-- New image upload field -->
                <div class="input-group">
                    <i class="fa fa-image"></i>
                    <input type="file" name="profileImage" accept="image/*" required>
                </div>

                <button type="submit">Create Account</button>

                <div class="extra-links">
                    <a href="${pageContext.request.contextPath}/login">Already have an account? Login</a>
                </div>

            </form>
        </div>
    </div>
   	<script>
	    function validateRegisterForm() {
	        const name = document.forms[0]["name"].value.trim();
	        const username = document.forms[0]["username"].value.trim();
	        const password = document.forms[0]["password"].value;
	        const email = document.forms[0]["email"].value.trim();
	        const phoneNumber = document.forms[0]["phoneNumber"].value.trim();
	        const address = document.forms[0]["address"].value.trim();
	        const image = document.forms[0]["profileImage"].value;
	
	        const nameRegex = /^[a-zA-Z\s]+$/;
	        const usernameRegex = /^[a-zA-Z][a-zA-Z0-9]*$/;
	        const passwordRegex = /^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&]).{8,}$/;
	        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
	        const phoneRegex = /^98\d{8}$/;
	        const imageRegex = /\.(jpg|jpeg|png|gif)$/i;
	
	        if (!name || !nameRegex.test(name)) {
	            alert("Enter a valid name.");
	            return false;
	        }
	
	        if (!username || !usernameRegex.test(username)) {
	            alert("Username must start with a letter and be alphanumeric.");
	            return false;
	        }
	
	        if (!password || !passwordRegex.test(password)) {
	            alert("Password must contain at least one uppercase letter, one number, one symbol, and be 8+ characters.");
	            return false;
	        }
	
	        if (!email || !emailRegex.test(email)) {
	            alert("Enter a valid email address.");
	            return false;
	        }
	
	        if (!phoneNumber || !phoneRegex.test(phoneNumber)) {
	            alert("Phone number must be 10 digits and start with 98.");
	            return false;
	        }
	
	        if (!address) {
	            alert("Address is required.");
	            return false;
	        }
	
	        if (!image || !imageRegex.test(image)) {
	            alert("Only image files (jpg, jpeg, png, gif) are allowed.");
	            return false;
	        }
	
	        return true;
	    }
	
	    document.querySelector("form").onsubmit = validateRegisterForm;
	</script>
   	
</body>
</html>
