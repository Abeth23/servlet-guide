<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="com.hulkhire.servlet.Match" %>
        <%@ page import="java.util.List" %>
            <% Match match=(Match) session.getAttribute("match"); if (match==null) { response.sendRedirect("index.jsp");
                return; } boolean isInnings2=match.getCurrentInnings()==2; %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <title>CricTrack - Live Scoring</title>
                    <style>
                        * {
                            margin: 0;
                            padding: 0;
                            box-sizing: border-box;
                        }

                        body {
                            font-family: 'Segoe UI', Arial, sans-serif;
                            min-height: 100vh;
                            background: linear-gradient(135deg, #1a472a 0%, #2d6a4f 50%, #1b4332 100%);
                            padding: 20px;
                        }

                        .container {
                            max-width: 600px;
                            margin: 0 auto;
                        }

                        .header {
                            text-align: center;
                            color: white;
                            margin-bottom: 20px;
                        }

                        .header h1 {
                            font-size: 22px;
                            margin-bottom: 4px;
                        }

                        .header p {
                            font-size: 13px;
                            opacity: 0.8;
                        }

                        .live-badge {
                            display: inline-block;
                            background: #ff0000;
                            color: white;
                            font-size: 10px;
                            font-weight: 700;
                            padding: 2px 8px;
                            border-radius: 20px;
                            letter-spacing: 1px;
                            margin-left: 8px;
                            animation: blink 1.5s infinite;
                        }

                        @keyframes blink {

                            0%,
                            100% {
                                opacity: 1;
                            }

                            50% {
                                opacity: 0.4;
                            }
                        }

                        .score-card {
                            background: white;
                            border-radius: 20px;
                            padding: 28px;
                            margin-bottom: 16px;
                            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
                            text-align: center;
                        }

                        .team-name {
                            font-size: 12px;
                            color: #1a472a;
                            text-transform: uppercase;
                            letter-spacing: 2px;
                            margin-bottom: 4px;
                            font-weight: 700;
                        }

                        .score {
                            font-size: 72px;
                            font-weight: 900;
                            color: #1a472a;
                            line-height: 1;
                            margin-bottom: 4px;
                        }

                        .score span {
                            font-size: 40px;
                            color: #aaa;
                        }

                        .over-info {
                            font-size: 16px;
                            color: #888;
                            margin-bottom: 16px;
                        }

                        .stats-row {
                            display: flex;
                            justify-content: center;
                            gap: 24px;
                            margin-bottom: 16px;
                            flex-wrap: wrap;
                        }

                        .stat {
                            text-align: center;
                        }

                        .stat-val {
                            font-size: 20px;
                            font-weight: 800;
                            color: #1a472a;
                        }

                        .stat-lbl {
                            font-size: 10px;
                            color: #aaa;
                            text-transform: uppercase;
                            letter-spacing: 1px;
                        }

                        /* Target banner for innings 2 */
                        .target-banner {
                            background: linear-gradient(135deg, #1a472a, #52b788);
                            color: white;
                            border-radius: 12px;
                            padding: 14px 20px;
                            margin-bottom: 16px;
                            display: flex;
                            justify-content: space-between;
                            align-items: center;
                        }

                        .target-banner .t-label {
                            font-size: 12px;
                            opacity: 0.85;
                        }

                        .target-banner .t-val {
                            font-size: 22px;
                            font-weight: 900;
                        }

                        .target-banner .t-need {
                            font-size: 13px;
                            opacity: 0.9;
                        }

                        .current-over {
                            background: #f8f9fa;
                            border-radius: 12px;
                            padding: 12px 16px;
                        }

                        .over-label {
                            font-size: 10px;
                            color: #aaa;
                            text-transform: uppercase;
                            letter-spacing: 1px;
                            margin-bottom: 8px;
                        }

                        .balls {
                            display: flex;
                            gap: 8px;
                            justify-content: center;
                            flex-wrap: wrap;
                        }

                        .ball {
                            width: 38px;
                            height: 38px;
                            border-radius: 50%;
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            font-size: 13px;
                            font-weight: 800;
                        }

                        .ball-0 {
                            background: #e0e0e0;
                            color: #666;
                        }

                        .ball-1 {
                            background: #e3f2fd;
                            color: #1565c0;
                        }

                        .ball-2 {
                            background: #e8f5e9;
                            color: #2e7d32;
                        }

                        .ball-3 {
                            background: #fff3e0;
                            color: #e65100;
                        }

                        .ball-4 {
                            background: #4caf50;
                            color: white;
                        }

                        .ball-6 {
                            background: #1a472a;
                            color: white;
                        }

                        .ball-W {
                            background: #f44336;
                            color: white;
                        }

                        .ball-WD {
                            background: #ff9800;
                            color: white;
                        }

                        .ball-NB {
                            background: #9c27b0;
                            color: white;
                        }

                        .btn-panel {
                            background: white;
                            border-radius: 20px;
                            padding: 24px;
                            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
                        }

                        .btn-label {
                            font-size: 11px;
                            color: #1a472a;
                            text-transform: uppercase;
                            letter-spacing: 2px;
                            margin-bottom: 16px;
                            text-align: center;
                            font-weight: 700;
                        }

                        .btn-grid {
                            display: grid;
                            grid-template-columns: repeat(4, 1fr);
                            gap: 10px;
                            margin-bottom: 10px;
                        }

                        .btn-grid-extras {
                            display: grid;
                            grid-template-columns: repeat(3, 1fr);
                            gap: 10px;
                        }

                        .ball-btn {
                            padding: 18px 8px;
                            border: none;
                            border-radius: 14px;
                            font-size: 22px;
                            font-weight: 900;
                            cursor: pointer;
                            transition: transform 0.1s, box-shadow 0.2s;
                            width: 100%;
                        }

                        .ball-btn:hover {
                            transform: scale(1.07);
                        }

                        .ball-btn:active {
                            transform: scale(0.94);
                        }

                        .btn-0 {
                            background: #e0e0e0;
                            color: #666;
                        }

                        .btn-1 {
                            background: #e3f2fd;
                            color: #1565c0;
                        }

                        .btn-2 {
                            background: #e8f5e9;
                            color: #2e7d32;
                        }

                        .btn-3 {
                            background: #fff3e0;
                            color: #e65100;
                        }

                        .btn-4 {
                            background: #4caf50;
                            color: white;
                            box-shadow: 0 4px 15px rgba(76, 175, 80, 0.4);
                        }

                        .btn-6 {
                            background: #1a472a;
                            color: white;
                            box-shadow: 0 4px 15px rgba(26, 71, 42, 0.4);
                        }

                        .btn-W {
                            background: #f44336;
                            color: white;
                            box-shadow: 0 4px 15px rgba(244, 67, 54, 0.4);
                        }

                        .btn-WD {
                            background: #ff9800;
                            color: white;
                            font-size: 13px;
                        }

                        .btn-NB {
                            background: #9c27b0;
                            color: white;
                            font-size: 13px;
                        }

                        .end-btn {
                            width: 100%;
                            padding: 14px;
                            background: linear-gradient(135deg, #c0392b, #e74c3c);
                            color: white;
                            border: none;
                            border-radius: 12px;
                            font-size: 14px;
                            font-weight: 700;
                            cursor: pointer;
                            margin-top: 12px;
                            transition: opacity 0.3s;
                        }

                        .end-btn:hover {
                            opacity: 0.9;
                        }
                    </style>
                </head>

                <body>
                    <div class="container">

                        <div class="header">
                            <h1>🏏 CricTrack <span class="live-badge">LIVE</span></h1>
                            <p>
                                <%= match.getTeam1() %> vs <%= match.getTeam2() %> —
                                        <%= isInnings2 ? "2nd" : "1st" %> Innings
                            </p>
                        </div>

                        <div class="score-card">
                            <div class="team-name">
                                ⚡ <%= isInnings2 ? match.getTeam2() : match.getTeam1() %> Innings
                            </div>
                            <div class="score">
                                <%= match.getRuns() %><span>/<%= match.getWickets() %></span>
                            </div>
                            <div class="over-info">
                                Overs: <%= match.getOverDisplay() %> / <%= match.getTotalOvers() %>
                            </div>

                            <div class="stats-row">
                                <div class="stat">
                                    <div class="stat-val">
                                        <%= match.getRunRate() %>
                                    </div>
                                    <div class="stat-lbl">Run Rate</div>
                                </div>
                                <div class="stat">
                                    <div class="stat-val">
                                        <%= 10 - match.getWickets() %>
                                    </div>
                                    <div class="stat-lbl">Wickets Left</div>
                                </div>
                                <div class="stat">
                                    <div class="stat-val">
                                        <%= match.getTotalOvers() - match.getCompletedOvers() %>
                                    </div>
                                    <div class="stat-lbl">Overs Left</div>
                                </div>
                                <% if (isInnings2) { %>
                                    <div class="stat">
                                        <div class="stat-val">
                                            <%= match.getRunsNeeded() %>
                                        </div>
                                        <div class="stat-lbl">Runs Needed</div>
                                    </div>
                                    <div class="stat">
                                        <div class="stat-val">
                                            <%= match.getBallsRemaining() %>
                                        </div>
                                        <div class="stat-lbl">Balls Left</div>
                                    </div>
                                    <% } %>
                            </div>

                            <!-- Target banner only for innings 2 -->
                            <% if (isInnings2) { %>
                                <div class="target-banner">
                                    <div>
                                        <div class="t-label">🎯 Target</div>
                                        <div class="t-val">
                                            <%= match.getTarget() %>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="t-need">
                                            Need <%= match.getRunsNeeded() %> runs
                                                in <%= match.getBallsRemaining() %> balls
                                        </div>
                                    </div>
                                </div>
                                <% } %>

                                    <div class="current-over">
                                        <div class="over-label">This Over</div>
                                        <div class="balls">
                                            <% if (match.getCurrentOver().isEmpty()) { %>
                                                <span style="color:#ccc; font-size:13px;">No balls yet</span>
                                                <% } else { for (String b : match.getCurrentOver()) { %>
                                                    <div class="ball ball-<%= b %>">
                                                        <%= b %>
                                                    </div>
                                                    <% }} %>
                                        </div>
                                    </div>
                        </div>

                        <div class="btn-panel">
                            <div class="btn-label">Tap to Score a Ball</div>

                            <div class="btn-grid">
                                <% String[] runs={"0","1","2","3","4","6"}; %>
                                    <% for (String r : runs) { %>
                                        <form action="score-ball" method="POST" style="margin:0">
                                            <input type="hidden" name="ball" value="<%= r %>" />
                                            <button type="submit" class="ball-btn btn-<%= r %>">
                                                <%= r %>
                                            </button>
                                        </form>
                                        <% } %>
                                            <form action="score-ball" method="POST"
                                                style="margin:0; grid-column: span 2">
                                                <input type="hidden" name="ball" value="W" />
                                                <button type="submit" class="ball-btn btn-W" style="width:100%">
                                                    🔴 W
                                                </button>
                                            </form>
                            </div>

                            <div class="btn-grid-extras">
                                <form action="score-ball" method="POST" style="margin:0">
                                    <input type="hidden" name="ball" value="WD" />
                                    <button type="submit" class="ball-btn btn-WD" style="width:100%">
                                        Wide
                                    </button>
                                </form>
                                <form action="score-ball" method="POST" style="margin:0">
                                    <input type="hidden" name="ball" value="NB" />
                                    <button type="submit" class="ball-btn btn-NB" style="width:100%">
                                        No Ball
                                    </button>
                                </form>
                                <form action="scorecard" method="GET" style="margin:0">
                                    <button type="submit" class="ball-btn" style="width:100%; background:#f0f0f0;
                               color:#888; font-size:13px;">
                                        End Inn.
                                    </button>
                                </form>
                            </div>

                            <form action="index.jsp" method="GET">
                                <button type="submit" class="end-btn">
                                    🏁 End Match & New Game
                                </button>
                            </form>
                        </div>

                    </div>
                </body>

                </html>