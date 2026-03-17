using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Services;
using Newtonsoft.Json;

public partial class Admin_Edit_Student : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    // ============================
    // LOAD STUDENT
    // ============================

    [WebMethod]
    public static string GetStudent(string Mobile)
    {

        SqlConnection con = new SqlConnection(
        ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);

        string query = @"

SELECT TOP 1

sa.StudentId,
sa.AdmissionNo,
sa.RollNo,
sa.StudentName,
sa.Mobile,
sa.Email,
sa.DOB,
sa.FatherName,
sa.FatherContactNo,
sa.Address,

sf.TotalAmount,
sf.Concession,
sf.NetAmount,
sf.PaidAmount,
sf.PaymentMode

FROM Student_Admission sa

LEFT JOIN Student_Fee sf
ON sa.StudentId = sf.StudentId

WHERE sa.Mobile=@Mobile
ORDER BY sa.Id DESC

";

        SqlCommand cmd = new SqlCommand(query, con);

        cmd.Parameters.AddWithValue("@Mobile", Mobile);

        SqlDataAdapter da = new SqlDataAdapter(cmd);

        DataTable dt = new DataTable();

        da.Fill(dt);

        return JsonConvert.SerializeObject(dt);

    }


    // ============================
    // UPDATE STUDENT
    // ============================

    [WebMethod]
    public static int UpdateStudent(

    string StudentId,
    string StudentName,
    string Mobile,
    string Email,
    string DOB,
    string FatherName,
    string FatherContactNo,
    string Address,

    string TotalAmount,
    string Concession,
    string NetAmount,
    string PaidAmount,
    string PaymentMode,

    string Photo,
    string AadhaarFile

    )
    {

        SqlConnection con = new SqlConnection(
        ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);

        con.Open();

        SqlTransaction tr = con.BeginTransaction();

        try
        {

            string query = @"UPDATE Student_Admission SET

StudentName=@StudentName,
Mobile=@Mobile,
Email=@Email,
DOB=@DOB,
FatherName=@FatherName,
FatherContactNo=@FatherContactNo,
Address=@Address";

            if (!string.IsNullOrEmpty(Photo))
                query += ",Photo=@Photo";

            if (!string.IsNullOrEmpty(AadhaarFile))
                query += ",AadhaarFile=@AadhaarFile";

            query += " WHERE StudentId=@StudentId";


            SqlCommand cmd = new SqlCommand(query, con, tr);

            cmd.Parameters.AddWithValue("@StudentId", StudentId);
            cmd.Parameters.AddWithValue("@StudentName", StudentName);
            cmd.Parameters.AddWithValue("@Mobile", Mobile);
            cmd.Parameters.AddWithValue("@Email", Email);
            cmd.Parameters.AddWithValue("@DOB", DOB);
            cmd.Parameters.AddWithValue("@FatherName", FatherName);
            cmd.Parameters.AddWithValue("@FatherContactNo", FatherContactNo);
            cmd.Parameters.AddWithValue("@Address", Address);

            if (!string.IsNullOrEmpty(Photo))
                cmd.Parameters.AddWithValue("@Photo", Photo);

            if (!string.IsNullOrEmpty(AadhaarFile))
                cmd.Parameters.AddWithValue("@AadhaarFile", AadhaarFile);

            cmd.ExecuteNonQuery();


            SqlCommand cmdFee = new SqlCommand(@"

UPDATE Student_Fee SET

TotalAmount=@TotalAmount,
Concession=@Concession,
NetAmount=@NetAmount,
PaidAmount=@PaidAmount,
PaymentMode=@PaymentMode

WHERE StudentId=@StudentId

", con, tr);


            cmdFee.Parameters.AddWithValue("@StudentId", StudentId);
            cmdFee.Parameters.AddWithValue("@TotalAmount", TotalAmount);
            cmdFee.Parameters.AddWithValue("@Concession", Concession);
            cmdFee.Parameters.AddWithValue("@NetAmount", NetAmount);
            cmdFee.Parameters.AddWithValue("@PaidAmount", PaidAmount);
            cmdFee.Parameters.AddWithValue("@PaymentMode", PaymentMode);

            cmdFee.ExecuteNonQuery();

            tr.Commit();
            con.Close();

            return 1;

        }

        catch
        {

            tr.Rollback();
            con.Close();
            return 0;

        }

    }

}