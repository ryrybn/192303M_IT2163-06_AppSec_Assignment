using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;
using System.Drawing;
using System.Net;
using System.IO;
using System.Web.Script.Serialization;
using System.Web.Services;
using _192303M_IT2163_06_AppSec_Assignment.Entity;
using System.Security.Cryptography;
using System.Text;
using System.Data;

namespace _192303M_IT2163_06_AppSec_Assignment
{
    public partial class Registration : System.Web.UI.Page
    {
        static string saltedPasswordHash;
        static string theSalt;
        byte[] theKey;
        byte[] theIV;

        protected void Page_Load(object sender, EventArgs e)
        {

        }


        protected void btn_signup_Click(object sender, EventArgs e)
        {
            string firstName = tb_firstname.Text.ToString().Trim();
            string lastName = tb_lastname.Text.ToString().Trim();
            string email = tb_email.Text.ToString().Trim();
            string password = tb_password.Text.ToString().Trim();
            DateTime dob = Convert.ToDateTime(tb_dob.Text);
            string cardholderName = tb_cardholdername.Text.ToString().Trim();
            string cardType = rb_cardtype.SelectedValue.ToString();
            string cardNo = tb_cardno.Text.ToString().Trim();
            string cardExpiry = tb_expirydate.Text.ToString().Trim();
            string cardCVV = tb_cvv.Text.ToString().Trim();

            int score = 0;
            bool length = false;
            bool lowercase = false;
            bool uppercase = false;
            bool numeric = false;
            bool specialchar = false;

            if (password.Length >= 12)
            {
                score++;
                length = true;
            }

            if (Regex.IsMatch(password, "[a-z]"))
            {
                score++;
                lowercase = true;
            }
            if (Regex.IsMatch(password, "[A-Z]"))
            {
                score++;
                uppercase = true;
            }
            if (Regex.IsMatch(password, "[0-9]"))
            {
                score++;
                numeric = true;
            }
            if (Regex.IsMatch(password, "[^A-Za-z0-9]"))
            {
                score++;
                specialchar = true;
            }

            string status = "Your password is ";
            switch (score)
            {
                case 0:
                    status = "Please enter a password.";
                    break;

                case 1:
                    status += "Extremely Weak!";
                    break;

                case 2:
                    status += "Very Weak!";
                    break;

                case 3:
                    status += "Too Weak!";
                    break;

                case 4:
                    status += "Weak.";
                    break;

                case 5:
                    status += "Excellent!";
                    break;

                default:
                    break;
            }

            if (score > 0 && score < 5)
            {
                if (!length)
                    status += "\nPlease use at least 12 characters.";
                if (!lowercase)
                    status += "\nPlease use at least 1 lowercase letter.";
                if (!uppercase)
                    status += "\nPlease use at least 1 uppercase letter.";
                if (!numeric)
                    status += "\nPlease use at least 1 numeric character.";
                if (!specialchar)
                    status += "\nPlease use at least 1 special character.";
            }

            if (score < 5)
            {
                lbl_pwerror.Text = status;
                lbl_pwerror.ForeColor = Color.Red;
                lbl_pwerror.Visible = true;
                return;
            }
            else
                lbl_pwerror.Visible = false;

            int errors = 0;

            User user = new User();

            if (user.CheckExistingUser(email) == 1)
            {
                lbl_emailexists.Text = "The email address already has an account. Please use another email address.";
                lbl_emailexists.Visible = true;
                errors++;
            }
            else if (user.CheckExistingUser(email) == -1)
            {
                lbMsg.Text = "User account creation was unsuccessful. Please try again.";
            }
            else
            {
                if (ValidateCaptcha() == false)
                {
                    lbMsg.Text += "User account creation was unsuccessful. Please try again.";
                    errors++;
                }


                if (errors == 0)
                {
                    RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider();
                    byte[] saltBytes = new byte[8];
                    rng.GetBytes(saltBytes);
                    theSalt = Convert.ToBase64String(saltBytes);
                    SHA512Managed hashing = new SHA512Managed();
                    string pwPlusSalt = password + theSalt;
                    byte[] simpleHash = hashing.ComputeHash(Encoding.UTF8.GetBytes(password));
                    byte[] saltedHash = hashing.ComputeHash(Encoding.UTF8.GetBytes(pwPlusSalt));
                    saltedPasswordHash = Convert.ToBase64String(saltedHash);
                    RijndaelManaged theCipher = new RijndaelManaged();
                    theCipher.GenerateKey();
                    theKey = theCipher.Key;
                    theIV = theCipher.IV;


                    byte[] encryptedCardholderName = encryptString(cardholderName);
                    byte[] encryptedCardType = encryptString(cardType);
                    byte[] encryptedCardNo = encryptString(cardNo);
                    byte[] encryptedCardExpiry = encryptString(cardExpiry);
                    byte[] encryptedCardCVV = encryptString(cardCVV);

                    user = new User(email, saltedPasswordHash, firstName, lastName, dob, encryptedCardholderName, encryptedCardType, encryptedCardNo, encryptedCardExpiry, encryptedCardCVV, theSalt);
                    int result = user.Insert();
                    if (result == 1)
                    {
                        string url = "Login?signupsuccess=1&";
                        Response.Redirect(url);
                    }
                    else
                        lbMsg.Text = "User account creation was unsuccessful. Please try again.";
                }
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

        protected byte[] encryptString(string text)
        {
            byte[] encryptedString = null;
            try
            {
                RijndaelManaged theCipher = new RijndaelManaged();
                theCipher.IV = theIV;
                theCipher.Key = theKey;
                ICryptoTransform encryptTransformer = theCipher.CreateEncryptor();
                byte[] plainString = Encoding.UTF8.GetBytes(text);
                encryptedString = encryptTransformer.TransformFinalBlock(plainString, 0, plainString.Length);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }
            finally { }
            return encryptedString;
        }

    }
}