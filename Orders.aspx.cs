using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

public partial class Orders : System.Web.UI.Page
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
            LoadUserOrders();
        }
    }

    private void LoadUserOrders()
    {
        string connStr = ConfigurationManager.ConnectionStrings["EcommerceDB"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();

            // Fetch user orders
            string query = @"
                SELECT OrderID, TotalAmount, OrderDate, Status, Products
                FROM Orders
                WHERE UserID = @UserID
                ORDER BY OrderDate DESC";

            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@UserID", Session["UserID"]);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                rptOrders.DataSource = dt;
                rptOrders.DataBind();
                lblNoOrders.Visible = false;
            }
            else
            {
                lblNoOrders.Visible = true;
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
