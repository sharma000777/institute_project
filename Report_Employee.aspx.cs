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

public partial class Admin_Report_Employee : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
    SqlComan5 cls = new SqlComan5();
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public class EmployeeModel
    {
        public int SlNo { get; set; }
        public int Id { get; set; }
        public string EmployeeId { get; set; }
        public string Photo { get; set; }
        public string EmployeeName { get; set; }
        public string Department { get; set; }
        public string Designation { get; set; }
        public string Salary { get; set; }
        public string Mobile { get; set; }
        public string Gender { get; set; }
        public string Email { get; set; }
        public string DOB { get; set; }
        public string AadharNo { get; set; }
        public string FatherName { get; set; }
        public string State { get; set; }
        public string City { get; set; }
        public string Pincode { get; set; }
        public string Address { get; set; }
        public string JoiningDate { get; set; }
    }
    public class DataTables
    {
        public int draw { get; set; }
        public int recordsTotal { get; set; }
        public int recordsFiltered { get; set; }
        public List<EmployeeModel> data { get; set; }
    }
    public static object Get_Employee_DetailData(string query)
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
        List<EmployeeModel> data = new List<EmployeeModel>();

        SqlCommand cmd = new SqlCommand(query, con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                data.Add(new EmployeeModel
                {
                    SlNo = Convert.ToInt32(dr["SlNo"]),
                    Id = Convert.ToInt32(dr["id"]),
                    EmployeeId = dr["EmployeeId"].ToString(),
                    Photo = dr["Photo"].ToString(),
                    EmployeeName = dr["EmployeeName"].ToString(),
                    Department = dr["Department"].ToString(),
                    Designation = dr["Designation"].ToString(),
                    Salary = dr["Salary"].ToString(),
                    Mobile = dr["Mobile"].ToString(),
                    Gender = dr["Gender"].ToString(),
                    Email = dr["Email"].ToString(),
                    DOB = dr["DOB"].ToString(),
                    AadharNo = dr["AadharNo"].ToString(),
                    FatherName = dr["FatherName"].ToString(),
                    State = dr["State"].ToString(),
                    City = dr["City"].ToString(),
                    Pincode = dr["Pincode"].ToString(),
                    Address = dr["Address"].ToString(),
                    JoiningDate = dr["JoiningDate"].ToString()
                });
            };
        }


        // Configure Jquery Datatable property Total record count property.    
        int totalRecords = data.Count;

        // Apply server-side data searching.   
        if (!string.IsNullOrEmpty(search))
        {
            data = data.Where(x => x.Id.ToString().Contains(search.ToLower()) || x.EmployeeId.ToLower().Contains(search.ToLower()) || x.EmployeeName.ToLower().Contains(search.ToLower()) || x.Department.ToLower().Contains(search.ToLower()) || x.Designation.ToLower().Contains(search.ToLower()) || x.Salary.ToLower().Contains(search.ToLower()) || x.Mobile.ToLower().Contains(search.ToLower()) || x.Gender.ToLower().Contains(search.ToLower()) || x.Email.ToLower().Contains(search.ToLower()) || x.DOB.ToLower().Contains(search.ToLower()) || x.AadharNo.ToLower().Contains(search.ToLower()) || x.FatherName.ToLower().Contains(search.ToLower()) || x.State.ToLower().Contains(search.ToLower()) || x.City.ToLower().Contains(search.ToLower()) || x.Pincode.ToLower().Contains(search.ToLower()) || x.Address.ToLower().Contains(search.ToLower()) || x.JoiningDate.ToLower().Contains(search.ToLower())).ToList();
        };


        // Apply server-side Sorting.    
        if (!string.IsNullOrEmpty(sortColumnName) && !string.IsNullOrEmpty(sortDirection))
        {
            if (sortDirection == "asc") // Check for ascending or descending order
                data = data.OrderBy(x => typeof(EmployeeModel).GetProperty(sortColumnName).GetValue(x, null)).ToList();
            else
                data = data.OrderByDescending(x => typeof(EmployeeModel).GetProperty(sortColumnName).GetValue(x, null)).ToList();
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
    public static object Get_Employee_Detail()
    {
        string query = @"select ROW_NUMBER() OVER (ORDER BY Id desc) AS SlNo,* from Employee_Detail";
        return Get_Employee_DetailData(query);
    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = true)]
    public static object Get_Employee_Detail_ByDate(string StartDate, string EndDate)
    {
        string query = @"
          select ROW_NUMBER() OVER (ORDER BY Id desc) AS SlNo,* from Employee_Detail where cast(Date as DATE) >= cast('" + StartDate + "' as DATE) and cast(Date as DATE) <= cast('" + EndDate + "' as DATE);";
        return Get_Employee_DetailData(query);
    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string Get_MinDate()
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
        SqlCommand cmd = new SqlCommand(@"
           select CONVERT(varchar(10), MIN(CONVERT(date, Date, 101)), 110) AS MinDate
           from Employee_Detail", con);
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
        SqlCommand cmd = new SqlCommand("select * from Designation_Master where Department='" + Department + "'", con);
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
    public static object Get_Employee_Detail_ByDepartment(string Department)
    {
        string query = @"
           select ROW_NUMBER() OVER (ORDER BY Id desc) AS SlNo,* from Employee_Detail where Department = '" + Department + "'";
        return Get_Employee_DetailData(query);
    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = true)]
    public static object Get_Employee_Detail_ByDesignation(string Department, string Designation)
    {
        string query = @"
           select ROW_NUMBER() OVER (ORDER BY Id desc) AS SlNo,* from Employee_Detail where Department = '" + Department + "' and Designation = '"+ Designation + "'";
        return Get_Employee_DetailData(query);
    }

}