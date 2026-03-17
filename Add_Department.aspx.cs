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

public partial class Admin_Add_Department : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
    SqlComan5 cls = new SqlComan5();
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [WebMethod]
    public static int Add_Department(string Department_Name)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
        SqlComan5 cls = new SqlComan5();

        DataTable dt = cls.GetDataTable("Select * from Department_Master where Department_Name='" + Department_Name + "'");
        if (dt.Rows.Count > 0)
            return -1;
        else
        {
            SqlCommand cmd = new SqlCommand(@"insert into Department_Master(
            Department_Name) VALUES (
            @Department_Name)", con);
            cmd.Parameters.AddWithValue("@Department_Name", Department_Name);
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

}