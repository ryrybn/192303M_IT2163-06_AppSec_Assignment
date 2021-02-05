using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;

namespace _192303M_IT2163_06_AppSec_Assignment
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["firstName"] != null)
            {
                if (Session["AuthToken"] != null && Request.Cookies["AuthToken"] != null)
                {
                    if (!Session["AuthToken"].ToString().Equals(Request.Cookies["AuthToken"].Value))
                    {
                        Response.Redirect("Login.aspx", false);
                    }
                    else
                    {
                        this.Master.LoginLink = "Logout";
                        this.Master.LoginLabel = "Logout";
                        this.Master.ProfileLabel = Session["firstName"].ToString();
                        this.Master.ProfileLinkVisbility = true;
                    }
                }
                else
                {
                    Response.Redirect("Login.aspx", false);
                }
            }
        }
    }
}