package com.Rydon.filters;

import java.io.IOException;

import com.Rydon.Util.SessionUtil;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebFilter(asyncSupported = true, urlPatterns = { "/*" })
public class AuthenticationFilter implements Filter {

    private static final String LOGIN = "/login";
    private static final String REGISTER = "/register";
    private static final String HOME = "/home";
    private static final String ROOT = "/";
    private static final String DASHBOARD = "/dashboard";
    private static final String MANAGE_USER = "/manageuser";

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        Filter.super.init(filterConfig);
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String uri = req.getRequestURI();
        String contextPath = req.getContextPath();

        // Static resources
        if (uri.endsWith(".css") || uri.contains("/images/") || uri.contains("/js/")) {
            chain.doFilter(request, response);
            return;
        }

        // Always allow public pages
        if (uri.endsWith(LOGIN) || uri.endsWith(REGISTER) || uri.endsWith(HOME) || uri.equals(contextPath + ROOT)) {
            chain.doFilter(request, response);
            return;
        }

        // Session attributes
        String username = (String) SessionUtil.getAttribute(req, "username");

        if (username == null) {
            // Not logged in, redirect to login
            res.sendRedirect(contextPath + LOGIN);
            return;
        }

        // If user tries to access login/register again after being logged in
        if (uri.endsWith(LOGIN) || uri.endsWith(REGISTER)) {
            if (username.equals("admin")) {
                res.sendRedirect(contextPath + DASHBOARD);
            } else {
                res.sendRedirect(contextPath + HOME);
            }
            return;
        }

        // Admin-only access restriction
        if (uri.endsWith(DASHBOARD) || uri.endsWith(MANAGE_USER)) {
            if (!"admin".equals(username)) {
                res.sendRedirect(contextPath + HOME);
                return;
            }
        }

        // Continue with normal flow
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        Filter.super.destroy();
    }
}
