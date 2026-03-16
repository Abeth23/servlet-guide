cat > ~/Desktop/servlet-guide/README.md << 'EOF'
# 🏏 CricTrack - Ball by Ball Cricket Scorer

A fully functional cricket scoring web app built with Java Servlets & JSP.

## What it does
- Set up a match with team names, overs & venue
- Score every ball in real time — 0, 1, 2, 3, 4, 6, Wide, No Ball, Wicket
- Live scorecard updates after every ball
- Over-by-over breakdown with fall of wickets tracker
- Print the final scorecard

## Tech Stack
- Java Servlets + JSP
- Apache Tomcat 10
- Maven (WAR deployment)

## Servlet Concepts Applied
- Servlet Lifecycle (init, service, destroy)
- Session Management
- Request Dispatching (forward & redirect)
- Servlet Mapping via annotations
- Servlet Filters for request logging

## How to Run
1. Clone the repo
2. Run: mvn clean package
3. Deploy target/servlet-guide.war to Tomcat 10
4. Open: http://localhost:8080/servlet-guide

## Project Structure
```
src/main/java/com/hulkhire/servlet/
├── Match.java              ← Match data model
├── MatchServlet.java       ← Creates match session
├── ScorerServlet.java      ← Updates score per ball
├── ScorecardServlet.java   ← Shows final scorecard
└── LoggingFilter.java      ← Logs every request

src/main/webapp/
├── index.jsp               ← Match setup form
├── scorer.jsp              ← Live scoring panel
└── scorecard.jsp           ← Final match summary
```

Built during Java backend training at Hulkhire Tech, Bengaluru.
EOF
