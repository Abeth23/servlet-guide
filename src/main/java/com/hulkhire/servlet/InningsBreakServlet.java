package com.hulkhire.servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/innings-break")
public class InningsBreakServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Get session
        HttpSession session = request.getSession(false);

        // 2. If no match redirect home
        if (session == null || session.getAttribute("match") == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        // 3. Get match from session
        Match match = (Match) session.getAttribute("match");

        // 4. Put match in request scope for innings-break.jsp
        request.setAttribute("match", match);

        // 5. Forward to innings-break.jsp
        request.getRequestDispatcher("/innings-break.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // User clicked "Start Team2 Innings" button
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("match") == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        Match match = (Match) session.getAttribute("match");

        // Switch match to innings 2
        match.startSecondInnings();

        // Forward to scorer.jsp for innings 2
        request.getRequestDispatcher("/scorer.jsp")
               .forward(request, response);
    }
}