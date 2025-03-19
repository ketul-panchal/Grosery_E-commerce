<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdminUsers.aspx.cs" Inherits="AdminUsers" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Manage Users - Admin Panel</title>
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
        .user-form {
            margin-bottom: 20px;
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
        .user-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .user-table th, .user-table td {
            padding: 10px;
            border: 1px solid #ccc;
            text-align: left;
        }
        .user-table th {
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
            </div>
            <div>
                <asp:Button ID="btnLogout" runat="server" CssClass="btn btn-delete" Text="Logout" OnClick="btnLogout_Click" />
            </div>
        </div>

        <div class="container">
            <h2>Manage Users</h2>

            <!-- User Form (Add/Edit) -->
            <div class="user-form">
                <asp:HiddenField ID="hdnUserID" runat="server" />
                <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" Placeholder="Username"></asp:TextBox>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" Placeholder="Email"></asp:TextBox>
                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" Placeholder="Password"></asp:TextBox>
                <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-control">
                    <asp:ListItem Text="Admin" Value="Admin"></asp:ListItem>
                    <asp:ListItem Text="Customer" Value="Customer"></asp:ListItem>
                </asp:DropDownList>
                <asp:Button ID="btnAddUser" runat="server" CssClass="btn btn-add" Text="Add User" OnClick="btnAddUser_Click" />
                <asp:Button ID="btnUpdateUser" runat="server" CssClass="btn btn-update" Text="Update User" Visible="false" OnClick="btnUpdateUser_Click" />
            </div>

            <!-- User List Table -->
            <asp:GridView ID="gvUsers" runat="server" CssClass="user-table" AutoGenerateColumns="False" OnRowCommand="gvUsers_RowCommand">
                <Columns>
                    <asp:BoundField DataField="UserID" HeaderText="User ID" />
                    <asp:BoundField DataField="Username" HeaderText="Username" />
                    <asp:BoundField DataField="Email" HeaderText="Email" />
                    <asp:BoundField DataField="Role" HeaderText="Role" />
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:Button ID="btnEdit" runat="server" CssClass="btn btn-update" Text="Edit" CommandName="EditUser" CommandArgument='<%# Eval("UserID") %>' />
                            <asp:Button ID="btnDelete" runat="server" CssClass="btn btn-delete" Text="Delete" CommandName="DeleteUser" CommandArgument='<%# Eval("UserID") %>' OnClientClick="return confirm('Are you sure you want to delete this user?');" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>

    </form>
</body>
</html>
