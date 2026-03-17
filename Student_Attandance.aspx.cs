using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Student_Attandance : System.Web.UI.Page
{
    string connStr = ConfigurationManager.ConnectionStrings["hms3"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            
                if (Session["LoginId"] == null)
                {
                    Response.Redirect("~/UserLogin/Admin_Login.aspx `");
                }


          

            LoadCourses();
            LoadSessions();
            LoadAttendance();
        }
    }

    private void LoadCourses()
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            SqlCommand cmd = new SqlCommand("SELECT Id, Course_Name FROM Course_Master", conn);
            conn.Open();
            ddlCourse.DataSource = cmd.ExecuteReader();
            ddlCourse.DataTextField = "Course_Name";
            ddlCourse.DataValueField = "Id";
            ddlCourse.DataBind();
        }

    }

    private void LoadSessions()
    {
        // Example static list
        ddlSession.Items.Add("2023-24");
        ddlSession.Items.Add("2024-25");
        ddlSession.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Select --", ""));
    }


    private void LoadAttendance()
    {
        string courseId = ddlCourse.SelectedValue;
        int month = Convert.ToInt32(ddlMonth.SelectedValue);
        string searchTerm = txtSearch.Text.Trim();

        // Validate year input
        int year;
        if (!int.TryParse(txtYear.Text, out year) || year < 2000 || year > 2100)
        {
            lblMessage.Text = "Please enter a valid year between 2000-2100";
            lblMessage.Visible = true;
            return;
        }
        lblMessage.Text = "";
        lblMessage.Visible = false;

        DataTable dt = new DataTable();

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            StringBuilder query = new StringBuilder();
            query.Append(@"
        SELECT 
            StudentId,
            StudentName,
            RollNo,
            CourseId,
            DAY(AttendanceDate) AS DayOfMonth,
            Status
        FROM Student_Attendance_View_Monthly
        WHERE MONTH(AttendanceDate) = @Month 
          AND YEAR(AttendanceDate) = @Year ");

            // Add course filter if selected
            if (!string.IsNullOrEmpty(courseId))
            {
                query.Append(" AND CourseId = @CourseId ");
            }

            // Add search filter if search term exists
            if (!string.IsNullOrEmpty(searchTerm))
            {
                query.Append(" AND (StudentName LIKE @SearchTerm OR RollNo LIKE @SearchTerm) ");
            }

            SqlCommand cmd = new SqlCommand(query.ToString(), conn);
            cmd.Parameters.AddWithValue("@Month", month);
            cmd.Parameters.AddWithValue("@Year", year);

            if (!string.IsNullOrEmpty(courseId))
            {
                cmd.Parameters.AddWithValue("@CourseId", courseId);
            }

            if (!string.IsNullOrEmpty(searchTerm))
            {
                cmd.Parameters.AddWithValue("@SearchTerm", "%" + searchTerm + "%");
            }

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
        }

        if (dt.Rows.Count == 0)
        {
            lblMessage.Text = "No records found matching your search criteria.";
            lblMessage.Visible = true;
        }

        litAttendanceTable.Text = GenerateAttendanceTable(dt, month);
    }

    private string GenerateAttendanceTable(DataTable dt, int month)
    {
        StringBuilder sb = new StringBuilder();
        int daysInMonth = DateTime.DaysInMonth(
      Convert.ToInt32(txtYear.Text),
      month
  );

        // Include RollNo and MobileNumber in the distinct student list
        var students = dt.DefaultView.ToTable(true, "StudentId", "StudentName", "RollNo", "CourseId");

        sb.Append("<table class='w-full border-2 border-gray-600 text-sm'>");
        sb.Append("<thead><tr class='bg-[#15a3b2] text-center border-2 border-gray-600'>");
        sb.Append("<th class='border p-2 min-w-24'>Roll No</th>");
        sb.Append("<th class='border p-2 min-w-44'>Name</th>");


        for (int i = 1; i <= daysInMonth; i++)
        {
            sb.Append(string.Format("<th class='border p-1'>{0}</th>", i));

        }

        sb.Append("<th class='border p-2 text-green-800'>P</th><th class='border p-2 text-red-800'>A</th><th class='border p-2 text-blue-800'>U</th><th class='border p-2 text-yellow-800'>E</th>");
        sb.Append("</tr></thead><tbody>");

        foreach (DataRow student in students.Rows)
        {
            string studentId = student["StudentId"].ToString();
            string name = student["StudentName"].ToString();
            string rollNo = student["RollNo"].ToString();


            var rows = dt.Select(string.Format("StudentId = '{0}'", studentId));

            var dayStatus = new string[daysInMonth + 1]; // index 1-based
            int present = 0, absent = 0, Unexcused = 0, Excused = 0;

            foreach (var row in rows)
            {
                int day = Convert.ToInt32(row["DayOfMonth"]);
                string status = row["Status"].ToString();
                dayStatus[day] = status;

                if (status == "P") present++;
                else if (status == "A") absent++;
                else if (status == "U") Unexcused++;
                else if (status == "E") Excused++;
            }

            sb.Append("<tr class='text-center border-2 border-gray-600'>");
            sb.Append(string.Format("<td class='border p-1'>{0}</td>", rollNo));
            sb.Append(string.Format("<td class='border p-1 text-left'>{0}</td>", name));



            for (int i = 1; i <= daysInMonth; i++)
            {
                string st = dayStatus[i];
                string boxClass = "";
                string textColor = "";

                // Determine styling based on status
                switch (st)
                {
                    case "P": // Present
                        boxClass = "border-green-500 bg-green-100";
                        textColor = "text-green-600";
                        break;
                    case "A": // Absent
                        boxClass = "border-red-500 bg-red-100";
                        textColor = "text-red-600";
                        break;
                    case "U": // Unauthorized Leave
                        boxClass = "border-blue-500 bg-blue-100";
                        textColor = "text-blue-600";
                        break;
                    case "E": // Early Departure
                        boxClass = "border-yellow-500 bg-yellow-100";
                        textColor = "text-yellow-600";
                        break;
                    default: // No data or other status
                        boxClass = "border-gray-300";
                        textColor = "text-gray-500";
                        break;
                }

                string circle = !string.IsNullOrEmpty(st)
                ? string.Format("<div class='w-6 h-6 rounded-full mx-auto flex items-center justify-center border-2 {0} {1}'>{2}</div>", boxClass, textColor, st)
                : "<div class='w-6 h-6 mx-auto'></div>";

                sb.Append(string.Format("<td class='p-1'>{0}</td>", circle));

            }

            sb.Append(string.Format("<td class='text-green-600 font-semibold border'>{0}</td>", present));
            sb.Append(string.Format("<td class='text-red-400 font-semibold border'>{0}</td>", absent));
            sb.Append(string.Format("<td class='text-blue-600 font-semibold border'>{0}</td>", Unexcused));
            sb.Append(string.Format("<td class='text-yellow-600 font-semibold border'>{0}</td>", Excused));

            sb.Append("</tr>");
        }

        sb.Append("</tbody></table>");
        return sb.ToString();
    }
    protected void btnExport_Click(object sender, EventArgs e)
    {
        Response.Clear();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", "attachment;filename=AttendanceReport.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-excel";

        StringWriter sw = new StringWriter();
        HtmlTextWriter hw = new HtmlTextWriter(sw);

        sw.Write(litAttendanceTable.Text);  // Literal content export

        Response.Output.Write(sw.ToString());
        Response.Flush();
        Response.End();
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        lblMessage.Text = "✔️ Save feature not implemented yet.";
    }

    protected void txtYear_TextChanged(object sender, EventArgs e)
    {
        LoadAttendance();
    }

    protected void ddlMonth_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadAttendance();
    }

    protected void ddlCourse_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadAttendance();
    }

    protected void txtSearch_TextChanged(object sender, EventArgs e)
    {
        LoadAttendance();
    }
}