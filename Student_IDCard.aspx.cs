using System;
using System.Data;
using System.Data.SqlClient;

public partial class Admin_Student_IDCard : System.Web.UI.Page
{

    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);

    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {

            string mobile = Request.QueryString["Mobile"];

            if (!string.IsNullOrEmpty(mobile))
            {

                LoadStudent(mobile);

            }

        }

    }

    void LoadStudent(string mobile)
    {

        SqlCommand cmd = new SqlCommand(@"

SELECT 
s.StudentId,
s.StudentName,
s.Mobile,
s.Photo,
c.Course_Name

FROM Student_Admission s

LEFT JOIN Course_Master c 
ON s.CourseId = c.Id

WHERE s.Mobile=@Mobile

", con);

        cmd.Parameters.AddWithValue("@Mobile", mobile);

        SqlDataAdapter da = new SqlDataAdapter(cmd);

        DataTable dt = new DataTable();

        da.Fill(dt);

        if (dt.Rows.Count > 0)
        {

            lblStudentId.Text = dt.Rows[0]["StudentId"].ToString();

            lblStudentName.Text = dt.Rows[0]["StudentName"].ToString();

            lblMobile.Text = dt.Rows[0]["Mobile"].ToString();

            lblCourse.Text = dt.Rows[0]["Course_Name"].ToString();

            imgPhoto.ImageUrl = "../UserLogin_Content/upload/" + dt.Rows[0]["Photo"].ToString();

        }

    }

}