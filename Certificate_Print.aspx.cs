using System;
using System.Data;
using System.Data.SqlClient;

public partial class Admin_Certificate_Print : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(
        System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString
    );

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string mobile = Request.QueryString["Mobile"];

            if (!string.IsNullOrEmpty(mobile))
            {
                LoadCertificate(mobile);
            }
        }
    }

    private void LoadCertificate(string Mobile)
    {
        string query = @"
    SELECT TOP 1
        sa.StudentName,
        sa.FatherName,
        sa.DOB,
        sa.Photo,
        sa.StudentId,
        cm.Course_Name,
        c.CertificateNo,
        c.IssueDate
    FROM Certificate_Master c
    INNER JOIN Student_Admission sa
        ON c.StudentId = sa.StudentId
    INNER JOIN Course_Master cm
        ON c.CourseId = cm.Id
    WHERE sa.Mobile = @Mobile";

        SqlCommand cmd = new SqlCommand(query, con);
        cmd.Parameters.AddWithValue("@Mobile", Mobile);

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);

        if (dt.Rows.Count > 0)
        {
            lblStudentName.Text = dt.Rows[0]["StudentName"].ToString();
            lblStudentName2.Text = dt.Rows[0]["StudentName"].ToString();

            lblFatherName.Text = dt.Rows[0]["FatherName"].ToString();
            lblDOB.Text = Convert.ToDateTime(dt.Rows[0]["DOB"]).ToString("dd-MM-yyyy");

            lblRegNo.Text = dt.Rows[0]["StudentId"].ToString();

            lblCourseName.Text = dt.Rows[0]["Course_Name"].ToString();

            DateTime issueDate = Convert.ToDateTime(dt.Rows[0]["IssueDate"]);
            lblIssueDate.Text = issueDate.ToString("dd MMM yyyy");

            lblGrade.Text = "Outstanding";

            imgPhoto.ImageUrl = "../UserLogin_Content/upload/" + dt.Rows[0]["Photo"].ToString();
        }
    }
}