using System;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;
using System.Web.Script.Services;
using Newtonsoft.Json;

public partial class Admin_Student_Batch : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    // ========================================
    // SEARCH MOBILE
    // ========================================

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string Get_SearchMobile()
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);

        SqlCommand cmd = new SqlCommand(
        "SELECT StudentId,StudentName,Mobile FROM Student_Admission", con);

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);

        return JsonConvert.SerializeObject(dt);
    }

    // ========================================
    // GET STUDENT PROFILE
    // ========================================

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


    // ========================================
    // BATCH DETAILS (MULTI COURSE SUPPORT)
    // ========================================

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string fetch_BatchDetail(string Mobile)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);

        string query = @"
SELECT 
FORMAT(bm.StartDate,'dd-MM-yyyy') AS StartDate,
sb.Id,
bm.BatchName,
cm.Course_Name,
bm.BatchStartTime,
bm.BatchEndTime,
bm.Status,
sm.SessionStart,
sm.SessionEnd

FROM Student_Admission sa

INNER JOIN Student_Batch sb 
ON sa.StudentId = sb.StudentId

INNER JOIN Batch_Master bm 
ON sb.BatchId = bm.Id

INNER JOIN Session_Master sm
ON sm.Id = bm.SessionId

INNER JOIN Course_Master cm 
ON bm.CourseId = cm.Id

WHERE sa.Mobile=@Mobile
ORDER BY bm.StartDate DESC";

        SqlCommand cmd = new SqlCommand(query, con);
        cmd.Parameters.AddWithValue("@Mobile", Mobile);

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);

        return JsonConvert.SerializeObject(dt);
    }
}