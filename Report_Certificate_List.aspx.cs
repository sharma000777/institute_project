using System;
using System.Data;
using System.Data.SqlClient;

public partial class Admin_Report_Certificate_List : System.Web.UI.Page
{

    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);

    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {

            LoadCertificates();

        }

    }

    void LoadCertificates()
    {

        string query = @"SELECT
c.CertificateNo,
sa.StudentName,
sa.Mobile,
cm.Course_Name,
c.IssueDate

FROM Certificate_Master c

INNER JOIN Student_Admission sa
ON c.StudentId=sa.StudentId

INNER JOIN Course_Master cm
ON c.CourseId=cm.Id

ORDER BY c.Id DESC";

        SqlCommand cmd = new SqlCommand(query, con);

        SqlDataAdapter da = new SqlDataAdapter(cmd);

        DataTable dt = new DataTable();

        da.Fill(dt);

        rptCert.DataSource = dt;

        rptCert.DataBind();

    }

}