<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Rentals - Rydon Admin</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/admin/manage.css" />
</head>
<body>

<!-- Include admin header -->
<jsp:include page="adminHeader.jsp" />
<!-- Page Title -->
<section class="section-title">
    <h1>Manage Rentals</h1>
</section>

<!-- Table -->
<section class="table-section">
    <table>
        <thead>
            <tr>
                <th>Rental ID</th>
                <th>User</th>
                <th>Bike</th>
                <th>Start Time</th>
                <th>End Time</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <!-- Example Rentals -->
            <tr>
                <td>101</td>
                <td>John Doe</td>
                <td>City Bike</td>
                <td>2025-04-25 10:00</td>
                <td>2025-04-25 18:00</td>
                <td>Completed</td>
                <td><a href="#" class="action-btn">View</a></td>
            </tr>
            <tr>
                <td>102</td>
                <td>Jane Smith</td>
                <td>Mountain Bike</td>
                <td>2025-04-26 12:00</td>
                <td>2025-04-26 20:00</td>
                <td>Active</td>
                <td><a href="#" class="action-btn">End Rental</a></td>
            </tr>
        </tbody>
    </table>
</section>

</body>
</html>
