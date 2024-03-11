using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace Foodie
{
    public partial class Cart : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        //SqlDataAdapter sda;
        //DataTable dt;
        //decimal grandTotal = 0;
       

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["grandTotalPrice"] = null;
                if (Session["userId"] == null)
                {
                    Response.Redirect("Login.aspx");
                }

                else
                {
                    getCartItems();
                }
            }
        }

        public void getCartItems()
        {
            try
            {
                DataTable dt = new DataTable();
                using (SqlConnection con = new SqlConnection(Connection.GetConnectionString()))
                {
                    using (SqlCommand cmd = new SqlCommand("Cart_Crud", con))
                    {
                        cmd.Parameters.AddWithValue("@Action", "SELECT");
                        cmd.Parameters.AddWithValue("@UserId", Session["userId"]);

                        cmd.CommandType = CommandType.StoredProcedure;
                        using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                        {
                            sda.Fill(dt);
                        }
                    }
                }
                rCartItem.DataSource = dt;
                rCartItem.DataBind();

                if (dt.Rows.Count != 0)
                {
                    lblMsg.Visible = false;
                }
                else
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "Your Cart is empty.";
                    lblMsg.CssClass = "alert alert-warning";
                }
            }

            catch (Exception ex)
            {
                Response.Write("<script>alert('Error - " + ex.Message + "')</script>");
            }
        }

        protected void rCartItem_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            Utils utils = new Utils();

            if (e.CommandName == "remove")
            {
                con = new SqlConnection(Connection.GetConnectionString());
                cmd = new SqlCommand("Cart_Crud", con);
                cmd.Parameters.AddWithValue("@Action", "DELETE");
                cmd.Parameters.AddWithValue("@ProductId", e.CommandArgument);
                cmd.Parameters.AddWithValue("@UserId", Session["userId"]);
                cmd.CommandType = CommandType.StoredProcedure;

                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    Session["cartCount"] = utils.cartCount(Convert.ToInt32(Session["userId"]));
                    getCartItems();
                }

                catch (Exception ex)
                {
                    Response.Write("<script>alert('Error - " + ex.Message + "')</script>");
                }

                finally
                {
                    con.Close();
                }
            }

            if (e.CommandName == "updateCart")
            {
                bool isCartUpdated = false;

                for (int item = 0; item < rCartItem.Items.Count; item++)
                {
                    if (rCartItem.Items[item].ItemType == ListItemType.Item || rCartItem.Items[item].ItemType == ListItemType.AlternatingItem)
                    {
                        TextBox quantity = rCartItem.Items[item].FindControl("txtQuantity") as TextBox;
                        HiddenField _productId = rCartItem.Items[item].FindControl("hdnProductId") as HiddenField;
                        HiddenField _quantity = rCartItem.Items[item].FindControl("hdnQuantity") as HiddenField;
                        int quantityFromCart = Convert.ToInt32(quantity.Text);
                        int ProductId = Convert.ToInt32(_productId.Value);
                        int quantityFromDB = Convert.ToInt32(_quantity.Value);

                        bool isTrue = false;
                        int updatedQuantity = 1;

                        if (quantityFromCart > quantityFromDB)
                        {
                            updatedQuantity = quantityFromCart;
                            isTrue = true;
                        }

                        else if (quantityFromCart < quantityFromDB)
                        {
                            updatedQuantity = quantityFromCart;
                            isTrue = true;
                        }

                        if (isTrue)
                        {
                            isCartUpdated = utils.UpdateCartQuantity(updatedQuantity, ProductId, Convert.ToInt32(Session["userId"]));
                        }
                    }
                }
                getCartItems();
            }

            if (e.CommandName == "checkout")
            {
                bool isTrue = false;
                string pName = string.Empty;

                for (int item = 0; item < rCartItem.Items.Count; item++)
                {
                    if (rCartItem.Items[item].ItemType == ListItemType.Item || rCartItem.Items[item].ItemType == ListItemType.AlternatingItem)
                    {
                        HiddenField _productId = rCartItem.Items[item].FindControl("hdnProductId") as HiddenField;
                        HiddenField _cartQuantity = rCartItem.Items[item].FindControl("hdnQuantity") as HiddenField;
                        HiddenField _productQuantity = rCartItem.Items[item].FindControl("hdnPrdQuantity") as HiddenField;
                        Label productName = rCartItem.Items[item].FindControl("lblName") as Label;

                        int productId = Convert.ToInt32(_productId.Value);
                        int cartQuantity = Convert.ToInt32(_cartQuantity.Value);
                        int productQuantity = Convert.ToInt32(_productQuantity.Value);

                        if (productQuantity > cartQuantity && productQuantity > 2)
                        {
                            isTrue = true;
                        }

                        else
                        {
                            isTrue = false;
                            pName = productName.Text.ToString();
                            break;
                        }
                    }
                }

                if (isTrue)
                {
                    Response.Redirect("Payment.aspx");
                }

                else
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "Item <b>'" + pName + "'</b> is out of stock!";
                    lblMsg.CssClass = "alert alert-warning";
                }
            }
        }

        protected void rCartItem_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {

            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Label lblPrice = e.Item.FindControl("lblPrice") as Label;
                TextBox txtQuantity = e.Item.FindControl("txtQuantity") as TextBox;
                Label lblTotalPrice = e.Item.FindControl("lblTotalPrice") as Label;

                if (lblPrice != null && txtQuantity != null && lblTotalPrice != null)
                {
                    decimal price = Convert.ToDecimal(lblPrice.Text);
                    int quantity = Convert.ToInt32(txtQuantity.Text);

                    decimal totalPrice = price * quantity;

                    lblTotalPrice.Text = totalPrice.ToString("0.00");
                    CalculatingGrandTotal(totalPrice);
                }
            }
        }

        private void CalculatingGrandTotal(decimal itemTotal)
        {
            decimal grandTotal = (Session["grandTotalPrice"] != null) ? (decimal)Session["grandTotalPrice"] : 0;
            grandTotal += itemTotal;
             Session["grandTotalPrice"] = grandTotal;
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            Response.Redirect("Payment.aspx");
        }
    }
}