using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using Newtonsoft.Json;
using System.Web.Services;
using System.Web.Script.Services;

public partial class Admin_Student_Profile : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    // =========================================
    // SEARCH MOBILE
    // =========================================

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string Get_SearchMobile()
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);

        SqlCommand cmd = new SqlCommand("SELECT StudentId,StudentName,Mobile FROM Student_Admission", con);

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);

        return JsonConvert.SerializeObject(dt);
    }


    // =========================================
    // GET STUDENT DETAILS
    // =========================================

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string Get_Student(string Mobile)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);

        string query = @"SELECT TOP 1 
        ROW_NUMBER() OVER (ORDER BY Id DESC) AS SlNo,
        * 
        FROM Student_Admission 
        WHERE Mobile=@Mobile";

        SqlCommand cmd = new SqlCommand(query, con);
        cmd.Parameters.AddWithValue("@Mobile", Mobile);

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);

        return JsonConvert.SerializeObject(dt);
    }



    // =========================================
    // COURSE MODEL
    // =========================================

    public class CourseModel
    {
        public int SlNo { get; set; }
        public int Id { get; set; }
        public string Course_Name { get; set; }
        public string Course_Duration { get; set; }
        public string Duration_Type { get; set; }
        public string Fee { get; set; }
    }

    public class DataTables
    {
        public int draw { get; set; }
        public int recordsTotal { get; set; }
        public int recordsFiltered { get; set; }
        public List<CourseModel> data { get; set; }
    }


    // =========================================
    // GET COURSE DETAILS (MULTI COURSE SUPPORT)
    // =========================================

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = true)]
    public static object Get_Course_Master(string Mobile)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);

        string query = @"
SELECT 
ROW_NUMBER() OVER (ORDER BY sb.Id DESC) AS SlNo,
cm.Id,
cm.Course_Name,
cm.Course_Duration,
cm.Duration_Type,
cm.Fee
FROM Student_Admission sa
INNER JOIN Student_Batch sb ON sa.StudentId = sb.StudentId
INNER JOIN Batch_Master bm ON sb.BatchId = bm.Id
INNER JOIN Course_Master cm ON bm.CourseId = cm.Id
WHERE sa.Mobile = @Mobile";

        SqlCommand cmd = new SqlCommand(query, con);
        cmd.Parameters.AddWithValue("@Mobile", Mobile);

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);

        List<CourseModel> data = new List<CourseModel>();

        foreach (DataRow dr in dt.Rows)
        {
            data.Add(new CourseModel
            {
                SlNo = Convert.ToInt32(dr["SlNo"]),
                Id = Convert.ToInt32(dr["Id"]),
                Course_Name = dr["Course_Name"].ToString(),
                Course_Duration = dr["Course_Duration"].ToString(),
                Duration_Type = dr["Duration_Type"].ToString(),
                Fee = dr["Fee"].ToString()
            });
        }

        return new
        {
            draw = HttpContext.Current.Request.Params["draw"],
            recordsTotal = data.Count,
            recordsFiltered = data.Count,
            data = data
        };
    }



    // =========================================
    // FEE MODEL
    // =========================================

    public class FeeModel
    {
        public int SlNo { get; set; }
        public int Id { get; set; }
        public string TotalAmount { get; set; }
        public string Concession { get; set; }
        public string NetAmount { get; set; }
        public string PaidAmount { get; set; }
        public string DuesAmount { get; set; }
        public string PaymentMode { get; set; }
        public string PaymentMethod { get; set; }
        public string Status { get; set; }
        public string Date { get; set; }
    }



    // =========================================
    // GET FEE DETAILS
    // =========================================

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = true)]
    public static object Get_Fee(string Mobile)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);

        string query = @"
