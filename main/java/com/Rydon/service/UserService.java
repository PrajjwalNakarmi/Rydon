package com.Rydon.service;

import com.Rydon.Model.UserModel;
import com.Rydon.config.DbConfig;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserService {

    public List<UserModel> getAllUsers() {
        List<UserModel> users = new ArrayList<>();
        String query = "SELECT * FROM user"; // Replace 'users' with your actual table name if different

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                UserModel user = new UserModel();
                user.setUserId(rs.getInt("user_id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setPhoneNumber(rs.getString("phone_number"));
                user.setAddress(rs.getString("address"));
                user.setRoleId(rs.getInt("role_id"));
                user.setRegistrationDate(rs.getString("registration_date"));
                user.setUpdatedAt(rs.getString("updated_at"));
                user.setUsername(rs.getString("username"));
                user.setImagePath(rs.getString("image_path")); // Optional

                users.add(user);
            }

        } catch (Exception e) {
            e.printStackTrace(); // Replace with logging in production
        }

        return users;
    }
    
    public boolean updateUser(UserModel user) throws ClassNotFoundException {
        String sql = "UPDATE user SET full_name = ?, email = ?, phone_number = ?, address = ?, password = ?, updated_at = NOW() WHERE user_id = ?";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhoneNumber());
            ps.setString(4, user.getAddress());

            // For password, you should ideally encrypt/hash it before storing
            String passwordToStore = user.getPassword(); 
            // TODO: encrypt/hash passwordToStore if needed
            ps.setString(5, passwordToStore);

            ps.setInt(6, user.getUserId());

            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
