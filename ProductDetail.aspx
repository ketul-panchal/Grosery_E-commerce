<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ProductDetail.aspx.cs" Inherits="ProductDetail" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Product Details</title>
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
            margin: 50px auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        .product-img {
            width: 100%;
            max-width: 400px;
            height: auto;
            border-radius: 8px;
            margin-bottom: 15px;
        }
        .btn {
            display: inline-block;
            padding: 10px 15px;
            font-size: 16px;
            font-weight: bold;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 10px;
        }
        .btn-cart {
            background-color: #007bff;
            color: white;
        }
        .btn-cart:hover {
            background-color: #0056b3;
        }
        .btn-back {
            background-color: #28a745;
            color: white;
            text-decoration: none;
            padding: 10px 15px;
            display: inline-block;
            margin-top: 15px;
            border-radius: 5px;
        }
        .btn-back:hover {
            background-color: #218838;
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
            <img id="imgProduct" runat="server" class="product-img" />
            <h2 id="lblProductName" runat="server"></h2>
            <h3 class="price">₹<asp:Label ID="lblPrice" runat="server"></asp:Label></h3>
            <p id="lblDescription" runat="server"></p>

            <asp:Button ID="btnAddToCart" runat="server" CssClass="btn btn-cart" Text="Add to Cart"
                OnClick="btnAddToCart_Click" />

            <a href="Home.aspx" class="btn-back">Back to Home</a>
        </div>

    </form>
</body>
</html>
