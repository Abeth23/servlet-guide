# CricTrack - Project Flow & Working

## One Paragraph Summary
CricTrack works by storing the entire match state as a Java object in the HttpSession.
When the user sets up a match, MatchServlet creates a Match object and stores it in session.
Every ball button click sends a POST request to ScorerServlet, which retrieves the Match
from session, calls addBall() to update the score, and either forwards back to scorer.jsp
for the next ball or redirects to ScorecardServlet when the innings is complete.
ScorecardServlet reads the final match from session and forwards to scorecard.jsp for rendering.
A LoggingFilter intercepts every request and logs it.

## Phase 1 - Match Setup
- User fills form in index.jsp
- Browser sends POST to /start-match
- Tomcat finds MatchServlet via @WebServlet("/start-match")
- MatchServlet creates Match object
- Match stored in SESSION scope
- Tomcat creates JSESSIONID cookie and sends to browser
- Forwards to scorer.jsp

## Phase 2 - Scoring a Ball (Core Loop)
- User clicks ball button (0,1,2,3,4,6,W,WD,NB)
- Each button is a form that POSTs to /score-ball
- Browser sends JSESSIONID cookie automatically
- ScorerServlet gets Match from session
- Calls match.addBall(ball)
- Checks if innings complete
- If NO  → forward to scorer.jsp (updated score shown)
- If YES → redirect to /scorecard

## Phase 3 - Over Complete
- After 6 legal balls ballsInOver reaches 6
- currentOver saved to allOvers
- currentOver cleared
- completedOvers incremented

## Phase 4 - Wicket Falls
- wickets incremented
- Score at fall saved to fallOfWickets list

## Phase 5 - Innings Ends
- isInningsComplete() returns true
- ScorerServlet does sendRedirect("scorecard")
- Browser makes new GET to /scorecard
- ScorecardServlet reads match from session
- Puts match in request scope
- Forwards to scorecard.jsp

## Phase 6 - Print
- window.print() opens browser print dialog
- @media print CSS hides buttons

## Filter
- LoggingFilter intercepts EVERY request
- Logs method, URL, and response time
- chain.doFilter() passes request to next servlet

## Key Concepts Used
- Servlet Lifecycle    → init() called once, doPost() called per request
- Session Management  → Match object persists across all ball requests
- Request Dispatching → forward() to JSP, redirect() to scorecard
- Servlet Mapping     → @WebServlet annotations
- Servlet Scope       → Session scope for match, Request scope for JSP rendering
- Servlet Filter      → LoggingFilter on /*

## Interview One-liner per File
- Match.java           → Plain Java class holding all match data
- MatchServlet.java    → Creates match, stores in session
- ScorerServlet.java   → Updates score on every ball click
- ScorecardServlet.java→ Reads match from session, forwards to scorecard JSP
- index.jsp            → Match setup form
- scorer.jsp           → Live scoring panel, reads match from session
- scorecard.jsp        → Final summary, reads match from request scope
- LoggingFilter.java   → Intercepts every request, logs timing
