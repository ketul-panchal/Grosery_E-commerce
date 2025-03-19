<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdminHome.aspx.cs" Inherits="AdminHome" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Admin Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }
        .navbar {
            background-color: #343a40;
            color: white;
            padding: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .navbar a {
            color: white;
            text-decoration: none;
            font-size: 18px;
            margin: 0 15px;
        }
        .navbar a:hover {
            text-decoration: underline;
        }
        .container {
            width: 90%;
            max-width: 800px;
            margin: 20px auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        .admin-options {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            margin-top: 20px;
        }
        .admin-box {
            width: 200px;
            background: #007bff;
            color: white;
            padding: 15px;
            border-radius: 8px;
            margin: 10px;
            text-align: center;
            font-size: 18px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s;
        }
        .admin-box:hover {
            background: #0056b3;
        }
        .logout-btn {
            background: #dc3545;
            padding: 10px 15px;
            border-radius: 5px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            text-decoration: none;
            color: white;
        }
        .logout-btn:hover {
            background: #c82333;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        
        <!-- Navigation Bar -->
        <div class="navbar">
            <div>
                <a href="AdminHome.aspx">Dashboard</a>
                <a href="AdminOrders.aspx">Orders</a>
                <a href="AdminProducts.aspx">Products</a>
                <a href="AdminUsers.aspx">Users</a>
            </div>
            <div>
                <span>Welcome, <asp:Label ID="lblAdminName" runat="server"></asp:Label>!</span>
                <asp:Button ID="btnLogout" runat="server" CssClass="logout-btn" Text="Logout" OnClick="btnLogout_Click" />
            </div>
        </div>

        <!-- Admin Dashboard Options -->
        <div class="container">
            <h2>Admin Dashboard</h2>
            <div class="admin-options">
                <a href="AdminOrders.aspx">
                    <div class="admin-box">Manage Orders</div>
                </a>
                <a href="AdminProducts.aspx">
                    <div class="admin-box">Manage Products</div>
                </a>
                <a href="AdminUsers.aspx">
                    <div class="admin-box">Manage Users</div>
                </a>
                <a href="AdminCategories.aspx">
                    <div class="admin-box">Manage Categories</div>
                </a>
            </div>
        </div>

    </form>
</body>
</html>
