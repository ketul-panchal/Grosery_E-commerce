<%@ Page Language="C#" AutoEventWireup="true" EnableEventValidation="false" CodeFile="Cart.aspx.cs" Inherits="Cart" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Grocery Shop - Cart</title>
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
        .cart-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #ddd;
            padding: 10px 0;
        }
        .cart-item img {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 5px;
        }
        .cart-item h4 {
            font-size: 18px;
            margin: 0;
        }
        .cart-item p {
            font-size: 16px;
            color: #666;
            margin: 5px 0;
        }
        .btn-remove {
            background-color: #dc3545;
            color: white;
            padding: 8px 10px;
            font-size: 14px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .btn-remove:hover {
            background-color: #c82333;
        }
        .cart-total {
            text-align: right;
            font-size: 20px;
            font-weight: bold;
            margin-top: 10px;
        }
        .btn-checkout {
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
        .btn-checkout:hover {
            background-color: #0056b3;
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
                <a href="Logout.aspx" class="logout-btn">Logout</a>
            </div>
        </div>

        <div class="container">
            <h2>Your Shopping Cart</h2>
            <asp:Repeater ID="rptCart" runat="server">
                <ItemTemplate>
                    <div class="cart-item">
                        <img src='<%# Eval("ImageURL") %>' alt="Product Image" />
                        <div>
                            <h4><%# Eval("ProductName") %></h4>
                            <p>Price: $<%# Eval("Price") %></p>
                            <p>Quantity: <%# Eval("Quantity") %></p>
                        </div>
                        <asp:Button ID="btnRemove" runat="server" CssClass="btn-remove" Text="Remove" CommandArgument='<%# Eval("CartID") %>' OnClick="btnRemove_Click" />
                    </div>
                </ItemTemplate>
            </asp:Repeater>

            <div class="cart-total">
                Total: $<asp:Label ID="lblTotalAmount" runat="server" Text="0.00"></asp:Label>
            </div>

            <asp:Button ID="btnCheckout" runat="server" CssClass="btn-checkout" Text="Proceed to Checkout" OnClick="btnCheckout_Click" />
        </div>

    </form>
</body>
</html>
