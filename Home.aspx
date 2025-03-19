<%@ Page Language="C#" AutoEventWireup="true" EnableEventValidation="false" CodeFile="Home.aspx.cs" Inherits="Home" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Grocery Shop - Home</title>
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
            max-width: 1200px;
            margin: 20px auto;
        }
        .category-header {
            font-size: 22px;
            font-weight: bold;
            color: #28a745;
            margin-bottom: 15px;
            border-bottom: 2px solid #28a745;
            padding-bottom: 5px;
        }
        .product-card {
            width: 240px;
            background: white;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin: 15px;
            display: inline-block;
            vertical-align: top;
            text-align: center;
        }
        .product-card a {
            text-decoration: none;
            color: inherit;
        }
        .product-card img {
            width: 100%;
            height: 180px;
            object-fit: cover;
            border-radius: 6px;
        }
        .product-card h3 {
            font-size: 18px;
            margin: 10px 0;
            color: #333;
        }
        .product-card p {
            font-size: 16px;
            color: #666;
            margin: 5px 0;
        }
        .product-card .price {
            font-size: 18px;
            font-weight: bold;
            color: #28a745;
        }
        .btn {
            display: block;
            width: 100%;
            padding: 10px;
            font-size: 16px;
            font-weight: bold;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .btn-cart {
            background-color: #007bff;
            color: white;
        }
        .btn-cart:hover {
            background-color: #0056b3;
        }
        .btn-checkout {
            background-color: #dc3545;
            color: white;
            margin-top: 10px;
        }
        .btn-checkout:hover {
            background-color: #c82333;
        }
        .logout-btn {
            background: black;
            color: #28a745;
            padding: 8px 15px;
            border-radius: 5px;
            text-decoration: none;
            font-weight: bold;
        }
        .logout-btn:hover {
            background: #e0e0e0;
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
            <asp:Repeater ID="rptCategories" runat="server">
                <ItemTemplate>
                    <div class="category-header"><%# Eval("CategoryName") %></div>
                    
                    <asp:Repeater ID="rptProducts" runat="server" DataSource='<%# Eval("Products") %>'>
                        <ItemTemplate>
                            <div class="product-card">
                                <a href='ProductDetail.aspx?ProductID=<%# Eval("ProductID") %>'>
                                    <img src='<%# ResolveUrl("~/" + Eval("ImageURL")) %>' alt="Product Image" />
                                </a>
                                <h3>
                                    <a href='ProductDetail.aspx?ProductID=<%# Eval("ProductID") %>'>
                                        <%# Eval("ProductName") %>
                                    </a>
                                </h3>
                                <p class="price">₹<%# Eval("Price") %></p>
                                <p><%# Eval("Description") %></p>

                                <!-- Add to Cart Button (Now using OnCommand instead of OnClick) -->
                                <asp:Button ID="btnAddToCart" runat="server" CssClass="btn btn-cart" Text="Add to Cart"
                                    CommandArgument='<%# Eval("ProductID") %>' OnCommand="btnAddToCart_Command" />

                                <!-- Checkout Button -->
                                <asp:Button ID="btnCheckout" runat="server" CssClass="btn btn-checkout" Text="Checkout"
                                    OnClick="btnCheckout_Click" />
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </ItemTemplate>
            </asp:Repeater>
        </div>

    </form>
</body>
</html>
