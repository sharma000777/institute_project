using System;
using System.Data;
using System.Data.SqlClient;

public partial class Admin_Admission_Confirmation_Print : System.Web.UI.Page
{

    SqlConnection con = new SqlConnection(
    System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);

    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {

            string mobile = Request.QueryString["Mobile"];

            LoadAdmission(mobile);

        }

    }

    void LoadAdmission(string mobile)
    {

        string query = @"

SELECT 
sa.StudentName,
sa.Mobile,
cm.Course_Name,
bm.BatchName,
sf.NetAmount,
sf.PaidAmount,
sf.DuesAmount

FROM Student_Admission sa

INNER JOIN Course_Master cm
ON sa.CourseId = cm.Id

INNER JOIN Student_Batch sb
ON sa.StudentId = sb.StudentId

INNER JOIN Batch_Master bm
ON sb.BatchId = bm.Id

INNER JOIN Student_Fee sf
ON sa.StudentId = sf.StudentId

WHERE sa.Mobile=@Mobile
";

        SqlCommand cmd = new SqlCommand(query, con);

        cmd.Parameters.AddWithValue("@Mobile", mobile);

        SqlDataAdapter da = new SqlDataAdapter(cmd);

        DataTable dt = new DataTable();

        da.Fill(dt);

        if (dt.Rows.Count > 0)
        {

            lblStudentName.Text = dt.Rows[0]["StudentName"].ToString();
            lblMobile.Text = dt.Rows[0]["Mobile"].ToString();
            lblCourse.Text = dt.Rows[0]["Course_Name"].ToString();
            lblBatch.Text = dt.Rows[0]["BatchName"].ToString();
            lblFee.Text = dt.Rows[0]["NetAmount"].ToString();
            lblPaid.Text = dt.Rows[0]["PaidAmount"].ToString();
            lblDue.Text = dt.Rows[0]["DuesAmount"].ToString();

        }

    }

}