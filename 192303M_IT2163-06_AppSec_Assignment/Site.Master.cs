using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace _192303M_IT2163_06_AppSec_Assignment
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public bool ProfileLinkVisbility
        {
            set
            { hl_profile.Visible = value; }
        }

        public string ProfileLabel
        {
            get
            { return hl_profile.Text; }
            set
            { hl_profile.Text = value; }
        }

        public string LoginLink
        {
            get
            { return hl_login.NavigateUrl; }
            set
            { hl_login.NavigateUrl = value; }
        }
        public string LoginLabel
        {
            get
            { return hl_login.Text; }
            set
            { hl_login.Text = value; }
        }
    }
}