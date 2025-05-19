package com.Rydon.Util;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Utility class for handling page redirections and setting messages.
 */
public class RedirectUtil {

    private static final String BASE_URL = "/WEB-INF/pages/";

    public static final String REGISTER_URL = BASE_URL + "register.jsp";
    public static final String LOGIN_URL = BASE_URL + "login.jsp";
    public static final String HOME_URL = BASE_URL + "home.jsp";
    public static final String DASHBOARD_URL = BASE_URL + "dashboard.jsp"; // Optional if you have a dashboard

    /**
     * Sets a message attribute in the request.
     */
    public void setMsgAttribute(HttpServletRequest req, String msgType, String msg) {
        req.setAttribute(msgType, msg);
    }

    /**
     * Forwards the request and response to a specific page.
     */
    public void redirectToPage(HttpServletRequest req, HttpServletResponse resp, String page)
            throws ServletException, IOException {
        req.getRequestDispatcher(page).forward(req, resp);
    }

    /**
     * Sets a message attribute and then forwards to a specific page.
     */
    public void setMsgAndRedirect(HttpServletRequest req, HttpServletResponse resp, String msgType, String msg, String page)
            throws ServletException, IOException {
        setMsgAttribute(req, msgType, msg);
        redirectToPage(req, resp, page);
    }
}
