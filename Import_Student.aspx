<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master"
AutoEventWireup="true" CodeFile="Import_Student.aspx.cs"
Inherits="Admin_Import_Student" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

<title>Import Students | Institute Management</title>

<style>

.import-card{
    max-width:700px;
    margin:auto;
}

.upload-box{
    border:2px dashed #696cff;
    padding:40px;
    text-align:center;
    border-radius:10px;
    background:#f8f9ff;
}

.upload-box:hover{
    background:#eef0ff;
}

</style>

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="row g-6 mb-6">

<div class="col-md-12">

<div class="card">

<div class="card-header d-flex justify-content-between">

<h5>
<span class="text-muted fw-light">Students Section /</span>
Import Students
</h5>

<a href="Student_Admission.aspx"
class="btn btn-primary">

<i class="ri-arrow-left-line"></i> Back

</a>

</div>


<div class="card-body">

<div class="import-card">

<h4 class="text-center mb-4">
Bulk Student Import
</h4>

<p class="text-center text-muted">

Upload an Excel file to import multiple students at once.

</p>


<div class="alert alert-info">

<b>Instructions:</b>

<ul class="mb-0">

<li>Upload only <b>.xlsx</b> format Excel file</li>

<li>First row must contain column headers</li>

<li>Mobile number must be unique</li>

<li>CourseId must exist in Course Master</li>

</ul>

</div>


<div class="upload-box">

<i class="ri-upload-cloud-2-line"
style="font-size:40px;color:#696cff"></i>

<br /><br />

<asp:FileUpload
ID="FileUpload1"
runat="server"
CssClass="form-control" />

</div>


<div class="text-center mt-4">

<asp:Button
ID="btnUpload"
runat="server"
Text="Upload & Import Students"

CssClass="btn btn-success text-bg-info btn-lg"
OnClick="btnUpload_Click" />

</div>


<div class="text-center mt-3">

<asp:Label
ID="lblMessage"
runat="server"
CssClass="fw-bold text-success"></asp:Label>

</div>




</div>

</div>

</div>

</div>

</div>

</asp:Content>