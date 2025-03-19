using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

public partial class AdminCategories : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Username"] == null || Session["Role"].ToString() != "Admin")
        {
            Response.Redirect("Login.aspx");
        }

        if (!IsPostBack)
        {
            LoadCategories();
        }
    }

    private void LoadCategories()
    {
        string connStr = ConfigurationManager.ConnectionStrings["EcommerceDB"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();

            string query = "SELECT * FROM Categories";
            SqlDataAdapter da = new SqlDataAdapter(query, conn);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvCategories.DataSource = dt;
            gvCategories.DataBind();
        }
    }

    protected void btnAddCategory_Click(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["EcommerceDB"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();
            string query = "INSERT INTO Categories (CategoryName) VALUES (@CategoryName)";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@CategoryName", txtCategoryName.Text);
            cmd.ExecuteNonQuery();
        }

        txtCategoryName.Text = "";
        LoadCategories();
    }

    protected void btnUpdateCategory_Click(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(hdnCategoryID.Value))
        {
            int categoryId = Convert.ToInt32(hdnCategoryID.Value);
            string connStr = ConfigurationManager.ConnectionStrings["EcommerceDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                string query = "UPDATE Categories SET CategoryName = @CategoryName WHERE CategoryID = @CategoryID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@CategoryName", txtCategoryName.Text);
                cmd.Parameters.AddWithValue("@CategoryID", categoryId);
                cmd.ExecuteNonQuery();
            }

            txtCategoryName.Text = "";
            hdnCategoryID.Value = "";
            btnAddCategory.Visible = true;
            btnUpdateCategory.Visible = false;

            LoadCategories();
        }
    }

    protected void gvCategories_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int categoryId = Convert.ToInt32(e.CommandArgument);
        string connStr = ConfigurationManager.ConnectionStrings["EcommerceDB"].ConnectionString;

        if (e.CommandName == "EditCategory")
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                string query = "SELECT * FROM Categories WHERE CategoryID = @CategoryID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@CategoryID", categoryId);
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    hdnCategoryID.Value = reader["CategoryID"].ToString();
                    txtCategoryName.Text = reader["CategoryName"].ToString();
                    btnAddCategory.Visible = false;
                    btnUpdateCategory.Visible = true;
                }
            }
        }
        else if (e.CommandName == "DeleteCategory")
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                // Check if category has products
                string checkQuery = "SELECT COUNT(*) FROM Products WHERE CategoryID = @CategoryID";
                SqlCommand checkCmd = new SqlCommand(checkQuery, conn);
                checkCmd.Parameters.AddWithValue("@CategoryID", categoryId);
                int count = Convert.ToInt32(checkCmd.ExecuteScalar());

                if (count == 0)
                {
                    string deleteQuery = "DELETE FROM Categories WHERE CategoryID = @CategoryID";
                    SqlCommand deleteCmd = new SqlCommand(deleteQuery, conn);
                    deleteCmd.Parameters.AddWithValue("@CategoryID", categoryId);
                    deleteCmd.ExecuteNonQuery();

                    LoadCategories(); // Refresh Categories
                }
                else
                {
                    lblMessage.Text = "Cannot delete category. There are existing products assigned to it.";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
            }
        }
    }


    protected void btnLogout_Click(object sender, EventArgs e)
    {
        Session.Clear();
        Session.Abandon();
        Response.Redirect("Login.aspx");
    }
}
