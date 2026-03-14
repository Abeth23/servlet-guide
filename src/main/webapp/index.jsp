<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <title>Greeting App</title>
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
                width: 360px;
            }

            h2 {
                color: #333;
                text-align: center;
                margin-bottom: 24px;
            }

            label {
                font-size: 13px;
                color: #555;
                display: block;
                margin-bottom: 4px;
            }

            input {
                width: 100%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 6px;
                font-size: 14px;
                box-sizing: border-box;
                margin-bottom: 16px;
            }

            button {
                width: 100%;
                padding: 12px;
                background: #007bff;
                color: white;
                border: none;
                border-radius: 6px;
                font-size: 15px;
                cursor: pointer;
            }

            button:hover {
                background: #0056b3;
            }

            .error {
                background: #ffe0e0;
                border: 1px solid #f5c6cb;
                color: #c00;
                padding: 10px;
                border-radius: 6px;
                margin-bottom: 16px;
                font-size: 13px;
                text-align: center;
            }
        </style>
    </head>

    <body>
        <div class="card">
            <h2>Greeting App</h2>

            <% if ("true".equals(request.getParameter("error"))) { %>
                <div class="error">Please fill in both Name and Phone.</div>
                <% } %>

                    <form action="greet" method="POST">
                        <label for="name">Full Name</label>
                        <input type="text" id="name" name="name" placeholder="Abethnego S" required />

                        <label for="phone">Phone Number</label>
                        <input type="tel" id="phone" name="phone" placeholder="+91 98765 43210" required />

                        <button type="submit">Submit</button>
                    </form>
        </div>
    </body>

    </html>