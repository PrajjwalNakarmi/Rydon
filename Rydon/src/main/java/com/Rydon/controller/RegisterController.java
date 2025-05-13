package com.Rydon.controller;

import java.io.IOException;

import com.Rydon.Model.UserModel;
import com.Rydon.Util.PasswordUtil;
import com.Rydon.service.RegisterService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class RegisterController
 */
/**
 * Servlet implementation class RegistrationController
 */

@WebServlet(asyncSupported = true, urlPatterns = { "/register" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
maxFileSize = 1024 * 1024 * 10, // 10MB
maxRequestSize = 1024 * 1024 * 50) // 50MB

public class RegisterController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private RegisterService registerService;

    public RegisterController() {
        super();
        registerService = new RegisterService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Read form data
        String name = request.getParameter("name");
        String username = request.getParameter("username");
        String phoneNumber = request.getParameter("phoneNumber");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String password = request.getParameter("password");

        // Create user model
        UserModel user = new UserModel();
        user.setFullName(name);
        user.setUsername(username);
        user.setPhoneNumber(phoneNumber);
        user.setEmail(email);
        user.setAddress(address);
        user.setPassword(PasswordUtil.encrypt(username, password));

        // Save user
        boolean isRegistered = registerService.addUser(user);

        if (isRegistered) {
            // Success - redirect to login page
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            // Failure - stay on register page with error
            request.setAttribute("error", "Registration failed. Try again!");
            request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
        }
    }
}
