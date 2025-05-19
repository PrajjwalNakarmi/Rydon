
package com.Rydon.service;

import com.Rydon.Model.BicycleModel;
import com.Rydon.Model.ModelModel;
import com.Rydon.config.DbConfig;

import java.sql.*;
import java.util.*;
import java.util.logging.Logger;

public class DashboardService {
    private static final Logger LOGGER = Logger.getLogger(DashboardService.class.getName());
    private Connection dbConn;
    private boolean isConnectionError = false;

    public DashboardService() {
        try {
            dbConn = DbConfig.getDbConnection();
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.severe("Failed to initialize database connection: " + e.getMessage());
            isConnectionError = true;
        }
    }

    public List<BicycleModel> getAllBicycles() {
        if (isConnectionError) {
            LOGGER.warning("Cannot retrieve bicycles due to connection error");
            return null;
        }

        String query = "SELECT bicycle_id, location, condition_rating, model_id, image_path FROM bicycle";
        List<BicycleModel> list = new ArrayList<>();

        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(new BicycleModel(
                    rs.getInt("bicycle_id"),
                    rs.getString("location"),
                    rs.getInt("condition_rating"),
                    rs.getInt("model_id"),
                    rs.getString("image_path")
                ));
            }
            return list;
        } catch (SQLException e) {
            LOGGER.severe("Error retrieving bicycles: " + e.getMessage());
            return null;
        }
    }

    public List<ModelModel> getAllModels() {
        if (isConnectionError) {
            LOGGER.warning("Cannot retrieve models due to connection error");
            return null;
        }

        String query = "SELECT model_id, model_name, category, hourly_rate FROM model";
        List<ModelModel> list = new ArrayList<>();

        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Double hourlyRate = rs.getObject("hourly_rate") != null ? rs.getDouble("hourly_rate") : null;
                list.add(new ModelModel(
                    rs.getInt("model_id"),
                    rs.getString("model_name"),
                    rs.getString("category"),
                    hourlyRate
                ));
            }
            return list;
        } catch (SQLException e) {
            LOGGER.severe("Error retrieving models: " + e.getMessage());
            return null;
        }
    }

    public int getTotalBicycles() {
        if (isConnectionError) return 0;

        String query = "SELECT COUNT(*) AS total FROM bicycle";
        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return rs.getInt("total");
            return 0;
        } catch (SQLException e) {
            LOGGER.severe("Error counting bicycles: " + e.getMessage());
            return 0;
        }
    }

    public int getGoodConditionBicycles() {
        if (isConnectionError) return 0;

        String query = "SELECT COUNT(*) AS total FROM bicycle WHERE condition_rating >= 7";
        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return rs.getInt("total");
            return 0;
        } catch (SQLException e) {
            LOGGER.severe("Error counting good condition bicycles: " + e.getMessage());
            return 0;
        }
    }

    public int addBicycleWithId(BicycleModel bike) {
        if (isConnectionError) {
            LOGGER.warning("Cannot add bicycle due to connection error");
            return -1;
        }

        String query = "INSERT INTO bicycle (location, condition_rating, model_id, image_path) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = dbConn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, bike.getLocation());
            stmt.setInt(2, bike.getConditionRating());
            stmt.setInt(3, bike.getModelId());
            stmt.setString(4, bike.getImagePath());
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1);
                    }
                }
            }
            LOGGER.warning("No rows affected when adding bicycle");
            return -1;
        } catch (SQLException e) {
            LOGGER.severe("Error adding bicycle: " + e.getMessage());
            return -1;
        }
    }

    public BicycleModel getBicycleById(int id) {
        if (isConnectionError) return null;

        String query = "SELECT bicycle_id, location, condition_rating, model_id, image_path FROM bicycle WHERE bicycle_id = ?";
        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new BicycleModel(
                    rs.getInt("bicycle_id"),
                    rs.getString("location"),
                    rs.getInt("condition_rating"),
                    rs.getInt("model_id"),
                    rs.getString("image_path")
                );
            }
            return null;
        } catch (SQLException e) {
            LOGGER.severe("Error retrieving bicycle by ID: " + e.getMessage());
            return null;
        }
    }

    public boolean updateBicycle(int id, String location, int conditionRating, int modelId, String imagePath) {
        if (isConnectionError) return false;

        String query = "UPDATE bicycle SET location = ?, condition_rating = ?, model_id = ?, image_path = ? WHERE bicycle_id = ?";
        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            stmt.setString(1, location);
            stmt.setInt(2, conditionRating);
            stmt.setInt(3, modelId);
            stmt.setString(4, imagePath);
            stmt.setInt(5, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.severe("Error updating bicycle: " + e.getMessage());
            return false;
        }
    }

    public boolean deleteBicycle(int id) {
        if (isConnectionError) return false;

        String query = "DELETE FROM bicycle WHERE bicycle_id = ?";
        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.severe("Error deleting bicycle: " + e.getMessage());
            return false;
        }
    }

    public Map<String, Integer> getMonthlyUserRegistrations() {
        if (isConnectionError) return null;

        String query = """
            SELECT MONTH(registration_date) AS month, COUNT(*) AS total
            FROM user
            WHERE YEAR(registration_date) = YEAR(CURDATE())
            GROUP BY MONTH(registration_date)
            ORDER BY month
        """;
        Map<String, Integer> userRegistrations = new LinkedHashMap<>();
        String[] months = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};

        for (String monthName : months) {
            userRegistrations.put(monthName, 0);
        }

        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                int monthIndex = rs.getInt("month") - 1;
                int count = rs.getInt("total");
                if (monthIndex >= 0 && monthIndex < 12) {
                    userRegistrations.put(months[monthIndex], count);
                }
            }
            return userRegistrations;
        } catch (SQLException e) {
            LOGGER.severe("Error retrieving user registrations: " + e.getMessage());
            return null;
        }
    }

    public int getTotalUsers() {
        if (isConnectionError) return 0;

        String query = "SELECT COUNT(*) AS total FROM user";
        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return rs.getInt("total");
            return 0;
        } catch (SQLException e) {
            LOGGER.severe("Error counting users: " + e.getMessage());
            return 0;
        }
    }

    public int getActiveRentals() {
        if (isConnectionError) return 0;

        String query = "SELECT COUNT(*) AS total FROM rentals WHERE rental_status = 'available'";
        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return rs.getInt("total");
            return 0;
        } catch (SQLException e) {
            LOGGER.severe("Error counting active rentals: " + e.getMessage());
            return 0;
        }
    }

    public double getTotalRevenue() {
        if (isConnectionError) return 0;

        String query = "SELECT SUM(total_amount) AS total FROM payment";
        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return rs.getDouble("total");
            return 0;
        } catch (SQLException e) {
            LOGGER.severe("Error calculating total revenue: " + e.getMessage());
            return 0;
        }
    }
}
