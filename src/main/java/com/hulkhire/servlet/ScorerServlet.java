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

        // 2. If no session redirect home
        if (session == null || session.getAttribute("match") == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        // 3. Get match from session
        Match match = (Match) session.getAttribute("match");

        // 4. Get ball value clicked
        String ball = request.getParameter("ball");

        // 5. Update match with this ball
        match.addBall(ball);

        // 6. Check innings and match state
        if (match.getCurrentInnings() == 1 && match.isInnings1Complete()) {
            // Innings 1 done → go to innings break page
            response.sendRedirect("innings-break");

        } else if (match.getCurrentInnings() == 2 && match.isInnings2Complete()) {
            // Innings 2 done → go to final scorecard
            response.sendRedirect("scorecard");

        } else {
            // Continue scoring
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