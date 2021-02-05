using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Security.Cryptography;

namespace _192303M_IT2163_06_AppSec_Assignment.Entity
{
    public class User
    {
        public int Id { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public DateTime Dob { get; set; }
        public byte[] CardholderName { get; set; }
        public byte[] CardType { get; set; }
        public byte[] CardNo { get; set; }
        public byte[] CardExpiry { get; set; }
        public byte[] CardCVV { get; set; }
        public string Salt { get; set; }


        public User() { }

        public User(string email, string password, string firstName, string lastName, DateTime dob, byte[] cardholderName, byte[] cardType, byte[] cardNo, byte[] cardExpiry, byte[] cardCVV, string salt)
        {
            Email = email;
            Password = password;
            FirstName = firstName;
            LastName = lastName;
            Dob = dob;
            CardholderName = cardholderName;
            CardType = cardType;
            CardNo = cardNo;
            CardExpiry = cardExpiry;
            CardCVV = cardCVV;
            Salt = salt;
    }

        public User(string firstName, string email, string password)
        {
            FirstName = firstName;
            Email = email;
            Password = password;
        }

        public int Insert()
        {
            try
            {
                string dbConnectionStr = ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString;
                SqlConnection dbSqlConnection = new SqlConnection(dbConnectionStr);

                string sqlStatement = "INSERT INTO Users (email, password, firstName, lastName, dob, cCardHolderName, cCardType, cCardNo, cCardExpiry, cCardCVV, salt) " +
                    "VALUES (@paraEmail, @paraPassword, @paraFName, @paraLName, @paraDob, @paraCardholderName, @paraCardType, @paraCardNo, @paraCardExpiry, @paraCardCVV, @paraSalt)";
                SqlCommand sqlCmd = new SqlCommand(sqlStatement, dbSqlConnection);

                sqlCmd.Parameters.AddWithValue("@paraEmail", Email);
                sqlCmd.Parameters.AddWithValue("@paraPassword", Password);
                sqlCmd.Parameters.AddWithValue("@paraFName", FirstName);
                sqlCmd.Parameters.AddWithValue("@paraLName", LastName);
                sqlCmd.Parameters.AddWithValue("@paraDob", Dob);
                sqlCmd.Parameters.AddWithValue("@paraCardholderName", CardholderName);
                sqlCmd.Parameters.AddWithValue("@paraCardType", CardType);
                sqlCmd.Parameters.AddWithValue("@paraCardNo", CardNo);
                sqlCmd.Parameters.AddWithValue("@paraCardExpiry", CardExpiry);
                sqlCmd.Parameters.AddWithValue("@paraCardCVV", CardCVV);
                sqlCmd.Parameters.AddWithValue("@paraSalt", Salt);

                dbSqlConnection.Open();
                int result = sqlCmd.ExecuteNonQuery();
                dbSqlConnection.Close();
                return result;
            }
            catch (SqlException ex)
            {
                return 0;
            }
        }

        public User Login(string email, string password, string theSalt, string theHash)
        {
            SHA512Managed hasher = new SHA512Managed();

            if (theSalt != null && theSalt.Length > 0 && theHash != null && theHash.Length > 0)
            {
                string pwdWithSalt = password + theSalt;
                byte[] hashWithSalt = hasher.ComputeHash(Encoding.UTF8.GetBytes(pwdWithSalt));
                string userHash = Convert.ToBase64String(hashWithSalt);
                if (userHash.Equals(theHash))
                {
                    User user = new User(reqName(email), email, password);
                    return user;
                }
            }
            return null;
        }

        public int CheckExistingUser(string email)
        {
            try
            {
                string dbConnectionStr = ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString;
                SqlConnection dbSqlConnection = new SqlConnection(dbConnectionStr);

                string sqlStatement = "Select * from Users Where email = @paraEmail";
                SqlDataAdapter da = new SqlDataAdapter(sqlStatement, dbSqlConnection);
                da.SelectCommand.Parameters.AddWithValue("@paraEmail", email);

                DataSet ds = new DataSet();

                da.Fill(ds);

                int rec_cnt = ds.Tables[0].Rows.Count;
                if (rec_cnt == 1)
                {
                    return 1;
                }
            return 0;
            }
            catch (SqlException ex)
            {
                return -1;
            }
        }

        public string reqHash(string email)
        {
            string dbConnectionStr = ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString;


            string hashValue = null;

            try
            {
                SqlConnection connection = new SqlConnection(dbConnectionStr);
                string sql = "Select password FROM Users WHERE email = @paraEmail";
                SqlCommand command = new SqlCommand(sql, connection);
                command.Parameters.AddWithValue("@paraEmail", email);
                try
                {
                    connection.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {

                        while (reader.Read())
                        {
                            if (reader["password"] != null)
                            {
                                if (reader["password"] != DBNull.Value)
                                {
                                    hashValue = reader["password"].ToString();
                                }
                            }
                        }

                    }
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.ToString());
                }
                finally { connection.Close(); }
            }
            catch (SqlException ex)
            {

            }
            return hashValue;
        }

