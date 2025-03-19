<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdminCategories.aspx.cs" Inherits="AdminCategories" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Manage Categories - Admin Panel</title>
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
            width: 97%;
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
        .category-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .category-table th, .category-table td {
            padding: 10px;
            border: 1px solid #ccc;
            text-align: left;
        }
        .category-table th {
            background: #007bff;
            color: white;
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
                <a href="AdminCategories.aspx">Categories</a>
            </div>
            <div>
                <asp:Button ID="btnLogout" runat="server" CssClass="btn btn-delete" Text="Logout" OnClick="btnLogout_Click" />
            </div>
        </div>

        <div class="container">
            <h2>Manage Categories</h2>

            <!-- Category Form (Add/Edit) -->
            <div class="category-form">
                <asp:HiddenField ID="hdnCategoryID" runat="server" />
                <asp:TextBox ID="txtCategoryName" runat="server" CssClass="form-control" Placeholder="Category Name"></asp:TextBox>
                <asp:Button ID="btnAddCategory" runat="server" CssClass="btn btn-add" Text="Add Category" OnClick="btnAddCategory_Click" />
                <asp:Button ID="btnUpdateCategory" runat="server" CssClass="btn btn-update" Text="Update Category" Visible="false" OnClick="btnUpdateCategory_Click" />
            </div>

            <!-- Category List Table -->
            <asp:GridView ID="gvCategories" runat="server" CssClass="category-table" AutoGenerateColumns="False" OnRowCommand="gvCategories_RowCommand">
                <Columns>
                    <asp:BoundField DataField="CategoryID" HeaderText="ID" />
                    <asp:BoundField DataField="CategoryName" HeaderText="Category Name" />
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:Button ID="btnEdit" runat="server" CssClass="btn btn-update" Text="Edit" CommandName="EditCategory" CommandArgument='<%# Eval("CategoryID") %>' />
                            <asp:Button ID="btnDelete" runat="server" CssClass="btn btn-delete" Text="Delete" CommandName="DeleteCategory" CommandArgument='<%# Eval("CategoryID") %>' OnClientClick="return confirm('Are you sure you want to delete this category?');" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
        <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>


    </form>
</body>
</html>
