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

		// Allow resources like CSS or access to /home and /
		if (uri.endsWith(".css") || uri.endsWith(HOME) || uri.endsWith(ROOT)) {
			chain.doFilter(request, response);
			return;
		}

		// Check login status
		boolean isLoggedIn = SessionUtil.getAttribute(req, "username") != null;
		Integer roleId = (Integer) SessionUtil.getAttribute(req, "role_id"); // Assuming role_id is stored in session

		if (!isLoggedIn) {
			// User not logged in
			if (uri.endsWith(LOGIN) || uri.endsWith(REGISTER)) {
				chain.doFilter(request, response);
			} else {
				res.sendRedirect(req.getContextPath() + LOGIN);
			}
		} else {
			// User already logged in
			if (uri.endsWith(LOGIN) || uri.endsWith(REGISTER)) {
				// Redirect based on role
				if (roleId != null && roleId == 1) {
					res.sendRedirect(req.getContextPath() + DASHBOARD);
				} else {
					res.sendRedirect(req.getContextPath() + HOME);
				}
			} else {
				chain.doFilter(request, response);
			}
		}
	}

	@Override
	public void destroy() {
		Filter.super.destroy();
	}
}
