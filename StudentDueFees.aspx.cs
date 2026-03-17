using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html.simpleparser;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_StudentDueFees : System.Web.UI.Page
{

    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadDueFees();
        }
    }

    void LoadDueFees()
    {

        SqlDataAdapter da = new SqlDataAdapter(@"

SELECT 
SA.RollNo,
SA.StudentName,
C.Course_Name AS Course,
B.BatchName AS Batch,
SF.TotalAmount,
SF.PaidAmount,
SF.DuesAmount

FROM Student_Admission SA

LEFT JOIN Student_Fee SF
ON SA.StudentId = SF.StudentId

LEFT JOIN Student_Batch SB
ON SA.StudentId = SB.StudentId

LEFT JOIN Course_Master C
ON SA.CourseId = C.Id

LEFT JOIN Batch_Master B
ON SB.BatchId = B.Id

WHERE CAST(SF.DuesAmount AS DECIMAL(18,2)) > 0

ORDER BY SA.RollNo

", con);

        DataTable dt = new DataTable();

        da.Fill(dt);

        gvDueFees.DataSource = dt;
        gvDueFees.DataBind();

    }


    protected void btnExcel_Click(object sender, EventArgs e)
    {

        Response.Clear();
        Response.Buffer = true;

        Response.AddHeader("content-disposition",
        "attachment;filename=DueFeesReport.xls");

        Response.ContentType = "application/vnd.ms-excel";

        StringWriter sw = new StringWriter();
        HtmlTextWriter hw = new HtmlTextWriter(sw);

        gvDueFees.RenderControl(hw);

        Response.Write(sw.ToString());
        Response.End();

    }


    protected void btnPDF_Click(object sender, EventArgs e)
    {

        Response.ContentType = "application/pdf";
        Response.AddHeader("content-disposition", "attachment;filename=DueFeesReport.pdf");
        Response.Cache.SetCacheability(HttpCacheability.NoCache);

        Document pdfDoc = new Document(PageSize.A4, 20f, 20f, 20f, 20f);
        PdfWriter.GetInstance(pdfDoc, Response.OutputStream);

        pdfDoc.Open();

        Font titleFont = FontFactory.GetFont("Arial", 16, Font.BOLD);
        Font headerFont = FontFactory.GetFont("Arial", 11, Font.BOLD);
        Font rowFont = FontFactory.GetFont("Arial", 10);

        Paragraph title = new Paragraph("Student Due Fees Report", titleFont);
        title.Alignment = Element.ALIGN_CENTER;
        title.SpacingAfter = 20;
        pdfDoc.Add(title);

        PdfPTable table = new PdfPTable(gvDueFees.Columns.Count);
        table.WidthPercentage = 100;

        // Table Header
        foreach (TableCell cell in gvDueFees.HeaderRow.Cells)
        {
            PdfPCell pdfCell = new PdfPCell(new Phrase(cell.Text, headerFont));
            pdfCell.HorizontalAlignment = Element.ALIGN_CENTER;
            pdfCell.BackgroundColor = new BaseColor(230, 230, 230);
            pdfCell.Padding = 5;
            table.AddCell(pdfCell);
        }

        // Table Rows
        foreach (GridViewRow row in gvDueFees.Rows)
        {
            foreach (TableCell cell in row.Cells)
            {
                PdfPCell pdfCell = new PdfPCell(new Phrase(cell.Text, rowFont));
                pdfCell.HorizontalAlignment = Element.ALIGN_CENTER;
                pdfCell.Padding = 5;
                table.AddCell(pdfCell);
            }
        }

        pdfDoc.Add(table);

        pdfDoc.Close();
        Response.End();

    }


    public override void VerifyRenderingInServerForm(Control control)
    {

    }

}