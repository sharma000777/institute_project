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

public partial class Admin_Student_Fee : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public class StudentFeeModel
    {
        public int SlNo { get; set; }
        public string InvoiceNo { get; set; }
        public string Status { get; set; }
        public string StudentName { get; set; }
        public string Mobile { get; set; }
        public string TotalAmount { get; set; }
        public string Concession { get; set; }
        public string NetAmount { get; set; }
        public string PaidAmount { get; set; }
        public string DuesAmount { get; set; }
        public string PaymentMode { get; set; }
        public string PaymentMethod { get; set; }
        public string TotalInstallment { get; set; }
        public string InstallmentDue { get; set; }
        public string Date { get; set; }
    }

    public class DataTables
    {
        public int draw { get; set; }
        public int recordsTotal { get; set; }
        public int recordsFiltered { get; set; }
        public List<StudentFeeModel> data { get; set; }
    }

    public static object Get_StudentFeeData(string query)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);

        DataTables result = new DataTables();

        string search = HttpContext.Current.Request.Params["search[value]"];
        string draw = HttpContext.Current.Request.Params["draw"];
        string sortColumnName = HttpContext.Current.Request["columns[" + HttpContext.Current.Request["order[0][column]"] + "][data]"];
        string sortDirection = HttpContext.Current.Request["order[0][dir]"];
        int startRec = Convert.ToInt32(HttpContext.Current.Request.Params["start"]);
        int pageSize = Convert.ToInt32(HttpContext.Current.Request.Params["length"]);

        List<StudentFeeModel> data = new List<StudentFeeModel>();

        SqlCommand cmd = new SqlCommand(query, con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);

        foreach (DataRow dr in dt.Rows)
        {
            data.Add(new StudentFeeModel
            {
                SlNo = Convert.ToInt32(dr["SlNo"]),
                InvoiceNo = dr["InvoiceNo"].ToString(),
                Status = dr["Status"].ToString(),
                StudentName = dr["StudentName"].ToString(),
                Mobile = dr["Mobile"].ToString(),
                TotalAmount = dr["TotalAmount"].ToString(),
                Concession = dr["Concession"].ToString(),
                NetAmount = dr["NetAmount"].ToString(),
                PaidAmount = dr["PaidAmount"].ToString(),
                DuesAmount = dr["DuesAmount"].ToString(),
                PaymentMode = dr["PaymentMode"].ToString(),
                PaymentMethod = dr["PaymentMethod"].ToString(),
                TotalInstallment = dr["Total_Installment"].ToString(),
                InstallmentDue = dr["InstallmentDue"].ToString(),
                Date = dr["Date"].ToString()
            });
        }

        int totalRecords = data.Count;

        if (!string.IsNullOrEmpty(search))
        {
            data = data.Where(x =>
                x.InvoiceNo.ToLower().Contains(search.ToLower()) ||
                x.StudentName.ToLower().Contains(search.ToLower()) ||
                x.Mobile.ToLower().Contains(search.ToLower())
            ).ToList();
        }

        if (!string.IsNullOrEmpty(sortColumnName))
        {
            if (sortDirection == "asc")
                data = data.OrderBy(x => typeof(StudentFeeModel).GetProperty(sortColumnName).GetValue(x, null)).ToList();
            else
                data = data.OrderByDescending(x => typeof(StudentFeeModel).GetProperty(sortColumnName).GetValue(x, null)).ToList();
        }

        int recFilter = data.Count;

        data = data.Skip(startRec).Take(pageSize).ToList();

        result.draw = Convert.ToInt32(draw);
        result.recordsTotal = totalRecords;
        result.recordsFiltered = recFilter;
        result.data = data;

        return result;
    }

    // ================= MAIN DATA =================

    static string baseQuery = @"
SELECT 
ROW_NUMBER() OVER (ORDER BY sf.Id DESC) AS SlNo,
FORMAT(sf.Date,'dd-MMM-yyyy') AS Date,
sa.StudentId,
sa.StudentName,
sa.Mobile,
sf.TotalAmount,
sf.InvoiceNo,
sf.Concession,
sf.NetAmount,
sf.PaidAmount,
sf.DuesAmount,
sf.PaymentMode,
sf.PaymentMethod,
sf.Status,
ISNULL(si.TotalInstallment,0) AS Total_Installment,
ISNULL(di.InstallmentDue,0) AS InstallmentDue
FROM Student_Fee sf
INNER JOIN Student_Admission sa ON sf.StudentId = sa.StudentId

LEFT JOIN
(
    SELECT StudentId, COUNT(*) AS TotalInstallment
    FROM Student_Installment
    GROUP BY StudentId
) si ON sa.StudentId = si.StudentId

LEFT JOIN
(
    SELECT StudentId, COUNT(*) AS InstallmentDue
    FROM Dues_Installment
    GROUP BY StudentId
) di ON sa.StudentId = di.StudentId
";

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = true)]
    public static object Get_StudentFee_Detail()
    {
        return Get_StudentFeeData(baseQuery);
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = true)]
    public static object Get_StudentFee_ByDate(string StartDate, string EndDate)
    {
        string query = baseQuery + " WHERE CAST(sf.Date AS DATE) >= CAST('" + StartDate + "' AS DATE) AND CAST(sf.Date AS DATE) <= CAST('" + EndDate + "' AS DATE)";
        return Get_StudentFeeData(query);
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = true)]
    public static object Get_StudentFee_ByMobile(string Mobile)
    {
        string query = baseQuery + " WHERE sa.Mobile='" + Mobile + "'";
        return Get_StudentFeeData(query);
    }

    // ================= MIN DATE =================

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string Get_MinDate()
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);

        SqlCommand cmd = new SqlCommand("SELECT CONVERT(varchar(10), MIN(CONVERT(date, Date, 101)), 110) FROM Student_Fee", con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);

        if (dt.Rows.Count > 0 && dt.Rows[0][0].ToString() != "")
            return dt.Rows[0][0].ToString();

        return DateTime.Now.ToString("MM-dd-yyyy");
    }

    // ================= MAX DATE =================

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string Get_MaxDate()
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);

        SqlCommand cmd = new SqlCommand("SELECT CONVERT(varchar(10), MAX(CONVERT(date, Date, 101)), 110) FROM Student_Fee", con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);

        if (dt.Rows.Count > 0 && dt.Rows[0][0].ToString() != "")
            return dt.Rows[0][0].ToString();

        return DateTime.Now.ToString("MM-dd-yyyy");
    }

    // ================= STUDENT SEARCH =================

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string Get_SearchByStudent()
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);

        SqlCommand cmd = new SqlCommand("SELECT StudentName,Mobile FROM Student_Admission WHERE Status='Active'", con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);

        return JsonConvert.SerializeObject(dt);
    }

}