<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Rydon - Home</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/home.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/header.css" />
</head>
<body>

        <!-- Include header -->
    <jsp:include page="header.jsp" />

    <!-- Hero Banner -->
    <section class="banner" style="background-image: url('${pageContext.request.contextPath}/resources/images/cycle1.jpeg');">
        <div class="banner-content">
            <h1>Discover the City on Two Wheels</h1>
            <p>Flexible rentals. Affordable rides. Anywhere, anytime.</p>
            <a href="${pageContext.request.contextPath}/product" class="banner-button">Start Exploring</a>
        </div>
    </section>

    <!-- Welcome Section -->
    <section class="welcome">
	    <h2>Why Ride with Rydon?</h2>
	    <div class="features">
	        <div class="feature">
	            <i class="fas fa-bicycle icon"></i>
	            <h3>Wide Range of Bikes</h3>
	            <p>Choose from city bikes, e-bikes, mountain bikes, and more.</p>
	        </div>
	        <div class="feature">
	            <i class="fas fa-tags icon"></i>
	            <h3>Affordable Prices</h3>
	            <p>Transparent pricing without hidden fees.</p>
	        </div>
	        <div class="feature">
	            <i class="fas fa-mobile-alt icon"></i>
	            <h3>Easy Booking</h3>
	            <p>Rent in just a few taps. It's that simple.</p>
	        </div>
	    </div>
	</section>


    <!-- Call to Action -->
    <section class="cta">
        <h2>Ready to Ride?</h2>
        <a href="#" class="rent-button">Find Your Bike</a>
    </section>
    <jsp:include page="footer.jsp" />

</body>
</html>
