<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdminOrders.aspx.cs" Inherits="AdminOrders" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Manage Orders - Admin Panel</title>
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
            max-width: 900px;
            margin: 20px auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .order-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .order-table th, .order-table td {
            padding: 10px;
            border: 1px solid #ccc;
            text-align: left;
        }
        .order-table th {
            background: #007bff;
            color: white;
        }
        .btn {
            padding: 8px 12px;
            border-radius: 5px;
            font-size: 14px;
            cursor: pointer;
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
            <h2>Manage Orders</h2>

            <!-- Orders Table -->
            <asp:GridView ID="gvOrders" runat="server" CssClass="order-table" AutoGenerateColumns="False" OnRowCommand="gvOrders_RowCommand">
                <Columns>
                    <asp:BoundField DataField="OrderID" HeaderText="Order ID" />
                    <asp:BoundField DataField="Username" HeaderText="Customer" />
                    <asp:BoundField DataField="TotalAmount" HeaderText="Total Amount" DataFormatString="₹{0:N2}" />
                    <asp:BoundField DataField="OrderDate" HeaderText="Order Date" DataFormatString="{0:MM/dd/yyyy}" />

                    <asp:TemplateField HeaderText="Current Status">
                        <ItemTemplate>
                            <asp:Label ID="lblCurrentStatus" runat="server" Text='<%# Eval("Status") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Update Status">
                        <ItemTemplate>
                            <asp:DropDownList ID="ddlStatus" runat="server">
                                <asp:ListItem Value="Pending">Pending</asp:ListItem>
                                <asp:ListItem Value="Shipped">Shipped</asp:ListItem>
                                <asp:ListItem Value="Delivered">Delivered</asp:ListItem>
                            </asp:DropDownList>
                            <asp:Button ID="btnUpdateStatus" runat="server" CssClass="btn btn-update" Text="Update" CommandName="UpdateStatus" CommandArgument='<%# Eval("OrderID") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:Button ID="btnDeleteOrder" runat="server" CssClass="btn btn-delete" Text="Delete" CommandName="DeleteOrder" CommandArgument='<%# Eval("OrderID") %>' OnClientClick="return confirm('Are you sure you want to delete this order?');" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>

    </form>
</body>
</html>
