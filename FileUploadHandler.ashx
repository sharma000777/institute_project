<%@ WebHandler Language="C#" Class="FileUploadHandler" %>


using System;
using System.IO;
using System.Web;

public class FileUploadHandler : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {
        try
        {
            if (context.Request.Files.Count == 0)
            {
                context.Response.Write("ERROR: No file received");
                return;
            }

            HttpPostedFile file = context.Request.Files[0];

            string extension = Path.GetExtension(file.FileName).ToLower();

            // ✅ Allowed file types
            string[] allowedExtensions = { ".jpg", ".jpeg", ".png", ".pdf" };

            if (Array.IndexOf(allowedExtensions, extension) < 0)
            {
                context.Response.Write("ERROR: Invalid file type");
                return;
            }

            // ✅ Generate unique file name
            string newFileName = Guid.NewGuid().ToString() + extension;

            // ✅ Detect which file is coming (Photo or Aadhaar)
            string uploadFolder = "";

            if (context.Request.Files.AllKeys[0] == "aadhaarFile")
            {
                uploadFolder = context.Server.MapPath("~/UserLogin_Content/upload/AadhaarFile" );
            }
            else
            {
                uploadFolder = context.Server.MapPath("~/UserLogin_Content/upload/");
            }

            // ✅ Create directory if not exists
            if (!Directory.Exists(uploadFolder))
                Directory.CreateDirectory(uploadFolder);

            string fullPath = Path.Combine(uploadFolder, newFileName);

            file.SaveAs(fullPath);

            // ✅ Return saved filename to JS
            context.Response.ContentType = "text/plain";
            context.Response.Write(newFileName);
        }
        catch (Exception ex)
        {
            context.Response.Write("ERROR: " + ex.Message);
        }
    }

    public bool IsReusable
    {
        get { return false; }
    }
}


//using System;
//using System.Web;

//public class FileUploadHandler : IHttpHandler {

//    public void ProcessRequest (HttpContext context) 
//    {
//       if (context.Request.Files.Count > 0)    
//        {    
//            HttpFileCollection files = context.Request.Files;    
//            for (int i = 0; i < files.Count; i++)    
//            {    
//                HttpPostedFile file = files[i];  
//                string fname = context.Server.MapPath("~/UserLogin_Content/upload/" + file.FileName);    
//                file.SaveAs(fname);    
//            }    
//            context.Response.ContentType = "text/plain";    
//            context.Response.Write("File Uploaded Successfully!");    
//        }    
//    }

//    public bool IsReusable  
//    {    
//        get   
//        {    
//            return false;    
//        }    
//    }  

//}

//using System;
//using System.Web;
//using System.IO;

//public class FileUploadHandler : IHttpHandler {

//    public void ProcessRequest(HttpContext context)
//    {
//        try
//        {
//            HttpPostedFile file = context.Request.Files["file"];
//            if (file != null && file.ContentLength > 0)
//            {
//                string uploadsFolder = context.Server.MapPath("../UserLogin_Content/upload");
//                if (!Directory.Exists(uploadsFolder))
//                {
//                    Directory.CreateDirectory(uploadsFolder);
//                }

//                string filePath = Path.Combine(uploadsFolder, Path.GetFileName(file.FileName));
//                file.SaveAs(filePath);
//                context.Response.ContentType = "application/json";
//                context.Response.Write("{\"status\":\"success\", \"filePath\":\"" + filePath + "\"}");
//            }
//            else
//            {
//                context.Response.ContentType = "application/json";
//                context.Response.Write("{\"status\":\"error\", \"message\":\"No file uploaded.\"}");
//            }
//        }
//        catch (Exception ex)
//        {
//            context.Response.ContentType = "application/json";
//            context.Response.Write("{\"status\":\"error\", \"message\":\"" + ex.Message + "\"}");
//        }
//    }

//    public bool IsReusable
//    {
//        get { return false; }
//    }

//}