        public string reqSalt(string email)
        {

            string dbConnectionStr = ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString;

            string saltValue = null;

            try
            {
                SqlConnection connection = new SqlConnection(dbConnectionStr);
                string sql = "Select salt FROM Users WHERE email = @paraEmail";
                SqlCommand command = new SqlCommand(sql, connection);
                command.Parameters.AddWithValue("@paraEmail", email);
                try
                {
                    connection.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {

                        while (reader.Read())
                        {
                            if (reader["salt"] != null)
                            {
                                if (reader["salt"] != DBNull.Value)
                                {
                                    saltValue = reader["salt"].ToString();
                                }
                            }
                        }

                    }
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.ToString());
                }

                finally { connection.Close(); }
            }
            catch (SqlException ex)
            {

            }
            return saltValue;
        }

        public string reqName(string email)
        {

            string dbConnectionStr = ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString;

            string name = null;

            try
            {
                SqlConnection connection = new SqlConnection(dbConnectionStr);
                string sql = "Select firstName FROM Users WHERE email = @paraEmail";
                SqlCommand command = new SqlCommand(sql, connection);
                command.Parameters.AddWithValue("@paraEmail", email);
                try
                {
                    connection.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {

                        while (reader.Read())
                        {
                            if (reader["firstName"] != null)
                            {
                                if (reader["firstName"] != DBNull.Value)
                                {
                                    name = reader["firstName"].ToString();
                                }
                            }
                        }

                    }
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.ToString());
                }
                finally { connection.Close(); }
            }
            catch (SqlException ex)
            {

            }
            return name;
        }

        public int checkLockout(string email)
        {
            string dbConnectionStr = ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString;

            int lockout = 0;

            try
            {
                SqlConnection connection = new SqlConnection(dbConnectionStr);
                string sql = "Select lockout FROM Users WHERE email = @paraEmail";
                SqlCommand command = new SqlCommand(sql, connection);
                command.Parameters.AddWithValue("@paraEmail", email);
                try
                {
                    connection.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            if (reader["lockout"] != null)
                            {
                                if (reader["lockout"] != DBNull.Value)
                                {
                                    lockout = Convert.ToInt32(reader["lockout"].ToString());
                                }
                            }
                        }

                    }
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.ToString());
                }
                finally { connection.Close(); }
            }
            catch (SqlException ex)
            {

            }
            return lockout;
        }

        public int upLockout(string email)
        {
            string dbConnectionStr = ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString;
            int lockout = 0;
            string sqlStatement = null;
            int result = 0;
            if (CheckExistingUser(email) == 1)
            {
                sqlStatement = "UPDATE Users SET lockout = lockout + 1 WHERE (email = @paraEmail)";

                SqlConnection dbSqlConnection = new SqlConnection(dbConnectionStr);
                try
                {
                    SqlCommand sqlCmd = new SqlCommand(sqlStatement, dbSqlConnection);
                    sqlCmd.Parameters.AddWithValue("@paraEmail", email);
                    dbSqlConnection.Open();
                    result = sqlCmd.ExecuteNonQuery();
                }
                catch (SqlException ex)
                {

                }
                finally { dbSqlConnection.Close(); }
            }
            return result;
        }

        public int resetLockout(string email)
        {
            string dbConnectionStr = ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString;
            int lockout = 0;
            string sqlStatement = null;
            int result = 0;
            if (CheckExistingUser(email) == 1)
            {
                sqlStatement = "UPDATE Users SET lockout = 0 WHERE (email = @paraEmail)";

                SqlConnection dbSqlConnection = new SqlConnection(dbConnectionStr);
                try
                {
                    SqlCommand sqlCmd = new SqlCommand(sqlStatement, dbSqlConnection);
                    sqlCmd.Parameters.AddWithValue("@paraEmail", email);
                    dbSqlConnection.Open();
                    result = sqlCmd.ExecuteNonQuery();
                }
                catch (SqlException ex)
                {
                }
                finally { dbSqlConnection.Close(); }
            }
            return result;
        }
    }
}
