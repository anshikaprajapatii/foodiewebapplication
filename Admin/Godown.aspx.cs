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
    public partial class Godown : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        //DataTable dt;

        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                Session["breadCrum"] = "Godowns";
                getGodowns();
            }
            lblMsg.Visible = false;
        }

        public void getGodowns()
        {
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("Godown_Crud", con);
            cmd.Parameters.AddWithValue("@Action", "SELECT");
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            rProductInventory.DataSource = dt;
            rProductInventory.DataBind();
        }

        protected void btnAddOrUpdate_Click(object sender, EventArgs e)
        {
            string actionName = string.Empty;
            int godownId = Convert.ToInt32(hdnID.Value);
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("Godown_Crud", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Action", godownId == 0 ? "INSERT" : "UPDATE");
            cmd.Parameters.AddWithValue("@GodownId", godownId);
            cmd.Parameters.AddWithValue("@GodownName", txtName.Text.Trim());
            cmd.Parameters.AddWithValue("@GodownAddress", txtAddress.Text.Trim());
            cmd.Parameters.AddWithValue("@GodownPinCode", txtPinCode.Text.Trim());

            try
            {
                con.Open();
                cmd.ExecuteNonQuery();
                lblMsg.Visible = true;
                lblMsg.Text = "Godown inserted successfully";
                lblMsg.CssClass = "alert alert-success";
            }

            catch(Exception ex)
            {
                lblMsg.Visible = true;
                lblMsg.Text = "Error - " + ex.Message;
                lblMsg.CssClass = "alert alert-danger";
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {

        }

        protected void rProductInventory_ItemCommand(object source, RepeaterCommandEventArgs e)
        {

        }
    }
}