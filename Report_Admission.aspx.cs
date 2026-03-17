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

public partial class Admin_Report_Admission : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
    SqlComan5 cls = new SqlComan5();
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public class AdmissionModel
    {
        public int SlNo { get; set; }
        public int Id { get; set; }
        public string StudentId { get; set; }
        public string AdmissionNo { get; set; }
        public string CourseId { get; set; }
        public string Photo { get; set; }
        public string StudentName { get; set; }
        public string RollNo { get; set; }
        public string Mobile { get; set; }
        public string Gender { get; set; }
        public string Email { get; set; }
        public string DOB { get; set; }
        public string FatherName { get; set; }
        public string FatherOccupation { get; set; }
        public string FatherContactNo { get; set; }
        public string MotherName { get; set; }
        public string State { get; set; }
        public string City { get; set; }
        public string Pincode { get; set; }
        public string Address { get; set; }
        public string Date { get; set; }
        public string AdmissionType { get; set; }
    }
    public class DataTables
    {
        public int draw { get; set; }
        public int recordsTotal { get; set; }
        public int recordsFiltered { get; set; }
        public List<AdmissionModel> data { get; set; }
    }
    public static object Get_Admission_DetailData(string query)
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
        List<AdmissionModel> data = new List<AdmissionModel>();

        SqlCommand cmd = new SqlCommand(query, con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                data.Add(new AdmissionModel
                {
                    SlNo = Convert.ToInt32(dr["SlNo"]),
                    Id = Convert.ToInt32(dr["Id"]),
                    StudentId = dr["StudentId"].ToString(),
                    AdmissionNo = dr["AdmissionNo"].ToString(),
                    CourseId = dr["CourseId"].ToString(),
                    Photo = dr["Photo"].ToString(),
                    StudentName = dr["StudentName"].ToString(),
                    RollNo = dr["RollNo"].ToString(),
                    Mobile = dr["Mobile"].ToString(),
                    Gender = dr["Gender"].ToString(),
                    Email = dr["Email"].ToString(),
                    DOB = dr["DOB"].ToString(),
                    FatherName = dr["FatherName"].ToString(),
                    FatherOccupation = dr["FatherOccupation"].ToString(),
                    FatherContactNo = dr["FatherContactNo"].ToString(),
                    MotherName = dr["MotherName"].ToString(),
                    State = dr["State"].ToString(),
                    City = dr["City"].ToString(),
                    Pincode = dr["Pincode"].ToString(),
                    Address = dr["Address"].ToString(),
                    Date = dr["Date"].ToString(),
                    AdmissionType = dr["AdmissionType"].ToString()
                });
            };
        }


        // Configure Jquery Datatable property Total record count property.    
        int totalRecords = data.Count;

        // Apply server-side data searching.   
        if (!string.IsNullOrEmpty(search))
        {
            data = data.Where(x => x.Id.ToString().Contains(search.ToLower()) || x.StudentId.ToLower().Contains(search.ToLower()) || x.AdmissionNo.ToLower().Contains(search.ToLower()) || x.Photo.ToLower().Contains(search.ToLower()) || x.StudentName.ToLower().Contains(search.ToLower()) || x.RollNo.ToLower().Contains(search.ToLower()) || x.Mobile.ToLower().Contains(search.ToLower()) || x.Gender.ToLower().Contains(search.ToLower()) || x.Email.ToLower().Contains(search.ToLower()) || x.DOB.ToLower().Contains(search.ToLower()) || x.FatherName.ToLower().Contains(search.ToLower()) || x.FatherOccupation.ToLower().Contains(search.ToLower()) || x.FatherContactNo.ToLower().Contains(search.ToLower()) || x.MotherName.ToLower().Contains(search.ToLower()) || x.State.ToLower().Contains(search.ToLower()) || x.City.ToLower().Contains(search.ToLower()) || x.Pincode.ToLower().Contains(search.ToLower()) || x.Address.ToLower().Contains(search.ToLower()) || x.Date.ToLower().Contains(search.ToLower()) || x.AdmissionType.ToLower().Contains(search.ToLower())).ToList();
        };


        // Apply server-side Sorting.    
        if (!string.IsNullOrEmpty(sortColumnName) && !string.IsNullOrEmpty(sortDirection))
        {
            if (sortDirection == "asc") // Check for ascending or descending order
                data = data.OrderBy(x => typeof(AdmissionModel).GetProperty(sortColumnName).GetValue(x, null)).ToList();
            else
                data = data.OrderByDescending(x => typeof(AdmissionModel).GetProperty(sortColumnName).GetValue(x, null)).ToList();
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
    public static object Get_Student_Admission(string StudentType, string OperatorId, bool IsOperator)
    {
        string query;
        if (!IsOperator)
        {
            if (StudentType == "All")
                query = @"select ROW_NUMBER() OVER (ORDER BY Id desc) AS SlNo,FORMAT(Date, 'dd-MMM-yyyy') AS Date,* from Student_Admission";
            else
                query = @"select ROW_NUMBER() OVER (ORDER BY Id desc) AS SlNo,FORMAT(Date, 'dd-MMM-yyyy') AS Date,* from Student_Admission where AdmissionType = '" + StudentType + "'";
        }
        else
        {
            if (StudentType == "All")
                query = @"select ROW_NUMBER() OVER (ORDER BY Id desc) AS SlNo,FORMAT(Date, 'dd-MMM-yyyy') AS Date,* from Student_Admission where ProcessedBy = '" + OperatorId + "'";
            else
                query = @"select ROW_NUMBER() OVER (ORDER BY Id desc) AS SlNo,FORMAT(Date, 'dd-MMM-yyyy') AS Date,* from Student_Admission where AdmissionType = '" + StudentType + "' and ProcessedBy = '" + OperatorId + "'";
        }

        return Get_Admission_DetailData(query);
    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = true)]
    public static object Get_Admission_Detail_ByDate(string StudentType, string StartDate, string EndDate, string OperatorId, bool IsOperator)
    {
        string query;
        if (!IsOperator)
        {
            if (StudentType == "All")
                query = @"select ROW_NUMBER() OVER (ORDER BY Id desc) AS SlNo,FORMAT(Date, 'dd-MMM-yyyy') AS Date,* from Student_Admission where cast(Date as DATE) >= cast('" + StartDate + "' as DATE) and cast(Date as DATE) <= cast('" + EndDate + "' as DATE);";
            else
                query = @"select ROW_NUMBER() OVER (ORDER BY Id desc) AS SlNo,FORMAT(Date, 'dd-MMM-yyyy') AS Date,* from Student_Admission where AdmissionType = '" + StudentType + "' and cast(Date as DATE) >= cast('" + StartDate + "' as DATE) and cast(Date as DATE) <= cast('" + EndDate + "' as DATE);";

        }
        else
        {
            if (StudentType == "All")
                query = @"select ROW_NUMBER() OVER (ORDER BY Id desc) AS SlNo,FORMAT(Date, 'dd-MMM-yyyy') AS Date,* from Student_Admission where cast(Date as DATE) >= cast('" + StartDate + "' as DATE) and cast(Date as DATE) <= cast('" + EndDate + "' as DATE) and ProcessedBy = '" + OperatorId + "';";
            else
                query = @"select ROW_NUMBER() OVER (ORDER BY Id desc) AS SlNo,FORMAT(Date, 'dd-MMM-yyyy') AS Date,* from Student_Admission where AdmissionType = '" + StudentType + "' and cast(Date as DATE) >= cast('" + StartDate + "' as DATE) and cast(Date as DATE) <= cast('" + EndDate + "' as DATE) and ProcessedBy = '" + OperatorId + "';";

        }

        return Get_Admission_DetailData(query);
    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string Get_MinDate()
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
        SqlCommand cmd = new SqlCommand(@"
           select CONVERT(varchar(10), MIN(CONVERT(date, Date, 101)), 110) AS MinDate
           from Student_Admission", con);
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
    public static string Get_Operator()
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
        SqlCommand cmd = new SqlCommand("select * from Operator_Profile", con);
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
    public static object Get_Admission_Detail_ByCourse(string CourseId, string StudentType, string OperatorId, bool IsOperator)
    {
        string query;
        if (!IsOperator)
        {
            if (StudentType == "All")
                query = @"select ROW_NUMBER() OVER (ORDER BY Id desc) AS SlNo,FORMAT(Date, 'dd-MMM-yyyy') AS Date,* from Student_Admission where CourseId = '" + CourseId + "'";
            else
                query = @"select ROW_NUMBER() OVER (ORDER BY Id desc) AS SlNo,FORMAT(Date, 'dd-MMM-yyyy') AS Date,* from Student_Admission where CourseId = '" + CourseId + "' and AdmissionType = '" + StudentType + "'";

        }
        else
        {
            if (StudentType == "All")
                query = @"select ROW_NUMBER() OVER (ORDER BY Id desc) AS SlNo,FORMAT(Date, 'dd-MMM-yyyy') AS Date,* from Student_Admission where CourseId = '" + CourseId + "' and ProcessedBy = '" + OperatorId + "'";
            else
                query = @"select ROW_NUMBER() OVER (ORDER BY Id desc) AS SlNo,FORMAT(Date, 'dd-MMM-yyyy') AS Date,* from Student_Admission where CourseId = '" + CourseId + "' and AdmissionType = '" + StudentType + "' and ProcessedBy = '" + OperatorId + "'";

        }

        return Get_Admission_DetailData(query);
    }

}