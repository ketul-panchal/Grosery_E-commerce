using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

public partial class Checkout : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Username"] == null)
        {
            Response.Redirect("Login.aspx");
        }
        else
        {
            lblUsername.Text = Session["Username"].ToString();
            if (!IsPostBack)
            {
                LoadCartItems();
            }
        }
    }

    private void LoadCartItems()
    {
        string connStr = ConfigurationManager.ConnectionStrings["EcommerceDB"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();

            string query = @"
                SELECT Cart.CartID, Products.ProductName, Products.Price, Cart.Quantity 
                FROM Cart 
                INNER JOIN Products ON Cart.ProductID = Products.ProductID 
                WHERE Cart.UserID = @UserID";

            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@UserID", Session["UserID"]);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            rptCart.DataSource = dt;
            rptCart.DataBind();

            decimal totalAmount = 0;
            foreach (DataRow row in dt.Rows)
            {
                totalAmount += Convert.ToDecimal(row["Price"]) * Convert.ToInt32(row["Quantity"]);
            }
            lblTotalAmount.Text = totalAmount.ToString("0.00");
        }
    }

    protected void btnPlaceOrder_Click(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["EcommerceDB"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();

            // Get cart items for the user
            string getCartItems = @"
            SELECT Products.ProductName, Products.Price, Cart.Quantity 
            FROM Cart 
            INNER JOIN Products ON Cart.ProductID = Products.ProductID 
            WHERE Cart.UserID = @UserID";

            SqlCommand cartCmd = new SqlCommand(getCartItems, conn);
            cartCmd.Parameters.AddWithValue("@UserID", Session["UserID"]);

            SqlDataAdapter da = new SqlDataAdapter(cartCmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            // Convert cart items into a formatted string
            string productsDetails = "";
            decimal totalAmount = 0;

            foreach (DataRow row in dt.Rows)
            {
                string productName = row["ProductName"].ToString();
                decimal price = Convert.ToDecimal(row["Price"]);
                int quantity = Convert.ToInt32(row["Quantity"]);

                totalAmount += price * quantity;
                productsDetails += string.Format("{0} (Qty: {1}, Price: ${2}), ", productName, quantity, price);
            }

            if (productsDetails.Length > 2)
            {
                productsDetails = productsDetails.Substring(0, productsDetails.Length - 2); // Remove last comma
            }

            // Insert Order with Products column
            string insertOrder = @"
            INSERT INTO Orders (UserID, TotalAmount, OrderDate, Status, Name, Address, City, Phone, Products) 
            VALUES (@UserID, @TotalAmount, GETDATE(), 'Pending', @Name, @Address, @City, @Phone, @Products)";

            SqlCommand orderCmd = new SqlCommand(insertOrder, conn);
            orderCmd.Parameters.AddWithValue("@UserID", Session["UserID"]);
            orderCmd.Parameters.AddWithValue("@TotalAmount", totalAmount);
            orderCmd.Parameters.AddWithValue("@Name", txtName.Text);
            orderCmd.Parameters.AddWithValue("@Address", txtAddress.Text);
            orderCmd.Parameters.AddWithValue("@City", txtCity.Text);
            orderCmd.Parameters.AddWithValue("@Phone", txtPhone.Text);
            orderCmd.Parameters.AddWithValue("@Products", productsDetails);

            orderCmd.ExecuteNonQuery();

            // Clear Cart
            string clearCart = "DELETE FROM Cart WHERE UserID = @UserID";
            SqlCommand clearCartCmd = new SqlCommand(clearCart, conn);
            clearCartCmd.Parameters.AddWithValue("@UserID", Session["UserID"]);
            clearCartCmd.ExecuteNonQuery();
        }

        Response.Redirect("Orders.aspx");
    }







    protected void btnLogout_Click(object sender, EventArgs e)
    {
        Session.Clear();
        Session.Abandon();
        Response.Redirect("Login.aspx");
    }
}
