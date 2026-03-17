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

public partial class Admin_Add_Enquiry : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
    SqlComan5 cls = new SqlComan5();
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string Get_Course()
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
        SqlCommand cmd = new SqlCommand("select * from Course_Master", con);
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
    public static string Get_ContactMedia()
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
        SqlCommand cmd = new SqlCommand("select * from Contact_Media_Master", con);
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
    public static string Get_CourseDetail(string Id)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
        SqlCommand cmd = new SqlCommand("select ROW_NUMBER() OVER (ORDER BY Id desc) AS SlNo,* from Course_Master where Id=@Id", con);
        cmd.Parameters.AddWithValue("@Id", Id);
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
    public static int Is_MobileExist(string Mobile)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
        SqlCommand cmd = new SqlCommand("Select * from Enquiry_Detail where Mobile=@Mobile", con);
        cmd.Parameters.AddWithValue("@Mobile", Mobile);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
            return 1;
        else
            return 0;
    }
    [WebMethod]
    public static int Add_Enquiry(string EnquiryType, string Name, string Mobile, string Qualification, string CourseId, string FollowUpDate, string Address, string Comment, string ContactMedia)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);

        SqlCommand cmd = new SqlCommand(@"insert into Enquiry_Detail(
        EnquiryType,Name,Mobile,Qualification,CourseId,FollowUpDate,Address,Comment,ContactMedia,Status,Date,ProcessedBy) VALUES (
        @EnquiryType,@Name,@Mobile,@Qualification,@CourseId,@FollowUpDate,@Address,@Comment,@ContactMedia,@Status,@Date,@ProcessedBy)", con);
        cmd.Parameters.AddWithValue("@EnquiryType", EnquiryType);
        cmd.Parameters.AddWithValue("@Name", Name);
        cmd.Parameters.AddWithValue("@Mobile", Mobile);
        cmd.Parameters.AddWithValue("@Qualification", Qualification);
        cmd.Parameters.AddWithValue("@CourseId", CourseId);
        cmd.Parameters.AddWithValue("@FollowUpDate", FollowUpDate);
        cmd.Parameters.AddWithValue("@Address", Address);
        cmd.Parameters.AddWithValue("@Comment", Comment);
        cmd.Parameters.AddWithValue("@ContactMedia", ContactMedia);
        cmd.Parameters.AddWithValue("@Status", "Completed");
        cmd.Parameters.AddWithValue("@Date", DateTime.Now.ToString("yyyy-MM-dd"));
        cmd.Parameters.AddWithValue("@ProcessedBy", "Admin");
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