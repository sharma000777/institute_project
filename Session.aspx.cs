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

public partial class Admin_Session : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
    SqlComan5 cls = new SqlComan5();
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public class SessionModel
    {
        public int SlNo { get; set; }
        public int Id { get; set; }
        public string SessionStart { get; set; }
        public string SessionEnd { get; set; }
    }
    public class DataTables
    {
        public int draw { get; set; }
        public int recordsTotal { get; set; }
        public int recordsFiltered { get; set; }
        public List<SessionModel> data { get; set; }
    }
    public static object Get_Session_MasterData(string query)
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
        List<SessionModel> data = new List<SessionModel>();

        SqlCommand cmd = new SqlCommand(query, con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                data.Add(new SessionModel
                {
                    SlNo = Convert.ToInt32(dr["SlNo"]),
                    Id = Convert.ToInt32(dr["Id"]),
                    SessionStart = dr["SessionStart"].ToString(),
                    SessionEnd = dr["SessionEnd"].ToString()
                });
            };
        }


        // Configure Jquery Datatable property Total record count property.    
        int totalRecords = data.Count;

        // Apply server-side data searching.   
        if (!string.IsNullOrEmpty(search))
        {
            data = data.Where(x => x.Id.ToString().Contains(search.ToLower()) || x.SessionStart.ToLower().Contains(search.ToLower()) || x.SessionEnd.ToLower().Contains(search.ToLower())).ToList();
        };


        // Apply server-side Sorting.    
        if (!string.IsNullOrEmpty(sortColumnName) && !string.IsNullOrEmpty(sortDirection))
        {
            if (sortDirection == "asc") // Check for ascending or descending order
                data = data.OrderBy(x => typeof(SessionModel).GetProperty(sortColumnName).GetValue(x, null)).ToList();
            else
                data = data.OrderByDescending(x => typeof(SessionModel).GetProperty(sortColumnName).GetValue(x, null)).ToList();
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
    public static object Get_Session_Master()
    {
        string query = @"select ROW_NUMBER() OVER (ORDER BY Id desc) AS SlNo,* from Session_Master";
        return Get_Session_MasterData(query);
    }
    [WebMethod]
    public static int Delete_Session_Master(string Id)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);

        SqlCommand cmd = new SqlCommand("delete from Session_Master where Id=@Id", con);
        cmd.Parameters.AddWithValue("@Id", Id);
        con.Open();
        int res = cmd.ExecuteNonQuery();
        con.Close();
        return res;

    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string Get_UpdateDetail(string Id)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
        SqlCommand cmd = new SqlCommand("select * from Session_Master where Id ='" + Id + "'", con);
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
    public static int Update_Session_Master(string Id, string SessionStart, string SessionEnd)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
        SqlCommand cmd = new SqlCommand(@"update Session_Master set 
        SessionStart=@SessionStart,SessionEnd=@SessionEnd where Id=@Id", con);
        cmd.Parameters.AddWithValue("@Id", Id);
        cmd.Parameters.AddWithValue("@SessionStart", SessionStart);
        cmd.Parameters.AddWithValue("@SessionEnd", SessionEnd);
        con.Open();
        int res = cmd.ExecuteNonQuery();
        con.Close();
        return res;
    }

}