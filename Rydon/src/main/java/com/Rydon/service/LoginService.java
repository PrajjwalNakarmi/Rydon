package com.Rydon.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.Rydon.config.DbConfig;
import com.Rydon.Model.UserModel;
import com.Rydon.Util.PasswordUtil;

/**
 * Service class for handling user login operations.
 */
public class LoginService {

    private Connection dbConn;
    private boolean isConnectionError = false;

    /**
     * Constructor initializes the database connection. Sets a flag if the connection fails.
     */
    public LoginService() {
        try {
            dbConn = DbConfig.getDbConnection();
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
            isConnectionError = true;
        }
    }
    /*
     * 1. Query the database.
		2. If user found:
    		-> Call validatePassword()
        		-> Try decrypt password
        		-> If decryption fails, fall back to plain password match
			3. If password correct:
    			-> Return full UserModel (userId + username)
			4. Else:
    			-> Return null (login failed)

     * */
    /**
     * Validates the user credentials against the database records.
     *
     * @param userModel the UserModel object containing username and password
     * @return UserModel if valid login, null if invalid login or connection error
     */
    public UserModel loginUser(UserModel userModel) {
        if (isConnectionError) {
            System.out.println("Database connection error!");
            return null;
        }

        String query = "SELECT user_id, username, password FROM user WHERE username = ?";
        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            stmt.setString(1, userModel.getUsername());
            ResultSet result = stmt.executeQuery();

            if (result.next()) {
                if (validatePassword(result, userModel)) {
                    UserModel authenticatedUser = new UserModel();
                    authenticatedUser.setUserId(result.getInt("user_id"));
                    authenticatedUser.setUsername(result.getString("username"));
                    return authenticatedUser;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Validates the password retrieved from the database.
     *
     * @param result    the ResultSet with user data
     * @param userModel the UserModel with input credentials
     * @return true if passwords match, false otherwise
     * @throws SQLException if database access error occurs
     */
    private boolean validatePassword(ResultSet result, UserModel userModel) throws SQLException {
        String dbUsername = result.getString("username");
        String dbPassword = result.getString("password");

        if (!dbUsername.equals(userModel.getUsername())) {
            return false;
        }

        String decryptedPassword = PasswordUtil.decrypt(dbPassword, dbUsername);

        if (decryptedPassword == null) {
            // Maybe stored password is plain text
            return dbPassword.equals(userModel.getPassword());
        } else {
            // Compare decrypted password
            return decryptedPassword.equals(userModel.getPassword());
        }
    }
}
