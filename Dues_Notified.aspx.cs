using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Web.Services;
using System.Web.Script.Services;
using Newtonsoft.Json;

public partial class Admin_Dues_Notified : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    static string conString = System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString;

    public class StudentFeeModel
    {
        public int SlNo { get; set; }
        public string StudentId { get; set; }
        public string StudentName { get; set; }
        public string Mobile { get; set; }
        public string Dues_Date { get; set; }
        public string Installment_Amount { get; set; }
        public string InstallmentNo { get; set; }
        public string Total_Dues { get; set; }
        public string Total_Installment { get; set; }
    }

    public class DataTables
    {
        public int draw { get; set; }
        public int recordsTotal { get; set; }
        public int recordsFiltered { get; set; }
        public List<StudentFeeModel> data { get; set; }
    }

    // --------------------------------------------------------
    // MAIN DATATABLE ENGINE
    // --------------------------------------------------------

    public static object GetData(string query, SqlParameter[] parameters = null)
    {
        List<StudentFeeModel> data = new List<StudentFeeModel>();

        using (SqlConnection con = new SqlConnection(conString))
        {
            SqlCommand cmd = new SqlCommand(query, con);

            if (parameters != null)
                cmd.Parameters.AddRange(parameters);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            foreach (DataRow dr in dt.Rows)
            {
                data.Add(new StudentFeeModel
                {
                    SlNo = Convert.ToInt32(dr["SlNo"]),
                    StudentId = dr["StudentId"].ToString(),
                    StudentName = dr["StudentName"].ToString(),
                    Mobile = dr["Mobile"].ToString(),
                    Dues_Date = dr["Dues_Date"].ToString(),
                    Installment_Amount = dr["Installment_Amount"].ToString(),
                    InstallmentNo = dr["InstallmentNo"].ToString(),
                    Total_Dues = dr["Total_Dues"].ToString(),
                    Total_Installment = dr["Total_Installment"].ToString()
                });
            }
        }

        DataTables result = new DataTables();

        string search = HttpContext.Current.Request.Params["search[value]"];
        string draw = HttpContext.Current.Request.Params["draw"];
        int start = Convert.ToInt32(HttpContext.Current.Request.Params["start"]);
        int length = Convert.ToInt32(HttpContext.Current.Request.Params["length"]);

        int totalRecords = data.Count;

        if (!string.IsNullOrEmpty(search))
        {
            data = data.Where(x =>
                x.StudentName.ToLower().Contains(search.ToLower()) ||
                x.Mobile.Contains(search) ||
                x.StudentId.ToLower().Contains(search.ToLower())
            ).ToList();
        }

        int filteredRecords = data.Count;

        data = data.Skip(start).Take(length).ToList();

        result.draw = Convert.ToInt32(draw);
        result.recordsTotal = totalRecords;
        result.recordsFiltered = filteredRecords;
        result.data = data;

        return result;
    }

    // --------------------------------------------------------
    // MAIN PAGE LOAD
    // --------------------------------------------------------

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = true)]
    public static object Get_DuesNotified()
    {
        string query = @"
        SELECT ROW_NUMBER() OVER (ORDER BY di.Dues_Date DESC) AS SlNo,
        di.StudentId,
        sa.StudentName,
        sa.Mobile,
        di.Installment_Amount,
        di.InstallmentNo,
        FORMAT(di.Dues_Date,'dd-MMM-yyyy') AS Dues_Date,
        di.Total_Dues,
        di.Total_Installment
        FROM Dues_Installment di
        INNER JOIN Student_Admission sa ON di.StudentId = sa.StudentId
        WHERE di.Dues_Date <= DATEADD(DAY,5,GETDATE())
        AND di.Total_Dues != 0";

        return GetData(query);
    }

    // --------------------------------------------------------
    // FILTER BY MOBILE
    // --------------------------------------------------------

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = true)]
    public static object Get_StudentFee_ByMobile(string Mobile)
    {
        string query = @"
        SELECT ROW_NUMBER() OVER (ORDER BY di.Dues_Date DESC) AS SlNo,
        di.StudentId,
        sa.StudentName,
        sa.Mobile,
        di.Installment_Amount,
        di.InstallmentNo,
        FORMAT(di.Dues_Date,'dd-MMM-yyyy') AS Dues_Date,
        di.Total_Dues,
        di.Total_Installment
        FROM Dues_Installment di
        INNER JOIN Student_Admission sa ON di.StudentId = sa.StudentId
        WHERE sa.Mobile = @Mobile
        AND di.Total_Dues != 0";

        SqlParameter[] param =
        {
            new SqlParameter("@Mobile", Mobile)
        };

        return GetData(query, param);
    }

    // --------------------------------------------------------
    // VIEW ALL NOTIFIED HISTORY
    // --------------------------------------------------------

    public class AllNotifiedModel
    {
        public int SlNo { get; set; }
        public string StudentId { get; set; }
        public string InstallmentNo { get; set; }
        public string NotifyDate { get; set; }
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = true)]
    public static object Get_AllNotified(string StudentId)
    {
        using (SqlConnection con = new SqlConnection(conString))
        {
            string query = @"
            SELECT ROW_NUMBER() OVER (ORDER BY NotifyDate ASC) AS SlNo,
            StudentId,
            InstallmentNo,
            FORMAT(NotifyDate,'dd-MMM-yyyy HH:mm:ss') AS NotifyDate
            FROM Notified_Dues
            WHERE StudentId=@StudentId";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@StudentId", StudentId);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            return dt;
        }
    }

    // --------------------------------------------------------
    // STUDENT SEARCH DROPDOWN
    // --------------------------------------------------------

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string Get_SearchByStudent()
    {
        using (SqlConnection con = new SqlConnection(conString))
        {
            SqlCommand cmd = new SqlCommand(
            "SELECT StudentId,StudentName,Mobile FROM Student_Admission WHERE Status='Active'", con);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            return JsonConvert.SerializeObject(dt);
        }
    }
}