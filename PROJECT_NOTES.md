# CricTrack - Project Notes & Interview Reference

## What is CricTrack?
A ball-by-ball cricket scoring web app built with Java Servlets and JSP.
User sets up a match, scores every ball in real time, and gets a full scorecard at the end.

## Tech Stack
- Java Servlets + JSP
- Apache Tomcat 10
- Maven (WAR deployment)
- Session Management (match state)

## Project Flow

### Phase 1 - Match Setup
- User opens index.jsp → fills Team1, Team2, Overs, Toss, Venue
- Clicks Start Match → Browser sends POST to /start-match
- Tomcat finds MatchServlet via @WebServlet("/start-match")
- MatchServlet creates Match object → stores in HttpSession
- Tomcat creates JSESSIONID cookie → sends to browser
- Forwards to scorer.jsp → user sees live scoring panel

### Phase 2 - Scoring a Ball (Core Loop)
- Each ball button (0,1,2,3,4,6,W,WD,NB) is a form
- Click sends POST to /score-ball with ball value hidden in form
- Browser automatically sends JSESSIONID cookie
- ScorerServlet gets Match from session
- Calls match.addBall(ball) → updates runs, wickets, overs
- If innings NOT complete → forward back to scorer.jsp
- If innings complete → redirect to /scorecard

### Phase 3 - Over Complete
- After 6 legal balls → over is complete
- Current over saved to allOvers list
- ballsInOver reset to 0
- completedOvers incremented

### Phase 4 - Wicket Falls
- wickets counter incremented
- Current score saved to fallOfWickets list e.g. "24/1"

### Phase 5 - Innings Ends
- isInningsComplete() returns true when:
  - completedOvers >= totalOvers (all overs done)
  - OR wickets >= 10 (all out)
- ScorerServlet does sendRedirect("scorecard")
- ScorecardServlet reads match from session
- Puts match in request scope
- Forwards to scorecard.jsp

### Phase 6 - Scorecard
- Shows final score, run rate, over by over breakdown
- Fall of wickets badges
- Print button uses window.print()
- New Match button goes back to index.jsp

## File Responsibilities

| File | What it does |
|------|-------------|
| Match.java | Plain Java class — holds all match data (runs, wickets, overs, balls) |
| MatchServlet.java | Reads form data, creates Match object, stores in session |
| ScorerServlet.java | Called on every ball click — updates match in session |
| ScorecardServlet.java | Reads match from session, forwards to scorecard.jsp |
| LoggingFilter.java | Intercepts every request — logs URL and response time |
| index.jsp | Match setup form with validation |
| scorer.jsp | Live scoring panel — reads match from session |
| scorecard.jsp | Final summary — reads match from request scope |

## Servlet Concepts Used in CricTrack

| Concept | Where used in CricTrack |
|---------|------------------------|
| Servlet Lifecycle | init() in MatchServlet prints when servlet loads |
| HttpServletRequest | Reading team names, ball value from form |
| HttpServletResponse | sendRedirect() to scorecard when innings ends |
| Servlet Mapping | @WebServlet("/start-match"), @WebServlet("/score-ball") |
| Session Management | Match object stored in session across all ball requests |
| Request Dispatching | forward() to scorer.jsp after every ball |
| Servlet Scope | Session scope for match, Request scope for JSP rendering |
| Servlet Filter | LoggingFilter on /* logs every ball click |

## Key Methods in Match.java

- addBall(String ball) → updates score based on ball clicked
- isInningsComplete() → returns true when overs done or 10 wickets
- getRunRate() → calculates runs per over
- getOverDisplay() → returns "3.4" format for current over

## Interview One-liner
"CricTrack stores the entire match state in HttpSession.
Every ball button click sends a POST to ScorerServlet which
updates the Match object in session and either re-renders
the scorer page or redirects to the scorecard when innings ends."
