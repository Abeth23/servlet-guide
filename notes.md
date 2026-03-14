# Servlet Project - Simple Notes

## What We Are Building
A simple web app with one form and one result page.
User opens browser → fills Name + Phone → clicks Submit → sees a greeting message.

## The 3 Main Players

1. JSP (index.jsp and success.jsp)
   - Just HTML pages with a little Java inside
   - The user sees these in the browser
   - Just the face of the app

2. Servlet (GreetingServlet.java)
   - The brain of the app
   - Receives form data, processes it, builds the message
   - User never sees this directly — works behind the scenes

3. Tomcat
   - The server that runs everything
   - Receives requests from browser, finds the right servlet, sends response back

## The Flow

1. User opens browser
2. Tomcat serves index.jsp → user sees the form
3. User fills Name + Phone → clicks Submit
4. Browser sends data to Tomcat at URL /greet
5. Tomcat sees /greet → finds GreetingServlet → runs doPost()
6. Servlet reads name and phone → builds message "Hi Abeth, your number is..."
7. Servlet hands the message to success.jsp
8. success.jsp displays the message to the user

## Why Each File Exists

- pom.xml          → Tells Maven what libraries to download and how to build
- web.xml          → Tells Tomcat basic settings (which file to show first)
- index.jsp        → The form the user fills
- success.jsp      → The page that shows the greeting
- GreetingServlet  → The Java class that handles the form submission

## Simple Analogy (Restaurant)

- index.jsp        = the menu (you place your order here)
- GreetingServlet  = the kitchen (processes your order)
- success.jsp      = the plate that comes back to you
- Tomcat           = the waiter who carries everything back and forth