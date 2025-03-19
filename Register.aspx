<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Grocery Shop - Register</title>
    <style>
        body {
            background: url('images/grocery-background.jpg') no-repeat center center fixed;
            background-size: cover;
            font-family: Arial, sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
        }
        .register-container {
            width: 100%;
            max-width: 420px;
            background: rgba(255, 255, 255, 0.95);
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.2);
            text-align: center;
        }
        .form-control {
            width: 94%;
            padding: 14px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 18px;
        }
        .btn-register {
            width: 100%;
            background-color: #28a745;
            color: white;
            padding: 14px;
            font-size: 18px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
        }
        .btn-register:hover {
            background-color: #218838;
        }
        .brand-logo {
            width: 100px;
            margin-bottom: 15px;
        }
        .heading {
            font-size: 26px;
            font-weight: bold;
            color: #28a745;
        }
        .subheading {
            font-size: 18px;
            color: #555;
            margin-bottom: 20px;
        }
        .text-muted {
            font-size: 16px;
            margin-top: 14px;
        }
        .text-muted a {
            color: #28a745;
            text-decoration: none;
        }
        .text-muted a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="register-container">
            <img src="images/logo.jpg" class="brand-logo" alt="Grocery Shop Logo" />
            
            <h3 class="heading">Create an Account</h3>
            <p class="subheading">Join Grocery Shop Today!</p>

            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" Placeholder="Enter Username"></asp:TextBox>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" Placeholder="Enter Email"></asp:TextBox>
            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" Placeholder="Enter Password"></asp:TextBox>

            <asp:Button ID="btnRegister" runat="server" CssClass="btn-register" Text="Register" OnClick="btnRegister_Click" />

            <div class="mt-2">
                <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
            </div>

            <hr />

            <div class="text-muted">
                Already have an account? <a href="Login.aspx">Login</a>
            </div>
        </div>
    </form>
</body>
</html>
