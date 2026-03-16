<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="com.hulkhire.servlet.Match" %>
        <% Match match=(Match) request.getAttribute("match"); if (match==null) { response.sendRedirect("index.jsp");
            return; } %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <title>CricTrack - Innings Break</title>
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
                        display: flex;
                        justify-content: center;
                        align-items: center;
                        padding: 20px;
                    }

                    .card {
                        background: white;
                        border-radius: 24px;
                        padding: 40px;
                        max-width: 480px;
                        width: 100%;
                        box-shadow: 0 24px 64px rgba(0, 0, 0, 0.4);
                        text-align: center;
                        animation: popIn 0.6s cubic-bezier(0.175, 0.885, 0.32, 1.275);
                    }

                    @keyframes popIn {
                        from {
                            opacity: 0;
                            transform: scale(0.85);
                        }

                        to {
                            opacity: 1;
                            transform: scale(1);
                        }
                    }

                    .icon {
                        font-size: 56px;
                        margin-bottom: 12px;
                    }

                    h2 {
                        font-size: 26px;
                        color: #1a472a;
                        margin-bottom: 6px;
                    }

                    .subtitle {
                        color: #888;
                        font-size: 13px;
                        margin-bottom: 28px;
                    }

                    .divider {
                        height: 3px;
                        background: linear-gradient(90deg, #1a472a, #52b788);
                        border-radius: 2px;
                        margin-bottom: 24px;
                    }

                    /* Innings 1 Summary */
                    .innings-summary {
                        background: #f8f9fa;
                        border-radius: 14px;
                        padding: 20px;
                        margin-bottom: 20px;
                    }

                    .innings-label {
                        font-size: 11px;
                        color: #888;
                        text-transform: uppercase;
                        letter-spacing: 1px;
                        margin-bottom: 6px;
                    }

                    .innings-team {
                        font-size: 16px;
                        font-weight: 700;
                        color: #333;
                        margin-bottom: 8px;
                    }

                    .innings-score {
                        font-size: 48px;
                        font-weight: 900;
                        color: #1a472a;
                        line-height: 1;
                    }

                    .innings-score span {
                        font-size: 28px;
                        color: #aaa;
                    }

                    .innings-overs {
                        font-size: 14px;
                        color: #888;
                        margin-top: 4px;
                    }

                    /* Target Box */
                    .target-box {
                        background: linear-gradient(135deg, #1a472a, #52b788);
                        border-radius: 14px;
                        padding: 20px;
                        margin-bottom: 24px;
                        color: white;
                    }

                    .target-label {
                        font-size: 12px;
                        opacity: 0.8;
                        text-transform: uppercase;
                        letter-spacing: 1px;
                        margin-bottom: 6px;
                    }

                    .target-number {
                        font-size: 56px;
                        font-weight: 900;
                        line-height: 1;
                    }

                    .target-desc {
                        font-size: 14px;
                        opacity: 0.85;
                        margin-top: 6px;
                    }

                    /* Start button */
                    .start-btn {
                        width: 100%;
                        padding: 16px;
                        background: linear-gradient(135deg, #1a472a, #52b788);
                        color: white;
                        border: none;
                        border-radius: 14px;
                        font-size: 17px;
                        font-weight: 700;
                        cursor: pointer;
                        transition: opacity 0.3s, transform 0.1s;
                        letter-spacing: 0.5px;
                    }

                    .start-btn:hover {
                        opacity: 0.92;
                        transform: translateY(-2px);
                    }

                    .footer {
                        color: #bbb;
                        font-size: 11px;
                        margin-top: 20px;
                    }
                </style>
            </head>

            <body>
                <div class="card">
                    <div class="icon">🏏</div>
                    <h2>Innings Break</h2>
                    <p class="subtitle">First innings complete. Time to chase!</p>

                    <div class="divider"></div>

                    <!-- Innings 1 Summary -->
                    <div class="innings-summary">
                        <div class="innings-label">1st Innings — <%= match.getTeam1() %>
                        </div>
                        <div class="innings-score">
                            <%= match.getRuns1() %><span>/<%= match.getWickets1() %></span>
                        </div>
                        <div class="innings-overs">
                            (<%= match.getCompletedOvers1() %>.<%= match.getBallsInOver1() %> Overs)
                        </div>
                    </div>

                    <!-- Target -->
                    <div class="target-box">
                        <div class="target-label">🎯 Target for <%= match.getTeam2() %>
                        </div>
                        <div class="target-number">
                            <%= match.getTarget() %>
                        </div>
                        <div class="target-desc">
                            <%= match.getTeam2() %> needs <%= match.getTarget() %> runs
                                    in <%= match.getTotalOvers() %> overs to win
                        </div>
                    </div>

                    <!-- Start Innings 2 Button -->
                    <form action="innings-break" method="POST">
                        <button type="submit" class="start-btn">
                            🏏 Start <%= match.getTeam2() %> Innings →
                        </button>
                    </form>

                    <p class="footer">CricTrack • Hulkhire Tech • Bengaluru</p>
                </div>
            </body>

            </html>