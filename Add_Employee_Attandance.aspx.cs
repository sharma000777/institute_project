using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Add_Employee_Attandance : System.Web.UI.Page
{
    string connStr = ConfigurationManager.ConnectionStrings["hms3"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindDepartment();  // Optional: if you still want course filtering for staff
            BindData();
            BindDesignation();
            lblSelectedCount.Text = " ";
        }
    }

    protected void BindDepartment()
    {
        using (SqlConnection con = new SqlConnection(connStr))
        {
            string query = "SELECT Id, Department_Name FROM Department_Master";
            SqlCommand cmd = new SqlCommand(query, con);
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();

            ddlDepartment.DataSource = rdr;
            ddlDepartment.DataTextField = "Department_Name";
            ddlDepartment.DataValueField = "Department_Name";
            ddlDepartment.DataBind();
        }
    }
    protected void BindDesignation()
    {
        using (SqlConnection con = new SqlConnection(connStr))
        {
            string query = "SELECT Id, Designation_Name FROM Designation_Master";
            SqlCommand cmd = new SqlCommand(query, con);
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();

            ddlDesignation.DataSource = rdr;
            ddlDesignation.DataTextField = "Designation_Name";
            ddlDesignation.DataValueField = "Designation_Name";
            ddlDesignation.DataBind();
        }
    }

    private void BindData()
    {
        DataTable dt = new DataTable();

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();

            StringBuilder query = new StringBuilder(@"
        SELECT 
        EmployeeId,
        EmployeeName,
        Gender,
        Mobile,
        Photo,
        Department,
        Designation
        FROM Employee_Detail
        WHERE 1=1");

            if (!string.IsNullOrEmpty(ddlDepartment.SelectedValue))
            {
                query.Append(" AND Department = @department");
            }

            if (!string.IsNullOrEmpty(ddlDesignation.SelectedValue))
            {
                query.Append(" AND Designation = @designation");
            }

            SqlCommand cmd = new SqlCommand(query.ToString(), conn);

            if (!string.IsNullOrEmpty(ddlDepartment.SelectedValue))
            {
                cmd.Parameters.AddWithValue("@department", ddlDepartment.SelectedValue);
            }

            if (!string.IsNullOrEmpty(ddlDesignation.SelectedValue))
            {
                cmd.Parameters.AddWithValue("@designation", ddlDesignation.SelectedValue);
            }

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
        }

        rptAttendance.DataSource = dt;
        rptAttendance.DataBind();
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        int savedCount = 0;
        int updatedCount = 0;

        string markedBy = Session["Username"] != null ? Session["Username"].ToString() : "Admin";
        DateTime attendanceDate = DateTime.Now.Date;

        string selectedDepartment = ddlDepartment.SelectedValue;

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();

            foreach (RepeaterItem item in rptAttendance.Items)
            {
                string staffId = ((HiddenField)item.FindControl("HiddenField")).Value;
                string status = Request.Form["attend_" + staffId];

                if (!string.IsNullOrEmpty(status))
                {

                    // CHECK EXISTING ATTENDANCE
                    SqlCommand checkCmd = new SqlCommand(
                        "SELECT COUNT(*) FROM Staff_Attendance WHERE StaffId=@StaffId AND AttendanceDate=@Date",
                        conn);

                    checkCmd.Parameters.AddWithValue("@StaffId", staffId);
                    checkCmd.Parameters.AddWithValue("@Date", attendanceDate);

                    int exists = (int)checkCmd.ExecuteScalar();

                    if (exists == 0)
                    {
                        // INSERT
                        SqlCommand insertCmd = new SqlCommand(@"
                    INSERT INTO Staff_Attendance
                    (StaffId, AttendanceDate, Status, Department, MarkedBy)
                    VALUES
                    (@StaffId, @Date, @Status, @Department, @MarkedBy)", conn);

                        insertCmd.Parameters.AddWithValue("@StaffId", staffId);
                        insertCmd.Parameters.AddWithValue("@Date", attendanceDate);
                        insertCmd.Parameters.AddWithValue("@Status", status);
                        insertCmd.Parameters.AddWithValue("@Department", selectedDepartment);
                        insertCmd.Parameters.AddWithValue("@MarkedBy", markedBy);

                        insertCmd.ExecuteNonQuery();

                        savedCount++;
                    }
                    else
                    {
                        // UPDATE EXISTING ATTENDANCE
                        SqlCommand updateCmd = new SqlCommand(@"
                    UPDATE Staff_Attendance
                    SET Status=@Status,
                        Department=@Department,
                        MarkedBy=@MarkedBy
                    WHERE StaffId=@StaffId
                    AND AttendanceDate=@Date", conn);

                        updateCmd.Parameters.AddWithValue("@StaffId", staffId);
                        updateCmd.Parameters.AddWithValue("@Date", attendanceDate);
                        updateCmd.Parameters.AddWithValue("@Status", status);
                        updateCmd.Parameters.AddWithValue("@Department", selectedDepartment);
                        updateCmd.Parameters.AddWithValue("@MarkedBy", markedBy);

                        updateCmd.ExecuteNonQuery();

                        updatedCount++;
                    }
                }
            }

            conn.Close();
        }

        lblSelectedCount.Text =
            "✅ Saved: " + savedCount + " | Updated: " + updatedCount;

        ScriptManager.RegisterStartupScript(
            this,
            this.GetType(),
            "alert",
            "alert('Attendance processed successfully');",
            true);
    

   
        // Show one-time message only after loop ends
        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('✅ Attendance processed successfully.');", true);

    }


    protected void ddlCourse_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }

    protected void ddlDesignation_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }

    protected void txtname_TextChanged(object sender, EventArgs e)
    {
        BindData();

    }
}