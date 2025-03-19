using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Web.UI.WebControls;

public partial class AdminProducts : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Username"] == null || Session["Role"] == null || Session["Role"].ToString() != "Admin")
        {
            Response.Redirect("Login.aspx");
        }

        if (!IsPostBack)
        {
            LoadCategories();
            LoadProducts();
        }
    }

    private void LoadCategories()
    {
        string connStr = ConfigurationManager.ConnectionStrings["EcommerceDB"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();
            string query = "SELECT CategoryID, CategoryName FROM Categories";
            SqlDataAdapter da = new SqlDataAdapter(query, conn);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ddlCategory.DataSource = dt;
            ddlCategory.DataTextField = "CategoryName";
            ddlCategory.DataValueField = "CategoryID";
            ddlCategory.DataBind();
        }
    }

    private void LoadProducts()
    {
        string connStr = ConfigurationManager.ConnectionStrings["EcommerceDB"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();
            string query = "SELECT * FROM Products";
            SqlDataAdapter da = new SqlDataAdapter(query, conn);
            DataTable dt = new DataTable();
            da.Fill(dt);
            gvProducts.DataSource = dt;
            gvProducts.DataBind();
        }
    }

    protected void btnAddProduct_Click(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["EcommerceDB"].ConnectionString;
        string imagePath = "images/default.png"; // Default image if none is uploaded

        // Handle Image Upload
        if (fileUpload.HasFile)
        {
            string filename = Path.GetFileName(fileUpload.FileName);
            string savePath = Server.MapPath("~/images/") + filename;
            fileUpload.SaveAs(savePath);
            imagePath = "images/" + filename; // Store without `~/`
        }

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();
            string query = "INSERT INTO Products (ProductName, Description, Price, CategoryID, ImageURL) VALUES (@Name, @Desc, @Price, @CategoryID, @Image)";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@Name", txtProductName.Text);
            cmd.Parameters.AddWithValue("@Desc", txtDescription.Text);
            cmd.Parameters.AddWithValue("@Price", Convert.ToDecimal(txtPrice.Text));
            cmd.Parameters.AddWithValue("@CategoryID", ddlCategory.SelectedValue);
            cmd.Parameters.AddWithValue("@Image", imagePath);
            cmd.ExecuteNonQuery();
        }

        // Clear form & reload product list
        txtProductName.Text = "";
        txtDescription.Text = "";
        txtPrice.Text = "";
        ddlCategory.SelectedIndex = 0;
        LoadProducts();
    }


    protected void btnUpdateProduct_Click(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["EcommerceDB"].ConnectionString;
        string imagePath = "";

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();

            // Check if a new image has been uploaded
            if (fileUpload.HasFile)
            {
                string filename = Path.GetFileName(fileUpload.FileName);
                string savePath = Server.MapPath("~/images/") + filename;
                fileUpload.SaveAs(savePath);
                imagePath = "~/images/" + filename; // Save new image path
            }
            else
            {
                // If no new image is uploaded, keep the existing one
                string getImageQuery = "SELECT ImageURL FROM Products WHERE ProductID = @ProductID";
                SqlCommand getImageCmd = new SqlCommand(getImageQuery, conn);
                getImageCmd.Parameters.AddWithValue("@ProductID", hdnProductID.Value);
                object existingImage = getImageCmd.ExecuteScalar();
                imagePath = existingImage != null ? existingImage.ToString() : "~/images/default.png";
            }

            // Update the product details
            string updateQuery = @"
            UPDATE Products 
            SET ProductName = @Name, 
                Description = @Desc, 
                Price = @Price, 
                CategoryID = @CategoryID, 
                ImageURL = @Image 
            WHERE ProductID = @ProductID";

            SqlCommand cmd = new SqlCommand(updateQuery, conn);
            cmd.Parameters.AddWithValue("@ProductID", hdnProductID.Value);
            cmd.Parameters.AddWithValue("@Name", txtProductName.Text);
            cmd.Parameters.AddWithValue("@Desc", txtDescription.Text);
            cmd.Parameters.AddWithValue("@Price", Convert.ToDecimal(txtPrice.Text));
            cmd.Parameters.AddWithValue("@CategoryID", ddlCategory.SelectedValue);
            cmd.Parameters.AddWithValue("@Image", imagePath);
            cmd.ExecuteNonQuery();
        }

        // Clear form & refresh product list
        hdnProductID.Value = "";
        txtProductName.Text = "";
        txtDescription.Text = "";
        txtPrice.Text = "";
        ddlCategory.SelectedIndex = 0;
        btnAddProduct.Visible = true;
        btnUpdateProduct.Visible = false;
        LoadProducts();
    }

    protected void gvProducts_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int productId = Convert.ToInt32(e.CommandArgument);
        string connStr = ConfigurationManager.ConnectionStrings["EcommerceDB"].ConnectionString;

        if (e.CommandName == "EditProduct")
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                string query = "SELECT * FROM Products WHERE ProductID = @ProductID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@ProductID", productId);
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    hdnProductID.Value = reader["ProductID"].ToString();
                    txtProductName.Text = reader["ProductName"].ToString();
                    txtDescription.Text = reader["Description"].ToString();
                    txtPrice.Text = reader["Price"].ToString();
                    ddlCategory.SelectedValue = reader["CategoryID"].ToString();
                    btnAddProduct.Visible = false;
                    btnUpdateProduct.Visible = true;
                }
            }
        }
        else if (e.CommandName == "DeleteProduct")
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                string deleteQuery = "DELETE FROM Products WHERE ProductID = @ProductID";
                SqlCommand cmd = new SqlCommand(deleteQuery, conn);
                cmd.Parameters.AddWithValue("@ProductID", productId);
                cmd.ExecuteNonQuery();
            }
            LoadProducts(); // Refresh Product List
        }
    }



    protected void btnLogout_Click(object sender, EventArgs e)
    {
        Session.Clear();
        Session.Abandon();
        Response.Redirect("Login.aspx"); // Redirect to login page
    }


}
