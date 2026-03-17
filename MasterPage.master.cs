using System;
using System.Web;
using System.Web.UI;

public partial class Admin_MasterPage : System.Web.UI.MasterPage
{

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["LoginId"] == null)
        {
            Response.Redirect("~/UserLogin/Admin_Login.aspx");
            return;
        }

        if (Session["Role"] == null)
        {
            Response.Redirect("~/UserLogin/Admin_Login.aspx");
            return;
        }

        if (!IsPostBack)
        {
            CheckRolePermission();
        }
    }
    private void CheckRolePermission()
    {
        if (Session["Role"] == null)
            return;

        string role = Session["Role"].ToString();

        if (role == "Operator")
        {
            menuMaster.Visible = false;
            menuEmployee.Visible = false;
            menuExpense.Visible = false;

            menuAdmission.Visible = true;
            menuEnquiry.Visible = true;
            menuFollowUp.Visible = true;
            menuDueReport.Visible = true;
        }
    }
    private void ManageRoleAccess()
    {

        if (Session["Role"] == null)
            return;

        string role = Session["Role"].ToString();


        if (role == "Operator")
        {

            // Operator allowed pages

            menuDashboard.Visible = true;
            menuAdmission.Visible = true;
            menuEnquiry.Visible = true;
            menuFollowUp.Visible = true;
            menuDueReport.Visible = true;


            // Restricted menus

            menuExpense.Visible = false;
            menuEmployee.Visible = false;

        }

        else if (role == "Admin")
        {

            // Admin full access

            menuDashboard.Visible = true;
            menuAdmission.Visible = true;
            menuEnquiry.Visible = true;
            menuFollowUp.Visible = true;
            menuDueReport.Visible = true;
            menuExpense.Visible = true;
            menuEmployee.Visible = true;

        }

    }



    protected void BtnLogout_Click(object sender, EventArgs e)
    {

        Session.Clear();
        Session.Abandon();

        if (Request.Cookies["LoginUserAuthCookie"] != null)
        {
            HttpCookie cookie = new HttpCookie("LoginUserAuthCookie");
            cookie.Expires = DateTime.Now.AddDays(-1);
            cookie.Value = "";
            Response.Cookies.Add(cookie);
        }

        Response.Redirect(Page.ResolveClientUrl("~/UserLogin/Admin_Login.aspx"));

    }

}