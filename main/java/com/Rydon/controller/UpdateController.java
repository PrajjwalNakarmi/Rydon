package com.Rydon.controller;



import com.Rydon.Model.UserModel;
import com.Rydon.service.UserService;
import com.Rydon.Util.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
/**
 * Servlet implementation class UpdateController
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/update" })
public class UpdateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateController() {
        super();
        // TODO Auto-generated constructor stub
    }

    private UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("UpdateController.doPost called");
        
        UserModel loggedInUser = (UserModel) SessionUtil.getAttribute(request, "loggedInUser");
        if (loggedInUser == null) {
            System.out.println("No logged in user, redirecting to login");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");
        String address = request.getParameter("address");
        String password = request.getParameter("password");

        System.out.println("Update info: " + fullName + ", " + email + ", " + phoneNumber + ", " + address);

        if (fullName == null || fullName.trim().isEmpty() || email == null || email.trim().isEmpty() || (phoneNumber == null || phoneNumber.trim().isEmpty() || address == null || address.trim().isEmpty())) {
            response.sendRedirect(request.getContextPath() + "/profile?error=Fields+cannot+be+Empty!!!+Pls+Fill+The+Form+Properly");
            return;
        }

        loggedInUser.setFullName(fullName);
        loggedInUser.setEmail(email);
        loggedInUser.setPhoneNumber(phoneNumber);
        loggedInUser.setAddress(address);

        if (password != null && !password.trim().isEmpty()) {
            loggedInUser.setPassword(password);
        }

        boolean updated = false;
        try {
            updated = userService.updateUser(loggedInUser);
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (updated) {
            SessionUtil.setAttribute(request, "loggedInUser", loggedInUser);
            System.out.println("Profile updated successfully");
            response.sendRedirect(request.getContextPath() + "/profile?success=Profile+updated+successfully");
        } else {
            System.out.println("Failed to update profile");
            response.sendRedirect(request.getContextPath() + "/profile?error=Failed+to+update+profile");
        }
    }

}
