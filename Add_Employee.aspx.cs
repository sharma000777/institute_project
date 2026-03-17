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

public partial class Admin_Add_Employee : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
    SqlComan5 cls = new SqlComan5();
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string Get_Department()
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
        SqlCommand cmd = new SqlCommand("select * from Department_Master", con);
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
    public static string Get_Designation(string Department)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
        SqlCommand cmd = new SqlCommand("select * from Designation_Master where Department=@Department", con);
        cmd.Parameters.AddWithValue("@Department", Department);
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
            EmployeeId = "EMP" + PID.ToString();
            return EmployeeId;
        }
        else
        {
            return "";
        }
    }


    [WebMethod]
    public static int Create_Employee(string EmployeeId, string EmployeeName, string Mobile, string Gender, string Email, string DOB, string AadharNo, string FatherName, string State, string City, string Pincode, string Address, string Photo, string Department, string Designation, string JoiningDate, string Salary)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
        SqlComan5 cls = new SqlComan5();
        
        string employeeQuery = @"
            Insert into Employee_Detail(EmployeeId,EmployeeName,Mobile,Gender,Email,DOB,AadharNo,FatherName,State,City,Pincode,Address,Photo,Department,Designation,JoiningDate,Salary,Date) values
            (@EmployeeId,@EmployeeName,@Mobile,@Gender,@Email,@DOB,@AadharNo,@FatherName,@State,@City,@Pincode,@Address,@Photo,@Department,@Designation,@JoiningDate,@Salary,@Date)
        ";

        con.Open();
        SqlTransaction transaction = con.BeginTransaction();

        try
        {
            SqlCommand cmd = new SqlCommand(employeeQuery, con, transaction);
            cmd.Parameters.AddWithValue("@EmployeeId", EmployeeId);
            cmd.Parameters.AddWithValue("@EmployeeName", EmployeeName);
            cmd.Parameters.AddWithValue("@Mobile", Mobile);
            cmd.Parameters.AddWithValue("@Gender", Gender);
            cmd.Parameters.AddWithValue("@Email", Email);
            cmd.Parameters.AddWithValue("@DOB", DOB);
            cmd.Parameters.AddWithValue("@AadharNo", AadharNo);
            cmd.Parameters.AddWithValue("@FatherName", FatherName);
            cmd.Parameters.AddWithValue("@State", State);
            cmd.Parameters.AddWithValue("@City", City);
            cmd.Parameters.AddWithValue("@Pincode", Pincode);
            cmd.Parameters.AddWithValue("@Address", Address);
            cmd.Parameters.AddWithValue("@Photo", Photo);
            cmd.Parameters.AddWithValue("@Department", Department);
            cmd.Parameters.AddWithValue("@Designation", Designation);
            cmd.Parameters.AddWithValue("@JoiningDate", JoiningDate);
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