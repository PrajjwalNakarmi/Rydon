package com.Rydon.service;

import java.sql.Connection;
import java.sql.Date;
import java.time.LocalDate;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.Rydon.config.DbConfig;
import com.Rydon.Model.*;

public class RegisterService {

    private Connection dbConn;

    /**
     * Constructor initializes the database connection.
     */
    public RegisterService() {
        try {
            this.dbConn = DbConfig.getDbConnection();
        } catch (SQLException | ClassNotFoundException ex) {
            System.err.println("Database connection error: " + ex.getMessage());
            ex.printStackTrace();
        }
    }

    /**
     * Fetches all available roles from the database.
     */
    public List<RoleModel> getRoles() {
        if (dbConn == null) {
            System.err.println("Database connection is not available!");
            return null;
        }

        String query = "SELECT * FROM role";

        try {
            PreparedStatement stmt = dbConn.prepareStatement(query);
            ResultSet result = stmt.executeQuery();

            List<RoleModel> roles = new ArrayList<>();

            while (result.next()) {
                roles.add(new RoleModel(result.getInt("role_id"), result.getString("role_name")));
            }

            return roles;
        } catch (SQLException e) {
            System.err.println("Error fetching roles: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Fetches all available bicycle models.
     */
    public List<ModelModel> getBicycleModels() {
        if (dbConn == null) {
            System.err.println("Database connection is not available!");
            return null;
        }

        String query = "SELECT * FROM model";

        try {
            PreparedStatement stmt = dbConn.prepareStatement(query);
            ResultSet result = stmt.executeQuery();

            List<ModelModel> models = new ArrayList<>();

            while (result.next()) {
                models.add(new ModelModel(result.getInt("model_id"), result.getString("model_name"),
                        result.getString("category"), result.getDouble("hourly_rate")));
            }

            return models;
        } catch (SQLException e) {
            System.err.println("Error fetching bicycle models: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Registers a new user.
     */
    public Boolean addUser(UserModel user) {
        if (dbConn == null) {
            System.err.println("Database connection is not available.");
            return null;
        }

        String insertQuery = "INSERT INTO user (full_name, email, password, phone_number, address, role_id, registration_date, updated_at, username, image_path) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            PreparedStatement stmt = dbConn.prepareStatement(insertQuery);
            stmt.setString(1, user.getFullName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPassword());
            stmt.setString(4, user.getPhoneNumber());
            stmt.setString(5, user.getAddress());
            stmt.setInt(6, 2); // Default role_id for user
            stmt.setDate(7, Date.valueOf(LocalDate.now()));
            stmt.setDate(8, Date.valueOf(LocalDate.now()));
            stmt.setString(9, user.getUsername());
            stmt.setString(10, user.getImagePath()); // Set image path here

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error adding user: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }


    /**
     * Registers a new bicycle.
     */
    public Boolean addBicycle(BicycleModel bicycle) {
        if (dbConn == null) {
            System.err.println("Database connection is not available.");
            return null;
        }

        String insertQuery = "INSERT INTO bicycle (location, condition_rating, model_id, image_path) "
                + "VALUES (?, ?, ?, ?)";

        try {
            PreparedStatement stmt = dbConn.prepareStatement(insertQuery);
            stmt.setString(1, bicycle.getLocation());
            stmt.setInt(2, bicycle.getConditionRating());
            stmt.setInt(3, bicycle.getModelId());
            stmt.setString(4, bicycle.getImagePath());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error adding bicycle: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Creates a new rental record.
     */
    public Boolean addRental(RentalsModel rental) {
        if (dbConn == null) {
            System.err.println("Database connection is not available.");
            return null;
        }

        String insertQuery = "INSERT INTO rental (start_time, end_time, rental_status, created_at) "
                + "VALUES (?, ?, ?, ?)";

        try {
            PreparedStatement stmt = dbConn.prepareStatement(insertQuery);
            stmt.setString(1, rental.getStartTime());
            stmt.setString(2, rental.getEndTime());
            stmt.setString(3, rental.getRentalStatus());
            stmt.setString(4, rental.getCreatedAt());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error creating rental: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Records a payment.
     */
    public Boolean addPayment(PaymentModel payment) {
        if (dbConn == null) {
            System.err.println("Database connection is not available.");
            return null;
        }

        String insertQuery = "INSERT INTO payment (total_amount, payment_status, payment_method_id, payment_date) "
                + "VALUES (?, ?, ?, ?)";

        try {
            PreparedStatement stmt = dbConn.prepareStatement(insertQuery);
            stmt.setDouble(1, payment.getTotalAmount());
            stmt.setString(2, payment.getPaymentStatus());
            stmt.setInt(3, payment.getPaymentMethodId());
            stmt.setString(4, payment.getPaymentDate());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error recording payment: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Adds a review.
     */
    public Boolean addReview(ReviewModel review) {
        if (dbConn == null) {
            System.err.println("Database connection is not available.");
            return null;
        }

        String insertQuery = "INSERT INTO review (rating, comments, review_date) "
                + "VALUES (?, ?, ?)";

        try {
            PreparedStatement stmt = dbConn.prepareStatement(insertQuery);
            stmt.setInt(1, review.getRating());
            stmt.setString(2, review.getComments());
            stmt.setString(3, review.getReviewDate());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error adding review: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }
}
