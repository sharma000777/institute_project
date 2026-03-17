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

public partial class Admin_Operator : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
    SqlComan5 cls = new SqlComan5();
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public class VisitorModel
    {
        public int SlNo { get; set; }
        public int Id { get; set; }
        public string LoginId { get; set; }
        public string Photo { get; set; }
        public string OperatorName { get; set; }
        public string Mobile { get; set; }
        public string Email { get; set; }
        public string Address { get; set; }
        public string UserName { get; set; }
        public string Password { get; set; }
        public string Date { get; set; }
    }
    public class DataTables
    {
        public int draw { get; set; }
        public int recordsTotal { get; set; }
        public int recordsFiltered { get; set; }
        public List<VisitorModel> data { get; set; }
    }
    public static object Get_Operator_DetailData(string query)
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
        List<VisitorModel> data = new List<VisitorModel>();

        SqlCommand cmd = new SqlCommand(query, con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                data.Add(new VisitorModel
                {
                    SlNo = Convert.ToInt32(dr["SlNo"]),
                    Id = Convert.ToInt32(dr["id"]),
                    LoginId = dr["LoginId"].ToString(),
                    Photo = dr["Image"].ToString(),
                    OperatorName = dr["Name"].ToString(),
                    Mobile = dr["Mobile"].ToString(),
                    Email = dr["Email"].ToString(),
                    Address = dr["Address"].ToString(),
                    UserName = dr["UserName"].ToString(),
                    Password = dr["Password"].ToString(),
                    Date = dr["Date"].ToString()
                });
            };
        }


        // Configure Jquery Datatable property Total record count property.    
        int totalRecords = data.Count;

        // Apply server-side data searching.   
        if (!string.IsNullOrEmpty(search))
        {
            data = data.Where(x => x.Id.ToString().Contains(search.ToLower()) || x.OperatorName.ToLower().Contains(search.ToLower()) || x.Mobile.ToLower().Contains(search.ToLower()) || x.Email.ToLower().Contains(search.ToLower()) || x.Address.ToLower().Contains(search.ToLower()) || x.UserName.ToLower().Contains(search.ToLower()) || x.Password.ToLower().Contains(search.ToLower()) || x.Date.ToLower().Contains(search.ToLower())).ToList();
        };


        // Apply server-side Sorting.    
        if (!string.IsNullOrEmpty(sortColumnName) && !string.IsNullOrEmpty(sortDirection))
        {
            if (sortDirection == "asc") // Check for ascending or descending order
                data = data.OrderBy(x => typeof(VisitorModel).GetProperty(sortColumnName).GetValue(x, null)).ToList();
            else
                data = data.OrderByDescending(x => typeof(VisitorModel).GetProperty(sortColumnName).GetValue(x, null)).ToList();
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
    public static object Get_Operator_Detail()
    {
        string query = @"select ROW_NUMBER() OVER (ORDER BY op.Id desc) AS SlNo,* from Operator_Profile op inner join Login_Master lm on op.LoginId = lm.LoginId";
        return Get_Operator_DetailData(query);
    }
    [WebMethod]
    public static int Delete_Operator_Detail(string LoginId)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);

        SqlCommand cmd = new SqlCommand("delete from Login_Master where LoginId=@LoginId", con);
        cmd.Parameters.AddWithValue("@LoginId", LoginId);
        con.Open();
        int res = cmd.ExecuteNonQuery();
        con.Close();
        return res;

    }
}