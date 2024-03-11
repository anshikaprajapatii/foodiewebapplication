using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace Foodie.Users
{
    public partial class Payment : System.Web.UI.Page
    {
        SqlConnection con;
        SqlTransaction transaction = null;
        string name = string.Empty;
        string cardNo = string.Empty;
        string expiryDate = string.Empty;
        string cvv = string.Empty;
        string address = string.Empty;
        string paymentMode = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["userId"] == null)
                {
                    Response.Redirect("Login.aspx");
                }
            }
        }

        protected void btnSubmitCard_Click(object sender, EventArgs e)
        {
            name = txtName.Text.Trim();
            cardNo = txtCardNo.Text.Trim();
            cardNo = string.Format("************{0}", txtCardNo.Text.Trim().Substring(12, 4));
            expiryDate = txtExpMonth.Text.Trim() + "/" + txtExpYear.Text.Trim();
            cvv = txtCvv.Text.Trim();
            address = txtAddress.Text.Trim();
            paymentMode = "card";

            if (Session["userId"] != null)
            {
                OrderPayment(name, cardNo, expiryDate, address, cvv, paymentMode);
            }

            else
            {
                Response.Redirect("Login.aspx");
            }
        }

        protected void btnSubmitCod_Click(object sender, EventArgs e)
        {
            address = txtCODAddress.Text.Trim();
            paymentMode = "cod";

            if (Session["userId"] != null)
            {
                OrderPayment(name, cardNo, expiryDate, address, cvv, paymentMode);
            }

            else
            {
                Response.Redirect("Login.aspx");
            }
        }

        void OrderPayment(string name, string cardno, string expdate, string address, string cvv, string paymentmode)
        {
            int paymentId; int productId; int quantity;
            DataTable dt = new DataTable();
            dt.Columns.AddRange(new DataColumn[7]
            {
                new DataColumn("OrderNo", typeof(string)),
                new DataColumn("ProductId", typeof(int)),
                new DataColumn("Quantity", typeof(int)),
                new DataColumn("UserId", typeof(int)),
                new DataColumn("Status", typeof(string)),
                new DataColumn("PaymentId", typeof(int)),
                new DataColumn("OrderDate", typeof(DateTime)),
            });

            con = new SqlConnection(Connection.GetConnectionString());
            con.Open();
            transaction = con.BeginTransaction();
            SqlCommand cmd = new SqlCommand("Save_Payment", con, transaction);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Name", name);
            cmd.Parameters.AddWithValue("@CardNo", cardno);
            cmd.Parameters.AddWithValue("@ExpiryDate", expdate);
            cmd.Parameters.AddWithValue("@Cvv", cvv);
            cmd.Parameters.AddWithValue("@Address", address);
            cmd.Parameters.AddWithValue("@PaymentMode", paymentmode);
            //cmd.Parameters.Add("@InsertedId", SqlDbType.Int);

            SqlParameter insertedIdParam = new SqlParameter("@InsertedId", SqlDbType.Int);
            insertedIdParam.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(insertedIdParam);
            //cmd.Parameters["InsertedId"].Direction = ParameterDirection.Output;

            try
            {
                cmd.ExecuteNonQuery();
                paymentId = Convert.ToInt32(cmd.Parameters["@InsertedId"].Value);

                SqlCommand cmdCart = new SqlCommand("Cart_Crud", con, transaction);
                cmdCart.Parameters.AddWithValue("@Action", "SELECT");
                cmdCart.Parameters.AddWithValue("@UserId", Session["userId"]);
                cmdCart.CommandType = CommandType.StoredProcedure;

                using (SqlDataReader dr = cmdCart.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        productId = (int)dr["ProductId"];
                        quantity = (int)dr["Quantity"];

                        //update product quantity
                        UpdateQuantity(productId, quantity, transaction, con);

                        //delete cart item
                        DeleteCartItem(productId, transaction, con);

                        dt.Rows.Add(Utils.GetUniqueId(), productId, quantity, (int)Session["userId"], "Pending", paymentId, Convert.ToDateTime(DateTime.Now));
                    }
                }

                if (dt.Rows.Count > 0)
                {
                    SqlCommand cmdOrders = new SqlCommand("Save_Orders", con, transaction);
                    cmdOrders.Parameters.AddWithValue("@tblOrders", dt);
                    cmdOrders.CommandType = CommandType.StoredProcedure;
                    cmdOrders.ExecuteNonQuery();
                }
                transaction.Commit();
                lblMsg.Visible = true;
                lblMsg.Text = "Your item ordered successfull!!";
                lblMsg.CssClass = "alert alert-success";
            }

            catch (Exception ex)
            {
                transaction.Rollback();
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }

            finally
            {
                con.Close();
            }
        }

        void UpdateQuantity(int _productId, int _quantity, SqlTransaction sqlTransaction, SqlConnection sqlConnection)
        {
            int dbQuantity;
            SqlCommand cmdProduct = new SqlCommand("Product_Crud", sqlConnection, sqlTransaction);
            cmdProduct.Parameters.AddWithValue("@Action", "GETBYID");
            cmdProduct.Parameters.AddWithValue("@ProductId", _productId);
            cmdProduct.CommandType = CommandType.StoredProcedure;

            try
            {
                using (SqlDataReader drl = cmdProduct.ExecuteReader())
                {
                    while (drl.Read())
                    {
                        dbQuantity = (int)drl["Quantity"];

                        if (dbQuantity > _quantity && dbQuantity > 2)
                        {
                            dbQuantity = dbQuantity - _quantity;
                            // Use sqlConnection instead of con
                            SqlCommand cmdQtyUpdate = new SqlCommand("Product_Crud", sqlConnection);
                            cmdQtyUpdate.Parameters.AddWithValue("@Action", "QTYUPDATE");
                            cmdQtyUpdate.Parameters.AddWithValue("@Quantity", _quantity);
                            cmdQtyUpdate.Parameters.AddWithValue("@ProductId", _productId);
                            cmdQtyUpdate.CommandType = CommandType.StoredProcedure;
                            cmdQtyUpdate.ExecuteNonQuery();
                        }
                    }
                }
            }
            catch (Exception exe)
            {
                Response.Write("<script>alert('" + exe.Message + "');</script>");
            }
        }

        void DeleteCartItem(int _productId, SqlTransaction sqlTransaction, SqlConnection sqlConnection)
        {
            try
            {
                SqlCommand cmdDeletePrd = new SqlCommand("Cart_Crud", sqlConnection, sqlTransaction);
                cmdDeletePrd.Parameters.AddWithValue("@Action", "DELETE");
                cmdDeletePrd.Parameters.AddWithValue("@ProductId", _productId);
                cmdDeletePrd.Parameters.AddWithValue("@UserId", Session["userId"]);
                cmdDeletePrd.CommandType = CommandType.StoredProcedure;


                cmdDeletePrd.ExecuteNonQuery();
            }

            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }
    }
}