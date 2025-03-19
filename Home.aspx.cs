using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;

public partial class Home : System.Web.UI.Page
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
                LoadCategoriesWithProducts();
            }
        }
    }


    protected void LoadCategoriesWithProducts()
    {
        string connStr = ConfigurationManager.ConnectionStrings["EcommerceDB"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();

            string categoryQuery = "SELECT CategoryID, CategoryName FROM Categories";
            SqlCommand catCmd = new SqlCommand(categoryQuery, conn);
            SqlDataAdapter catDa = new SqlDataAdapter(catCmd);
            DataTable catTable = new DataTable();
            catDa.Fill(catTable);

            List<object> categoryList = new List<object>();

            foreach (DataRow catRow in catTable.Rows)
            {
                int categoryId = Convert.ToInt32(catRow["CategoryID"]);
                string categoryName = catRow["CategoryName"].ToString();

                string productQuery = "SELECT ProductID, ProductName, Price, Description, ImageURL FROM Products WHERE CategoryID = @CategoryID";
                SqlCommand prodCmd = new SqlCommand(productQuery, conn);
                prodCmd.Parameters.AddWithValue("@CategoryID", categoryId);

                SqlDataAdapter prodDa = new SqlDataAdapter(prodCmd);
                DataTable prodTable = new DataTable();
                prodDa.Fill(prodTable);

                List<object> productList = new List<object>();
                foreach (DataRow row in prodTable.Rows)
                {
                    int productId = Convert.ToInt32(row["ProductID"]);

                    Page.ClientScript.RegisterForEventValidation("btnAddToCart", productId.ToString());

                    productList.Add(new
                    {
                        ProductID = productId,
                        ProductName = row["ProductName"].ToString(),
                        Price = Convert.ToDecimal(row["Price"]),
                        Description = row["Description"].ToString(),
                        ImageURL = row["ImageURL"].ToString()
                    });
                }

                categoryList.Add(new { CategoryName = categoryName, Products = productList });
            }

            rptCategories.DataSource = categoryList;
            rptCategories.DataBind();
        }
    }


    protected void btnAddToCart_Command(object sender, CommandEventArgs e)
    {
        int productId = Convert.ToInt32(e.CommandArgument);

        string connStr = ConfigurationManager.ConnectionStrings["EcommerceDB"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();

            string checkQuery = "SELECT Quantity FROM Cart WHERE UserID = @UserID AND ProductID = @ProductID";
            SqlCommand checkCmd = new SqlCommand(checkQuery, conn);
            checkCmd.Parameters.AddWithValue("@UserID", Session["UserID"]);
            checkCmd.Parameters.AddWithValue("@ProductID", productId);

            object existingQuantity = checkCmd.ExecuteScalar();

            if (existingQuantity != null)
            {
                int quantity = Convert.ToInt32(existingQuantity) + 1;
                string updateQuery = "UPDATE Cart SET Quantity = @Quantity WHERE UserID = @UserID AND ProductID = @ProductID";
                SqlCommand updateCmd = new SqlCommand(updateQuery, conn);
                updateCmd.Parameters.AddWithValue("@Quantity", quantity);
                updateCmd.Parameters.AddWithValue("@UserID", Session["UserID"]);
                updateCmd.Parameters.AddWithValue("@ProductID", productId);
                updateCmd.ExecuteNonQuery();
            }
            else
            {
                string insertQuery = "INSERT INTO Cart (UserID, ProductID, Quantity) VALUES (@UserID, @ProductID, 1)";
                SqlCommand insertCmd = new SqlCommand(insertQuery, conn);
                insertCmd.Parameters.AddWithValue("@UserID", Session["UserID"]);
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



    protected void btnCheckout_Click(object sender, EventArgs e)
    {
        Response.Redirect("Checkout.aspx");
    }
}
