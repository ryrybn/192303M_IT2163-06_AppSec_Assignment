using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.IO;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Security.Cryptography;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using _192303M_IT2163_06_AppSec_Assignment.Entity;

namespace _192303M_IT2163_06_AppSec_Assignment
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string success = Request.QueryString["signupsuccess"];
            if (success == "1")
            {
                lbl_msg.Text = "User account created Successfully!";
                lbl_msg.Visible = true;
            }
        }

        protected void btn_login_Click(object sender, EventArgs e)
        {
            string password = tb_password.Text.ToString().Trim();
            string email = tb_email.Text.ToString().Trim();
            User user = new User();
            string theHash = user.reqHash(email);
            string theSalt = user.reqSalt(email);


            if (ValidateCaptcha())
            {
                if (user.checkLockout(email) < 3)
                {
                    user = user.Login(email, password, theSalt, theHash);
                    if (user != null)
                    {
                        user.resetLockout(email);
                        Session["firstName"] = user.FirstName;
                        string guid = Guid.NewGuid().ToString();
                        Session["AuthToken"] = guid;
                        Response.Cookies.Add(new HttpCookie("AuthToken", guid));
                        Response.Redirect("/");
                    }
                    else
                    {
                        user = new User();
                        int upLockout = user.upLockout(email);
                        lbl_error.Text = "Login failed. Email address or password provided might be incorrect.";
                    }
                }
                else
                {
                    lbl_error.Text = "This account has been locked out due to many login attempts. Please contact administrator.";
                }
            }
            else
            {
                lbl_error.Text = "Login failed. Email address or password provided might be incorrect.";
            }
        }

        public class captchaResObject
        {
            public string success { get; set; }
            public List<string> ErrorMessage { get; set; }
        }

        public bool ValidateCaptcha()
        {
            bool result = true;
            string captchaResponse = Request.Form["g-recaptcha-response"];

            HttpWebRequest req = (HttpWebRequest)WebRequest.Create
            ("https://www.google.com/recaptcha/api/siteverify?secret= &response=" + captchaResponse);


            try
            {
                using (WebResponse wResponse = req.GetResponse())
                {
                    using (StreamReader readStream = new StreamReader(wResponse.GetResponseStream()))
                    {
                        string jsonResponse = readStream.ReadToEnd();

                        JavaScriptSerializer js = new JavaScriptSerializer();

                        captchaResObject jsonObject = js.Deserialize<captchaResObject>(jsonResponse);
                        result = Convert.ToBoolean(jsonObject.success);
                    }
                }

                return result;
            }
            catch (WebException ex)
            {
                throw ex;
            }
        }
    }
}