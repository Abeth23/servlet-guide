package com.hulkhire.servlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/greet")
public class GreetingServlet extends HttpServlet {

    @Override
    public void init() throws ServletException {
        System.out.println("[GreetingServlet] init() called - servlet loaded.");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Read form fields
        String name  = request.getParameter("name");
        String phone = request.getParameter("phone");

        // 2. Validate
        if (name == null || name.isBlank() || phone == null || phone.isBlank()) {
            response.sendRedirect("index.jsp?error=true");
            return;
        }

        // 3. Build message
        String message = "Hi " + name.trim() + ", your number is " + phone.trim() + "!";

        // 4. Store in request scope
        request.setAttribute("message", message);

        // 5. Forward to success.jsp
        RequestDispatcher dispatcher = request.getRequestDispatcher("/success.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("index.jsp");
    }

    @Override
    public void destroy() {
        System.out.println("[GreetingServlet] destroy() called - servlet unloaded.");
    }
}