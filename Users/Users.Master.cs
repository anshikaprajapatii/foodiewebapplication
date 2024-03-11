using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Foodie.Users
{
    public partial class Users : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           if(Session["userId"] != null)
           {
                btnLoginOrLogout.Text = "Logout";
                Utils utils = new Utils();
                Session["cartCount"] = utils.cartCount(Convert.ToInt32(Session["userId"])).ToString();
           }

           else
           {
                btnLoginOrLogout.Text = "Login";
                Session["cartCount"] = "0";
           }
        }

        protected void btnLoginOrLogout_Click(object sender, EventArgs e)
        {
            if(Session["userId"]==null)
            {
                Response.Redirect("Login.aspx");
            }

            else
            {
                Session.Abandon();
                Response.Redirect("Login.aspx");
            }
        }

        protected void btnRegisterOrProfile_Click(object sender, EventArgs e)
        {
            if(Session["userId"] != null)
            {
                btnRegisterOrProfile.ToolTip = "User Profile";
                Response.Redirect("Profile.aspx");
            }

            else
            {
                btnRegisterOrProfile.ToolTip = "User Registration";
                Response.Redirect("Registration.aspx");
            }
        }
    }
}