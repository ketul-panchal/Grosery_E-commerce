<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Checkout.aspx.cs" Inherits="Checkout" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Grocery Shop - Checkout</title>
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
        .form-control {
            width: 100%;
            padding: 12px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 16px;
        }
        .btn-place-order {
            width: 100%;
            background-color: #007bff;
            color: white;
            padding: 12px;
            font-size: 18px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 15px;
        }
        .btn-place-order:hover {
            background-color: #0056b3;
        }
        .cart-summary {
            text-align: right;
            font-size: 18px;
            font-weight: bold;
            margin-top: 10px;
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
                <a href="Orders.aspx">Orders</a>
            </div>
            <div>
                <span>Welcome, <asp:Label ID="lblUsername" runat="server"></asp:Label>!</span>
                <asp:Button ID="btnLogout" runat="server" CssClass="logout-btn" Text="Logout" OnClick="btnLogout_Click" />
            </div>
        </div>

        <div class="container">
            <h2>Checkout</h2>

            <!-- Shipping Details -->
            <h3>Shipping Information</h3>
            <asp:TextBox ID="txtName" runat="server" CssClass="form-control" Placeholder="Full Name"></asp:TextBox>
            <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" Placeholder="Address"></asp:TextBox>
            <asp:TextBox ID="txtCity" runat="server" CssClass="form-control" Placeholder="City"></asp:TextBox>
            <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" Placeholder="Phone Number"></asp:TextBox>

            <!-- Cart Summary -->
            <h3>Order Summary</h3>
            <asp:Repeater ID="rptCart" runat="server">
                <ItemTemplate>
                    <div>
                        <p><strong><%# Eval("ProductName") %></strong> - ₹<%# Eval("Price") %> x <%# Eval("Quantity") %></p>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

            <div class="cart-summary">
                Total: ₹<asp:Label ID="lblTotalAmount" runat="server" Text="0.00"></asp:Label>
            </div>

            <!-- Place Order Button -->
            <asp:Button ID="btnPlaceOrder" runat="server" CssClass="btn-place-order" Text="Place Order" OnClick="btnPlaceOrder_Click" />
        </div>

    </form>
</body>
</html>
