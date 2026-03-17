using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Script.Services;
using System.Data;
using System.Data.SqlClient;
using Newtonsoft.Json;

public partial class Admin_Paid_Installment : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public class PaidInstallmentModel
    {
        public int SlNo { get; set; }
        public int Id { get; set; }
        public string InvoiceNo { get; set; }
        public string StudentId { get; set; }
        public string AdmissionNo { get; set; }
        public string StudentName { get; set; }
        public string Mobile { get; set; }
        public string Course_Name { get; set; }
        public string BatchName { get; set; }
        public string RollNo { get; set; }
        public string Paid_Amount { get; set; }
        public string Installment_No { get; set; }
        public string PaymentMethod { get; set; }
        public string Date { get; set; }
    }

    public class DataTables
    {
        public int draw { get; set; }
        public int recordsTotal { get; set; }
        public int recordsFiltered { get; set; }
        public List<PaidInstallmentModel> data { get; set; }
    }

    public static object Get_Fee_Payment_DetailData(string query)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);

        DataTables result = new DataTables();

        string search = HttpContext.Current.Request.Params["search[value]"];
        string draw = HttpContext.Current.Request.Params["draw"];
        string sortColumnName = HttpContext.Current.Request["columns[" + HttpContext.Current.Request["order[0][column]"] + "][data]"];
        string sortDirection = HttpContext.Current.Request["order[0][dir]"];
        int startRec = Convert.ToInt32(HttpContext.Current.Request.Params["start"]);
        int pageSize = Convert.ToInt32(HttpContext.Current.Request.Params["length"]);

        List<PaidInstallmentModel> data = new List<PaidInstallmentModel>();

        SqlCommand cmd = new SqlCommand(query, con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);

        foreach (DataRow dr in dt.Rows)
        {
            data.Add(new PaidInstallmentModel
            {
                SlNo = Convert.ToInt32(dr["SlNo"]),
                Id = Convert.ToInt32(dr["Id"]),
                InvoiceNo = dr["InvoiceNo"].ToString(),
                StudentId = dr["StudentId"].ToString(),
                AdmissionNo = dr["AdmissionNo"].ToString(),
                StudentName = dr["StudentName"].ToString(),
                Mobile = dr["Mobile"].ToString(),
                Course_Name = dr["Course_Name"].ToString(),
                BatchName = dr["BatchName"].ToString(),
                RollNo = dr["RollNo"].ToString(),
                Paid_Amount = dr["Paid_Amount"].ToString(),
                Installment_No = dr["Installment_No"].ToString(),
                PaymentMethod = dr["PaymentMethod"].ToString(),
                Date = dr["Date"].ToString()
            });
        }

        int totalRecords = data.Count;

        if (!string.IsNullOrEmpty(search))
        {
            data = data.Where(x =>
            x.StudentName.ToLower().Contains(search.ToLower()) ||
            x.Mobile.Contains(search) ||
            x.InvoiceNo.Contains(search)).ToList();
        }

        if (!string.IsNullOrEmpty(sortColumnName))
        {
            if (sortDirection == "asc")
                data = data.OrderBy(x => typeof(PaidInstallmentModel).GetProperty(sortColumnName).GetValue(x, null)).ToList();
            else
                data = data.OrderByDescending(x => typeof(PaidInstallmentModel).GetProperty(sortColumnName).GetValue(x, null)).ToList();
        }

        int recFilter = data.Count;

        data = data.Skip(startRec).Take(pageSize).ToList();

        result.draw = Convert.ToInt32(draw);
        result.recordsTotal = totalRecords;
        result.recordsFiltered = recFilter;
        result.data = data;

        return result;
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = true)]
    public static object Get_Fee_Payment_Detail(string OperatorId, bool IsOperator)
    {

        string query = @"
SELECT 
ROW_NUMBER() OVER (ORDER BY pi.Id DESC) AS SlNo,
FORMAT(pi.Date,'dd-MMM-yyyy') AS Date,
pi.Id,
pi.InvoiceNo,
pi.StudentId,
sa.AdmissionNo,
sa.StudentName,
sa.Mobile,
cm.Course_Name,
bm.BatchName,
sa.RollNo,
pi.Paid_Amount,
pi.Installment_No,
pi.PaymentMethod

FROM Paid_Installment pi

INNER JOIN Student_Admission sa
ON pi.StudentId = sa.StudentId

INNER JOIN Student_Batch sb
ON sa.StudentId = sb.StudentId

INNER JOIN Batch_Master bm
ON sb.BatchId = bm.Id

INNER JOIN Course_Master cm
ON bm.CourseId = cm.Id

WHERE sa.Status='Active'";

        if (IsOperator && !string.IsNullOrEmpty(OperatorId))
        {
            query += " AND pi.ProcessedBy='" + OperatorId + "'";
        }

        return Get_Fee_Payment_DetailData(query);
    }

    [WebMethod]
    public static string Get_SearchByStudent()
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);

        SqlCommand cmd = new SqlCommand(@"
SELECT DISTINCT sa.Mobile,sa.StudentName
FROM Student_Admission sa
INNER JOIN Paid_Installment pi
ON sa.StudentId=pi.StudentId
WHERE sa.Status='Active'", con);

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);

        return JsonConvert.SerializeObject(dt);
    }

    [WebMethod]
    public static string Get_Operator()
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);

        SqlCommand cmd = new SqlCommand(
        "SELECT LoginId,Name,Mobile FROM Operator_Profile", con);

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);

        return JsonConvert.SerializeObject(dt);
    }

    [WebMethod]
    public static string Get_MinDate()
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);

        SqlCommand cmd = new SqlCommand(
        "SELECT CONVERT(varchar(10),MIN(CONVERT(date,Date)),110) FROM Paid_Installment", con);

        con.Open();

        object result = cmd.ExecuteScalar();

        con.Close();

        if (result == null)
            return DateTime.Now.ToString("MM-dd-yyyy");

        return result.ToString();
    }

    [WebMethod]
    public static string Get_MaxDate()
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);

        SqlCommand cmd = new SqlCommand(
        "SELECT CONVERT(varchar(10),MAX(CONVERT(date,Date)),110) FROM Paid_Installment", con);

        con.Open();

        object result = cmd.ExecuteScalar();

        con.Close();

        if (result == null)
            return DateTime.Now.ToString("MM-dd-yyyy");

        return result.ToString();
    }
}