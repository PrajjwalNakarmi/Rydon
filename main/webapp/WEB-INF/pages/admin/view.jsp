<%@ page import="java.util.List" %>
<%@ page import="com.Rydon.Model.BicycleModel" %>
<%@ page import="com.Rydon.service.DashboardService" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Bicycles - Admin Dashboard</title>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/admin/view.css">
</head>
<body>
    <header>Rydon Admin - View Bicycles</header>
    <main>
        <%
            DashboardService service = new DashboardService();
            List<BicycleModel> bicycles = service.getAllBicycles();
            if (bicycles != null && !bicycles.isEmpty()) {
        %>
        <table>
            <tr>
                <th>ID</th>
                <th>Location</th>
                <th>Condition</th>
                <th>Model ID</th>
                <th>Image</th>
            </tr>
            <% for (BicycleModel bike : bicycles) { %>
            <tr>
                <td><%= bike.getBicycleId() %></td>
                <td><%= bike.getLocation() %></td>
                <td><%= bike.getConditionRating() %></td>
                <td><%= bike.getModelId() %></td>
                <td>
                    <% if (bike.getImagePath() != null && !bike.getImagePath().isEmpty()) { %>
                        <img src="<%= bike.getImagePath() %>" alt="Bike Image">
                    <% } else { %>
                        No Image
                    <% } %>
                </td>
            </tr>
            <% } %>
        </table>
        <% } else { %>
            <div class="no-data">No bicycles found in the system.</div>
        <% } %>
    </main>
</body>
</html>
