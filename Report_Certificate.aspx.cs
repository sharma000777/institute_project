using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

public partial class Admin_Report_Certificate : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(
    System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadStudents();
        }
    }

    void LoadStudents()
    {
        string query = @"SELECT sa.StudentName,sa.Mobile,cm.Course_Name
        FROM Student_Admission sa
        INNER JOIN Course_Master cm ON sa.CourseId=cm.Id
        WHERE sa.Status='Active'";

        SqlCommand cmd = new SqlCommand(query, con);

        SqlDataAdapter da = new SqlDataAdapter(cmd);

        DataTable dt = new DataTable();

        da.Fill(dt);

        rptStudents.DataSource = dt;

        rptStudents.DataBind();
    }


    [System.Web.Services.WebMethod]
    public static string GenerateBulk(List<string> mobiles)
    {
        SqlConnection con = new SqlConnection(
        System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);

        con.Open();

        List<string> messages = new List<string>();

        foreach (string mobile in mobiles)
        {

            string query = @"
            SELECT 
            sa.StudentId,
            sa.CourseId,
            sa.Date,
            cm.Course_Duration,
            cm.Duration_Type,
            ISNULL(sf.DuesAmount,0) AS DuesAmount

            FROM Student_Admission sa
            INNER JOIN Course_Master cm ON sa.CourseId = cm.Id
            LEFT JOIN Student_Fee sf ON sa.StudentId = sf.StudentId

            WHERE sa.Mobile=@Mobile";

            SqlCommand cmd = new SqlCommand(query, con);

            cmd.Parameters.AddWithValue("@Mobile", mobile);

            SqlDataReader dr = cmd.ExecuteReader();

            if (!dr.Read())
            {
                dr.Close();
                messages.Add(mobile + " : Student not found");
                continue;
            }

            string studentId = dr["StudentId"].ToString();
            string courseId = dr["CourseId"].ToString();

            decimal dues = Convert.ToDecimal(dr["DuesAmount"]);

            DateTime admissionDate = Convert.ToDateTime(dr["Date"]);

            int duration = Convert.ToInt32(dr["Course_Duration"]);

            string durationType = dr["Duration_Type"].ToString();

            dr.Close();

            // 🔴 Fees Check

            if (dues > 0)
            {
                messages.Add(mobile + " : Fees pending");
                continue;
            }


            // 🔴 Course Completion Check (TEMPORARILY DISABLED)

            /*
            DateTime completionDate;

            if (durationType == "Month")
                completionDate = admissionDate.AddMonths(duration);

            else if (durationType == "Year")
                completionDate = admissionDate.AddYears(duration);

            else
                completionDate = admissionDate.AddDays(duration);

            if (DateTime.Now < completionDate)
            {
                messages.Add(mobile + " : Course not completed yet");
                continue;
            }
            */


            // 🔴 Duplicate Certificate Check

            string checkQuery = @"SELECT COUNT(*) 
            FROM Certificate_Master 
            WHERE StudentId=@StudentId AND CourseId=@CourseId";

            SqlCommand chk = new SqlCommand(checkQuery, con);

            chk.Parameters.AddWithValue("@StudentId", studentId);
            chk.Parameters.AddWithValue("@CourseId", courseId);

            int exist = Convert.ToInt32(chk.ExecuteScalar());

            if (exist > 0)
            {
                messages.Add(mobile + " : Certificate already generated");
                continue;
            }


            // 🟢 Generate Certificate

            string certNo = "CERT-" + DateTime.Now.Ticks.ToString().Substring(10);

            string insert = @"INSERT INTO Certificate_Master
            (CertificateNo,StudentId,CourseId,IssueDate,GeneratedBy,Status)

            VALUES
            (@CertificateNo,@StudentId,@CourseId,GETDATE(),'Admin','Generated')";

            SqlCommand cmdInsert = new SqlCommand(insert, con);

            cmdInsert.Parameters.AddWithValue("@CertificateNo", certNo);
            cmdInsert.Parameters.AddWithValue("@StudentId", studentId);
            cmdInsert.Parameters.AddWithValue("@CourseId", courseId);

            cmdInsert.ExecuteNonQuery();

            messages.Add(mobile + " : Certificate generated");

        }

        con.Close();

        return string.Join("\n", messages);
    }
}