using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class ProductDetail : System.Web.UI.Page
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
        }

        if (!IsPostBack)
        {
            LoadProductDetails();
        }
    }

    private void LoadProductDetails()
    {
        if (Request.QueryString["ProductID"] != null)
        {
            int productId = Convert.ToInt32(Request.QueryString["ProductID"]);
            string connStr = ConfigurationManager.ConnectionStrings["EcommerceDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                string query = "SELECT ProductName, Price, Description, ImageURL FROM Products WHERE ProductID = @ProductID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@ProductID", productId);
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    lblProductName.InnerText = reader["ProductName"].ToString();
                    lblPrice.Text = Convert.ToDecimal(reader["Price"]).ToString("N2");
                    lblDescription.InnerText = reader["Description"].ToString();
                    imgProduct.Src = ResolveUrl(reader["ImageURL"].ToString());
                    btnAddToCart.CommandArgument = productId.ToString();
                }
            }
        }
    }

    protected void btnAddToCart_Click(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            Response.Redirect("Login.aspx");
            return;
        }

        int productId = Convert.ToInt32(Request.QueryString["ProductID"]);
        int userId = Convert.ToInt32(Session["UserID"]);
        string connStr = ConfigurationManager.ConnectionStrings["EcommerceDB"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();
            string checkQuery = "SELECT Quantity FROM Cart WHERE UserID = @UserID AND ProductID = @ProductID";
            SqlCommand checkCmd = new SqlCommand(checkQuery, conn);
            checkCmd.Parameters.AddWithValue("@UserID", userId);
            checkCmd.Parameters.AddWithValue("@ProductID", productId);
            object existingQuantity = checkCmd.ExecuteScalar();

            if (existingQuantity != null)
            {
                int quantity = Convert.ToInt32(existingQuantity) + 1;
                string updateQuery = "UPDATE Cart SET Quantity = @Quantity WHERE UserID = @UserID AND ProductID = @ProductID";
                SqlCommand updateCmd = new SqlCommand(updateQuery, conn);
                updateCmd.Parameters.AddWithValue("@Quantity", quantity);
                updateCmd.Parameters.AddWithValue("@UserID", userId);
                updateCmd.Parameters.AddWithValue("@ProductID", productId);
                updateCmd.ExecuteNonQuery();
            }
            else
            {
                string insertQuery = "INSERT INTO Cart (UserID, ProductID, Quantity) VALUES (@UserID, @ProductID, 1)";
                SqlCommand insertCmd = new SqlCommand(insertQuery, conn);
                insertCmd.Parameters.AddWithValue("@UserID", userId);
                insertCmd.Parameters.AddWithValue("@ProductID", productId);
                insertCmd.ExecuteNonQuery();
            }
        }

        Response.Redirect("Cart.aspx");
    }

    protected void btnLogout_Click(object sender, EventArgs e)
    {
        Session.Clear(); // Clear all session variables
        Session.Abandon(); // Destroy the session
        Response.Redirect("Login.aspx"); // Redirect to Login page
    }
}
