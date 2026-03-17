using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text;
using System.Web.UI;

public partial class Admin_Employee_Attandance : System.Web.UI.Page
{
    string connStr = ConfigurationManager.ConnectionStrings["hms3"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindDepartment();
            BindDesignation();

            txtYear.Text = DateTime.Now.Year.ToString();
            ddlMonth.SelectedValue = DateTime.Now.Month.ToString();

            LoadAttendance();
        }
    }

    // ===============================
    // LOAD DEPARTMENT
    // ===============================
    protected void BindDepartment()
    {
        using (SqlConnection con = new SqlConnection(connStr))
        {
            SqlCommand cmd = new SqlCommand("SELECT Department_Name FROM Department_Master", con);
            con.Open();

            ddlDepartment.DataSource = cmd.ExecuteReader();
            ddlDepartment.DataTextField = "Department_Name";
            ddlDepartment.DataValueField = "Department_Name";
            ddlDepartment.DataBind();
        }

        ddlDepartment.Items.Insert(0, "-- All --");
    }

    // ===============================
    // LOAD DESIGNATION
    // ===============================
    protected void BindDesignation()
    {
        using (SqlConnection con = new SqlConnection(connStr))
        {
            SqlCommand cmd = new SqlCommand("SELECT Designation_Name FROM Designation_Master", con);
            con.Open();

            ddlDesignation.DataSource = cmd.ExecuteReader();
            ddlDesignation.DataTextField = "Designation_Name";
            ddlDesignation.DataValueField = "Designation_Name";
            ddlDesignation.DataBind();
        }

        ddlDesignation.Items.Insert(0, "-- All --");
    }

    // ===============================
    // LOAD ATTENDANCE
    // ===============================
    private void LoadAttendance()
    {
        string department = ddlDepartment.SelectedValue;
        string designation = ddlDesignation.SelectedValue;
        int month = Convert.ToInt32(ddlMonth.SelectedValue);
        int year = Convert.ToInt32(txtYear.Text);
        string search = txtSearch.Text.Trim();

        DataTable dt = new DataTable();

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            StringBuilder query = new StringBuilder(@"
            SELECT 
                EmployeeId,
                EmployeeName,
                Department,
                Designation,
                DAY(AttendanceDate) AS DayOfMonth,
                Status
            FROM Employee_Attendance_View_Monthly
            WHERE MONTH(AttendanceDate)=@Month
            AND YEAR(AttendanceDate)=@Year
            ");

            if (department != "-- All --")
                query.Append(" AND Department=@Department ");

            if (designation != "-- All --")
                query.Append(" AND Designation=@Designation ");

            if (!string.IsNullOrEmpty(search))
                query.Append(" AND (EmployeeName LIKE @Search OR EmployeeId LIKE @Search)");

            SqlCommand cmd = new SqlCommand(query.ToString(), conn);

            cmd.Parameters.AddWithValue("@Month", month);
            cmd.Parameters.AddWithValue("@Year", year);

            if (department != "-- All --")
                cmd.Parameters.AddWithValue("@Department", department);

            if (designation != "-- All --")
                cmd.Parameters.AddWithValue("@Designation", designation);

            if (!string.IsNullOrEmpty(search))
                cmd.Parameters.AddWithValue("@Search", "%" + search + "%");

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
        }

        litAttendanceTable.Text = GenerateTable(dt, month, year);
    }

    // ===============================
    // GENERATE ATTENDANCE TABLE
    // ===============================
    private string GenerateTable(DataTable dt, int month, int year)
    {
        StringBuilder sb = new StringBuilder();

        int daysInMonth = DateTime.DaysInMonth(year, month);

        var employees = dt.DefaultView.ToTable(true, "EmployeeId", "EmployeeName");

        sb.Append("<table class='w-full border text-sm'>");

        sb.Append("<thead><tr class='bg-[#15a3b2] text-white text-center'>");
        sb.Append("<th class='border p-2'>Emp ID</th>");
        sb.Append("<th class='border p-2'>Name</th>");

        for (int i = 1; i <= daysInMonth; i++)
            sb.Append("<th class='border p-1'>" + i + "</th>");

        sb.Append("<th class='border'>P</th>");
        sb.Append("<th class='border'>A</th>");
        sb.Append("<th class='border'>U</th>");
        sb.Append("<th class='border'>E</th>");

        sb.Append("</tr></thead><tbody>");

        foreach (DataRow emp in employees.Rows)
        {
            string id = emp["EmployeeId"].ToString();
            string name = emp["EmployeeName"].ToString();

            var rows = dt.Select("EmployeeId='" + id + "'");

            string[] dayStatus = new string[daysInMonth + 1];

            int p = 0, a = 0, u = 0, e = 0;

            foreach (var r in rows)
            {
                int day = Convert.ToInt32(r["DayOfMonth"]);
                string st = r["Status"].ToString();

                dayStatus[day] = st;

                if (st == "P") p++;
                if (st == "A") a++;
                if (st == "U") u++;
                if (st == "E") e++;
            }

            sb.Append("<tr class='text-center'>");

            sb.Append("<td class='border'>" + id + "</td>");
            sb.Append("<td class='border text-left'>" + name + "</td>");

            for (int i = 1; i <= daysInMonth; i++)
            {
                string st = dayStatus[i];

                if (string.IsNullOrEmpty(st))
                    sb.Append("<td class='border'></td>");
                else
                    sb.Append("<td class='border'>" + st + "</td>");
            }

            sb.Append("<td class='border text-green-600'>" + p + "</td>");
            sb.Append("<td class='border text-red-600'>" + a + "</td>");
            sb.Append("<td class='border text-blue-600'>" + u + "</td>");
            sb.Append("<td class='border text-yellow-600'>" + e + "</td>");

            sb.Append("</tr>");
        }

        sb.Append("</tbody></table>");

        return sb.ToString();
    }

    // ===============================
    // EXPORT
    // ===============================
    protected void btnExport_Click(object sender, EventArgs e)
    {
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=EmployeeAttendance.xls");
        Response.ContentType = "application/vnd.ms-excel";

        Response.Write(litAttendanceTable.Text);
        Response.End();
    }

    protected void ddlDepartment_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadAttendance();
    }

    protected void ddlDesignation_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadAttendance();
    }

    protected void ddlMonth_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadAttendance();
    }

    protected void txtYear_TextChanged(object sender, EventArgs e)
    {
        LoadAttendance();
    }

    protected void txtSearch_TextChanged(object sender, EventArgs e)
    {
        LoadAttendance();
    }
}