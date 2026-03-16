<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="com.hulkhire.servlet.Match" %>
        <%@ page import="java.util.List" %>
            <% Match match=(Match) request.getAttribute("match"); if (match==null) { response.sendRedirect("index.jsp");
                return; } %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <title>CricTrack - Final Scorecard</title>
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
                            max-width: 640px;
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

                        /* Winner Banner */
                        .winner-banner {
                            background: linear-gradient(135deg, #f39c12, #e67e22);
                            color: white;
                            border-radius: 16px;
                            padding: 20px;
                            text-align: center;
                            margin-bottom: 24px;
                            box-shadow: 0 4px 20px rgba(243, 156, 18, 0.4);
                            animation: popIn 0.6s cubic-bezier(0.175, 0.885, 0.32, 1.275);
                        }

                        @keyframes popIn {
                            from {
                                opacity: 0;
                                transform: scale(0.8);
                            }

                            to {
                                opacity: 1;
                                transform: scale(1);
                            }
                        }

                        .winner-banner .trophy {
                            font-size: 36px;
                            margin-bottom: 6px;
                        }

                        .winner-banner .winner-text {
                            font-size: 20px;
                            font-weight: 800;
                        }

                        .match-title {
                            text-align: center;
                            margin-bottom: 20px;
                        }

                        .match-title h2 {
                            font-size: 20px;
                            color: #1a472a;
                            margin-bottom: 4px;
                        }

                        .match-title p {
                            color: #888;
                            font-size: 13px;
                        }

                        /* Both innings scores side by side */
                        .innings-grid {
                            display: grid;
                            grid-template-columns: 1fr 1fr;
                            gap: 14px;
                            margin-bottom: 24px;
                        }

                        .innings-box {
                            border-radius: 14px;
                            padding: 16px;
                            text-align: center;
                        }

                        .innings-box.inn1 {
                            background: linear-gradient(135deg, #1a472a, #2d6a4f);
                            color: white;
                        }

                        .innings-box.inn2 {
                            background: linear-gradient(135deg, #1565c0, #1976d2);
                            color: white;
                        }

                        .inn-label {
                            font-size: 10px;
                            opacity: 0.8;
                            text-transform: uppercase;
                            letter-spacing: 1px;
                            margin-bottom: 4px;
                        }

                        .inn-team {
                            font-size: 14px;
                            font-weight: 700;
                            margin-bottom: 6px;
                        }

                        .inn-score {
                            font-size: 36px;
                            font-weight: 900;
                            line-height: 1;
                        }

                        .inn-score span {
                            font-size: 22px;
                            opacity: 0.7;
                        }

                        .inn-overs {
                            font-size: 12px;
                            opacity: 0.8;
                            margin-top: 4px;
                        }

                        .section-title {
                            font-size: 11px;
                            font-weight: 700;
                            color: #1a472a;
                            text-transform: uppercase;
                            letter-spacing: 2px;
                            margin-bottom: 12px;
                            margin-top: 20px;
                        }

                        .over-table {
                            width: 100%;
                            border-collapse: collapse;
                            margin-bottom: 8px;
                            font-size: 14px;
                        }

                        .over-table th {
                            padding: 10px 12px;
                            text-align: left;
                            font-size: 11px;
                            letter-spacing: 1px;
                            text-transform: uppercase;
                            color: white;
                        }

                        .over-table.t1 th {
                            background: linear-gradient(135deg, #1a472a, #2d6a4f);
                        }

                        .over-table.t2 th {
                            background: linear-gradient(135deg, #1565c0, #1976d2);
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
                            margin-bottom: 16px;
                        }

                        .fow-badge {
                            background: #fff0f0;
                            border: 1px solid #ffcccc;
                            color: #c0392b;
                            padding: 4px 12px;
                            border-radius: 20px;
                            font-size: 12px;
                            font-weight: 700;
                        }

                        .btn-row {
                            display: flex;
                            gap: 12px;
                            margin-top: 24px;
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
                            <p>Final Scorecard</p>
                        </div>

                        <div class="card">

                            <div class="match-title">
                                <h2>
                                    <%= match.getTeam1() %> vs <%= match.getTeam2() %>
                                </h2>
                                <p>Toss: <%= match.getTossWinner() %> •
                                        <%= match.getTotalOvers() %> Overs Match</p>
                            </div>

                            <!-- Winner Banner -->
                            <div class="winner-banner">
                                <div class="trophy">🏆</div>
                                <div class="winner-text">
                                    <%= match.getWinner() %>
                                </div>
                            </div>

                            <!-- Both Innings Scores -->
                            <div class="innings-grid">
                                <div class="innings-box inn1">
                                    <div class="inn-label">1st Innings</div>
                                    <div class="inn-team">
                                        <%= match.getTeam1() %>
                                    </div>
                                    <div class="inn-score">
                                        <%= match.getRuns1() %><span>/<%= match.getWickets1() %></span>
                                    </div>
                                    <div class="inn-overs">
                                        (<%= match.getCompletedOvers1() %>.<%= match.getBallsInOver1() %> Overs)
                                    </div>
                                </div>
                                <div class="innings-box inn2">
                                    <div class="inn-label">2nd Innings</div>
                                    <div class="inn-team">
                                        <%= match.getTeam2() %>
                                    </div>
                                    <div class="inn-score">
                                        <%= match.getRuns2() %><span>/<%= match.getWickets2() %></span>
                                    </div>
                                    <div class="inn-overs">
                                        (<%= match.getCompletedOvers2() %>.<%= match.getBallsInOver2() %> Overs)
                                    </div>
                                </div>
                            </div>

                            <!-- Innings 1 Over by Over -->
                            <div class="section-title">
                                <%= match.getTeam1() %> — Over by Over
                            </div>
                            <table class="over-table t1">
                                <tr>
                                    <th>Over</th>
                                    <th>Balls</th>
                                    <th>Runs</th>
                                </tr>
                                <% List<List<String>> overs1 = match.getAllOvers1();
                                    for (int i = 0; i < overs1.size(); i++) { List<String> over = overs1.get(i);
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

                            <!-- Innings 1 Fall of Wickets -->
                            <% if (!match.getFallOfWickets1().isEmpty()) { %>
                                <div class="section-title">🔴 <%= match.getTeam1() %> — Fall of Wickets</div>
                                <div class="fow-list">
                                    <% for (String fow : match.getFallOfWickets1()) { %>
                                        <span class="fow-badge">🔴 <%= fow %></span>
                                        <% } %>
                                </div>
                                <% } %>

                                    <!-- Innings 2 Over by Over -->
                                    <div class="section-title">
                                        <%= match.getTeam2() %> — Over by Over
                                    </div>
                                    <table class="over-table t2">
                                        <tr>
                                            <th>Over</th>
                                            <th>Balls</th>
                                            <th>Runs</th>
                                        </tr>
                                        <% List<List<String>> overs2 = match.getAllOvers2();
                                            for (int i = 0; i < overs2.size(); i++) { List<String> over = overs2.get(i);
                                                int overRuns = 0;
                                                for (String b : over) {
                                                try { overRuns += Integer.parseInt(b); }
                                                catch (NumberFormatException e) {
                                                if (b.equals("WD") || b.equals("NB")) overRuns += 1;
                                                }
                                                }
                                                %>
                                                <tr>
                                                    <td><b style="color:#1565c0">Over <%= (i+1) %></b></td>
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

                                    <!-- Innings 2 Fall of Wickets -->
                                    <% if (!match.getFallOfWickets2().isEmpty()) { %>
                                        <div class="section-title">🔴 <%= match.getTeam2() %> — Fall of Wickets</div>
                                        <div class="fow-list">
                                            <% for (String fow : match.getFallOfWickets2()) { %>
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