package com.hulkhire.servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/start-match")
public class MatchServlet extends HttpServlet {

    @Override
    public void init() throws ServletException {
        System.out.println("[MatchServlet] init() called - servlet loaded.");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Read form data from index.jsp
        String team1      = request.getParameter("team1");
        String team2      = request.getParameter("team2");
        String oversStr   = request.getParameter("overs");
        String tossWinner = request.getParameter("toss");

        // 2. Validate
        if (team1 == null || team1.isBlank() ||
            team2 == null || team2.isBlank() ||
            oversStr == null || oversStr.isBlank()) {
            response.sendRedirect("index.jsp?error=true");
            return;
        }

        int overs = Integer.parseInt(oversStr);

        // 3. Create Match object
        Match match = new Match(team1.trim(), team2.trim(), overs, tossWinner);

        // 4. Store in SESSION scope
        // This match object will be available across ALL future requests
        HttpSession session = request.getSession();
        session.setAttribute("match", match);

        // 5. Forward to scorer.jsp
        request.getRequestDispatcher("/scorer.jsp")
               .forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("index.jsp");
    }
}