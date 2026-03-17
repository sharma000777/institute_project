using System;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using OfficeOpenXml;

public partial class Admin_Import_Student : System.Web.UI.Page
{

    string connStr = ConfigurationManager.ConnectionStrings["hms3"].ConnectionString;

    protected void btnImport_Click(object sender, EventArgs e)
    {

        if (!FileUpload1.HasFile)
        {
            lblMessage.Text = "Please select Excel file";
            return;
        }

        string filePath = Server.MapPath("~/Uploads/" + FileUpload1.FileName);

        FileUpload1.SaveAs(filePath);

        ExcelPackage.LicenseContext = LicenseContext.NonCommercial;

        int success = 0;
        int errors = 0;

        using (ExcelPackage package = new ExcelPackage(new FileInfo(filePath)))
        {

            var sheet = package.Workbook.Worksheets[0];

            int rows = sheet.Dimension.Rows;

            using (SqlConnection con = new SqlConnection(connStr))
            {

                con.Open();

                for (int i = 2; i <= rows; i++)
                {

                    try
                    {

                        string studentName = sheet.Cells[i, 1].Text.Trim();
                        string mobile = sheet.Cells[i, 2].Text.Trim();
                        string gender = sheet.Cells[i, 3].Text.Trim();
                        string email = sheet.Cells[i, 4].Text.Trim();
                        string courseName = sheet.Cells[i, 14].Text.Trim();
                        string batchName = sheet.Cells[i, 15].Text.Trim();

                        int courseId = GetCourseId(con, courseName);

                        if (courseId == 0)
                        {
                            errors++;
                            continue;
                        }

                        int batchId = GetBatchId(con, batchName, courseId);

                        if (batchId == 0)
                        {
                            errors++;
                            continue;
                        }

                        string studentId = GenerateStudentId();

                        SqlCommand cmd = new SqlCommand(@"

INSERT INTO Student_Admission
(StudentId,StudentName,Mobile,Gender,Email,CourseId,Status,Date)

VALUES
(@StudentId,@StudentName,@Mobile,@Gender,@Email,@CourseId,'Active',GETDATE())

", con);

                        cmd.Parameters.AddWithValue("@StudentId", studentId);
                        cmd.Parameters.AddWithValue("@StudentName", studentName);
                        cmd.Parameters.AddWithValue("@Mobile", mobile);
                        cmd.Parameters.AddWithValue("@Gender", gender);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@CourseId", courseId);

                        cmd.ExecuteNonQuery();


                        SqlCommand cmdBatch = new SqlCommand(@"

INSERT INTO Student_Batch
(StudentId,BatchId,Date)

VALUES
(@StudentId,@BatchId,GETDATE())

", con);

                        cmdBatch.Parameters.AddWithValue("@StudentId", studentId);
                        cmdBatch.Parameters.AddWithValue("@BatchId", batchId);

                        cmdBatch.ExecuteNonQuery();

                        success++;

                    }

                    catch
                    {
                        errors++;
                    }

                }

            }

        }

        lblMessage.Text = "Import Completed | Success : " + success + " | Errors : " + errors;

    }


    string GenerateStudentId()
    {
        return "STU" + DateTime.Now.Ticks.ToString().Substring(10);
    }


    int GetCourseId(SqlConnection con, string courseName)
    {

        SqlCommand cmd = new SqlCommand(
        "SELECT TOP 1 Id FROM Course_Master WHERE LOWER(Course_Name)=LOWER(@Name)", con);

        cmd.Parameters.AddWithValue("@Name", courseName);

        object result = cmd.ExecuteScalar();

        if (result == null)
            return 0;

        return Convert.ToInt32(result);

    }


    int GetBatchId(SqlConnection con, string batchName, int courseId)
    {

        SqlCommand cmd = new SqlCommand(
        "SELECT TOP 1 Id FROM Batch_Master WHERE LOWER(BatchName)=LOWER(@Name) AND CourseId=@CourseId", con);

        cmd.Parameters.AddWithValue("@Name", batchName);
        cmd.Parameters.AddWithValue("@CourseId", courseId);

        object result = cmd.ExecuteScalar();

        if (result == null)
            return 0;

        return Convert.ToInt32(result);

    }

}