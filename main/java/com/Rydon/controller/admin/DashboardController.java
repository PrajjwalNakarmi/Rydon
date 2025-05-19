
package com.Rydon.controller.admin;

import com.Rydon.Model.BicycleModel;
import com.Rydon.Model.ModelModel;
import com.Rydon.service.DashboardService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(asyncSupported = true, urlPatterns = {"/dashboard"})
public class DashboardController extends HttpServlet {
    private DashboardService dashboardService;

    @Override
    public void init() throws ServletException {
        dashboardService = new DashboardService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	System.out.println("Sucessfully Edited the detial!!!");
        if ("/edit".equals(request.getServletPath())) {
            String idStr = request.getParameter("id");
            int id;
            try {
                id = Integer.parseInt(idStr);
            } catch (NumberFormatException e) {
                response.setContentType("application/json");
                response.getWriter().write("{\"success\":false,\"message\":\"Invalid ID\"}");
                return;
            }

            BicycleModel bicycle = dashboardService.getBicycleById(id);
            List<ModelModel> models = dashboardService.getAllModels();
            if (bicycle == null) {
                response.setContentType("application/json");
                response.getWriter().write("{\"success\":false,\"message\":\"Bicycle not found\"}");
                return;
            }

            response.setContentType("application/json");
            String json = "{\"success\":true,\"bicycle\":{\"bicycleId\":" + bicycle.getBicycleId() +
                ",\"location\":\"" + (bicycle.getLocation() != null ? bicycle.getLocation() : "") +
                "\",\"conditionRating\":" + bicycle.getConditionRating() +
                ",\"modelId\":" + bicycle.getModelId() +
                ",\"imagePath\":\"" + (bicycle.getImagePath() != null ? bicycle.getImagePath() : "") +
                "\"},\"models\":[";
            for (int i = 0; i < models.size(); i++) {
                ModelModel m = models.get(i);
                json += "{\"modelId\":" + m.getModelId() + ",\"modelName\":\"" + m.getModelName() + "\"}";
                if (i < models.size() - 1) json += ",";
            }
            json += "]}";
            response.getWriter().write(json);
            return;
        }

        request.getRequestDispatcher("/WEB-INF/pages/admin/dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        String action = request.getParameter("action");

        if (action == null) {
            response.getWriter().write("{\"success\":false,\"message\":\"No action specified\"}");
            return;
        }

        try {
            if ("add".equals(action)) {
                String location = request.getParameter("location");
                String conditionRatingStr = request.getParameter("conditionRating");
                String modelIdStr = request.getParameter("modelId");
                String imagePath = request.getParameter("imagePath");

                if (location == null || location.isEmpty()) {
                    response.getWriter().write("{\"success\":false,\"message\":\"Location required\"}");
                    return;
                }
                int conditionRating = Integer.parseInt(conditionRatingStr);
                int modelId = Integer.parseInt(modelIdStr);

                BicycleModel bike = new BicycleModel(0, location, conditionRating, modelId, imagePath);
                int id = dashboardService.addBicycleWithId(bike);
                if (id == -1) {
                    response.getWriter().write("{\"success\":false,\"message\":\"Add failed\"}");
                    return;
                }

                request.setAttribute("successMessage", "Bicycle added with ID: " + id);
                request.getRequestDispatcher("/WEB-INF/pages/admin/dashboard.jsp").forward(request, response);
            } else if ("update".equals(action)) {
                String bicycleIdStr = request.getParameter("bicycleId");
                String location = request.getParameter("location");
                String conditionRatingStr = request.getParameter("conditionRating");
                String modelIdStr = request.getParameter("modelId");
                String imagePath = request.getParameter("imagePath");

                int bicycleId = Integer.parseInt(bicycleIdStr);
                int conditionRating = Integer.parseInt(conditionRatingStr);
                int modelId = Integer.parseInt(modelIdStr);

                boolean success = dashboardService.updateBicycle(bicycleId, location, conditionRating, modelId, imagePath);
                response.getWriter().write("{\"success\":" + success + ",\"message\":\"" + (success ? "Updated" : "Update failed") + "\"}");
            } else if ("delete".equals(action)) {
                String bicycleIdStr = request.getParameter("bicycleId");
                int bicycleId = Integer.parseInt(bicycleIdStr);

                boolean success = dashboardService.deleteBicycle(bicycleId);
                response.getWriter().write("{\"success\":" + success + ",\"message\":\"" + (success ? "Deleted" : "Delete failed") + "\"}");
            } else {
                response.getWriter().write("{\"success\":false,\"message\":\"Invalid action\"}");
            }
        } catch (Exception e) {
            response.getWriter().write("{\"success\":false,\"message\":\"Error: " + e.getMessage() + "\"}");
        }
    }
}
