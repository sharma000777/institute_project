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

public partial class Admin_Add_Employee_Salary : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
    SqlComan5 cls = new SqlComan5();
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string Get_SearchEmployee()
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
        SqlCommand cmd = new SqlCommand("select * from Employee_Detail", con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            string json = JsonConvert.SerializeObject(dt);

            return json;
        }
        else
        {
            string json = JsonConvert.SerializeObject(dt);

            return json;
        }
    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string Get_EmployeeDetail(string EmployeeId)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
        SqlCommand cmd = new SqlCommand("select * from Employee_Detail where EmployeeId='"+ EmployeeId + "'", con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            string json = JsonConvert.SerializeObject(dt);

            return json;
        }
        else
        {
            string json = JsonConvert.SerializeObject(dt);

            return json;
        }
    }
    [WebMethod]
    public static string Get_EmployeeId()
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
        SqlCommand cmd = new SqlCommand("Select (isnull(max(cast(Id As numeric(18,0))),0)) from Employee_Detail", con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            string EmployeeId;
            double PID = double.Parse(dt.Rows[0]["Column1"].ToString()) + 1;
            if (PID < 9)
            {
                EmployeeId = "EMP" + PID.ToString();
            }
            else
            {
                EmployeeId = "STU" + PID.ToString();
            }
            return EmployeeId;
        }
        else
        {
            return "";
        }
    }
    [WebMethod]
    public static int IsExist(string EmployeeId, string Month)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
        SqlCommand cmd = new SqlCommand("Select * from Employees_Salary where EmployeeId='"+ EmployeeId + "' and Month='"+Month+"' and Year='"+DateTime.Now.Year+"'", con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            return 1;
        }
        else
        {
            return 0;
        }
    }


    [WebMethod]
    public static int Create_Employee_Salary(string EmployeeId, string TotalSalary, string Month, string TotalDays, string WorkingDays, string Salary)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
        SqlComan5 cls = new SqlComan5();

        string employeeQuery = @"
            Insert into Employees_Salary(EmployeeId,TotalSalary,Year,Month,TotalDays,WorkingDays,Salary,Date) values
            (@EmployeeId,@TotalSalary,@Year,@Month,@TotalDays,@WorkingDays,@Salary,@Date)
        ";

        con.Open();
        SqlTransaction transaction = con.BeginTransaction();

        try
        {
            SqlCommand cmd = new SqlCommand(employeeQuery, con, transaction);
            cmd.Parameters.AddWithValue("@EmployeeId", EmployeeId);
            cmd.Parameters.AddWithValue("@TotalSalary", TotalSalary);
            cmd.Parameters.AddWithValue("@Year", DateTime.Now.Year);
            cmd.Parameters.AddWithValue("@Month", Month);
            cmd.Parameters.AddWithValue("@TotalDays", TotalDays);
            cmd.Parameters.AddWithValue("@WorkingDays", WorkingDays);
            cmd.Parameters.AddWithValue("@Salary", Salary);
            cmd.Parameters.AddWithValue("@Date", DateTime.Now.ToString("yyyy-MM-dd"));
            int res = cmd.ExecuteNonQuery();
            if (res > 0)
            {
                transaction.Commit();
                return 1;

            }
            else
            {
                transaction.Rollback();
                return 0;
            }
        }
        catch (Exception ex)
        {
            transaction.Rollback();
            return 0;
        }
    }

}