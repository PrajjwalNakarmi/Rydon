<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.util.*, com.Rydon.Model.UserModel, com.Rydon.service.UserService" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Users - Rydon Admin</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/admin/manage.css" />
</head>
<body>

<%
    UserService userService = new UserService();
    List<UserModel> users = userService.getAllUsers();
%>

<!-- Include admin header -->
<jsp:include page="adminHeader.jsp" />

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
        <% if (users != null && !users.isEmpty()) {
            for (UserModel user : users) {
                String role = user.getRoleId() == 1 ? "Admin" : "User"; // adjust if needed
        %>
            <tr>
                <td><%= user.getUserId() %></td>
                <td><%= user.getFullName() %></td>
                <td><%= user.getEmail() %></td>
                <td><%= role %></td>
                <td>Active</td>
                <td>
                    <a href="${pageContext.request.contextPath}/admin/user/edit?id=<%= user.getUserId() %>" class="action-btn">Edit</a> | 
                    <a href="${pageContext.request.contextPath}/admin/user/deactivate?id=<%= user.getUserId() %>" class="action-btn">Deactivate</a>
                </td>
            </tr>
        <% }} else { %>
            <tr><td colspan="6" style="text-align:center;">No users found.</td></tr>
        <% } %>
        </tbody>
    </table>
</section>

</body>
</html>
