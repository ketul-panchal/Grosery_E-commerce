using System;
using System.Data.SqlClient;
using System.Configuration;

public partial class Login : System.Web.UI.Page
{
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["EcommerceDB"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();

            string query = "SELECT UserID, Username, Role FROM Users WHERE Email = @Email AND Password = @Password";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@Email", txtLoginEmail.Text);
            cmd.Parameters.AddWithValue("@Password", txtLoginPassword.Text);

            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                Session["UserID"] = reader["UserID"];
                Session["Username"] = reader["Username"];
                Session["Role"] = reader["Role"].ToString();

                if (reader["Role"].ToString() == "Admin")
                {
                    Response.Redirect("AdminHome.aspx"); // Redirect Admins
                }
                else
                {
                    Response.Redirect("Home.aspx"); // Redirect Customers
                }
            }
            else
            {
                lblLoginMessage.Text = "Invalid email or password.";
            }
        }
    }

}
