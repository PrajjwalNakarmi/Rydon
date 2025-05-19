package com.Rydon.controller;

import java.io.IOException;


import com.Rydon.Model.UserModel;
import com.Rydon.service.LoginService;
import com.Rydon.Util.CookiesUtil;
import com.Rydon.Util.SessionUtil;
import com.Rydon.Util.RedirectUtil;
import com.Rydon.Util.ValidationUtil;
import com.Rydon.Util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.Rydon.Util.*;
/**
 * Controller for handling user login operations.
 * Validates user credentials and manages session and cookies upon successful login.
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/login" })
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private ValidationUtil validationUtil;
    private RedirectUtil redirectionUtil;
    private LoginService loginService;

    @Override
    public void init() throws ServletException {
        this.validationUtil = new ValidationUtil();
        this.redirectionUtil = new RedirectUtil();
        this.loginService = new LoginService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher(RedirectUtil.LOGIN_URL).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        if (validationUtil.isNullOrEmpty(username) || validationUtil.isNullOrEmpty(password)) {
            redirectionUtil.setMsgAndRedirect(req, resp, "error", "Please fill all the fields!", RedirectUtil.LOGIN_URL);
            return;
        }

        UserModel userModel = new UserModel();
        userModel.setUsername(username);
        userModel.setPassword(password);  // PASS plain password here

        UserModel loggedInUser = loginService.loginUser(userModel);

        if (loggedInUser != null) {
            handleSuccessfulLogin(req, resp, loggedInUser);
        } else {
            handleLoginFailure(req, resp);
        }
    }


    /**
     * Handles actions after a successful login.
     *
     * @param req           the HttpServletRequest
     * @param resp          the HttpServletResponse
     * @param loggedInUser  the authenticated UserModel
     * @throws IOException
     */
    private void handleSuccessfulLogin(HttpServletRequest req, HttpServletResponse resp, UserModel loggedInUser)
            throws IOException {
        SessionUtil.setAttribute(req, "username", loggedInUser.getUsername());
        SessionUtil.setAttribute(req, "userId", loggedInUser.getUserId());
        SessionUtil.setAttribute(req, "loggedInUser", loggedInUser);

        if ("admin".equalsIgnoreCase(loggedInUser.getUsername())) {
            CookiesUtil.addCookie(resp, "role", "admin", 5 * 30);
            resp.sendRedirect(req.getContextPath() + "/dashboard");
        } else {
            CookiesUtil.addCookie(resp, "role", "user", 5 * 30);
            resp.sendRedirect(req.getContextPath() + "/home");
        }
    }

    /**
     * Handles login failures by setting an error message and redirecting back to login page.
     *
     * @param req   the HttpServletRequest
     * @param resp  the HttpServletResponse
     * @throws ServletException
     * @throws IOException
     */
    private void handleLoginFailure(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        redirectionUtil.setMsgAndRedirect(req, resp, "error", "Invalid credentials. Please try again!", RedirectUtil.LOGIN_URL);
    }
}
