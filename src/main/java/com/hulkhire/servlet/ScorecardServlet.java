package com.hulkhire.servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/scorecard")
public class ScorecardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Get session
        HttpSession session = request.getSession(false);

        // 2. If no match in session redirect home
        if (session == null || session.getAttribute("match") == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        // 3. Get match from session
        Match match = (Match) session.getAttribute("match");

        // 4. Put match in request scope for scorecard.jsp
        request.setAttribute("match", match);

        // 5. Forward to scorecard.jsp
        request.getRequestDispatcher("/scorecard.jsp")
               .forward(request, response);
    }
}