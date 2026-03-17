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

public partial class Admin_Student_Admission : System.Web.UI.Page
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
        public string Status { get; set; }
        public string DropoutDate { get; set; }
    }
    public class DataTables
    {
        public int draw { get; set; }
        public int recordsTotal { get; set; }
        public int recordsFiltered { get; set; }
        public List<VisitorModel> data { get; set; }
    }
    public static object Get_Student_AdmissionData(string query)
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
                    Date = dr["Date"].ToString(),
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
                    Status = dr["Status"].ToString(),
                    DropoutDate = dr["DropoutDate"].ToString()
                });
            };
        }


        // Configure Jquery Datatable property Total record count property.    
        int totalRecords = data.Count;

        // Apply server-side data searching.   
        if (!string.IsNullOrEmpty(search))
        {
            data = data.Where(x => x.Id.ToString().Contains(search.ToLower()) || x.StudentId.ToLower().Contains(search.ToLower()) || x.AdmissionNo.ToLower().Contains(search.ToLower()) || x.Photo.ToLower().Contains(search.ToLower()) || x.StudentName.ToLower().Contains(search.ToLower()) || x.RollNo.ToLower().Contains(search.ToLower()) || x.Mobile.ToLower().Contains(search.ToLower()) || x.Gender.ToLower().Contains(search.ToLower()) || x.Email.ToLower().Contains(search.ToLower()) || x.DOB.ToLower().Contains(search.ToLower()) || x.FatherName.ToLower().Contains(search.ToLower()) || x.FatherOccupation.ToLower().Contains(search.ToLower()) || x.FatherContactNo.ToLower().Contains(search.ToLower()) || x.MotherName.ToLower().Contains(search.ToLower()) || x.State.ToLower().Contains(search.ToLower()) || x.City.ToLower().Contains(search.ToLower()) || x.Pincode.ToLower().Contains(search.ToLower()) || x.Address.ToLower().Contains(search.ToLower()) || x.Date.ToLower().Contains(search.ToLower()) || x.Status.ToLower().Contains(search.ToLower())).ToList();
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
    public static object Get_Student_Admission(string StudentType)
    {
        string query;
        if(StudentType == "All")
            query = @"select ROW_NUMBER() OVER (ORDER BY Id desc) AS SlNo,FORMAT(Date, 'dd-MMM-yyyy') AS Date,* from Student_Admission";
        else
            query = @"select ROW_NUMBER() OVER (ORDER BY Id desc) AS SlNo,FORMAT(Date, 'dd-MMM-yyyy') AS Date,* from Student_Admission where Status = '" + StudentType+"'";
        return Get_Student_AdmissionData(query);
    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = true)]
    public static object Get_Student_Admission_ByDate(string StudentType, string StartDate, string EndDate)
    {
        string query;
        if (StudentType != "All")
            query = @"select ROW_NUMBER() OVER (ORDER BY Id desc) AS SlNo,FORMAT(Date, 'dd-MMM-yyyy') AS Date,FORMAT(DropoutDate, 'dd-MMM-yyyy') AS DropoutDate,* from Student_Admission where Status='" + StudentType + "' and cast(DropoutDate as DATE) >= cast('" + StartDate + "' as DATE) and cast(DropoutDate as DATE) <= cast('" + EndDate + "' as DATE)";
        else
            query = "";
        return Get_Student_AdmissionData(query);
    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string Get_MinDate()
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
        SqlCommand cmd = new SqlCommand(@"
           select CONVERT(varchar(10), MIN(CONVERT(date, DropoutDate, 101)), 110) AS MinDate
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
    public static int Delete_Student(string Mobile)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);

        SqlCommand cmd = new SqlCommand("delete from Student_Admission where Mobile=@Mobile", con);
        cmd.Parameters.AddWithValue("@Mobile", Mobile);
        con.Open();
        int res = cmd.ExecuteNonQuery();
        con.Close();
        return res;

    }

    [WebMethod]
    public static int Dropout_Student(string Mobile)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);

        SqlCommand cmd = new SqlCommand("Update Student_Admission set Status=@Status,DropoutDate=@DropoutDate where Mobile=@Mobile", con);
        cmd.Parameters.AddWithValue("@Status", "Dropout");
        cmd.Parameters.AddWithValue("@Mobile", Mobile);
        cmd.Parameters.AddWithValue("@DropoutDate", DateTime.Now.ToString("yyyy-MM-dd"));
        con.Open();
        int res = cmd.ExecuteNonQuery();
        con.Close();
        return res;

    }
    [WebMethod]
    public static int Activate_Student(string Mobile)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);

        SqlCommand cmd = new SqlCommand("Update Student_Admission set Status=@Status,DropoutDate=@DropoutDate where Mobile=@Mobile", con);
        cmd.Parameters.AddWithValue("@Status", "Active");
        cmd.Parameters.AddWithValue("@Mobile", Mobile);
        cmd.Parameters.AddWithValue("@DropoutDate", "");

        con.Open();
        int res = cmd.ExecuteNonQuery();
        con.Close();
        return res;

    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string Get_UpdateDetail(string Mobile)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
        SqlCommand cmd = new SqlCommand("select * from Student_Admission where Mobile ='" + Mobile + "'", con);
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
    public static string Get_CourseDetail(string StudentId)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
        SqlCommand cmd = new SqlCommand("select ROW_NUMBER() OVER (ORDER BY cm.Id desc) AS SlNo,cm.* from Course_Master cm inner join Student_Admission sa on cm.Id = sa.CourseId where sa.StudentId ='" + StudentId + "'", con);
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
    public static string Get_FeeDetail(string StudentId)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
        SqlCommand cmd = new SqlCommand("select * from Student_Fee where StudentId ='" + StudentId + "'", con);
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
    public static int Update_Student_Admission(string StudentId, string AdmissionNo, string RollNo, string StudentName, string Mobile, string Gender, string Email, string DOB, string FatherName, string FatherOccupation, string FatherContactNo, string MotherName, string State, string City, string Pincode, string Address)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
        SqlCommand cmd = new SqlCommand(@"update Student_Admission set 
        StudentName=@StudentName,Mobile=@Mobile,Gender=@Gender,Email=@Email,
        DOB=@DOB,FatherName=@FatherName,FatherOccupation=@FatherOccupation,FatherContactNo=@FatherContactNo,
        MotherName=@MotherName,State=@State,City=@City,Pincode=@Pincode,Address=@Address where StudentId=@StudentId and RollNo=@RollNo", con);
        cmd.Parameters.AddWithValue("@StudentId", StudentId);
        cmd.Parameters.AddWithValue("@RollNo", RollNo);
        cmd.Parameters.AddWithValue("@StudentName", StudentName);
        cmd.Parameters.AddWithValue("@Mobile", Mobile);
        cmd.Parameters.AddWithValue("@Gender", Gender);
        cmd.Parameters.AddWithValue("@Email", Email);
        cmd.Parameters.AddWithValue("@DOB", DOB);
        cmd.Parameters.AddWithValue("@FatherName", FatherName);
        cmd.Parameters.AddWithValue("@FatherOccupation", FatherOccupation);
        cmd.Parameters.AddWithValue("@FatherContactNo", FatherContactNo);
        cmd.Parameters.AddWithValue("@MotherName", MotherName);
        cmd.Parameters.AddWithValue("@State", State);
        cmd.Parameters.AddWithValue("@City", City);
        cmd.Parameters.AddWithValue("@Pincode", Pincode);
        cmd.Parameters.AddWithValue("@Address", Address);
        con.Open();
        int res = cmd.ExecuteNonQuery();
        con.Close();
        return res;
    }
    [WebMethod]
    public static int Add_Comment(string Id, string Comment)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);

        SqlCommand cmd = new SqlCommand(@"Update Visitors set Comment=@Comment where Id=@Id", con);
        cmd.Parameters.AddWithValue("@Id", Id);
        cmd.Parameters.AddWithValue("@Comment", Comment);
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