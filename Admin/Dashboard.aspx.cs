using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Foodie.Admin
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                Session["breadCrum"] = "";

                if(Session["admin"] == null)
                {
                    Response.Redirect("../Users/Login.aspx");
                }

                else
                {
                    DashboardCount dashboardCount = new DashboardCount();
                    Session["category"] = dashboardCount.Count("CATEGORY");
                    Session["product"] = dashboardCount.Count("PRODUCT");
                    Session["order"] = dashboardCount.Count("ORDER");
                    Session["delivered"] = dashboardCount.Count("DELIVERED");
                    Session["pending"] = dashboardCount.Count("PENDING");
                    Session["user"] = dashboardCount.Count("USER");
                    Session["soldAmount"] = dashboardCount.Count("SOLDAMOUNT");
                    Session["contact"] = dashboardCount.Count("CONTACT");
                }
            }
        }
    }
}