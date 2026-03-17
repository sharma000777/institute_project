using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using OfficeOpenXml;
using OfficeOpenXml.Drawing;

public partial class Admin_Import_Student : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(
    System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);

    protected void btnUpload_Click(object sender, EventArgs e)
    {
        if (FileUpload1.HasFile)
        {
            string path = Server.MapPath("~/Excel/");
            if (!Directory.Exists(path))
                Directory.CreateDirectory(path);

            string filePath = path + FileUpload1.FileName;

            FileUpload1.SaveAs(filePath);

            ImportExcel(filePath);
        }
    }

    void ImportExcel(string filePath)
    {
        using (ExcelPackage package = new ExcelPackage(new FileInfo(filePath)))
        {
            ExcelWorksheet ws = package.Workbook.Worksheets[0];
            int rowCount = ws.Dimension.Rows;

            con.Open();

            for (int row = 2; row <= rowCount; row++)
            {
                string StudentName = ws.Cells[row, 1].Text;
                string Mobile = ws.Cells[row, 2].Text;
                string Gender = ws.Cells[row, 3].Text;
                string Email = ws.Cells[row, 4].Text;
                string DOB = ws.Cells[row, 5].Text;
                string FatherName = ws.Cells[row, 6].Text;
                string FatherOccupation = ws.Cells[row, 7].Text;
                string FatherContact = ws.Cells[row, 8].Text;
                string MotherName = ws.Cells[row, 9].Text;
                string State = ws.Cells[row, 10].Text;
                string City = ws.Cells[row, 11].Text;
                string Pincode = ws.Cells[row, 12].Text;
                string Address = ws.Cells[row, 13].Text;
                string CourseName = ws.Cells[row, 14].Text;

                string CourseId = GetCourseId(con, CourseName);

                string photoFileName = "";
                string aadhaarFileName = "";

                // =============================
                // Extract Drawings (Photo/PDF)
                // =============================

                foreach (var drawing in ws.Drawings)
                {
                    int picRow = drawing.From.Row + 1;

                    if (picRow == row)
                    {
                        ExcelPicture pic = drawing as ExcelPicture;

                        if (pic != null)
                        {
                            
                            photoFileName = Guid.NewGuid().ToString() + ".jpg";

                            string photoPath = Server.MapPath("~/UserLogin_Content/upload/" + photoFileName);

                            File.WriteAllBytes(photoPath, pic.Image.ImageBytes);
                        }
                    }
                }

                // ==================================
                // Duplicate Check
                // ==================================

                SqlCommand check = new SqlCommand(
                "SELECT COUNT(*) FROM Student_Admission WHERE Mobile=@Mobile", con);

                check.Parameters.AddWithValue("@Mobile", Mobile);

                int exists = (int)check.ExecuteScalar();

                if (exists == 0)
                {
                    string studentId = GetStudentId(con);
                    string admissionNo = GetAdmissionNo(con);
                    string rollNo = GetRollNo(con);

                    SqlCommand cmd = new SqlCommand(@"

INSERT INTO Student_Admission
(
StudentId,AdmissionNo,RollNo,StudentName,Mobile,
Gender,Email,DOB,FatherName,FatherOccupation,
FatherContactNo,MotherName,State,City,Pincode,
Address,Photo,CourseId,Status,Date,
AdmissionType,ProcessedBy,AadhaarFile
)

VALUES
(
@StudentId,@AdmissionNo,@RollNo,@StudentName,@Mobile,
@Gender,@Email,@DOB,@FatherName,@FatherOccupation,
@FatherContactNo,@MotherName,@State,@City,@Pincode,
@Address,@Photo,@CourseId,'Active',GETDATE(),
'Excel','Admin',@AadhaarFile
)", con);

                    cmd.Parameters.AddWithValue("@StudentId", studentId);
                    cmd.Parameters.AddWithValue("@AdmissionNo", admissionNo);
                    cmd.Parameters.AddWithValue("@RollNo", rollNo);
                    cmd.Parameters.AddWithValue("@StudentName", StudentName);
                    cmd.Parameters.AddWithValue("@Mobile", Mobile);
                    cmd.Parameters.AddWithValue("@Gender", Gender);
                    cmd.Parameters.AddWithValue("@Email", Email);
                    cmd.Parameters.AddWithValue("@DOB", DOB);
                    cmd.Parameters.AddWithValue("@FatherName", FatherName);
                    cmd.Parameters.AddWithValue("@FatherOccupation", FatherOccupation);
                    cmd.Parameters.AddWithValue("@FatherContactNo", FatherContact);
                    cmd.Parameters.AddWithValue("@MotherName", MotherName);
                    cmd.Parameters.AddWithValue("@State", State);
                    cmd.Parameters.AddWithValue("@City", City);
                    cmd.Parameters.AddWithValue("@Pincode", Pincode);
                    cmd.Parameters.AddWithValue("@Address", Address);
                    cmd.Parameters.AddWithValue("@Photo", photoFileName);
                    cmd.Parameters.AddWithValue("@CourseId", CourseId);
                    cmd.Parameters.AddWithValue("@AadhaarFile", aadhaarFileName);

                    cmd.ExecuteNonQuery();
                }
            }

            con.Close();

            lblMessage.Text = "Students Imported Successfully!";
        }
    }

    string GetStudentId(SqlConnection con)
    {
        SqlCommand cmd = new SqlCommand(
        "select isnull(max(cast(Id as int)),0)+1 from Student_Admission", con);

        int id = (int)cmd.ExecuteScalar();
        return "STU" + id;
    }

    string GetAdmissionNo(SqlConnection con)
    {
        SqlCommand cmd = new SqlCommand(
        "select isnull(max(cast(Id as int)),0)+1 from Student_Admission", con);

        int id = (int)cmd.ExecuteScalar();
        return "ADM" + id;
    }

    string GetRollNo(SqlConnection con)
    {
        SqlCommand cmd = new SqlCommand(
        "select isnull(max(cast(RollNo as int)),0)+1 from Student_Admission", con);

        int id = (int)cmd.ExecuteScalar();
        return id.ToString();
    }

    string GetCourseId(SqlConnection con, string courseName)
    {
        SqlCommand cmd = new SqlCommand(
        "SELECT Id FROM Course_Master WHERE Course_Name=@CourseName", con);

        cmd.Parameters.AddWithValue("@CourseName", courseName);

        object result = cmd.ExecuteScalar();

        if (result != null)
            return result.ToString();
        else
            return "";
    }
}