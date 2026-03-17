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

public partial class Admin_Add_Course : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
    SqlComan5 cls = new SqlComan5();
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [WebMethod]
    public static int Add_Course(string Course_Name, string Course_Duration, string Duration_Type, string Fee)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);

        SqlCommand cmd = new SqlCommand(@"insert into Course_Master(
        Course_Name,Course_Duration,Duration_Type,Fee) VALUES (
        @Course_Name,@Course_Duration,@Duration_Type,@Fee)", con);
        cmd.Parameters.AddWithValue("@Course_Name", Course_Name);
        cmd.Parameters.AddWithValue("@Course_Duration", Course_Duration);
        cmd.Parameters.AddWithValue("@Duration_Type", Duration_Type);
        cmd.Parameters.AddWithValue("@Fee", Fee);
        con.Open();
        int res = cmd.ExecuteNonQuery();
        con.Close();

        if (res > 0)
        {
            return 1;
        }
        else
        {
            return 0;
        }

    }

}