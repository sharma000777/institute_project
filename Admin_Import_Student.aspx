<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master"
AutoEventWireup="true" CodeFile="Admin_Import_Student.aspx.cs"
Inherits="Admin_Import_Student" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="container">

<h3>Import Students From Excel</h3>

<asp:FileUpload ID="FileUpload1" runat="server" CssClass="form-control" />

<br />

<asp:Button
ID="btnImport"
runat="server"
Text="Import Students"
CssClass="btn btn-success"
OnClick="btnImport_Click" />

<br /><br />

<asp:Label ID="lblMessage" runat="server" CssClass="alert alert-info"></asp:Label>

</div>

</asp:Content>