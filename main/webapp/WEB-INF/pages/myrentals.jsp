<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Rentals - Rydon</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/product.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/header.css" />
</head>
<body>

    <!-- Include header -->
    <jsp:include page="header.jsp" />

	<!-- Banner -->
	<section class="rent-banner">
	    <h1>My Rentals</h1>
	    <p>Track your rented bikes and their status here.</p>
	</section>
	
	<!-- Rental Table -->
	<section class="bike-list" style="width: 95%; margin: 40px auto; padding: 20px;">
	    <table border="0" cellpadding="10" cellspacing="0" style="width: 100%; text-align: center; background: white; border-collapse: collapse; box-shadow: 0 2px 8px rgba(0,0,0,0.1);">
	        <thead style="background-color: #ff6600; color: white;">
	            <tr>
	                <th>Rental ID</th>
	                <th>Bike Name</th>
	                <th>Start Date</th>
	                <th>End Date</th>
	                <th>Status</th>
	                <th>Created At</th>
	            </tr>
	        </thead>
	        <tbody>
	            <tr>
	                <td>1001</td>
	                <td>City Bike</td>
	                <td>2025-04-25</td>
	                <td>2025-04-26</td>
	                <td><span class="status active">Active</span></td>
	                <td>2025-04-24 10:30 AM</td>
	            </tr>
	            <tr>
	                <td>1002</td>
	                <td>Mountain Bike</td>
	                <td>2025-04-20</td>
	                <td>2025-04-21</td>
	                <td><span class="status completed">Completed</span></td>
	                <td>2025-04-18 02:15 PM</td>
	            </tr>
	            <tr>
	                <td>1003</td>
	                <td>E-Bike</td>
	                <td>2025-04-10</td>
	                <td>2025-04-11</td>
	                <td><span class="status cancelled">Cancelled</span></td>
	                <td>2025-04-09 05:00 PM</td>
	            </tr>
	        </tbody>
	    </table>
	</section>

  <!-- Include footer -->
    <jsp:include page="footer.jsp" />

</body>
</html>
	