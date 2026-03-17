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

public partial class Admin_Report_Due : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
    SqlComan5 cls = new SqlComan5();
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public class DueModel
    {
        public int SlNo { get; set; }
        public int Id { get; set; }
        public string TotalDuesAmount { get; set; }
        public string StudentId { get; set; }
        public string AdmissionNo { get; set; }
        public string StudentName { get; set; }
        public string Mobile { get; set; }
        public string Course_Name { get; set; }
        public string BatchName { get; set; }
        public string RollNo { get; set; }
        public string Total_Dues { get; set; }
        public string Installment_Amount { get; set; }
        public string Dues_Date { get; set; }
        public string Total_Installment { get; set; }
    }
    public class DataTables
    {
        public int draw { get; set; }
        public int recordsTotal { get; set; }
        public int recordsFiltered { get; set; }
        public List<DueModel> data { get; set; }
    }
    public static object Get_Due_DetailData(string query)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);

        // Initialization.    
        DataTables result = new DataTables();


        // Capture Jquery Datatables Plugin Properties.    
        string search = HttpContext.Current.Request.Params["search[value]"];
        string draw = HttpContext.Current.Request.Params["draw"];
        string sortColumnName = HttpContext.Current.Request["columns[" + HttpContext.Current.Request["order[0][column]"] + "][data]"]; // Changed from "name" to "data"
        string sortDirection = HttpContext.Current.Request["order[0][dir]"];
        int startRec = Convert.ToInt32(HttpContext.Current.Request.Params["start"]);
        int pageSize = Convert.ToInt32(HttpContext.Current.Request.Params["length"]);

        // Load data from text file.   
        List<DueModel> data = new List<DueModel>();

        SqlCommand cmd = new SqlCommand(query, con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                data.Add(new DueModel
                {
                    SlNo = Convert.ToInt32(dr["SlNo"]),
                    Id = Convert.ToInt32(dr["id"]),
                    TotalDuesAmount = dr["TotalDuesAmount"].ToString(),
                    StudentId = dr["StudentId"].ToString(),
                    AdmissionNo = dr["AdmissionNo"].ToString(),
                    StudentName = dr["StudentName"].ToString(),
                    Mobile = dr["Mobile"].ToString(),
                    Course_Name = dr["Course_Name"].ToString(),
                    BatchName = dr["BatchName"].ToString(),
                    RollNo = dr["RollNo"].ToString(),
                    Total_Dues = dr["Total_Dues"].ToString(),
                    Installment_Amount = dr["Installment_Amount"].ToString(),
                    Dues_Date = dr["Dues_Date"].ToString(),
                    Total_Installment = dr["Total_Installment"].ToString()
                });
            };
        }


        // Configure Jquery Datatable property Total record count property.    
        int totalRecords = data.Count;

        // Apply server-side data searching.   
        if (!string.IsNullOrEmpty(search))
        {
            data = data.Where(x => x.Id.ToString().Contains(search.ToLower()) || x.StudentId.ToLower().Contains(search.ToLower()) || x.AdmissionNo.ToLower().Contains(search.ToLower()) || x.StudentName.ToLower().Contains(search.ToLower()) || x.Mobile.ToLower().Contains(search.ToLower()) || x.Course_Name.ToLower().Contains(search.ToLower()) || x.BatchName.ToLower().Contains(search.ToLower()) || x.RollNo.ToLower().Contains(search.ToLower()) || x.Total_Dues.ToLower().Contains(search.ToLower()) || x.Installment_Amount.ToLower().Contains(search.ToLower()) || x.Dues_Date.ToLower().Contains(search.ToLower()) || x.Total_Installment.ToLower().Contains(search.ToLower())).ToList();
        };


        // Apply server-side Sorting.    
        if (!string.IsNullOrEmpty(sortColumnName) && !string.IsNullOrEmpty(sortDirection))
        {
            if (sortDirection == "asc") // Check for ascending or descending order
                data = data.OrderBy(x => typeof(DueModel).GetProperty(sortColumnName).GetValue(x, null)).ToList();
            else
                data = data.OrderByDescending(x => typeof(DueModel).GetProperty(sortColumnName).GetValue(x, null)).ToList();
        };


        // Configure Jquery Datatable property Filter record count property after applying searching and sorting.    
        int recFilter = data.Count;

        // Apply server-side pagination.    

        data = data.Skip(startRec).Take(pageSize).ToList();

        // Mapping final configuration settings for Jquery Datatables plugin.    
        result.draw = Convert.ToInt32(draw);
        result.recordsTotal = totalRecords;
        result.recordsFiltered = recFilter;
        result.data = data;


        // Return info.    
        return result;
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = true)]
    public static object Get_Due_Detail()
    {
        string query = @"select ROW_NUMBER() OVER (ORDER BY di.Id desc) AS SlNo,SUM(CAST(di.Total_Dues AS DECIMAL(18, 2))) OVER () AS TotalDuesAmount,FORMAT(di.Dues_Date, 'dd-MMM-yyyy') AS Dues_Date,* from Dues_Installment di inner join Student_Admission sa on di.StudentId=sa.StudentId inner join Course_Master cm on sa.CourseId=cm.Id inner join Student_Batch sb on sa.StudentId = sb.StudentId inner join Batch_Master bm on sb.BatchId = bm.Id where di.Total_Installment != '0'";
        return Get_Due_DetailData(query);
    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = true)]
    public static object Get_Due_Detail_ByDate(string StartDate, string EndDate)
    {
        string query = @"
          select ROW_NUMBER() OVER (ORDER BY di.Id desc) AS SlNo,SUM(CAST(di.Total_Dues AS DECIMAL(18, 2))) OVER () AS TotalDuesAmount,FORMAT(di.Dues_Date, 'dd-MMM-yyyy') AS Dues_Date,* from Dues_Installment di inner join Student_Admission sa on di.StudentId=sa.StudentId inner join Course_Master cm on sa.CourseId=cm.Id inner join Student_Batch sb on sa.StudentId = sb.StudentId inner join Batch_Master bm on sb.BatchId = bm.Id where di.Total_Installment != '0' and cast(di.Dues_Date as DATE) >= cast('" + StartDate + "' as DATE) and cast(di.Dues_Date as DATE) <= cast('" + EndDate + "' as DATE);";
        return Get_Due_DetailData(query);
    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string Get_MinDate()
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
        SqlCommand cmd = new SqlCommand(@"
           select CONVERT(varchar(10), MIN(CONVERT(date, Dues_Date, 101)), 110) AS MinDate
           from Dues_Installment", con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            if (dt.Rows[0]["MinDate"].ToString() == "")
            {
                return DateTime.Now.ToString("MM-dd-yyyy");
            }
            else
            {
                return dt.Rows[0]["MinDate"].ToString();
            }
        }
        else
        {
            return "";
        }
    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string Get_MaxDate()
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
        SqlCommand cmd = new SqlCommand(@"
           select CONVERT(varchar(10), MAX(CONVERT(date, Dues_Date, 101)), 110) AS MaxDate
           from Dues_Installment", con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            if (dt.Rows[0]["MaxDate"].ToString() == "")
            {
                return DateTime.Now.ToString("MM-dd-yyyy");
            }
            else
            {
                return dt.Rows[0]["MaxDate"].ToString();
            }
        }
        else
        {
            return "";
        }
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
    public static string Get_SearchByStudent()
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
        SqlCommand cmd = new SqlCommand("select distinct sa.Mobile, sa.StudentName from Student_Admission sa inner join Paid_Installment si on sa.StudentId=si.StudentId", con);
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
    [ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = true)]
    public static object Get_Due_Detail_ByMobile(string Mobile)
    {
        string query = @"
           select ROW_NUMBER() OVER (ORDER BY di.Id desc) AS SlNo,SUM(CAST(di.Total_Dues AS DECIMAL(18, 2))) OVER () AS TotalDuesAmount,FORMAT(di.Dues_Date, 'dd-MMM-yyyy') AS Dues_Date,* from Dues_Installment di inner join Student_Admission sa on di.StudentId=sa.StudentId inner join Course_Master cm on sa.CourseId=cm.Id inner join Student_Batch sb on sa.StudentId = sb.StudentId inner join Batch_Master bm on sb.BatchId = bm.Id where di.Total_Installment != '0' and sa.Mobile='" + Mobile + "'";
        return Get_Due_DetailData(query);
    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = true)]
    public static object Get_Due_Detail_ByCourse(string CourseId)
    {
        string query = @"
           select ROW_NUMBER() OVER (ORDER BY di.Id desc) AS SlNo,SUM(CAST(di.Total_Dues AS DECIMAL(18, 2))) OVER () AS TotalDuesAmount,FORMAT(di.Dues_Date, 'dd-MMM-yyyy') AS Dues_Date,* from Dues_Installment di inner join Student_Admission sa on di.StudentId=sa.StudentId inner join Course_Master cm on sa.CourseId=cm.Id inner join Student_Batch sb on sa.StudentId = sb.StudentId inner join Batch_Master bm on sb.BatchId = bm.Id where di.Total_Installment != '0' and sa.CourseId='" + CourseId + "'";
        return Get_Due_DetailData(query);
    }

}