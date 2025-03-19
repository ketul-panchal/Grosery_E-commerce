using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class AdminHome : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Username"] == null || Session["Role"] == null || Session["Role"].ToString() != "Admin")
        {
            Response.Redirect("Login.aspx"); // Redirect to login if not admin
        }
        else
        {
            lblAdminName.Text = Session["Username"].ToString();
        }
    }

    protected void btnLogout_Click(object sender, EventArgs e)
    {
        Session.Clear();
        Session.Abandon();
        Response.Redirect("Login.aspx");
    }
}
