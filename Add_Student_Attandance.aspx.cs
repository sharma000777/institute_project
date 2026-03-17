using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Add_Student_Attandance : System.Web.UI.Page
{
    string connStr = ConfigurationManager.ConnectionStrings["hms3"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindCourse();
            BindBatch();
            BindData();
            BindSession();
            lblSelectedCount.Text = " ";
        }
    }

    protected void BindSession()
    {
       

        using (SqlConnection con = new SqlConnection(connStr))
        {
            string query = "SELECT Id, SessionStart, SessionEnd FROM Session_Master";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();

                if (rdr.HasRows)
                {
                    DataTable dt = new DataTable();
                    dt.Load(rdr);

                    // Create a new column for combined text
                    dt.Columns.Add("SessionDisplay", typeof(string));

                    foreach (DataRow row in dt.Rows)
                    {
                        string start = row["SessionStart"].ToString();
                        string end = row["SessionEnd"].ToString();
                        row["SessionDisplay"] = start + " - " + end;
                    }

                    ddlSession.DataSource = dt;
                    ddlSession.DataTextField = "SessionDisplay";
                    ddlSession.DataValueField = "Id";
                    ddlSession.DataBind();


                }
                else
                {
                    // Optional: Clear dropdown if no data
                    ddlSession.Items.Clear();
                    ddlSession.Items.Insert(0, new ListItem("No sessions available", ""));
                }

                rdr.Close();
            }
        }
    }


    protected void BindCourse()
    {
     

        using (SqlConnection con = new SqlConnection(connStr))
        {
            string query = "SELECT Id, Course_Name FROM Course_Master";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();

                ddlCourse.DataSource = rdr;
                ddlCourse.DataTextField = "Course_Name";
                ddlCourse.DataValueField = "Id";
                ddlCourse.DataBind();


            }
        }
    }

    protected void BindBatch()
    {
     

        using (SqlConnection con = new SqlConnection(connStr))
        {
            string query = "SELECT Id, BatchName FROM Batch_Master";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();

                ddlBatch.DataSource = rdr;
                ddlBatch.DataTextField = "BatchName";
                ddlBatch.DataValueField = "Id";
                ddlBatch.DataBind();


            }
        }
    }

    private void BindData()
    {
        DataTable dt = new DataTable();
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();

            string query = "SELECT DISTINCT * FROM Attendance_StudentView WHERE 1=1";

            // Add filters based on selected values
            if (!string.IsNullOrEmpty(ddlCourse.SelectedValue) && ddlCourse.SelectedValue != "0")
            {
                query += " AND CourseId = @CourseId";
            }

            if (!string.IsNullOrEmpty(ddlSession.SelectedValue) && ddlSession.SelectedValue != "0")
            {
                query += " AND SessionId = @SessionId";
            }

            if (!string.IsNullOrEmpty(ddlBatch.SelectedValue) && ddlBatch.SelectedValue != "0")
            {
                query += " AND BatchId = @BatchId";
            }

            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                if (!string.IsNullOrEmpty(ddlCourse.SelectedValue) && ddlCourse.SelectedValue != "0")
                {
                    cmd.Parameters.AddWithValue("@CourseId", ddlCourse.SelectedValue);
                }

                if (!string.IsNullOrEmpty(ddlSession.SelectedValue) && ddlSession.SelectedValue != "0")
                {
                    cmd.Parameters.AddWithValue("@SessionId", ddlSession.SelectedValue);
                }

                if (!string.IsNullOrEmpty(ddlBatch.SelectedValue) && ddlBatch.SelectedValue != "0")
                {
                    cmd.Parameters.AddWithValue("@BatchId", ddlBatch.SelectedValue);
                }

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
            }
        }

        rptAttendance.DataSource = dt;
        rptAttendance.DataBind();
    }


    //protected void btnSubmit_Click(object sender, EventArgs e)
    //{
    //    int savedCount = 0;
    //    //string userType = "Student"; // ya session se le lo: Session["UserType"]
    //    string markedBy = Session["Username"] != null ? Session["Username"].ToString() : "Admin";
    //    DateTime attendanceDate = DateTime.Now.Date;

    //    string selectedCourseId = ddlCourse.SelectedValue != "0" ? ddlCourse.SelectedValue : null;
    //    string selectedBatch = ddlBatch.SelectedValue != "0" ? ddlBatch.SelectedValue : null;

    //    using (SqlConnection conn = new SqlConnection(connStr))
    //    {
    //        conn.Open();

    //        foreach (RepeaterItem item in rptAttendance.Items)
    //        {
    //            string id = ((HiddenField)item.FindControl("HiddenField")).Value;
    //            string status = Request.Form["attend_" + id];  // Value "P" or "A"

    //            if (!string.IsNullOrEmpty(status))
    //            {
    //                // Check if already exists
    //                SqlCommand checkCmd = new SqlCommand("SELECT COUNT(*) FROM Student_Attendance WHERE StudentId = @StudentId AND AttendanceDate = @Date", conn);
    //                checkCmd.Parameters.AddWithValue("@StudentId", id);
    //                checkCmd.Parameters.AddWithValue("@Date", attendanceDate);
    //                int exists = (int)checkCmd.ExecuteScalar();

    //                if (exists == 0)
    //                {
    //                    // Insert into Student_Attendance
    //                    SqlCommand insertCmd = new SqlCommand(@"
    //                    INSERT INTO Student_Attendance 
    //                    (StudentId, AttendanceDate, Status, CourseId, Batch, MarkedBy)
    //                    VALUES 
    //                    (@StudentId, @Date, @Status, @CourseId, @Batch, @MarkedBy)", conn);

    //                    insertCmd.Parameters.AddWithValue("@StudentId", id);
    //                    insertCmd.Parameters.AddWithValue("@Date", attendanceDate);
    //                    insertCmd.Parameters.AddWithValue("@Status", status);
    //                    insertCmd.Parameters.AddWithValue("@CourseId", (object)selectedCourseId ?? DBNull.Value);
    //                    insertCmd.Parameters.AddWithValue("@Batch", (object)selectedBatch ?? DBNull.Value);
    //                    insertCmd.Parameters.AddWithValue("@MarkedBy", markedBy);

    //                    insertCmd.ExecuteNonQuery();
    //                    savedCount++;
    //                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('✅  Attendance record(s) saved successfully!');", true);


    //                }
    //                else
    //                {
    //                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert(' Attendance record is Already Submited');", true);

    //                }
    //            }
    //        }
    //        conn.Close();
    //    }

    //    lblSelectedCount.Text = "✅ Saved {savedCount} attendance records!";
    //}

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        int savedCount = 0;

        string markedBy = Session["Username"] != null ? Session["Username"].ToString() : "Admin";

        DateTime attendanceDate = DateTime.Now.Date;

        string selectedCourseId = ddlCourse.SelectedValue != "0" ? ddlCourse.SelectedValue : null;
        string selectedBatch = ddlBatch.SelectedValue != "0" ? ddlBatch.SelectedValue : null;

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();

            foreach (RepeaterItem item in rptAttendance.Items)
            {
                string id = ((HiddenField)item.FindControl("HiddenField")).Value;

                string status = Request.Form["attend_" + id];

                if (!string.IsNullOrEmpty(status))
                {

                    // Check if attendance exists
                    SqlCommand checkCmd = new SqlCommand(@"
                SELECT COUNT(*) 
                FROM Student_Attendance 
                WHERE StudentId=@StudentId 
                AND AttendanceDate=@Date", conn);

                    checkCmd.Parameters.AddWithValue("@StudentId", id);
                    checkCmd.Parameters.AddWithValue("@Date", attendanceDate);

                    int exists = (int)checkCmd.ExecuteScalar();

                    if (exists == 0)
                    {
                        // INSERT attendance

                        SqlCommand insertCmd = new SqlCommand(@"
                    INSERT INTO Student_Attendance
                    (StudentId, AttendanceDate, Status, CourseId, Batch, MarkedBy)
                    VALUES
                    (@StudentId,@Date,@Status,@CourseId,@Batch,@MarkedBy)", conn);

                        insertCmd.Parameters.AddWithValue("@StudentId", id);
                        insertCmd.Parameters.AddWithValue("@Date", attendanceDate);
                        insertCmd.Parameters.AddWithValue("@Status", status);
                        insertCmd.Parameters.AddWithValue("@CourseId", (object)selectedCourseId ?? DBNull.Value);
                        insertCmd.Parameters.AddWithValue("@Batch", (object)selectedBatch ?? DBNull.Value);
                        insertCmd.Parameters.AddWithValue("@MarkedBy", markedBy);

                        insertCmd.ExecuteNonQuery();
                    }
                    else
                    {
                        // UPDATE attendance

                        SqlCommand updateCmd = new SqlCommand(@"
                    UPDATE Student_Attendance
                    SET Status=@Status,
                        MarkedBy=@MarkedBy
                    WHERE StudentId=@StudentId
                    AND AttendanceDate=@Date", conn);

                        updateCmd.Parameters.AddWithValue("@StudentId", id);
                        updateCmd.Parameters.AddWithValue("@Date", attendanceDate);
                        updateCmd.Parameters.AddWithValue("@Status", status);
                        updateCmd.Parameters.AddWithValue("@MarkedBy", markedBy);

                        updateCmd.ExecuteNonQuery();
                    }

                    savedCount++;
                }
            }

            conn.Close();
        }

        lblSelectedCount.Text = "✅ Saved / Updated " + savedCount + " attendance records";

        ScriptManager.RegisterStartupScript(this, this.GetType(),
            "alert",
            "alert('Attendance saved / updated successfully');",
            true);
    }
    protected void ddlCourse_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }

    protected void ddlSession_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }

    protected void ddlBatch_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }
}

