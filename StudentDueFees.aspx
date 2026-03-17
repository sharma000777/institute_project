<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true" CodeFile="StudentDueFees.aspx.cs" Inherits="Admin_StudentDueFees" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

<style>

.title{
font-size:26px;
font-weight:bold;
margin-bottom:20px;
}

.btn{
padding:8px 15px;
background:#007bff;
color:white;
border:none;
margin-right:10px;
cursor:pointer;
}

.grid{
margin-top:20px;
}

</style>

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="title">
Student Due Fees Report
</div>

<asp:Button ID="btnExcel" runat="server" CssClass="btn"
Text="Download Excel"
OnClick="btnExcel_Click" />

<asp:Button ID="btnPDF" runat="server" CssClass="btn"
Text="Download PDF"
OnClick="btnPDF_Click" />

<div class="grid">

<asp:GridView ID="gvDueFees" runat="server"
AutoGenerateColumns="false"
Width="100%"
BorderWidth="1"
CellPadding="5">

<Columns>

<asp:BoundField DataField="RollNo" HeaderText="Roll No"/>

<asp:BoundField DataField="StudentName" HeaderText="Student Name"/>

<asp:BoundField DataField="Course" HeaderText="Course"/>

<asp:BoundField DataField="Batch" HeaderText="Batch"/>

<asp:BoundField DataField="TotalAmount" HeaderText="Total Fee"/>

<asp:BoundField DataField="PaidAmount" HeaderText="Paid"/>

<asp:BoundField DataField="DuesAmount" HeaderText="Due"/>

</Columns>

</asp:GridView>

</div>

</asp:Content>
