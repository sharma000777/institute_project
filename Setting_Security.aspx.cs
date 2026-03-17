using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Globalization;
using System.Linq.Dynamic;
using System.Dynamic;
using System.Web.Services;
using System.Web.Script.Services;
using Newtonsoft.Json;

public partial class Admin_Setting_Security : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
    SqlComan5 cls = new SqlComan5();
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string Get_CurrentPass()
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);

        string LoginId = HttpContext.Current.Session["LoginId"].ToString();

        SqlCommand cmd = new SqlCommand("select * from Login_Master where LoginId ='" + LoginId + "'", con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            return dt.Rows[0]["Password"].ToString();
        }
        else
        {
            return "";
        }
    }
    [WebMethod]
    public static int Update_NewPass(string Password)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);

        string LoginId = HttpContext.Current.Session["LoginId"].ToString();

        SqlCommand cmd = new SqlCommand(@"update Login_Master set 
        Password=@Password where LoginId=@LoginId", con);
        cmd.Parameters.AddWithValue("@Password", Password);
        cmd.Parameters.AddWithValue("@LoginId", LoginId);
        con.Open();
        int res = cmd.ExecuteNonQuery();
        con.Close();
        return res;
    }
}