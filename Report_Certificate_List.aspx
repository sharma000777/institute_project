<%@ Page Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true" CodeFile="Report_Certificate_List.aspx.cs" Inherits="Admin_Report_Certificate_List" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

<div class="card">

<div class="card-header">
<h4>Generated Certificates</h4>
</div>

<div class="card-body">

<table class="table table-bordered">

<thead>

<tr>
<th>Certificate No</th>
<th>Student Name</th>
<th>Course</th>
<th>Issue Date</th>
<th>Print</th>
</tr>

</thead>

<tbody>

<asp:Repeater ID="rptCert" runat="server">

<ItemTemplate>

<tr>

<td><%# Eval("CertificateNo") %></td>

<td><%# Eval("StudentName") %></td>

<td><%# Eval("Course_Name") %></td>

<td><%# Eval("IssueDate") %></td>

<td>

<a href='Certificate_Print.aspx?Mobile=<%# Eval("Mobile") %>' 
class="btn btn-primary">

Print

</a>

</td>

</tr>

</ItemTemplate>

</asp:Repeater>

</tbody>

</table>

</div>

</div>

</asp:Content>