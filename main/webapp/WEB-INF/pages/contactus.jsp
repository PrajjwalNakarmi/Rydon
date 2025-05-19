<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Contact Us - Rydon</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/contactus.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/header.css" />

</head>
<body>
    <!-- Include header -->
    <jsp:include page="header.jsp" />

    <section class="contactus-wrapper">
        <div class="contactus-card">
            <h1 class="title">Get in <span class="highlight">Touch</span></h1>
            <p class="intro">Have questions, feedback, or need help? We’re here for you. Reach out to the Rydon team using the form below.</p>

            <form class="contact-form" onsubmit="return handleSubmit(event);">
                <div class="form-group">
                    <label for="name">Full Name</label>
                    <input type="text" name="name" id="name" placeholder="Your name" required>
                </div>
                
                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input type="email" name="email" id="email" placeholder="you@example.com" required>
                </div>
                
                <div class="form-group">
                    <label for="message">Your Message</label>
                    <textarea name="message" id="message" rows="5" placeholder="Type your message here..." required></textarea>
                </div>
                
                <button type="submit" class="submit-btn">Send Message</button>
            </form>
        </div>
    </section>

    <div id="successPopup" class="popup">
        ✅ Your message has been sent successfully!
    </div>

    <!-- Include footer -->
    <jsp:include page="footer.jsp" />

    <script>
        function handleSubmit(event) {
            event.preventDefault(); // Prevent default form submission

            const name = document.getElementById("name").value.trim();
            const email = document.getElementById("email").value.trim();
            const message = document.getElementById("message").value.trim();
            const emailPattern = /^[^@\s]+@[^@\s]+\.[^@\s]+$/;

            if (name === "") {
                alert("Please enter your name.");
                return false;
            }

            if (!emailPattern.test(email)) {
                alert("Please enter a valid email address.");
                return false;
            }

            if (message === "") {
                alert("Please enter your message.");
                return false;
            }

            // Show success popup
            const popup = document.getElementById("successPopup");
            popup.style.display = "block";

            // Optional: Clear form
            document.querySelector(".contact-form").reset();

            // Hide popup after 3 seconds
            setTimeout(() => {
                popup.style.display = "none";
            }, 3000);

            return false;
        }
    </script>
</body>
</html>
