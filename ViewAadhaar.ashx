<%@ WebHandler Language="C#" Class="ViewAadhaar" %>

using System;
using System.IO;
using System.Web;

public class ViewAadhaar : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {
        try
        {
            string fileName = context.Request.QueryString["file"];

            if (string.IsNullOrEmpty(fileName))
            {
                context.Response.Write("File not found.");
                return;
            }

            if (fileName.Contains(".."))
            {
                context.Response.Write("Invalid file request.");
                return;
            }

            string filePath = context.Server.MapPath("~/UserLogin_Content/upload/AadhaarFile/" + fileName);

            if (!File.Exists(filePath))
            {
                context.Response.Write("File does not exist.");
                return;
            }

            context.Response.Clear();
            context.Response.ContentType = MimeMapping.GetMimeMapping(filePath);
            context.Response.AddHeader("Content-Disposition", "inline; filename=" + fileName);
            context.Response.TransmitFile(filePath);
            context.Response.End();
        }
        catch (Exception ex)
        {
            context.Response.Write("Error: " + ex.Message);
        }
    }

    public bool IsReusable
    {
        get { return false; }
    }
}