using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Globalization;
using System.Linq.Dynamic;
using System.Dynamic;
using System.Web.Services;
using System.Web.Script.Services;
using Newtonsoft.Json;

public partial class Admin_PrintInvoice : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
    SqlComan5 cls = new SqlComan5();
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string Get_InvoiceDetail(string InvoiceNo, string Mobile, string PayMode)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
        SqlCommand cmd;
        if (PayMode == "Installment")
            cmd = new SqlCommand("select pi.InvoiceNo,FORMAT(pi.Date, 'dd-MMM-yyyy') AS Date,sa.RollNo,bm.BatchName,bm.BatchStartTime,bm.BatchEndTime,sa.StudentName,pi.Installment_No,sf.PaymentMode,pi.PaymentMethod,di.Installment_Amount,FORMAT(di.Dues_Date, 'dd-MMM-yyyy') AS Dues_Date,pi.Paid_Amount,cm.Course_Name from Student_Admission sa inner join Paid_Installment pi on sa.StudentId = pi.StudentId inner join Dues_Installment di on sa.StudentId = di.StudentId inner join Student_Fee sf on sa.StudentId = sf.StudentId inner join Student_Batch sb on sa.StudentId = sb.StudentId inner join Batch_Master bm on sb.BatchId = bm.Id inner join Course_Master cm on sa.CourseId = cm.Id where sa.Mobile='" + Mobile + "' and pi.InvoiceNo='" + InvoiceNo + "'", con);
        else
            cmd = new SqlCommand("select sf.InvoiceNo,FORMAT(sf.Date, 'dd-MMM-yyyy') AS Date,sa.RollNo,bm.BatchName,bm.BatchStartTime,bm.BatchEndTime,sa.StudentName,'No Installment' as Installment_No,sf.PaymentMode,sf.PaymentMethod,'No Dues' AS Dues_Date,sf.PaidAmount as Paid_Amount,cm.Course_Name from Student_Admission sa inner join Student_Fee sf on sa.StudentId = sf.StudentId inner join Student_Batch sb on sa.StudentId = sb.StudentId inner join Batch_Master bm on sb.BatchId = bm.Id inner join Course_Master cm on sa.CourseId = cm.Id where sa.Mobile='" + Mobile + "' and sf.InvoiceNo='" + InvoiceNo + "'", con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            string json = JsonConvert.SerializeObject(dt);

            return json;
        }
        else
        {
            string json = JsonConvert.SerializeObject(dt);

            return json;
        }
    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string Get_Institute()
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["hms3"].ConnectionString);
        SqlCommand cmd = new SqlCommand("Select * from Institute_Master", con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            string json = JsonConvert.SerializeObject(dt);

            return json;
        }
        else
        {
            string json = JsonConvert.SerializeObject(dt);

            return json;
        }
    }
}