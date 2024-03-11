using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace Foodie
{
    public class Connection
    {
        public static string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["cs"].ConnectionString;
        }
    }

    public class Utils
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;

        public static bool IsValidExtension(string fileName)
        {
            bool isValid = false;
            string[] fileExtension = { ".jpg", ".jpeg", ".png" };

            for(int i = 0; i<=fileExtension.Length - 1; i++)
            {
                if(fileName.Contains(fileExtension[i]))
                {
                    isValid = true;
                    break;
                }
            }
            return isValid;
        }

        public static string GetImageUrl(Object url)
        {
            string url1 = "";

            if(url == null || url == DBNull.Value || string.IsNullOrEmpty(url.ToString()))
            {
                url1 = "../Images/No_image.png";
            }

            else
            {
                url1 = string.Format("../{0}", url);
            }
            return url1;
        }

        public bool UpdateCartQuantity(int quantity, int productId, int userId)
        {
            bool isUpdated = false;
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("Cart_Crud", con);
            cmd.Parameters.AddWithValue("@Action", "UPDATE");
            cmd.Parameters.AddWithValue("@ProductId", productId);
            cmd.Parameters.AddWithValue("@Quantity", quantity);
            cmd.Parameters.AddWithValue("@UserId", userId);
            cmd.CommandType = CommandType.StoredProcedure;

            try
            {
                con.Open();
                cmd.ExecuteNonQuery();
                isUpdated = true;
            }

            catch (Exception ex)
            {
                isUpdated = false;
                System.Web.HttpContext.Current.Response.Write("<script>alert('" + ex.Message + "');</script>");
            }

            finally
            {
                con.Close();
            }
            return isUpdated;
        }

        public int cartCount(int userId)
        {
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("Cart_Crud", con);
            cmd.Parameters.AddWithValue("@Action", "SELECT");
            cmd.Parameters.AddWithValue("@UserId", userId);
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            return dt.Rows.Count;
        }

        public static string GetUniqueId()
        {
            Guid guid =Guid.NewGuid();
            String uniqueId = guid.ToString();
            return uniqueId;
        }
    }

    public class DashboardCount
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataReader sdr;

        public int Count(string name)
        {
            int count = 0;
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("Dashboard", con);
            cmd.Parameters.AddWithValue("@Action", name);
            cmd.CommandType = CommandType.StoredProcedure;
            con.Open();
            sdr = cmd.ExecuteReader();
            
            while(sdr.Read())
            {
                if(sdr[0] == DBNull.Value)
                {
                    count = 0;
                }

                else
                {
                    count = Convert.ToInt32(sdr[0]);
                }
            }
            sdr.Close();
            con.Close();
            return count;
        }
    }
}