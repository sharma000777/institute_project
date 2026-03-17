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

public partial class Admin_Dues_Installment : System.Web.UI.Page
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
        public string StudentId { get; set; }
        public string AdmissionNo { get; set; }
        public string StudentName { get; set; }
        public string Mobile { get; set; }
        public string Course_Name { get; set; }
        public string BatchName { get; set; }
        public string RollNo { get; set; }
        public string Installment_Amount { get; set; }
        public string Dues_Date { get; set; }
        public string Total_Installment { get; set; }
        public int CourseId { get; set; }
        public int BatchId { get; set; }
    }
    public class DataTables
    {
        public int draw { get; set; }
        public int recordsTotal { get; set; }
        public int recordsFiltered { get; set; }
        public List<EnquiryModel> data { get; set; }
    }
    public static object Get_Fee_Payment_DetailData(string query)
    {
        SqlConnection con = new SqlConnection(
            System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);

        DataTables result = new DataTables();

        // SAFE PARAMS
        int draw = 1;
        int startRec = 0;
        int pageSize = 10;

        string search = HttpContext.Current.Request.Params["search[value]"] ?? "";

        if (HttpContext.Current.Request.Params["draw"] != null)
            draw = Convert.ToInt32(HttpContext.Current.Request.Params["draw"]);

        if (HttpContext.Current.Request.Params["start"] != null)
            startRec = Convert.ToInt32(HttpContext.Current.Request.Params["start"]);

        if (HttpContext.Current.Request.Params["length"] != null)
            pageSize = Convert.ToInt32(HttpContext.Current.Request.Params["length"]);

        List<EnquiryModel> data = new List<EnquiryModel>();

        SqlCommand cmd = new SqlCommand(query, con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);

        // 🔥 DATA MAPPING (SAFE)
        foreach (DataRow dr in dt.Rows)
        {
            data.Add(new EnquiryModel
            {
                SlNo = dt.Columns.Contains("SlNo") && dr["SlNo"] != DBNull.Value ? Convert.ToInt32(dr["SlNo"]) : 0,
                Id = dt.Columns.Contains("Id") && dr["Id"] != DBNull.Value ? Convert.ToInt32(dr["Id"]) : 0,

                StudentId = dt.Columns.Contains("StudentId") ? dr["StudentId"].ToString() : "",
                AdmissionNo = dt.Columns.Contains("AdmissionNo") ? dr["AdmissionNo"].ToString() : "",
                StudentName = dt.Columns.Contains("StudentName") ? dr["StudentName"].ToString() : "",
                Mobile = dt.Columns.Contains("Mobile") ? dr["Mobile"].ToString() : "",
                Course_Name = dt.Columns.Contains("Course_Name") ? dr["Course_Name"].ToString() : "",
                BatchName = dt.Columns.Contains("BatchName") ? dr["BatchName"].ToString() : "",
                RollNo = dt.Columns.Contains("RollNo") ? dr["RollNo"].ToString() : "",
                Installment_Amount = dt.Columns.Contains("Installment_Amount") ? dr["Installment_Amount"].ToString() : "",
                Dues_Date = dt.Columns.Contains("Dues_Date") ? dr["Dues_Date"].ToString() : "",
                Total_Installment = dt.Columns.Contains("Total_Installment") ? dr["Total_Installment"].ToString() : ""
            });
        }

        int totalRecords = data.Count;

        // 🔍 SEARCH (SAFE)
        if (!string.IsNullOrEmpty(search))
        {
            search = search.ToLower();

            data = data.Where(x =>
                (x.StudentId ?? "").ToLower().Contains(search) ||
                (x.StudentName ?? "").ToLower().Contains(search) ||
                (x.Mobile ?? "").ToLower().Contains(search) ||
                (x.Course_Name ?? "").ToLower().Contains(search) ||
                (x.BatchName ?? "").ToLower().Contains(search)
            ).ToList();
        }

        int recFilter = data.Count;

        // 📄 PAGINATION
        data = data.Skip(startRec).Take(pageSize).ToList();

        // 📦 FINAL RESPONSE
        result.draw = draw;
        result.recordsTotal = totalRecords;
        result.recordsFiltered = recFilter;
        result.data = data;

        return result;
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = true)]
    public static object Get_Fee_Payment_Detail()
    {
        string query = @"select ROW_NUMBER() OVER (ORDER BY di.Id desc) AS SlNo,FORMAT(di.Dues_Date, 'dd-MMM-yyyy') AS Dues_Date,* from Dues_Installment di inner join Student_Admission sa on di.StudentId=sa.StudentId inner join Course_Master cm on sa.CourseId=cm.Id inner join Student_Batch sb on sa.StudentId = sb.StudentId inner join Batch_Master bm on sb.BatchId = bm.Id where di.Total_Installment != '0' and sa.Status = 'Active'";
        return Get_Fee_Payment_DetailData(query);
    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = true)]
    public static object Get_DuesInstallment_ByDate(string StartDate, string EndDate)
    {
        string query = @"
          select ROW_NUMBER() OVER (ORDER BY di.Id desc) AS SlNo,FORMAT(di.Dues_Date, 'dd-MMM-yyyy') AS Dues_Date,* from Dues_Installment di inner join Student_Admission sa on di.StudentId=sa.StudentId inner join Course_Master cm on sa.CourseId=cm.Id inner join Student_Batch sb on sa.StudentId = sb.StudentId inner join Batch_Master bm on sb.BatchId = bm.Id where di.Total_Installment != '0' and sa.Status = 'Active' and cast(di.Dues_Date as DATE) >= cast('" + StartDate + "' as DATE) and cast(di.Dues_Date as DATE) <= cast('" + EndDate + "' as DATE);";
        return Get_Fee_Payment_DetailData(query);
    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = true)]
    public static object Get_DuesInstallment_ByMobile(string Mobile)
    {
        string query = @"
          select ROW_NUMBER() OVER (ORDER BY di.Id desc) AS SlNo,FORMAT(di.Dues_Date, 'dd-MMM-yyyy') AS Dues_Date,* from Dues_Installment di inner join Student_Admission sa on di.StudentId=sa.StudentId inner join Course_Master cm on sa.CourseId=cm.Id inner join Student_Batch sb on sa.StudentId = sb.StudentId inner join Batch_Master bm on sb.BatchId = bm.Id where di.Total_Installment != '0' and sa.Mobile='" + Mobile+ "' and sa.Status = 'Active'";
        return Get_Fee_Payment_DetailData(query);
    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string Get_MinDate()
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
        SqlCommand cmd = new SqlCommand(@"
           select CONVERT(varchar(10), MIN(CONVERT(date, Dues_Date, 101)), 110) AS MinDate
           from Dues_Installment", con);
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
    public static string Get_MaxDate()
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
        SqlCommand cmd = new SqlCommand(@"
           select CONVERT(varchar(10), MAX(CONVERT(date, Dues_Date, 101)), 110) AS MaxDate
           from Dues_Installment", con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            if (dt.Rows[0]["MaxDate"].ToString() == "")
            {
                return DateTime.Now.ToString("MM-dd-yyyy");
            }
            else
            {
                return dt.Rows[0]["MaxDate"].ToString();
            }
        }
        else
        {
            return "";
        }
    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string Get_SearchByStudent()
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
        SqlCommand cmd = new SqlCommand("select * from Student_Admission sa inner join Student_Installment si on sa.StudentId=si.StudentId where si.Status = 'Dues' and sa.Status = 'Active'", con);
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
    public static string Get_UpdateDetail(string StudentId)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
        SqlCommand cmd = new SqlCommand("select ROW_NUMBER() OVER (ORDER BY sf.Id desc) AS SlNo,FORMAT(sf.Dues_Date, 'dd-MMM-yyyy') AS Dues_Date,* from Dues_Installment sf inner join Student_Admission sa on sf.StudentId = sa.StudentId where sf.StudentId=@StudentId", con);
        cmd.Parameters.AddWithValue("@StudentId", StudentId);
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
    public static string Get_InvoiceNo()
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
        SqlCommand cmd = new SqlCommand("Select (isnull(max(cast(Id As numeric(18,0))),0)) from Paid_Installment", con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            string InvoiceNo;
            double PID = double.Parse(dt.Rows[0]["Column1"].ToString()) + 1;
            if (PID < 9)
            {
                InvoiceNo = "INV0" + PID.ToString();
            }
            else
            {
                InvoiceNo = "INV" + PID.ToString();
            }
            return InvoiceNo;
        }
        else
        {
            return "";
        }
    }
    public static int Get_InstallmentNo(string StudentId)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
        SqlCommand cmd = new SqlCommand("Select * from Paid_Installment where StudentId=@StudentId", con);
        cmd.Parameters.AddWithValue("@StudentId", StudentId);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        return dt.Rows.Count;
    }
    [WebMethod]
    public static int Update_Status(string StudentId)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
        SqlComan5 cls = new SqlComan5();

        string StatusStudentFeeQuery = @"
            Update Student_Fee set Status=@Status where StudentId=@StudentId
        ";

        string StatusStudentInstallmentQuery = @"
            Update Student_Installment set Status=@Status where StudentId=@StudentId
        ";

        string Dues_InstallmentQuery = @"
            Update Dues_Installment set Total_Installment=@Total_Installment where StudentId=@StudentId
        ";

        con.Open();
        SqlTransaction transaction = con.BeginTransaction();

        DataTable dt = cls.GetDataTable("Select * from Student_Fee where StudentId='" + StudentId + "'");
        if (dt.Rows.Count > 0)
        {
            if (dt.Rows[0]["DuesAmount"].ToString() == "0" || dt.Rows[0]["DuesAmount"].ToString() == "0.00")
            {
                SqlCommand cmd21 = new SqlCommand(StatusStudentFeeQuery, con, transaction);
                cmd21.Parameters.AddWithValue("@Status", "Paid");
                cmd21.Parameters.AddWithValue("@StudentId", StudentId);
                int res21 = cmd21.ExecuteNonQuery();
                if (res21 > 0)
                {
                    SqlCommand cmd22 = new SqlCommand(StatusStudentInstallmentQuery, con, transaction);
                    cmd22.Parameters.AddWithValue("@Status", "Paid");
                    cmd22.Parameters.AddWithValue("@StudentId", StudentId);
                    int res22 = cmd22.ExecuteNonQuery();
                    if (res22 > 0)
                    {
                        SqlCommand cmd23 = new SqlCommand(Dues_InstallmentQuery, con, transaction);
                        cmd23.Parameters.AddWithValue("@Total_Installment", "0");
                        cmd23.Parameters.AddWithValue("@StudentId", StudentId);
                        int res23 = cmd23.ExecuteNonQuery();
                        if (res23 > 0)
                        {
                            transaction.Commit();
                            return 1;
                        }
                        else
                        {
                            transaction.Rollback();
                            return 0;
                        }
                    }
                    else
                    {
                        transaction.Rollback();
                        return 0;
                    }
                }
                else
                {
                    transaction.Rollback();
                    return 0;
                }
            }
            else
            {
                transaction.Commit();
                return 1;
            }
        }
        else
        {
            transaction.Rollback();
            return 0;
        }
    }
    [WebMethod]
    public static string Pay_Dues_Installment(string StudentId, string AmountToPay,
    string MyNewDuesInstallment, string MyNewDuesInstallmentNo,
    string MyNewTotalDuesAmount, string NewNextDueDate,
    string NewPaymentMethod)
    {
        using (SqlConnection con = new SqlConnection(
            System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString))
        {
            con.Open();
            SqlTransaction transaction = con.BeginTransaction();

            try
            {
                decimal payAmount = Convert.ToDecimal(AmountToPay);
                decimal newInstallmentAmount = Convert.ToDecimal(MyNewDuesInstallment);
                decimal newTotalDues = Convert.ToDecimal(MyNewTotalDuesAmount);
                int newInstallmentNo = Convert.ToInt32(MyNewDuesInstallmentNo);

                string InvoiceNo = Get_InvoiceNo();
                int Paid_InstallmentNo = Get_InstallmentNo(StudentId) + 1;

                // 1️⃣ Update Student Fee
                SqlCommand cmd = new SqlCommand(@"
                Update Student_Fee 
                set PaidAmount = cast(PaidAmount as decimal(18,2)) + @PaidAmount,
                    DuesAmount = cast(DuesAmount as decimal(18,2)) - @PaidAmount
                where StudentId=@StudentId",
                    con, transaction);

                cmd.Parameters.Add("@PaidAmount", SqlDbType.Decimal).Value = payAmount;
                cmd.Parameters.AddWithValue("@StudentId", StudentId);
                cmd.ExecuteNonQuery();

                // 2️⃣ Insert Paid Installment
                SqlCommand cmd1 = new SqlCommand(@"
                Insert into Paid_Installment
                (InvoiceNo,StudentId,Paid_Amount,Installment_No,PaymentMethod,Date,ProcessedBy)
                values
                (@InvoiceNo,@StudentId,@Paid_Amount,@Installment_No,@PaymentMethod,@Date,'Admin')",
                    con, transaction);

                cmd1.Parameters.AddWithValue("@InvoiceNo", InvoiceNo);
                cmd1.Parameters.AddWithValue("@StudentId", StudentId);
                cmd1.Parameters.Add("@Paid_Amount", SqlDbType.Decimal).Value = payAmount;
                cmd1.Parameters.AddWithValue("@Installment_No", Paid_InstallmentNo);
                cmd1.Parameters.AddWithValue("@PaymentMethod", NewPaymentMethod);
                cmd1.Parameters.Add("@Date", SqlDbType.Date).Value = DateTime.Now;
                cmd1.ExecuteNonQuery();

                // 3️⃣ Update Dues Installment
                SqlCommand cmd2 = new SqlCommand(@"
                Update Dues_Installment 
                set Installment_Amount=@Installment_Amount,
                    Total_Installment=@Total_Installment,
                    Total_Dues=@Total_Dues,
                    Dues_Date=@Dues_Date
                where StudentId=@StudentId",
                    con, transaction);

                cmd2.Parameters.Add("@Installment_Amount", SqlDbType.Decimal).Value = newInstallmentAmount;
                cmd2.Parameters.AddWithValue("@Total_Installment", newInstallmentNo);
                cmd2.Parameters.Add("@Total_Dues", SqlDbType.Decimal).Value = newTotalDues;
                cmd2.Parameters.Add("@Dues_Date", SqlDbType.Date).Value =
                    string.IsNullOrEmpty(NewNextDueDate) ? (object)DBNull.Value : Convert.ToDateTime(NewNextDueDate);
                cmd2.Parameters.AddWithValue("@StudentId", StudentId);
                cmd2.ExecuteNonQuery();

                transaction.Commit();
                return InvoiceNo;
            }
            catch (Exception ex)
            {
                transaction.Rollback();
                return "ERROR: " + ex.Message;
            }
        }
    }

}