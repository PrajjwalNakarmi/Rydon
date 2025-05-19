package com.Rydon.controller;

import java.io.File;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.UUID;

import com.Rydon.Model.UserModel;
import com.Rydon.Util.PasswordUtil;
import com.Rydon.Util.ImageUtil;
import com.Rydon.service.RegisterService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ImageUtil imageUtil = new ImageUtil();  // create instance

        String name = request.getParameter("name");
        String username = request.getParameter("username");
        String phoneNumber = request.getParameter("phoneNumber");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String password = request.getParameter("password");

        Part profileImagePart = request.getPart("profileImage");

        String imageFileName = null;

        if (profileImagePart != null && profileImagePart.getSize() > 0) {
            imageFileName = imageUtil.getImageNameFromPart(profileImagePart);

            boolean isImageUploaded = imageUtil.uploadImage(profileImagePart, "", "");
            if (!isImageUploaded) {
                request.setAttribute("error", "Image upload failed!");
                request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
                return;
            }
        }

        UserModel user = new UserModel();
        user.setFullName(name);
        user.setUsername(username);
        user.setPhoneNumber(phoneNumber);
        user.setEmail(email);
        user.setAddress(address);
        user.setPassword(PasswordUtil.encrypt(username, password));
        user.setImagePath(imageFileName);

        boolean isRegistered = registerService.addUser(user);

        if (isRegistered) {
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            request.setAttribute("error", "Registration failed. Try again!");
            request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
        }
    }


    
    
}
