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
    public partial class ProductTransaction : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["breadCrum"] = "Product Transaction ";

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
                cmd = new SqlCommand("ProductTransaction_Crud", con);
                cmd.Parameters.AddWithValue("@Action", "SELECT");
                cmd.CommandType = CommandType.StoredProcedure;
                sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    rProductTransaction.DataSource = dt;
                    rProductTransaction.DataBind();
                }
            }

            catch (Exception ex)
            {
                lblMsg.Visible = true;
                lblMsg.Text = "Error - " + ex.Message;
                lblMsg.CssClass = "alert alert-danger";
            }
        }

        protected void btnAddOrUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                string actionName = string.Empty;
                int productTrnsId = Convert.ToInt32(hdnID.Value);
                int productId = Convert.ToInt32(ddlProducts.SelectedValue);
                int godownId = Convert.ToInt32(ddlGodowns.SelectedValue);
                string transactionType = ddlTransactionType.SelectedValue;
                int updatedQuantity = Convert.ToInt32(txtUpdQty.Text.Trim());

                if (Session["admin"] != null)
                {
                    ProcessProductTransaction(productTrnsId, productId, godownId, transactionType, updatedQuantity);
                    lblMsg.Visible = true;
                    lblMsg.Text = "Product transaction successful";
                    lblMsg.CssClass = "alert alert-success";
                }

                else
                {
                    Response.Redirect("Login.aspx");
                }
            }

            catch (Exception ex)
            {
                lblMsg.Visible = true;
                lblMsg.Text = "Error - " + ex.Message;
                lblMsg.CssClass = "alert alert-danger";
            }
        }

        private void ProcessProductTransaction(int productTrnsId, int productId, int godownId, string transactionType, int updatedQuantity)
        {
            try
            {
                con = new SqlConnection(Connection.GetConnectionString());
                con.Open();
                if (transactionType == "1")
                {
                    updateInventory(godownId, productId, updatedQuantity);
                }

                else if (transactionType == "2")
                {
                    subtractFromInventory(godownId, productId, updatedQuantity);
                }

                cmd = new SqlCommand("ProductTransaction_Crud", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Action", productTrnsId == 0 ? "INSERT" : "UPDATE");
                cmd.Parameters.AddWithValue("@ProductTrnId", productTrnsId);
                cmd.Parameters.AddWithValue("@GodownId", ddlGodowns.SelectedValue);
                cmd.Parameters.AddWithValue("@ProductId", ddlProducts.SelectedValue);
                cmd.Parameters.AddWithValue("@TransactionType", ddlTransactionType.SelectedValue);
                cmd.Parameters.AddWithValue("@UpdatedQuantity", txtUpdQty.Text.Trim());

                cmd.ExecuteNonQuery();
            }

            catch(Exception ex)
            {
                lblMsg.Visible = true;
                lblMsg.Text = "Error - " + ex.Message;
                lblMsg.CssClass = "alert alert-danger";
            }

            finally
            {
                if(con.State == ConnectionState.Open)
                {
                    con.Open();
                }
            }
        }

        private void clear()
        {
            ddlGodowns.SelectedValue = string.Empty;
            ddlProducts.SelectedValue = string.Empty;
            ddlTransactionType.SelectedValue = string.Empty;
            txtUpdQty.Text = string.Empty;
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            clear();
        }

        private void updateInventory(int godownId, int productId, int quantity)
        {
            try
            {
                con = new SqlConnection(Connection.GetConnectionString());
                con.Open();
                SqlTransaction sqlTransaction = con.BeginTransaction();

                try
                {
                    cmd = new SqlCommand("UpdateInventory", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@GodownId", godownId);
                    cmd.Parameters.AddWithValue("@ProductId", productId);
                    cmd.Parameters.AddWithValue("@Quantity", quantity);

                    //if (con.State != ConnectionState.Open)
                    //{
                    //    con.Open();
                    //}
                    cmd.ExecuteNonQuery();
                    sqlTransaction.Commit();

                    lblMsg.Visible = true;
                    lblMsg.Text = "Successfull";
                    lblMsg.CssClass = "alert alert-success";
                }

                catch (Exception ex)
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "Error - " + ex.Message;
                    lblMsg.CssClass = "alert alert-danger";
                }
            }

            catch (Exception ex)
            {
                lblMsg.Visible = true;
                lblMsg.Text = "Error - " + ex.Message;
                lblMsg.CssClass = "alert alert-danger";
            }
        }

        private void subtractFromInventory(int godownId, int productId, int quantity)
        {
            try
            {
                con = new SqlConnection(Connection.GetConnectionString());

                try
                {
                    cmd = new SqlCommand("SubtractFromInventory", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@GodownId", godownId);
                    cmd.Parameters.AddWithValue("@ProductId", productId);
                    cmd.Parameters.AddWithValue("@Quantity", quantity);

                    if (con.State != ConnectionState.Open)
                    {
                        con.Open();
                    }
                    cmd.ExecuteNonQuery();

                    lblMsg.Visible = true;
                    lblMsg.Text = "Successfull";
                    lblMsg.CssClass = "alert alert-success";
                }

                catch(Exception ex)
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "Error - " + ex.Message;
                    lblMsg.CssClass = "alert alert-danger";
                }
            }

            catch (Exception ex)
            {
                lblMsg.Visible = true;
                lblMsg.Text = "Error - " + ex.Message;
                lblMsg.CssClass = "alert alert-danger";
            }

            finally
            {
                con.Close();
            }
        }

        protected void rProductTransaction_ItemCommand(object source, RepeaterCommandEventArgs e)
        {

        }
    }
}