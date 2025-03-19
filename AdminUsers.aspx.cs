using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

public partial class AdminUsers : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Username"] == null || Session["Role"] == null || Session["Role"].ToString() != "Admin")
        {
            Response.Redirect("Login.aspx"); // Restrict non-admin users
        }

        if (!IsPostBack)
        {
            LoadUsers();
        }
    }

    private void LoadUsers()
    {
        string connStr = ConfigurationManager.ConnectionStrings["EcommerceDB"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();
            string query = "SELECT UserID, Username, Email, Role FROM Users";
            SqlDataAdapter da = new SqlDataAdapter(query, conn);
            DataTable dt = new DataTable();
            da.Fill(dt);
            gvUsers.DataSource = dt;
            gvUsers.DataBind();
        }
    }

    protected void btnAddUser_Click(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["EcommerceDB"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();
            string query = "INSERT INTO Users (Username, Email, Password, Role) VALUES (@Username, @Email, @Password, @Role)";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@Username", txtUsername.Text);
            cmd.Parameters.AddWithValue("@Email", txtEmail.Text);
            cmd.Parameters.AddWithValue("@Password", txtPassword.Text);
            cmd.Parameters.AddWithValue("@Role", ddlRole.SelectedValue);
            cmd.ExecuteNonQuery();
        }
        LoadUsers();
    }

    protected void gvUsers_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int userId = Convert.ToInt32(e.CommandArgument);
        string connStr = ConfigurationManager.ConnectionStrings["EcommerceDB"].ConnectionString;

        if (e.CommandName == "EditUser")
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                string query = "SELECT * FROM Users WHERE UserID = @UserID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserID", userId);
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    hdnUserID.Value = reader["UserID"].ToString();
                    txtUsername.Text = reader["Username"].ToString();
                    txtEmail.Text = reader["Email"].ToString();
                    ddlRole.SelectedValue = reader["Role"].ToString();
                    btnAddUser.Visible = false;
                    btnUpdateUser.Visible = true;
                }
            }
        }
        else if (e.CommandName == "DeleteUser")
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                // First, delete all related records from the Cart table
                string deleteCartQuery = "DELETE FROM Cart WHERE UserID = @UserID";
                SqlCommand deleteCartCmd = new SqlCommand(deleteCartQuery, conn);
                deleteCartCmd.Parameters.AddWithValue("@UserID", userId);
                deleteCartCmd.ExecuteNonQuery();

                // Second, delete all related records from the Orders table
                string deleteOrdersQuery = "DELETE FROM Orders WHERE UserID = @UserID";
                SqlCommand deleteOrdersCmd = new SqlCommand(deleteOrdersQuery, conn);
                deleteOrdersCmd.Parameters.AddWithValue("@UserID", userId);
                deleteOrdersCmd.ExecuteNonQuery();

                // Now, delete the user from the Users table
                string deleteUserQuery = "DELETE FROM Users WHERE UserID = @UserID";
                SqlCommand deleteUserCmd = new SqlCommand(deleteUserQuery, conn);
                deleteUserCmd.Parameters.AddWithValue("@UserID", userId);
                deleteUserCmd.ExecuteNonQuery();
            }
            LoadUsers(); // Refresh user list
        }
    }



    // ✅ Fix: Added Missing Update User Functionality
    protected void btnUpdateUser_Click(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["EcommerceDB"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();
            string query = "UPDATE Users SET Username=@Username, Email=@Email, Role=@Role WHERE UserID=@UserID";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@UserID", hdnUserID.Value);
            cmd.Parameters.AddWithValue("@Username", txtUsername.Text);
            cmd.Parameters.AddWithValue("@Email", txtEmail.Text);
            cmd.Parameters.AddWithValue("@Role", ddlRole.SelectedValue);
            cmd.ExecuteNonQuery();
        }

        // Reset Form & Reload Users
        hdnUserID.Value = "";
        txtUsername.Text = "";
        txtEmail.Text = "";
        ddlRole.SelectedIndex = 0;
        btnAddUser.Visible = true;
        btnUpdateUser.Visible = false;
        LoadUsers();
    }

    protected void btnLogout_Click(object sender, EventArgs e)
    {
        Session.Clear();
        Response.Redirect("Login.aspx");
    }
}
