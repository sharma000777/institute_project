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

public partial class Admin_Add_Student_Admission : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
    SqlComan5 cls = new SqlComan5();
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string Get_SearchCallEnquiryStudent()
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
        SqlCommand cmd = new SqlCommand("select * from Enquiry_Detail where Status not in ('Admitted') and EnquiryType = 'Call'", con);
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
    public static string Get_SearchVisitorEnquiryStudent()
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
        SqlCommand cmd = new SqlCommand("select * from Enquiry_Detail where Status not in ('Admitted') and EnquiryType = 'Visitor'", con);
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
    public static string Get_SearchDetail(string CheckedValue,string Mobile)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
        SqlCommand cmd;
        if (CheckedValue == "CallEnquiry")
            cmd = new SqlCommand("select * from Enquiry_Detail where Mobile=@Mobile and EnquiryType = 'Call'", con);
        else
            cmd = new SqlCommand("select * from Enquiry_Detail where Mobile=@Mobile and EnquiryType = 'Visitor'", con);
        cmd.Parameters.AddWithValue("@Mobile", Mobile);
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
    public static string Get_BatchDetail(string SessionId, string CourseId, string BatchName)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
        
        string query = @"select ROW_NUMBER() OVER (ORDER BY bm.Id desc) AS SlNo,FORMAT(bm.StartDate, 'dd-MM-yyyy') AS StartDate,* from Batch_Master bm inner join Session_Master sm on bm.SessionId = sm.Id inner join Course_Master cm on bm.CourseId = cm.Id where bm.SessionId = @SessionId and bm.CourseId = @CourseId and bm.BatchName = @BatchName";

        SqlCommand cmd = new SqlCommand(query,con);
        cmd.Parameters.AddWithValue("@SessionId", SessionId);
        cmd.Parameters.AddWithValue("@CourseId", CourseId);
        cmd.Parameters.AddWithValue("@BatchName", BatchName);
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
    public static string Get_Course()
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
        SqlCommand cmd = new SqlCommand("select * from Course_Master", con);
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
    public static string Get_StudentId()
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
        SqlCommand cmd = new SqlCommand("Select (isnull(max(cast(Id As numeric(18,0))),0)) from Student_Admission", con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            string StudentId;
            double PID = double.Parse(dt.Rows[0]["Column1"].ToString()) + 1;
            if (PID <= 9)
            {
                StudentId = "STU0" + PID.ToString();
            }
            else
            {
                StudentId = "STU" + PID.ToString();
            }
            return StudentId;
        }
        else
        {
            return "";
        }
    }
    [WebMethod]
    public static string Get_AdmissionNo()
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
        SqlCommand cmd = new SqlCommand("Select (isnull(max(cast(Id As numeric(18,0))),0)) from Student_Admission", con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            string AdmissionNo;
            double PID = double.Parse(dt.Rows[0]["Column1"].ToString()) + 1;
            if(PID < 9)
            {
                AdmissionNo = "ADM" + PID.ToString();
            }
            else
            {
                AdmissionNo = "ADM" + PID.ToString();
            }
            return AdmissionNo;
        }
        else
        {
            return "";
        }
    }
    [WebMethod]
    public static string Get_RollNo()
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
        SqlCommand cmd = new SqlCommand("Select (isnull(max(cast(RollNo As numeric(18,0))),0)) from Student_Admission", con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            string RollNo;
            double PID = double.Parse(dt.Rows[0]["Column1"].ToString()) + 1;
            if(PID < 9)
            {
                RollNo = "0" + PID.ToString();
            }
            else
            {
                RollNo = PID.ToString();
            }
            return RollNo;
        }
        else
        {
            return "";
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
            if(PID < 9)
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
    public static string Get_InvoiceNo2()
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
        SqlCommand cmd = new SqlCommand("Select (isnull(max(cast(Id As numeric(18,0))),0)) from Student_Fee", con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            string InvoiceNo;
            double PID = double.Parse(dt.Rows[0]["Column1"].ToString()) + 1;
            if(PID < 9)
            {
                InvoiceNo = "INVC0" + PID.ToString();
            }
            else
            {
                InvoiceNo = "INVC" + PID.ToString();
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
    public static int Is_MobileExist(string Mobile)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
        SqlCommand cmd = new SqlCommand("Select * from Student_Admission where Mobile=@Mobile", con);
        cmd.Parameters.AddWithValue("@Mobile", Mobile);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
            return 1;
        else
            return 0;
    }

    [WebMethod]
    public static string Take_Admission(
string StudentId, string AdmissionNo, string RollNo, string StudentName,
string Mobile, string Gender, string Email, string DOB,
string FatherName, string FatherOccupation, string FatherContactNo,
string MotherName, string State, string City, string Pincode,
string Address, string Photo, string AadhaarFile, string CourseId,
string TotalAmount, string Concession, string NetAmount,
string PaymentMode, string InstallmentAmount, string InstallmentNo,
string PaidAmount, string NextDueDate, string PaymentMethod,
string MyInstallmentAmount, string MyInstallmentNo,
string MyTotalDuesAmount, string BatchId, string CheckedValue)
    {
        using (SqlConnection con = new SqlConnection(
            System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString))
        {
            con.Open();
            SqlTransaction transaction = con.BeginTransaction();

            try
            {
                decimal totalAmount = ParseDecimal(TotalAmount);
                decimal netAmount = ParseDecimal(NetAmount);
                decimal paidAmount = ParseDecimal(PaidAmount);
                decimal duesAmount = ParseDecimal(MyTotalDuesAmount);
                decimal installmentAmount = ParseDecimal(InstallmentAmount);
                decimal myInstallmentAmount = ParseDecimal(MyInstallmentAmount);

                int totalInstallment = string.IsNullOrEmpty(InstallmentNo) ? 0 : Convert.ToInt32(InstallmentNo);
                int myTotalInstallment = string.IsNullOrEmpty(MyInstallmentNo) ? 0 : Convert.ToInt32(MyInstallmentNo);

                DateTime dobDate = Convert.ToDateTime(DOB);
                DateTime dueDate = DateTime.Now;

                if (PaymentMode == "Installment")
                    dueDate = Convert.ToDateTime(NextDueDate);

                // ===============================
                // CHECK EXISTING STUDENT
                // ===============================

                SqlCommand cmdCheck = new SqlCommand(
                "SELECT StudentId FROM Student_Admission WHERE Mobile=@Mobile",
                con, transaction);

                cmdCheck.Parameters.AddWithValue("@Mobile", Mobile);

                object existingStudent = cmdCheck.ExecuteScalar();

                bool isNewStudent = false;

                if (existingStudent != null)
                {
                    StudentId = existingStudent.ToString();
                }
                else
                {
                    isNewStudent = true;
                }

                // ===============================
                // INSERT STUDENT ONLY IF NEW
                // ===============================

                if (isNewStudent)
                {
                    SqlCommand cmdStudent = new SqlCommand(@"
                INSERT INTO Student_Admission
                (StudentId,AdmissionNo,RollNo,StudentName,Mobile,Gender,Email,DOB,
                 FatherName,FatherOccupation,FatherContactNo,MotherName,
                 State,City,Pincode,Address,Photo,AadhaarFile,CourseId,
                 Status,Date,AdmissionType,ProcessedBy)
                VALUES
                (@StudentId,@AdmissionNo,@RollNo,@StudentName,@Mobile,@Gender,@Email,@DOB,
                 @FatherName,@FatherOccupation,@FatherContactNo,@MotherName,
                 @State,@City,@Pincode,@Address,@Photo,@AadhaarFile,@CourseId,
                 'Active',GETDATE(),@AdmissionType,'Admin')",
                     con, transaction);

                    cmdStudent.Parameters.AddWithValue("@StudentId", StudentId);
                    cmdStudent.Parameters.AddWithValue("@AdmissionNo", AdmissionNo);
                    cmdStudent.Parameters.AddWithValue("@RollNo", RollNo);
                    cmdStudent.Parameters.AddWithValue("@StudentName", StudentName);
                    cmdStudent.Parameters.AddWithValue("@Mobile", Mobile);
                    cmdStudent.Parameters.AddWithValue("@Gender", Gender);
                    cmdStudent.Parameters.AddWithValue("@Email", Email);
                    cmdStudent.Parameters.Add("@DOB", SqlDbType.Date).Value = dobDate;
                    cmdStudent.Parameters.AddWithValue("@FatherName", FatherName);
                    cmdStudent.Parameters.AddWithValue("@FatherOccupation", FatherOccupation);
                    cmdStudent.Parameters.AddWithValue("@FatherContactNo", FatherContactNo);
                    cmdStudent.Parameters.AddWithValue("@MotherName", MotherName);
                    cmdStudent.Parameters.AddWithValue("@State", State);
                    cmdStudent.Parameters.AddWithValue("@City", City);
                    cmdStudent.Parameters.AddWithValue("@Pincode", Pincode);
                    cmdStudent.Parameters.AddWithValue("@Address", Address);
                    cmdStudent.Parameters.AddWithValue("@Photo", Photo);
                    cmdStudent.Parameters.AddWithValue("@AadhaarFile", AadhaarFile);
                    cmdStudent.Parameters.AddWithValue("@CourseId", CourseId);
                    cmdStudent.Parameters.AddWithValue("@AdmissionType",
                        CheckedValue == "New" ? "New" :
                        CheckedValue == "CallEnquiry" ? "Call" : "Visitor");

                    cmdStudent.ExecuteNonQuery();
                }

                // ===============================
                // GENERATE INVOICE
                // ===============================

                string invoiceNo = Get_InvoiceNo();
                string invoiceNoFull = Get_InvoiceNo2();

                // ===============================
                // INSERT FEE
                // ===============================

                SqlCommand cmdFee = new SqlCommand(@"
            INSERT INTO Student_Fee
            (InvoiceNo,StudentId,AdmissionNo,TotalAmount,Concession,
             NetAmount,PaidAmount,DuesAmount,PaymentMode,
             PaymentMethod,Status,Date)
            VALUES
            (@InvoiceNo,@StudentId,@AdmissionNo,@TotalAmount,@Concession,
             @NetAmount,@PaidAmount,@DuesAmount,@PaymentMode,
             @PaymentMethod,@Status,GETDATE())",
                con, transaction);

                cmdFee.Parameters.AddWithValue("@InvoiceNo",
                    PaymentMode == "Installment" ? invoiceNo : invoiceNoFull);

                cmdFee.Parameters.AddWithValue("@StudentId", StudentId);
                cmdFee.Parameters.AddWithValue("@AdmissionNo", AdmissionNo);
                cmdFee.Parameters.AddWithValue("@TotalAmount", totalAmount);
                cmdFee.Parameters.AddWithValue("@Concession", Concession);
                cmdFee.Parameters.AddWithValue("@NetAmount", netAmount);
                cmdFee.Parameters.AddWithValue("@PaidAmount", paidAmount);
                cmdFee.Parameters.AddWithValue("@DuesAmount", duesAmount);
                cmdFee.Parameters.AddWithValue("@PaymentMode", PaymentMode);
                cmdFee.Parameters.AddWithValue("@PaymentMethod", PaymentMethod);
                cmdFee.Parameters.AddWithValue("@Status",
                    PaymentMode == "Installment" ? "Dues" : "Paid");

                cmdFee.ExecuteNonQuery();

                // ===============================
                // ASSIGN BATCH (COURSE LINK)
                // ===============================

                SqlCommand cmdBatch = new SqlCommand(
                "INSERT INTO Student_Batch (StudentId,BatchId,Date) VALUES (@StudentId,@BatchId,GETDATE())",
                con, transaction);

                cmdBatch.Parameters.AddWithValue("@StudentId", StudentId);
                cmdBatch.Parameters.AddWithValue("@BatchId", BatchId);

                cmdBatch.ExecuteNonQuery();

                // ===============================
                // INSTALLMENT MODE
                // ===============================

                if (PaymentMode == "Installment")
                {
                    SqlCommand cmdInst = new SqlCommand(@"
                INSERT INTO Student_Installment
                (StudentId,Installment_Amount,Total_Installment,Total_Amount,Status)
                VALUES (@StudentId,@Installment_Amount,@Total_Installment,@Total_Amount,'Dues')",
                    con, transaction);

                    cmdInst.Parameters.AddWithValue("@StudentId", StudentId);
                    cmdInst.Parameters.AddWithValue("@Installment_Amount", installmentAmount);
                    cmdInst.Parameters.AddWithValue("@Total_Installment", totalInstallment);
                    cmdInst.Parameters.AddWithValue("@Total_Amount", netAmount);

                    cmdInst.ExecuteNonQuery();

                    SqlCommand cmdPaid = new SqlCommand(@"
                INSERT INTO Paid_Installment
                (InvoiceNo,StudentId,Paid_Amount,Installment_No,PaymentMethod,Date,ProcessedBy)
                VALUES (@InvoiceNo,@StudentId,@Paid_Amount,1,@PaymentMethod,GETDATE(),'Admin')",
                    con, transaction);

                    cmdPaid.Parameters.AddWithValue("@InvoiceNo", invoiceNo);
                    cmdPaid.Parameters.AddWithValue("@StudentId", StudentId);
                    cmdPaid.Parameters.AddWithValue("@Paid_Amount", paidAmount);
                    cmdPaid.Parameters.AddWithValue("@PaymentMethod", PaymentMethod);

                    cmdPaid.ExecuteNonQuery();

                    SqlCommand cmdDues = new SqlCommand(@"
                INSERT INTO Dues_Installment
                (StudentId,Installment_Amount,Total_Installment,
                 Total_Dues,Dues_Date,Date)
                VALUES
                (@StudentId,@Installment_Amount,@Total_Installment,
                 @Total_Dues,@Dues_Date,GETDATE())",
                    con, transaction);

                    cmdDues.Parameters.AddWithValue("@StudentId", StudentId);
                    cmdDues.Parameters.AddWithValue("@Installment_Amount", myInstallmentAmount);
                    cmdDues.Parameters.AddWithValue("@Total_Installment", myTotalInstallment);
                    cmdDues.Parameters.AddWithValue("@Total_Dues", duesAmount);
                    cmdDues.Parameters.AddWithValue("@Dues_Date", dueDate);

                    cmdDues.ExecuteNonQuery();
                }

                transaction.Commit();

                return PaymentMode == "Installment" ? invoiceNo : invoiceNoFull;
            }
            catch (Exception ex)
            {
                transaction.Rollback();
                return "ERROR: " + ex.Message;
            }
        }
    }

    private static decimal ParseDecimal(string value)
    {
        if (string.IsNullOrWhiteSpace(value))
            return 0m;

        decimal parsed;
        if (!decimal.TryParse(value, NumberStyles.Any, CultureInfo.InvariantCulture, out parsed))
        {
            if (!decimal.TryParse(value, out parsed))
                throw new Exception("Invalid decimal value.");
        }
        return parsed;
    }
}

