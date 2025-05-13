<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Users - Rydon Admin</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/admin/manage.css" />
</head>
<body>

<!-- Navbar -->
<div class="navbar">
    <div class="logo">Rydon Admin</div>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/dashboard">Dashboard</a>
        <a href="${pageContext.request.contextPath}/manageuser">Manage Users</a>
        <a href="${pageContext.request.contextPath}/manageproduct">Manage Rentals</a>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </div>
</div>

<!-- Page Title -->
<section class="section-title">
    <h1>Manage Users</h1>
</section>

<!-- Table -->
<section class="table-section">
    <table>
        <thead>
            <tr>
                <th>User ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Role</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <!-- Example Users -->
            <tr>
                <td>1</td>
                <td>John Doe</td>
                <td>john@example.com</td>
                <td>User</td>
                <td>Active</td>
                <td><a href="#" class="action-btn">Edit</a> | <a href="#" class="action-btn">Deactivate</a></td>
            </tr>
            <tr>
                <td>2</td>
                <td>Admin User</td>
                <td>admin@rydon.com</td>
                <td>Admin</td>
                <td>Active</td>
                <td><a href="#" class="action-btn">Edit</a> | <a href="#" class="action-btn">Deactivate</a></td>
            </tr>
        </tbody>
    </table>
</section>

</body>
</html>