SELECT 
ROW_NUMBER() OVER (ORDER BY sf.Id DESC) AS SlNo,
sf.*
FROM Student_Fee sf
INNER JOIN Student_Admission sa ON sf.StudentId = sa.StudentId
WHERE sa.Mobile = @Mobile";

        SqlCommand cmd = new SqlCommand(query, con);
        cmd.Parameters.AddWithValue("@Mobile", Mobile);

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);

        List<FeeModel> data = new List<FeeModel>();

        foreach (DataRow dr in dt.Rows)
        {
            data.Add(new FeeModel
            {
                SlNo = Convert.ToInt32(dr["SlNo"]),
                Id = Convert.ToInt32(dr["Id"]),
                TotalAmount = dr["TotalAmount"].ToString(),
                Concession = dr["Concession"].ToString(),
                NetAmount = dr["NetAmount"].ToString(),
                PaidAmount = dr["PaidAmount"].ToString(),
                DuesAmount = dr["DuesAmount"].ToString(),
                PaymentMode = dr["PaymentMode"].ToString(),
                PaymentMethod = dr["PaymentMethod"].ToString(),
                Status = dr["Status"].ToString(),
                Date = dr["Date"].ToString()
            });
        }

        return new
        {
            draw = HttpContext.Current.Request.Params["draw"],
            recordsTotal = data.Count,
            recordsFiltered = data.Count,
            data = data
        };
    }



    // =========================================
    // CHECK INSTALLMENT
    // =========================================

    [WebMethod]
    public static int IsInstallment(string Mobile)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);

        string query = @"SELECT TOP 1 sf.Status 
                         FROM Student_Fee sf
                         INNER JOIN Student_Admission sa ON sf.StudentId = sa.StudentId
                         WHERE sa.Mobile=@Mobile
                         ORDER BY sf.Id DESC";

        SqlCommand cmd = new SqlCommand(query, con);
        cmd.Parameters.AddWithValue("@Mobile", Mobile);

        con.Open();

        object status = cmd.ExecuteScalar();

        con.Close();

        if (status != null && status.ToString() == "Dues")
            return 1;

        return 0;
    }



    // =========================================
    // INSTALLMENT PLAN
    // =========================================

    [WebMethod]
    public static string fetchMyInstallment(string Mobile)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);

        string query = @"
SELECT 
ROW_NUMBER() OVER (ORDER BY si.Id DESC) AS SlNo,
si.*
FROM Student_Installment si
INNER JOIN Student_Admission sa ON si.StudentId = sa.StudentId
WHERE sa.Mobile=@Mobile";

        SqlCommand cmd = new SqlCommand(query, con);
        cmd.Parameters.AddWithValue("@Mobile", Mobile);

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);

        return JsonConvert.SerializeObject(dt);
    }



    // =========================================
    // GENERATE CERTIFICATE
    // =========================================

    [WebMethod]
    public static string Generate_Certificate(string Mobile)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);

        con.Open();

        string query = @"
SELECT TOP 1
sa.StudentId,
bm.CourseId,
sf.DuesAmount
FROM Student_Admission sa
INNER JOIN Student_Batch sb ON sa.StudentId = sb.StudentId
INNER JOIN Batch_Master bm ON sb.BatchId = bm.Id
INNER JOIN Student_Fee sf ON sa.StudentId = sf.StudentId
WHERE sa.Mobile=@Mobile
ORDER BY sf.Id DESC";

        SqlCommand cmd = new SqlCommand(query, con);
        cmd.Parameters.AddWithValue("@Mobile", Mobile);

        SqlDataReader dr = cmd.ExecuteReader();

        if (dr.Read())
        {
            decimal dues = Convert.ToDecimal(dr["DuesAmount"]);

            if (dues > 0)
            {
                con.Close();
                return "Fees dues pending. Certificate cannot be generated.";
            }

            string studentId = dr["StudentId"].ToString();
            string courseId = dr["CourseId"].ToString();

            dr.Close();

            string certNo = "CERT" + DateTime.Now.Ticks.ToString().Substring(10);

            string insert = @"INSERT INTO Certificate_Master
            (CertificateNo,StudentId,CourseId,IssueDate,GeneratedBy,Status)
            VALUES
            (@CertificateNo,@StudentId,@CourseId,GETDATE(),'Admin','Generated')";

            SqlCommand cmdInsert = new SqlCommand(insert, con);

            cmdInsert.Parameters.AddWithValue("@CertificateNo", certNo);
            cmdInsert.Parameters.AddWithValue("@StudentId", studentId);
            cmdInsert.Parameters.AddWithValue("@CourseId", courseId);

            cmdInsert.ExecuteNonQuery();

            con.Close();

            return "SUCCESS";
        }

        con.Close();

        return "Student not found";
    }
}