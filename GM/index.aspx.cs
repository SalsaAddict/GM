using Newtonsoft.Json;
using System;
using System.Net;
using System.Security.Cryptography;
using System.Text;
using Facebook;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace GM
{
    public partial class Index : System.Web.UI.Page
    {

        const string AppSecret = "64b831a3ad7d355067c6eeb4cd20004c";

        private void Authenticate()
        {
            try
            {
                FacebookClient FB = new FacebookClient();
                dynamic SignedRequest = FB.ParseSignedRequest(AppSecret, Request.Params["signed_request"]);
                FB.AccessToken = SignedRequest.oauth_token;
                dynamic Me = FB.Get("/me", new { fields = new string[] { "id", "first_name", "last_name", "gender" } });
                using (SqlConnection Connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["Database"].ConnectionString))
                {
                    Connection.Open();
                    using (SqlTransaction Transaction = Connection.BeginTransaction(IsolationLevel.Serializable))
                    {
                        try
                        {
                            using (SqlCommand Command = new SqlCommand("apiLogin", Connection, Transaction))
                            {
                                Command.CommandType = CommandType.StoredProcedure;
                                Command.Parameters.AddWithValue("UserId", SignedRequest.user_id);
                                Command.Parameters.AddWithValue("Forename", Me.first_name);
                                Command.Parameters.AddWithValue("Surname", Me.last_name);
                                Command.Parameters.AddWithValue("Gender", Me.gender);
                                Command.Parameters.AddWithValue("CountryId", SignedRequest.user.country);
                                Command.ExecuteNonQuery();
                            }
                            Transaction.Commit();
                            Session["UserId"] = SignedRequest.user_id;
                        }
                        catch
                        {
                            Transaction.Rollback();
                        }
                    }
                    Connection.Close();
                }
            }
            catch { Session.RemoveAll(); }
        }

        public string UserId { get { return Session["UserId"] as string; } }

        public bool Authenticated { get { return !string.IsNullOrWhiteSpace(UserId); } }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Params["signed_request"] == null) Response.Redirect("https://apps.facebook.com/1574477942882037/");
            Authenticate();
        }
    }
}