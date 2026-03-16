<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="com.hulkhire.servlet.Match" %>
        <%@ page import="java.util.List" %>
            <% Match match=(Match) request.getAttribute("match"); if (match==null) { response.sendRedirect("index.jsp");
                return; } %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <title>CricTrack - Scorecard</title>
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
                            max-width: 620px;
                            margin: 0 auto;
                        }

                        .header {
                            text-align: center;
                            color: white;
                            margin-bottom: 20px;
                            animation: slideDown 0.5s ease;
                        }

                        @keyframes slideDown {
                            from {
                                opacity: 0;
                                transform: translateY(-20px);
                            }

                            to {
                                opacity: 1;
                                transform: translateY(0);
                            }
                        }

                        .header h1 {
                            font-size: 26px;
                            margin-bottom: 4px;
                        }

                        .header p {
                            font-size: 13px;
                            opacity: 0.8;
                        }

                        .card {
                            background: white;
                            border-radius: 20px;
                            padding: 28px;
                            margin-bottom: 16px;
                            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
                            animation: slideUp 0.5s ease;
                        }

                        @keyframes slideUp {
                            from {
                                opacity: 0;
                                transform: translateY(20px);
                            }

                            to {
                                opacity: 1;
                                transform: translateY(0);
                            }
                        }

                        .match-title {
                            text-align: center;
                            margin-bottom: 20px;
                        }

                        .match-title h2 {
                            font-size: 22px;
                            color: #1a472a;
                            margin-bottom: 4px;
                        }

                        .match-title p {
                            color: #888;
                            font-size: 13px;
                        }

                        .final-score {
                            text-align: center;
                            background: linear-gradient(135deg, #1a472a, #52b788);
                            color: white;
                            border-radius: 16px;
                            padding: 24px;
                            margin-bottom: 20px;
                        }

                        .final-score .team {
                            font-size: 12px;
                            opacity: 0.85;
                            text-transform: uppercase;
                            letter-spacing: 2px;
                            margin-bottom: 4px;
                        }

                        .final-score .runs {
                            font-size: 60px;
                            font-weight: 900;
                            line-height: 1;
                        }

                        .final-score .runs span {
                            font-size: 36px;
                            opacity: 0.7;
                        }

                        .final-score .over {
                            font-size: 15px;
                            opacity: 0.8;
                            margin-top: 6px;
                        }

                        .stats-grid {
                            display: grid;
                            grid-template-columns: repeat(3, 1fr);
                            gap: 12px;
                            margin-bottom: 24px;
                        }

                        .stat-box {
                            background: #f8f9fa;
                            border-radius: 12px;
                            padding: 14px;
                            text-align: center;
                        }

                        .stat-box .val {
                            font-size: 24px;
                            font-weight: 800;
                            color: #1a472a;
                        }

                        .stat-box .lbl {
                            font-size: 10px;
                            color: #aaa;
                            text-transform: uppercase;
                            letter-spacing: 1px;
                            margin-top: 2px;
                        }

                        .section-title {
                            font-size: 11px;
                            font-weight: 700;
                            color: #1a472a;
                            text-transform: uppercase;
                            letter-spacing: 2px;
                            margin-bottom: 12px;
                        }

                        .over-table {
                            width: 100%;
                            border-collapse: collapse;
                            margin-bottom: 24px;
                            font-size: 14px;
                        }

                        .over-table th {
                            background: linear-gradient(135deg, #1a472a, #2d6a4f);
                            color: white;
                            padding: 10px 12px;
                            text-align: left;
                            font-size: 11px;
                            letter-spacing: 1px;
                            text-transform: uppercase;
                        }

                        .over-table th:first-child {
                            border-radius: 8px 0 0 0;
                        }

                        .over-table th:last-child {
                            border-radius: 0 8px 0 0;
                        }

                        .over-table td {
                            padding: 10px 12px;
                            border-bottom: 1px solid #f0f0f0;
                            color: #444;
                        }

                        .over-table tr:last-child td {
                            border-bottom: none;
                        }

                        .over-table tr:nth-child(even) td {
                            background: #f8f9fa;
                        }

                        .ball-dot {
                            display: inline-block;
                            padding: 3px 7px;
                            border-radius: 6px;
                            font-size: 11px;
                            font-weight: 700;
                            margin: 2px;
                        }

                        .b0 {
                            background: #e0e0e0;
                            color: #666;
                        }

                        .b1 {
                            background: #e3f2fd;
                            color: #1565c0;
                        }

                        .b2 {
                            background: #e8f5e9;
                            color: #2e7d32;
                        }

                        .b3 {
                            background: #fff3e0;
                            color: #e65100;
                        }

                        .b4 {
                            background: #4caf50;
                            color: white;
                        }

                        .b6 {
                            background: #1a472a;
                            color: white;
                        }

                        .bW {
                            background: #f44336;
                            color: white;
                        }

                        .bWD {
                            background: #ff9800;
                            color: white;
                        }

                        .bNB {
                            background: #9c27b0;
                            color: white;
                        }

                        .fow-list {
                            display: flex;
                            flex-wrap: wrap;
                            gap: 8px;
                            margin-bottom: 24px;
                        }

                        .fow-badge {
                            background: #fff0f0;
                            border: 1px solid #ffcccc;
                            color: #c0392b;
                            padding: 4px 14px;
                            border-radius: 20px;
                            font-size: 13px;
                            font-weight: 700;
                        }

                        .btn-row {
                            display: flex;
                            gap: 12px;
                        }

                        .btn-print {
                            flex: 1;
                            padding: 14px;
                            background: linear-gradient(135deg, #1a472a, #52b788);
                            color: white;
                            border: none;
                            border-radius: 12px;
                            font-size: 15px;
                            font-weight: 700;
                            cursor: pointer;
                            transition: opacity 0.3s, transform 0.1s;
                        }

                        .btn-print:hover {
                            opacity: 0.9;
                            transform: translateY(-2px);
                        }

                        .btn-new {
                            flex: 1;
                            padding: 14px;
                            background: #f0f0f0;
                            color: #444;
                            border: none;
                            border-radius: 12px;
                            font-size: 15px;
                            font-weight: 700;
                            cursor: pointer;
                            text-decoration: none;
                            text-align: center;
                            transition: background 0.3s;
                        }

                        .btn-new:hover {
                            background: #e0e0e0;
                        }

                        @media print {
                            body {
                                background: white;
                            }

                            .btn-row {
                                display: none;
                            }
                        }
                    </style>
                </head>

                <body>
                    <div class="container">

                        <div class="header">
                            <h1>🏏 CricTrack</h1>
                            <p>Match Scorecard</p>
                        </div>

                        <div class="card">

                            <div class="match-title">
                                <h2>
                                    <%= match.getTeam1() %> vs <%= match.getTeam2() %>
                                </h2>
                                <p>Toss: <%= match.getTossWinner() %> •
                                        <%= match.getTotalOvers() %> Overs Match</p>
                            </div>

                            <div class="final-score">
                                <div class="team">⚡ <%= match.getTeam1() %> Innings</div>
                                <div class="runs">
                                    <%= match.getRuns() %><span>/<%= match.getWickets() %></span>
                                </div>
                                <div class="over">
                                    (<%= match.getOverDisplay() %> Overs)
                                </div>
                            </div>

                            <div class="stats-grid">
                                <div class="stat-box">
                                    <div class="val">
                                        <%= match.getRunRate() %>
                                    </div>
                                    <div class="lbl">Run Rate</div>
                                </div>
                                <div class="stat-box">
                                    <div class="val">
                                        <%= match.getWickets() %>
                                    </div>
                                    <div class="lbl">Wickets</div>
                                </div>
                                <div class="stat-box">
                                    <div class="val">
                                        <%= match.getCompletedOvers() %>
                                    </div>
                                    <div class="lbl">Overs</div>
                                </div>
                            </div>

                            <div class="section-title">⚡ Over by Over Breakdown</div>
                            <table class="over-table">
                                <tr>
                                    <th>Over</th>
                                    <th>Balls</th>
                                    <th>Runs</th>
                                </tr>
                                <% List<List<String>> allOvers = match.getAllOvers();
                                    for (int i = 0; i < allOvers.size(); i++) { List<String> over = allOvers.get(i);
                                        int overRuns = 0;
                                        for (String b : over) {
                                        try { overRuns += Integer.parseInt(b); }
                                        catch (NumberFormatException e) {
                                        if (b.equals("WD") || b.equals("NB")) overRuns += 1;
                                        }
                                        }
                                        %>
                                        <tr>
                                            <td><b style="color:#1a472a">Over <%= (i+1) %></b></td>
                                            <td>
                                                <% for (String b : over) { %>
                                                    <span class="ball-dot b<%= b %>">
                                                        <%= b %>
                                                    </span>
                                                    <% } %>
                                            </td>
                                            <td><b>
                                                    <%= overRuns %>
                                                </b></td>
                                        </tr>
                                        <% } %>
                            </table>

                            <% if (!match.getFallOfWickets().isEmpty()) { %>
                                <div class="section-title">🔴 Fall of Wickets</div>
                                <div class="fow-list">
                                    <% for (String fow : match.getFallOfWickets()) { %>
                                        <span class="fow-badge">🔴 <%= fow %></span>
                                        <% } %>
                                </div>
                                <% } %>

                                    <div class="btn-row">
                                        <button class="btn-print" onclick="window.print()">
                                            🖨️ Print Scorecard
                                        </button>
                                        <a href="index.jsp" class="btn-new">
                                            🏏 New Match
                                        </a>
                                    </div>

                        </div>
                    </div>
                </body>

                </html>