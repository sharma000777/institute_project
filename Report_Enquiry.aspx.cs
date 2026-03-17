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


public partial class Admin_Report_Enquiry : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
    SqlComan5 cls = new SqlComan5();
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public class EnquiryModel
    {
        public int SlNo { get; set; }
        public int Id { get; set; }
        public string EnquiryType { get; set; }
        public string Name { get; set; }
        public string Mobile { get; set; }
        public string Qualification { get; set; }
        public string Course_Name { get; set; }
        public string Course_Duration { get; set; }
        public string Duration_Type { get; set; }
        public string Fee { get; set; }
        public string FollowUpDate { get; set; }
        public string Date { get; set; }
        public string Status { get; set; }
        public string Comment { get; set; }
        public string ContactMedia { get; set; }
        public string Reason { get; set; }
    }
    public class DataTables
    {
        public int draw { get; set; }
        public int recordsTotal { get; set; }
        public int recordsFiltered { get; set; }
        public List<EnquiryModel> data { get; set; }
    }
    public static object Get_Enquiry_DetailData(string query)
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
        List<EnquiryModel> data = new List<EnquiryModel>();

        SqlCommand cmd = new SqlCommand(query, con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                data.Add(new EnquiryModel
                {
                    SlNo = Convert.ToInt32(dr["SlNo"]),
                    Id = Convert.ToInt32(dr["id"]),
                    EnquiryType = dr["EnquiryType"].ToString(),
                    Name = dr["Name"].ToString(),
                    Mobile = dr["Mobile"].ToString(),
                    Qualification = dr["Qualification"].ToString(),
                    Course_Name = dr["Course_Name"].ToString(),
                    Course_Duration = dr["Course_Duration"].ToString(),
                    Duration_Type = dr["Duration_Type"].ToString(),
                    Fee = dr["Fee"].ToString(),
                    FollowUpDate = dr["FollowUpDate"].ToString(),
                    Date = dr["Date"].ToString(),
                    Status = dr["Status"].ToString(),
                    Comment = dr["Comment"].ToString(),
                    ContactMedia = dr["ContactMedia"].ToString(),
                    Reason = dr["Reason"].ToString()
                });
            };
        }


        // Configure Jquery Datatable property Total record count property.    
        int totalRecords = data.Count;

        // Apply server-side data searching.   
        if (!string.IsNullOrEmpty(search))
        {
            data = data.Where(x => x.Id.ToString().Contains(search.ToLower()) || x.EnquiryType.ToLower().Contains(search.ToLower()) || x.Name.ToLower().Contains(search.ToLower()) || x.Mobile.ToLower().Contains(search.ToLower()) || x.Qualification.ToLower().Contains(search.ToLower()) || x.Course_Name.ToLower().Contains(search.ToLower()) || x.Course_Duration.ToLower().Contains(search.ToLower()) || x.Duration_Type.ToLower().Contains(search.ToLower()) || x.Fee.ToLower().Contains(search.ToLower()) || x.FollowUpDate.ToLower().Contains(search.ToLower()) || x.ContactMedia.ToLower().Contains(search.ToLower()) || x.Date.ToLower().Contains(search.ToLower()) || x.Status.ToLower().Contains(search.ToLower()) || x.Reason.ToLower().Contains(search.ToLower())).ToList();
        };


        // Apply server-side Sorting.    
        if (!string.IsNullOrEmpty(sortColumnName) && !string.IsNullOrEmpty(sortDirection))
        {
            if (sortDirection == "asc") // Check for ascending or descending order
                data = data.OrderBy(x => typeof(EnquiryModel).GetProperty(sortColumnName).GetValue(x, null)).ToList();
            else
                data = data.OrderByDescending(x => typeof(EnquiryModel).GetProperty(sortColumnName).GetValue(x, null)).ToList();
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
    public static object Get_Enquiry_Detail(string EnquiryType, string EnrollmentType, string OperatorId, bool IsOperator)
    {
        string query;
        if(!IsOperator)
        {
            if (EnquiryType == "All" && EnrollmentType == "All")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id";
            else if (EnquiryType == "All" && EnrollmentType == "Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.Status='Admitted'";
            else if (EnquiryType == "All" && EnrollmentType == "Pending Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.Status='Completed' and ed.Reason is null";
            else if (EnquiryType == "All" && EnrollmentType == "Not Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.Status='Completed' and ed.Reason is not null";
            else if (EnquiryType == "Call" && EnrollmentType == "All")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Call'";
            else if (EnquiryType == "Call" && EnrollmentType == "Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Call' and ed.Status='Admitted'";
            else if (EnquiryType == "Call" && EnrollmentType == "Pending Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Call' and ed.Status='Completed' and ed.Reason is null";
            else if (EnquiryType == "Call" && EnrollmentType == "Not Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Call' and ed.Status='Completed' and ed.Reason is not null";
            else if (EnquiryType == "Visitor" && EnrollmentType == "All")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Visitor'";
            else if (EnquiryType == "Visitor" && EnrollmentType == "Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Visitor' and ed.Status='Admitted'";
            else if (EnquiryType == "Visitor" && EnrollmentType == "Pending Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Visitor' and ed.Status='Completed' and ed.Reason is null";
            else if (EnquiryType == "Visitor" && EnrollmentType == "Not Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Visitor' and ed.Status='Completed' and ed.Reason is not null";
            else
                query = "";
        }
        else
        {
            if (EnquiryType == "All" && EnrollmentType == "All")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ProcessedBy = '" + OperatorId + "'";
            else if (EnquiryType == "All" && EnrollmentType == "Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.Status='Admitted' and ProcessedBy = '" + OperatorId + "'";
            else if (EnquiryType == "All" && EnrollmentType == "Pending Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.Status='Completed' and ed.Reason is null and ProcessedBy = '" + OperatorId + "'";
            else if (EnquiryType == "All" && EnrollmentType == "Not Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.Status='Completed' and ed.Reason is not null and ProcessedBy = '" + OperatorId + "'";
            else if (EnquiryType == "Call" && EnrollmentType == "All")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Call' and ProcessedBy = '" + OperatorId + "'";
            else if (EnquiryType == "Call" && EnrollmentType == "Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Call' and ed.Status='Admitted' and ProcessedBy = '" + OperatorId + "'";
            else if (EnquiryType == "Call" && EnrollmentType == "Pending Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Call' and ed.Status='Completed' and ed.Reason is null and ProcessedBy = '" + OperatorId + "'";
            else if (EnquiryType == "Call" && EnrollmentType == "Not Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Call' and ed.Status='Completed' and ed.Reason is not null and ProcessedBy = '" + OperatorId + "'";
            else if (EnquiryType == "Visitor" && EnrollmentType == "All")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Visitor' and ProcessedBy = '" + OperatorId + "'";
            else if (EnquiryType == "Visitor" && EnrollmentType == "Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Visitor' and ed.Status='Admitted' and ProcessedBy = '" + OperatorId + "'";
            else if (EnquiryType == "Visitor" && EnrollmentType == "Pending Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Visitor' and ed.Status='Completed' and ed.Reason is null and ProcessedBy = '" + OperatorId + "'";
            else if (EnquiryType == "Visitor" && EnrollmentType == "Not Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Visitor' and ed.Status='Completed' and ed.Reason is not null and ProcessedBy = '" + OperatorId + "'";
            else
                query = "";
        }
        
        
        return Get_Enquiry_DetailData(query);
    }
    
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = true)]
    public static object Get_Enquiry_Detail_ByReason(string EnquiryType, string EnrollmentType, string Reason, string OperatorId, bool IsOperator)
    {
        string query;
        if (!IsOperator)
        {
            if (EnquiryType == "All" && EnrollmentType == "All")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.Reason = '" + Reason + "'";
            else if (EnquiryType == "All" && EnrollmentType == "Not Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.Status='Completed' and ed.Reason = '" + Reason + "'";
            else if (EnquiryType == "Call" && EnrollmentType == "All")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Call' and ed.Reason = '" + Reason + "'";
            else if (EnquiryType == "Call" && EnrollmentType == "Not Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Call' and ed.Status='Completed' and ed.Reason = '" + Reason + "'";
            else if (EnquiryType == "Visitor" && EnrollmentType == "All")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Visitor' and ed.Reason = '" + Reason + "'";
            else if (EnquiryType == "Visitor" && EnrollmentType == "Not Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Visitor' and ed.Status='Completed' and ed.Reason = '" + Reason + "'";
            else
                query = "";
        }
        else
        {
            if (EnquiryType == "All" && EnrollmentType == "All")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.Reason = '" + Reason + "' and ProcessedBy = '" + OperatorId + "'";
            else if (EnquiryType == "All" && EnrollmentType == "Not Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.Status='Completed' and ed.Reason = '" + Reason + "' and ProcessedBy = '" + OperatorId + "'";
            else if (EnquiryType == "Call" && EnrollmentType == "All")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Call' and ed.Reason = '" + Reason + "' and ProcessedBy = '" + OperatorId + "'";
            else if (EnquiryType == "Call" && EnrollmentType == "Not Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Call' and ed.Status='Completed' and ed.Reason = '" + Reason + "' and ProcessedBy = '" + OperatorId + "'";
            else if (EnquiryType == "Visitor" && EnrollmentType == "All")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Visitor' and ed.Reason = '" + Reason + "' and ProcessedBy = '" + OperatorId + "'";
            else if (EnquiryType == "Visitor" && EnrollmentType == "Not Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Visitor' and ed.Status='Completed' and ed.Reason = '" + Reason + "' and ProcessedBy = '" + OperatorId + "'";
            else
                query = "";
        }
            
        
        return Get_Enquiry_DetailData(query);
    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = true)]
    public static object Get_Enquiry_Detail_ByContactMedia(string EnquiryType, string EnrollmentType, string ContactMedia, string OperatorId, bool IsOperator)
    {
        string query;
        if (!IsOperator)
        {
            if (EnquiryType == "All" && EnrollmentType == "All")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.ContactMedia = '" + ContactMedia + "'";
            else if (EnquiryType == "All" && EnrollmentType == "Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.Status='Admitted' and ed.ContactMedia = '" + ContactMedia + "'";
            else if (EnquiryType == "All" && EnrollmentType == "Pending Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.Status='Completed' and ed.Reason is null and ed.ContactMedia = '" + ContactMedia + "'";
            else if (EnquiryType == "All" && EnrollmentType == "Not Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.Status='Completed' and ed.Reason is not null and ed.ContactMedia = '" + ContactMedia + "'";
            else if (EnquiryType == "Call" && EnrollmentType == "All")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Call' and ed.ContactMedia = '" + ContactMedia + "'";
            else if (EnquiryType == "Call" && EnrollmentType == "Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Call' and ed.Status='Admitted' and ed.ContactMedia = '" + ContactMedia + "'";
            else if (EnquiryType == "Call" && EnrollmentType == "Pending Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Call' and ed.Status='Completed' and ed.Reason is null and ed.ContactMedia = '" + ContactMedia + "'";
            else if (EnquiryType == "Call" && EnrollmentType == "Not Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Call' and ed.Status='Completed' and ed.Reason is not null and ed.ContactMedia = '" + ContactMedia + "'";
            else if (EnquiryType == "Visitor" && EnrollmentType == "All")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Visitor' and ed.ContactMedia = '" + ContactMedia + "'";
            else if (EnquiryType == "Visitor" && EnrollmentType == "Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Visitor' and ed.Status='Admitted' and ed.ContactMedia = '" + ContactMedia + "'";
            else if (EnquiryType == "Visitor" && EnrollmentType == "Pending Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Visitor' and ed.Status='Completed' and ed.Reason is null and ed.ContactMedia = '" + ContactMedia + "'";
            else if (EnquiryType == "Visitor" && EnrollmentType == "Not Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Visitor' and ed.Status='Completed' and ed.Reason is not null and ed.ContactMedia = '" + ContactMedia + "'";
            else
                query = "";
        }
        else
        {
            if (EnquiryType == "All" && EnrollmentType == "All")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.ContactMedia = '" + ContactMedia + "' and ProcessedBy = '" + OperatorId + "'";
            else if (EnquiryType == "All" && EnrollmentType == "Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.Status='Admitted' and ed.ContactMedia = '" + ContactMedia + "' and ProcessedBy = '" + OperatorId + "'";
            else if (EnquiryType == "All" && EnrollmentType == "Pending Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.Status='Completed' and ed.Reason is null and ed.ContactMedia = '" + ContactMedia + "' and ProcessedBy = '" + OperatorId + "'";
            else if (EnquiryType == "All" && EnrollmentType == "Not Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.Status='Completed' and ed.Reason is not null and ed.ContactMedia = '" + ContactMedia + "' and ProcessedBy = '" + OperatorId + "'";
            else if (EnquiryType == "Call" && EnrollmentType == "All")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Call' and ed.ContactMedia = '" + ContactMedia + "' and ProcessedBy = '" + OperatorId + "'";
            else if (EnquiryType == "Call" && EnrollmentType == "Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Call' and ed.Status='Admitted' and ed.ContactMedia = '" + ContactMedia + "' and ProcessedBy = '" + OperatorId + "'";
            else if (EnquiryType == "Call" && EnrollmentType == "Pending Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Call' and ed.Status='Completed' and ed.Reason is null and ed.ContactMedia = '" + ContactMedia + "' and ProcessedBy = '" + OperatorId + "'";
            else if (EnquiryType == "Call" && EnrollmentType == "Not Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Call' and ed.Status='Completed' and ed.Reason is not null and ed.ContactMedia = '" + ContactMedia + "' and ProcessedBy = '" + OperatorId + "'";
            else if (EnquiryType == "Visitor" && EnrollmentType == "All")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Visitor' and ed.ContactMedia = '" + ContactMedia + "' and ProcessedBy = '" + OperatorId + "'";
            else if (EnquiryType == "Visitor" && EnrollmentType == "Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Visitor' and ed.Status='Admitted' and ed.ContactMedia = '" + ContactMedia + "' and ProcessedBy = '" + OperatorId + "'";
            else if (EnquiryType == "Visitor" && EnrollmentType == "Pending Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Visitor' and ed.Status='Completed' and ed.Reason is null and ed.ContactMedia = '" + ContactMedia + "' and ProcessedBy = '" + OperatorId + "'";
            else if (EnquiryType == "Visitor" && EnrollmentType == "Not Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Visitor' and ed.Status='Completed' and ed.Reason is not null and ed.ContactMedia = '" + ContactMedia + "' and ProcessedBy = '" + OperatorId + "'";
            else
                query = "";
        }
            

        return Get_Enquiry_DetailData(query);
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = true)]
    public static object Get_Enquiry_Detail_ByDate(string EnquiryType, string EnrollmentType, string StartDate, string EndDate, string OperatorId, bool IsOperator)
    {
        string query;
        if (!IsOperator)
        {
            if (EnquiryType == "All" && EnrollmentType == "All")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where cast(ed.Date as DATE) >= cast('" + StartDate + "' as DATE) and cast(ed.Date as DATE) <= cast('" + EndDate + "' as DATE)";
            else if (EnquiryType == "All" && EnrollmentType == "Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.Status='Admitted' and cast(ed.Date as DATE) >= cast('" + StartDate + "' as DATE) and cast(ed.Date as DATE) <= cast('" + EndDate + "' as DATE)";
            else if (EnquiryType == "All" && EnrollmentType == "Pending Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.Status='Completed' and ed.Reason is null and cast(ed.Date as DATE) >= cast('" + StartDate + "' as DATE) and cast(ed.Date as DATE) <= cast('" + EndDate + "' as DATE)";
            else if (EnquiryType == "All" && EnrollmentType == "Not Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.Status='Completed' and ed.Reason is not null and cast(ed.Date as DATE) >= cast('" + StartDate + "' as DATE) and cast(ed.Date as DATE) <= cast('" + EndDate + "' as DATE)";
            else if (EnquiryType == "Call" && EnrollmentType == "All")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Call' and cast(ed.Date as DATE) >= cast('" + StartDate + "' as DATE) and cast(ed.Date as DATE) <= cast('" + EndDate + "' as DATE)";
            else if (EnquiryType == "Call" && EnrollmentType == "Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Call' and ed.Status='Admitted' and cast(ed.Date as DATE) >= cast('" + StartDate + "' as DATE) and cast(ed.Date as DATE) <= cast('" + EndDate + "' as DATE)";
            else if (EnquiryType == "Call" && EnrollmentType == "Pending Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Call' and ed.Status='Completed' and ed.Reason is null and cast(ed.Date as DATE) >= cast('" + StartDate + "' as DATE) and cast(ed.Date as DATE) <= cast('" + EndDate + "' as DATE)";
            else if (EnquiryType == "Call" && EnrollmentType == "Not Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Call' and ed.Status='Completed' and ed.Reason is not null and cast(ed.Date as DATE) >= cast('" + StartDate + "' as DATE) and cast(ed.Date as DATE) <= cast('" + EndDate + "' as DATE)";
            else if (EnquiryType == "Visitor" && EnrollmentType == "All")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Visitor' and cast(ed.Date as DATE) >= cast('" + StartDate + "' as DATE) and cast(ed.Date as DATE) <= cast('" + EndDate + "' as DATE)";
            else if (EnquiryType == "Visitor" && EnrollmentType == "Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Visitor' and ed.Status='Admitted' and cast(ed.Date as DATE) >= cast('" + StartDate + "' as DATE) and cast(ed.Date as DATE) <= cast('" + EndDate + "' as DATE)";
            else if (EnquiryType == "Visitor" && EnrollmentType == "Pending Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Visitor' and ed.Status='Completed' and ed.Reason is null and cast(ed.Date as DATE) >= cast('" + StartDate + "' as DATE) and cast(ed.Date as DATE) <= cast('" + EndDate + "' as DATE)";
            else if (EnquiryType == "Visitor" && EnrollmentType == "Not Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Visitor' and ed.Status='Completed' and ed.Reason is not null and cast(ed.Date as DATE) >= cast('" + StartDate + "' as DATE) and cast(ed.Date as DATE) <= cast('" + EndDate + "' as DATE)";
            else
                query = "";

        }
        else
        {
            if (EnquiryType == "All" && EnrollmentType == "All")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ProcessedBy = '" + OperatorId + "' and cast(ed.Date as DATE) >= cast('" + StartDate + "' as DATE) and cast(ed.Date as DATE) <= cast('" + EndDate + "' as DATE)";
            else if (EnquiryType == "All" && EnrollmentType == "Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.Status='Admitted' and ProcessedBy = '" + OperatorId + "' and cast(ed.Date as DATE) >= cast('" + StartDate + "' as DATE) and cast(ed.Date as DATE) <= cast('" + EndDate + "' as DATE)";
            else if (EnquiryType == "All" && EnrollmentType == "Pending Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.Status='Completed' and ed.Reason is null and ProcessedBy = '" + OperatorId + "' and cast(ed.Date as DATE) >= cast('" + StartDate + "' as DATE) and cast(ed.Date as DATE) <= cast('" + EndDate + "' as DATE)";
            else if (EnquiryType == "All" && EnrollmentType == "Not Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.Status='Completed' and ed.Reason is not null and ProcessedBy = '" + OperatorId + "' and cast(ed.Date as DATE) >= cast('" + StartDate + "' as DATE) and cast(ed.Date as DATE) <= cast('" + EndDate + "' as DATE)";
            else if (EnquiryType == "Call" && EnrollmentType == "All")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Call' and ProcessedBy = '" + OperatorId + "' and cast(ed.Date as DATE) >= cast('" + StartDate + "' as DATE) and cast(ed.Date as DATE) <= cast('" + EndDate + "' as DATE)";
            else if (EnquiryType == "Call" && EnrollmentType == "Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Call' and ed.Status='Admitted' and ProcessedBy = '" + OperatorId + "' and cast(ed.Date as DATE) >= cast('" + StartDate + "' as DATE) and cast(ed.Date as DATE) <= cast('" + EndDate + "' as DATE)";
            else if (EnquiryType == "Call" && EnrollmentType == "Pending Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Call' and ed.Status='Completed' and ed.Reason is null and ProcessedBy = '" + OperatorId + "' and cast(ed.Date as DATE) >= cast('" + StartDate + "' as DATE) and cast(ed.Date as DATE) <= cast('" + EndDate + "' as DATE)";
            else if (EnquiryType == "Call" && EnrollmentType == "Not Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Call' and ed.Status='Completed' and ed.Reason is not null and cast(ed.Date as DATE) >= cast('" + StartDate + "' as DATE) and cast(ed.Date as DATE) <= cast('" + EndDate + "' as DATE)";
            else if (EnquiryType == "Visitor" && EnrollmentType == "All")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Visitor' and ProcessedBy = '" + OperatorId + "' and cast(ed.Date as DATE) >= cast('" + StartDate + "' as DATE) and cast(ed.Date as DATE) <= cast('" + EndDate + "' as DATE)";
            else if (EnquiryType == "Visitor" && EnrollmentType == "Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Visitor' and ed.Status='Admitted' and ProcessedBy = '" + OperatorId + "' and cast(ed.Date as DATE) >= cast('" + StartDate + "' as DATE) and cast(ed.Date as DATE) <= cast('" + EndDate + "' as DATE)";
            else if (EnquiryType == "Visitor" && EnrollmentType == "Pending Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Visitor' and ed.Status='Completed' and ed.Reason is null and ProcessedBy = '" + OperatorId + "' and cast(ed.Date as DATE) >= cast('" + StartDate + "' as DATE) and cast(ed.Date as DATE) <= cast('" + EndDate + "' as DATE)";
            else if (EnquiryType == "Visitor" && EnrollmentType == "Not Enrolled")
                query = @"select ROW_NUMBER() OVER (ORDER BY ed.Id desc) AS SlNo,FORMAT(ed.Date, 'dd-MMM-yyyy') AS Date,FORMAT(ed.FollowUpDate, 'dd-MMM-yyyy') AS FollowUpDate, * from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id where ed.EnquiryType='Visitor' and ed.Status='Completed' and ed.Reason is not null and ProcessedBy = '" + OperatorId + "' and cast(ed.Date as DATE) >= cast('" + StartDate + "' as DATE) and cast(ed.Date as DATE) <= cast('" + EndDate + "' as DATE)";
            else
                query = "";
        }

        return Get_Enquiry_DetailData(query);
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string Get_MinDate()
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
        SqlCommand cmd = new SqlCommand(@"
           select CONVERT(varchar(10), MIN(CONVERT(date, ed.Date, 101)), 110) AS MinDate
           from Enquiry_Detail ed inner join Course_Master cm on ed.CourseId = cm.Id", con);
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
    public static string Get_Reason()
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
        SqlCommand cmd = new SqlCommand("select * from Reason_Master", con);
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

}