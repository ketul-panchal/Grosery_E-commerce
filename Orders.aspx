<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Orders.aspx.cs" Inherits="Orders" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Grocery Shop - My Orders</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }
        .navbar {
            background-color: #28a745;
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
        }
        .order-box {
            background: #fff;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            margin-bottom: 15px;
        }
        .order-box h3 {
            margin: 0;
            font-size: 18px;
            color: #333;
        }
        .order-box p {
            margin: 5px 0;
            font-size: 16px;
            color: #666;
        }
        .status {
            font-weight: bold;
            color: #007bff;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <!-- Navigation Bar -->
        <div class="navbar">
            <div>
                <a href="Home.aspx">Home</a>
                <a href="Cart.aspx">Cart</a>
                <a href="Orders.aspx">My Orders</a>
            </div>
            <div>
                <span>Welcome, <asp:Label ID="lblUsername" runat="server"></asp:Label>!</span>
                <asp:Button ID="btnLogout" runat="server" CssClass="logout-btn" Text="Logout" OnClick="btnLogout_Click" />
            </div>
        </div>

        <div class="container">
            <h2>My Orders</h2>

            <asp:Repeater ID="rptOrders" runat="server">
                <ItemTemplate>
                    <div class="order-box">
                        <h3>Order #<%# Eval("OrderID") %></h3>
                        <p><strong>Placed On:</strong> <%# Eval("OrderDate") %></p>
                        <p><strong>Status:</strong> <span class="status"><%# Eval("Status") %></span></p>
                        <p><strong>Total Amount:</strong> ₹<%# Eval("TotalAmount") %></p>
                        <p><strong>Products:</strong> <%# Eval("Products") %></p>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

            <asp:Label ID="lblNoOrders" runat="server" ForeColor="Red" Visible="false" Text="You have not placed any orders yet."></asp:Label>
        </div>

    </form>
</body>
</html>
