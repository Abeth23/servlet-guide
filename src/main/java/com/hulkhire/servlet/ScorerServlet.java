package com.hulkhire.servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/score-ball")
public class ScorerServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Get session
        HttpSession session = request.getSession(false);

        // 2. If no session exists redirect to home
        if (session == null || session.getAttribute("match") == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        // 3. Get match object from session
        Match match = (Match) session.getAttribute("match");

        // 4. Get the ball value clicked by user
        String ball = request.getParameter("ball");

        // 5. Update match with this ball
        match.addBall(ball);

        // 6. Check if innings is complete
        if (match.isInningsComplete()) {
            // Redirect to scorecard
            response.sendRedirect("scorecard");
        } else {
            // Forward back to scorer.jsp with updated score
            request.getRequestDispatcher("/scorer.jsp")
                   .forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("index.jsp");
    }
}