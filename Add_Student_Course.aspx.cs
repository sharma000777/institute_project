using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using Newtonsoft.Json;

public partial class Admin_Add_Student_Course : System.Web.UI.Page
{

    static string cs = System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString;

    [WebMethod]
    public static string GetStudents()
    {

        SqlConnection con = new SqlConnection(cs);

        SqlDataAdapter da = new SqlDataAdapter(
        "select StudentId,StudentName,Mobile from Student_Admission", con);

        DataTable dt = new DataTable();

        da.Fill(dt);

        return JsonConvert.SerializeObject(dt);

    }



    [WebMethod]
    public static string GetCourses()
    {

        SqlConnection con = new SqlConnection(cs);

        SqlDataAdapter da = new SqlDataAdapter(
        "select Id,Course_Name,Fee from Course_Master", con);

        DataTable dt = new DataTable();

        da.Fill(dt);

        return JsonConvert.SerializeObject(dt);

    }



    [WebMethod]
    public static string GetBatch(int courseId)
    {

        SqlConnection con = new SqlConnection(cs);

        SqlCommand cmd = new SqlCommand(
        "select Id,BatchName from Batch_Master where CourseId=@CourseId", con);

        cmd.Parameters.AddWithValue("@CourseId", courseId);

        SqlDataAdapter da = new SqlDataAdapter(cmd);

        DataTable dt = new DataTable();

        da.Fill(dt);

        return JsonConvert.SerializeObject(dt);

    }



    [WebMethod]
    public static string AddCourse(string studentId, int batchId, decimal fee, decimal paid, string paymentMode)
    {

        SqlConnection con = new SqlConnection(cs);

        con.Open();

        SqlTransaction tr = con.BeginTransaction();

        try
        {

            decimal dues = fee - paid;

            string invoice = "INV" + DateTime.Now.Ticks.ToString().Substring(10);

            // 1️⃣ Insert Student Batch
            SqlCommand cmd1 = new SqlCommand(
            "insert into Student_Batch(StudentId,BatchId,Date) values(@StudentId,@BatchId,GETDATE())",
            con, tr);

            cmd1.Parameters.AddWithValue("@StudentId", studentId);
            cmd1.Parameters.AddWithValue("@BatchId", batchId);

            cmd1.ExecuteNonQuery();


            // 2️⃣ Insert Fee
            SqlCommand cmd2 = new SqlCommand(
            @"insert into Student_Fee
(StudentId,BatchId,TotalAmount,NetAmount,PaidAmount,DuesAmount,PaymentMode,Status,Date,InvoiceNo)
values
(@StudentId,@BatchId,@Total,@Total,@Paid,@Dues,@Mode,@Status,GETDATE(),@InvoiceNo)",
            con, tr);

            cmd2.Parameters.AddWithValue("@StudentId", studentId);
            cmd2.Parameters.AddWithValue("@BatchId", batchId);
            cmd2.Parameters.AddWithValue("@Total", fee);
            cmd2.Parameters.AddWithValue("@Paid", paid);
            cmd2.Parameters.AddWithValue("@Dues", dues);
            cmd2.Parameters.AddWithValue("@Mode", paymentMode);
            cmd2.Parameters.AddWithValue("@InvoiceNo", invoice);

            if (dues > 0)
                cmd2.Parameters.AddWithValue("@Status", "Dues");
            else
                cmd2.Parameters.AddWithValue("@Status", "Paid");

            cmd2.ExecuteNonQuery();


            // 3️⃣ Paid Installment Entry
            if (paid > 0)
            {

                SqlCommand cmd3 = new SqlCommand(
                @"insert into Paid_Installment
(InvoiceNo,StudentId,BatchId,Paid_Amount,Installment_No,PaymentMethod,Date,ProcessedBy)
values
(@InvoiceNo,@StudentId,@BatchId,@Paid,1,'Cash',GETDATE(),'Admin')",
                con, tr);

                cmd3.Parameters.AddWithValue("@InvoiceNo", invoice);
                cmd3.Parameters.AddWithValue("@StudentId", studentId);
                cmd3.Parameters.AddWithValue("@BatchId", batchId);
                cmd3.Parameters.AddWithValue("@Paid", paid);

                cmd3.ExecuteNonQuery();

            }


            // 4️⃣ Create Dues Installment
            if (dues > 0)
            {

                SqlCommand cmd4 = new SqlCommand(
                @"insert into Dues_Installment
(StudentId,BatchId,Installment_Amount,Total_Installment,Total_Dues,Dues_Date,Date)
values
(@StudentId,@BatchId,@InstallmentAmount,1,@TotalDues,DATEADD(DAY,30,GETDATE()),GETDATE())",
                con, tr);

                cmd4.Parameters.AddWithValue("@StudentId", studentId);
                cmd4.Parameters.AddWithValue("@BatchId", batchId);
                cmd4.Parameters.AddWithValue("@InstallmentAmount", dues);
                cmd4.Parameters.AddWithValue("@TotalDues", dues);

                cmd4.ExecuteNonQuery();

            }


            tr.Commit();

            return "Course Added Successfully";

        }

        catch (Exception ex)
        {

            tr.Rollback();

            return ex.Message;

        }

        finally
        {

            con.Close();

        }

    }

}