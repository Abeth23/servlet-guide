<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <title>Success</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background: #f0f2f5;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
            }

            .card {
                background: white;
                padding: 40px;
                border-radius: 10px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                width: 400px;
                text-align: center;
            }

            .icon {
                font-size: 52px;
                margin-bottom: 12px;
            }

            h2 {
                color: #28a745;
                margin-bottom: 8px;
            }

            .message-box {
                background: #f8fff9;
                border: 1px solid #c3e6cb;
                color: #155724;
                padding: 20px;
                border-radius: 8px;
                font-size: 18px;
                margin: 20px 0;
                line-height: 1.5;
            }

            .back-link {
                display: inline-block;
                margin-top: 10px;
                padding: 10px 24px;
                background: #007bff;
                color: white;
                border-radius: 6px;
                text-decoration: none;
                font-size: 14px;
            }

            .back-link:hover {
                background: #0056b3;
            }
        </style>
    </head>

    <body>
        <div class="card">
            <div class="icon">✅</div>
            <h2>Submission Successful!</h2>

            <div class="message-box">
                <%= request.getAttribute("message") %>
            </div>

            <a href="index.jsp" class="back-link">Go Back</a>
        </div>
    </body>

    </html>