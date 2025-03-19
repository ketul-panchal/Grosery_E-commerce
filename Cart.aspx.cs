using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections.Generic;

public partial class Cart : System.Web.UI.Page
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
            LoadCartItems();
        }
    }

    private void LoadCartItems()
    {
        string connStr = ConfigurationManager.ConnectionStrings["EcommerceDB"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();

            string query = @"
                SELECT Cart.CartID, Products.ProductName, Products.Price, Products.ImageURL, Cart.Quantity 
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

    protected void btnRemove_Click(object sender, EventArgs e)
    {
        int cartId = Convert.ToInt32(((System.Web.UI.WebControls.Button)sender).CommandArgument);

        string connStr = ConfigurationManager.ConnectionStrings["EcommerceDB"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();
            string query = "DELETE FROM Cart WHERE CartID = @CartID";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@CartID", cartId);
            cmd.ExecuteNonQuery();
        }

        Response.Redirect("Cart.aspx");
    }

    protected void btnCheckout_Click(object sender, EventArgs e)
    {
        Response.Redirect("Checkout.aspx");
    }
}
