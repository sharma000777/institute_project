using System;
using System.Data;
using System.Data.SqlClient;

public partial class Admin_Employee_IDCard : System.Web.UI.Page
{

    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);

    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {

            if (Request.QueryString["EmployeeId"] != null)
            {

                string EmployeeId = Request.QueryString["EmployeeId"].ToString();

                SqlCommand cmd = new SqlCommand("select * from Employee_Detail where EmployeeId=@EmployeeId", con);

                cmd.Parameters.AddWithValue("@EmployeeId", EmployeeId);

                SqlDataAdapter da = new SqlDataAdapter(cmd);

                DataTable dt = new DataTable();

                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {

                    lblEmployeeId.Text = dt.Rows[0]["EmployeeId"].ToString();
                    lblName.Text = dt.Rows[0]["EmployeeName"].ToString();
                    lblDepartment.Text = dt.Rows[0]["Department"].ToString();
                    lblDesignation.Text = dt.Rows[0]["Designation"].ToString();
                    lblMobile.Text = dt.Rows[0]["Mobile"].ToString();

                    imgPhoto.ImageUrl = "/UserLogin_Content/upload/" + dt.Rows[0]["Photo"].ToString();

                }

            }

        }

    }

}