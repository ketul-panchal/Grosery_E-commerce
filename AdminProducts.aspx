<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdminProducts.aspx.cs" Inherits="AdminProducts" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Manage Products - Admin Panel</title>
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
            width: 96%;
            padding: 10px;
            margin: 5px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .btn {
            padding: 10px 15px;
            border-radius: 5px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            margin-top: 10px;
        }
        .btn-add {
            background: #007bff;
            color: white;
            border: none;
        }
        .btn-update {
            background: #28a745;
            color: white;
            border: none;
        }
        .btn-delete {
            background: #dc3545;
            color: white;
            border: none;
        }
        .product-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .product-table th, .product-table td {
            padding: 10px;
            border: 1px solid #ccc;
            text-align: left;
        }
        .product-table th {
            background: #007bff;
            color: white;
        }
        .product-img {
            width: 50px;
            height: 50px;
            object-fit: cover;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" enctype="multipart/form-data">

        <!-- Navigation Bar -->
        <div class="navbar">
            <div>
                <a href="AdminHome.aspx">Dashboard</a>
                <a href="AdminOrders.aspx">Orders</a>
                <a href="AdminProducts.aspx">Products</a>
                <a href="AdminUsers.aspx">Users</a>
            </div>
            <div>
                <asp:Button ID="btnLogout" runat="server" CssClass="btn btn-delete" Text="Logout" OnClick="btnLogout_Click" />
            </div>
        </div>

        <div class="container">
            <h2>Manage Products</h2>

            <!-- Product Form (Add/Edit) -->
            <div class="product-form">
                <asp:HiddenField ID="hdnProductID" runat="server" />
                <asp:TextBox ID="txtProductName" runat="server" CssClass="form-control" Placeholder="Product Name"></asp:TextBox>
                <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" Placeholder="Description"></asp:TextBox>
                <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control" TextMode="Number" Placeholder="Price"></asp:TextBox>
                <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control"></asp:DropDownList>
                <asp:FileUpload ID="fileUpload" runat="server" CssClass="form-control" />
                <asp:Button ID="btnAddProduct" runat="server" CssClass="btn btn-add" Text="Add Product" OnClick="btnAddProduct_Click" />
                <asp:Button ID="btnUpdateProduct" runat="server" CssClass="btn btn-update" Text="Update Product" Visible="false" OnClick="btnUpdateProduct_Click" />
            </div>

            <!-- Product List Table -->
            <asp:GridView ID="gvProducts" runat="server" CssClass="product-table" AutoGenerateColumns="False" OnRowCommand="gvProducts_RowCommand">
                <Columns>
                    <asp:BoundField DataField="ProductID" HeaderText="ID" />
                    <asp:BoundField DataField="ProductName" HeaderText="Product Name" />
                    <asp:BoundField DataField="Description" HeaderText="Description" />
                    <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="₹{0:N2}" />
                   <asp:TemplateField HeaderText="Image">
                     <ItemTemplate>
                        <img src='<%# ResolveUrl("~/") + Eval("ImageURL") %>' class="product-img" />
                     </ItemTemplate>
                   </asp:TemplateField>
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:Button ID="btnEdit" runat="server" CssClass="btn btn-update" Text="Edit" CommandName="EditProduct" CommandArgument='<%# Eval("ProductID") %>' />
                            <asp:Button ID="btnDelete" runat="server" CssClass="btn btn-delete" Text="Delete" CommandName="DeleteProduct" CommandArgument='<%# Eval("ProductID") %>' OnClientClick="return confirm('Are you sure you want to delete this product?');" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>

    </form>
</body>
</html>
