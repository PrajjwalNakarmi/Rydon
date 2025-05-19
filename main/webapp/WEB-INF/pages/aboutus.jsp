<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>About Us - Rydon</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/aboutus.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/header.css" />
</head>
<body>
	<!-- Include header -->
    <jsp:include page="header.jsp" />

    <section class="aboutus-wrapper">
        <div class="aboutus-card">
            <h1 class="title">About <span class="highlight">Rydon</span></h1>
            <p class="intro">At <strong>Rydon</strong>, we believe that every journey should be an adventure—fun, eco-friendly, and affordable.</p>

            <div class="aboutus-content">
                <p>Founded in 2020, Rydon was created to bring cycling back into people’s lives. From city commuting to weekend leisure rides, we offer a wide selection of bikes for rent tailored to your lifestyle.</p>

                <p>We’re more than just a rental company—we're a movement. Our mission is to make transportation greener and cities cleaner, one ride at a time. With flexible plans, quality bikes, and seamless booking, we aim to make your riding experience smooth and memorable.</p>

                <p>Join the Rydon community and pedal toward a smarter future.</p>
            </div>
        </div>
    </section>
	<!-- Include footer -->
    <jsp:include page="footer.jsp" />
</body>
</html>
