# 🏏 CricTrack - Full Match Cricket Scorer

A fully functional two-innings cricket scoring web app built with Java Servlets & JSP.

## Features
- Set up a match with team names, overs, toss & venue
- Score every ball — 0, 1, 2, 3, 4, 6, Wide, No Ball, Wicket
- Live scorecard updates after every ball
- Innings break page with target for Team 2
- Full run chase — live target, runs needed & balls remaining
- Automatic winner declaration (by runs or by wickets)
- Over-by-over breakdown for both innings
- Fall of wickets tracker for both innings
- Print final scorecard

## Tech Stack
- Java Servlets + JSP
- Apache Tomcat 10
- Maven (WAR deployment)

## Servlet Concepts Applied
- Servlet Lifecycle (init, service, destroy)
- Session Management (match state across all requests)
- Request Dispatching (forward & redirect)
- Servlet Mapping (@WebServlet annotations)
- Servlet Scope (session & request scope)
- Servlet Filters (LoggingFilter)

## Project Flow
```
index.jsp → MatchServlet → scorer.jsp (Team1)
         → innings-break.jsp (target shown)
         → scorer.jsp (Team2 run chase)
         → scorecard.jsp (winner + both innings)
```

## How to Run
1. Clone the repo
2. Run: mvn clean package
3. Deploy target/servlet-guide.war to Tomcat 10
4. Open: http://localhost:8080/servlet-guide

## File Structure
```
src/main/java/com/hulkhire/servlet/
├── Match.java                 ← Match data model (both innings)
├── MatchServlet.java          ← Creates match, stores in session
├── ScorerServlet.java         ← Updates score per ball
├── InningsBreakServlet.java   ← Handles innings switch
├── ScorecardServlet.java      ← Shows final scorecard
└── LoggingFilter.java         ← Logs every request

src/main/webapp/
├── index.jsp                  ← Match setup form
├── scorer.jsp                 ← Live scoring panel (both innings)
├── innings-break.jsp          ← Innings break + target page
└── scorecard.jsp              ← Final scorecard (both innings + winner)
```

Built during Java backend training at Hulkhire Tech, Bengaluru.
