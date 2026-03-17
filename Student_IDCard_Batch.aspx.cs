using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class Admin_Student_IDCard_Batch : System.Web.UI.Page
{

    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);

    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            LoadStudents();
        }

    }

    void LoadStudents()
    {

        string query = @"SELECT sa.StudentId,
       sa.StudentName,
       sa.Mobile,
       sa.Photo,
       cm.Course_Name
FROM Student_Admission sa
INNER JOIN Course_Master cm
ON sa.CourseId = cm.Id";

        SqlDataAdapter da = new SqlDataAdapter(query, con);

        DataTable dt = new DataTable();

        da.Fill(dt);

        rptStudents.DataSource = dt;

        rptStudents.DataBind();

    }

}