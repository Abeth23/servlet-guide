<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <title>CricTrack - Setup Match</title>
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
                padding: 40px;
                border-radius: 24px;
                box-shadow: 0 24px 64px rgba(0, 0, 0, 0.4);
                width: 100%;
                max-width: 460px;
                animation: slideUp 0.5s ease;
            }

            @keyframes slideUp {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }

                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .header {
                text-align: center;
                margin-bottom: 32px;
            }

            .logo {
                font-size: 52px;
                margin-bottom: 8px;
            }

            h2 {
                font-size: 26px;
                color: #1a472a;
                margin-bottom: 4px;
            }

            .subtitle {
                color: #888;
                font-size: 13px;
            }

            .divider {
                height: 3px;
                background: linear-gradient(90deg, #1a472a, #52b788);
                border-radius: 2px;
                margin: 20px 0;
            }

            .form-group {
                margin-bottom: 18px;
            }

            label {
                display: block;
                font-size: 12px;
                font-weight: 700;
                color: #555;
                margin-bottom: 6px;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            input,
            select {
                width: 100%;
                padding: 12px 16px;
                border: 2px solid #e0e0e0;
                border-radius: 10px;
                font-size: 15px;
                transition: border-color 0.3s;
                outline: none;
                color: #333;
            }

            input:focus,
            select:focus {
                border-color: #2d6a4f;
            }

            input.err {
                border-color: #e74c3c;
            }

            .err-msg {
                color: #e74c3c;
                font-size: 11px;
                margin-top: 4px;
                display: none;
            }

            .err-msg.show {
                display: block;
            }

            .two-col {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 14px;
            }

            .error-banner {
                background: #ffe0e0;
                border: 1px solid #f5c6cb;
                color: #c00;
                padding: 10px;
                border-radius: 10px;
                margin-bottom: 16px;
                font-size: 13px;
                text-align: center;
            }

            button[type="submit"] {
                width: 100%;
                padding: 14px;
                background: linear-gradient(135deg, #1a472a, #52b788);
                color: white;
                border: none;
                border-radius: 12px;
                font-size: 16px;
                font-weight: 700;
                cursor: pointer;
                transition: opacity 0.3s, transform 0.1s;
                margin-top: 8px;
            }

            button[type="submit"]:hover {
                opacity: 0.92;
                transform: translateY(-2px);
            }

            .footer {
                text-align: center;
                color: #bbb;
                font-size: 11px;
                margin-top: 20px;
            }
        </style>
    </head>

    <body>
        <div class="card">
            <div class="header">
                <div class="logo">🏏</div>
                <h2>CricTrack</h2>
                <p class="subtitle">Ball by ball cricket scorer</p>
            </div>

            <div class="divider"></div>

            <% if ("true".equals(request.getParameter("error"))) { %>
                <div class="error-banner">⚠️ Please fill all fields correctly.</div>
                <% } %>

                    <form action="start-match" method="POST" id="matchForm">

                        <div class="two-col">
                            <div class="form-group">
                                <label>Team 1</label>
                                <input type="text" name="team1" id="team1" placeholder="e.g. India" />
                                <div class="err-msg" id="t1err">Required</div>
                            </div>
                            <div class="form-group">
                                <label>Team 2</label>
                                <input type="text" name="team2" id="team2" placeholder="e.g. Australia" />
                                <div class="err-msg" id="t2err">Required</div>
                            </div>
                        </div>

                        <div class="two-col">
                            <div class="form-group">
                                <label>Total Overs</label>
                                <select name="overs">
                                    <option value="5">5 Overs</option>
                                    <option value="10">10 Overs</option>
                                    <option value="20" selected>20 Overs (T20)</option>
                                    <option value="50">50 Overs (ODI)</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Toss Winner</label>
                                <select name="toss">
                                    <option value="Team 1">Team 1</option>
                                    <option value="Team 2">Team 2</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label>Venue</label>
                            <input type="text" name="venue" id="venue" placeholder="e.g. Wankhede Stadium, Mumbai" />
                            <div class="err-msg" id="verr">Required</div>
                        </div>

                        <button type="submit">🏏 Start Match</button>
                    </form>

                    <p class="footer">CricTrack • Hulkhire Tech • Bengaluru</p>
        </div>

        <script>
            document.getElementById('matchForm').addEventListener('submit', function (e) {
                let valid = true;
                const fields = [
                    { id: 'team1', errId: 't1err' },
                    { id: 'team2', errId: 't2err' },
                    { id: 'venue', errId: 'verr' },
                ];
                fields.forEach(f => {
                    const el = document.getElementById(f.id);
                    const err = document.getElementById(f.errId);
                    el.classList.remove('err');
                    err.classList.remove('show');
                    if (el.value.trim() === '') {
                        el.classList.add('err');
                        err.classList.add('show');
                        valid = false;
                    }
                });
                if (!valid) e.preventDefault();
            });
        </script>
    </body>

    </html>