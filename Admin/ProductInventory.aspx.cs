using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace Foodie.Admin
{
    public partial class ProductInventory : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        //DataTable dt;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["breadCrum"] = "Product Inventory";

                if (Session["admin"] == null)
                {
                    Response.Redirect("../User/Login.aspx");
                }

                else
                {
                    getProductInventory();
                }
            }
            lblMsg.Visible = false;
        }

        private void getProductInventory()
        {
            lblMsg.Visible = false;

            try
            {
                con = new SqlConnection(Connection.GetConnectionString());
                cmd = new SqlCommand("ProductInventory_Crud", con);
                cmd.Parameters.AddWithValue("@Action", "SELECT");
                cmd.CommandType = CommandType.StoredProcedure;
                sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    rProductInventory.DataSource = dt;
                    rProductInventory.DataBind();
                }
            }

            catch (Exception ex)
            {
                lblMsg.Visible = true;
                lblMsg.Text = "Error - " + ex.Message;
                lblMsg.CssClass = "alert alert-danger";
            }
        }

        protected void rProductInventory_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if(e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Label lblActive = e.Item.FindControl("lblIsActive") as Label;

                if(lblActive.Text == "True")
                {
                    lblActive.CssClass = "badge badge-success";
                    lblActive.Text = "Active";
                }

                else
                {
                    lblActive.CssClass = "badge badge-danger";
                    lblActive.Text = "InActive";
                }
            }
        }
    }
}