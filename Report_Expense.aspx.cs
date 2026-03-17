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

public partial class Admin_Report_Expense : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
    SqlComan5 cls = new SqlComan5();
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public class ExpenseModel
    {
        public int SlNo { get; set; }
        public int Id { get; set; }
        public string ExpenseBy { get; set; }
        public string Purpose { get; set; }
        public string Amount { get; set; }
        public string RecieverName { get; set; }
        public string PaymentMethod { get; set; }
        public string TransactionNo { get; set; }
        public string BankName { get; set; }
        public string Date { get; set; }
        public string Remarks { get; set; }
    }
    public class DataTables
    {
        public int draw { get; set; }
        public int recordsTotal { get; set; }
        public int recordsFiltered { get; set; }
        public List<ExpenseModel> data { get; set; }
    }
    public static object Get_Expense_DetailData(string query)
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
        List<ExpenseModel> data = new List<ExpenseModel>();

        SqlCommand cmd = new SqlCommand(query, con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                data.Add(new ExpenseModel
                {
                    SlNo = Convert.ToInt32(dr["SlNo"]),
                    Id = Convert.ToInt32(dr["id"]),
                    ExpenseBy = dr["EmployeeName"].ToString(),
                    Purpose = dr["Purpose"].ToString(),
                    Amount = dr["Amount"].ToString(),
                    RecieverName = dr["RecieverName"].ToString(),
                    PaymentMethod = dr["PaymentMethod"].ToString(),
                    TransactionNo = dr["TransactionNo"].ToString(),
                    BankName = dr["BankName"].ToString(),
                    Date = dr["Date"].ToString(),
                    Remarks = dr["Remarks"].ToString()
                });
            };
        }


        // Configure Jquery Datatable property Total record count property.    
        int totalRecords = data.Count;

        // Apply server-side data searching.   
        if (!string.IsNullOrEmpty(search))
        {
            data = data.Where(x => x.Id.ToString().Contains(search.ToLower()) || x.ExpenseBy.ToLower().Contains(search.ToLower()) || x.Purpose.ToLower().Contains(search.ToLower()) || x.Amount.ToLower().Contains(search.ToLower()) || x.RecieverName.ToLower().Contains(search.ToLower()) || x.PaymentMethod.ToLower().Contains(search.ToLower()) || x.TransactionNo.ToLower().Contains(search.ToLower()) || x.BankName.ToLower().Contains(search.ToLower()) || x.Date.ToLower().Contains(search.ToLower()) || x.Remarks.ToLower().Contains(search.ToLower())).ToList();
        };


        // Apply server-side Sorting.    
        if (!string.IsNullOrEmpty(sortColumnName) && !string.IsNullOrEmpty(sortDirection))
        {
            if (sortDirection == "asc") // Check for ascending or descending order
                data = data.OrderBy(x => typeof(ExpenseModel).GetProperty(sortColumnName).GetValue(x, null)).ToList();
            else
                data = data.OrderByDescending(x => typeof(ExpenseModel).GetProperty(sortColumnName).GetValue(x, null)).ToList();
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
    public static object Get_Expense_Detail()
    {
        string query = @"select ROW_NUMBER() OVER (ORDER BY e.Id desc) AS SlNo,* from Expenses e inner join Employee_Detail ed on e.ExpenseBy = ed.EmployeeId";
        return Get_Expense_DetailData(query);
    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = true)]
    public static object Get_Expense_Detail_ByDate(string StartDate, string EndDate)
    {
        string query = @"
          select ROW_NUMBER() OVER (ORDER BY e.Id desc) AS SlNo,* from Expenses e inner join Employee_Detail ed on e.ExpenseBy = ed.EmployeeId where cast(e.Date as DATE) >= cast('" + StartDate + "' as DATE) and cast(e.Date as DATE) <= cast('" + EndDate + "' as DATE);";
        return Get_Expense_DetailData(query);
    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string Get_MinDate()
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
        SqlCommand cmd = new SqlCommand(@"
           select CONVERT(varchar(10), MIN(CONVERT(date, ed.Date, 101)), 110) AS MinDate
           from Expenses ed", con);
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
    
   

}