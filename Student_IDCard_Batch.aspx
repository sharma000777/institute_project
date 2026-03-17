<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true" CodeFile="Student_IDCard_Batch.aspx.cs" Inherits="Admin_Student_IDCard_Batch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

<style>

.cards-container{
display:flex;
flex-wrap:wrap;
gap:25px;
justify-content:center;
margin-top:20px;
}

.id-card{

width:380px;
height:300px;
background:#f2f2f2;
border-radius:8px;
overflow:hidden;
box-shadow:0 10px 25px rgba(0,0,0,0.3);
position:relative;

}

.header{
position:absolute;
top:0;
width:100%;
z-index:1;
}

.footer{
position:absolute;
bottom:0;
width:100%;
z-index:1;
}

.logo-box{
text-align:center;
margin-top:15px;
z-index:2;
position:relative;
}

.logo{
width:110px;
}

.inst-name{
text-align:center;
font-weight:bold;
font-size:14px;
color:#c40000;
margin-top:3px;
z-index:2;
position:relative;
}

.body{
display:flex;
padding:10px 20px;
margin-top:15px;
position:relative;
z-index:2;
}

.photo{
width:85px;
height:100px;
border:3px solid #ddd;
background:white;
object-fit:cover;
margin-right:15px;
}

.details{
font-size:14px;
line-height:24px;
}

.print-btn{
text-align:center;
margin-top:25px;
}

@media print{

.print-btn{
display:none;
}

}

@media print{

/* Page setup */

@page{
margin:0;
}

/* Hide everything */

body *{
visibility:hidden;
}

/* Show only ID cards */

.cards-container,
.cards-container *{
visibility:visible;
}

/* Position cards for print */

.cards-container{
position:absolute;
top:0;
left:0;
width:100%;
}

/* Remove shadows for print */

.id-card{
box-shadow:none;
}

/* Hide print button */

.print-btn{
display:none;
}

}

</style>

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="print-btn">
<button class="btn btn-primary" onclick="window.print()">Print All ID Cards</button>
</div>


<div class="cards-container">

<asp:Repeater ID="rptStudents" runat="server">

<ItemTemplate>

<div class="id-card">

<div class="header">

<svg viewBox="0 0 500 120" width="100%" height="90">

<path d="M0,0 L500,0 L500,40 C350,90 150,90 0,40 Z" fill="black"></path>
<path d="M0,25 C150,100 350,100 500,25 L500,60 L0,60 Z" fill="#d40000"></path>

</svg>

</div>


<div class="logo-box">

<img src="../Images/Institutelogo1.png" class="logo"/>

</div>

<div class="inst-name">
MS Technical Institute & Training Centre
</div>


<div class="body">

<img src='<%# ResolveUrl("~/UserLogin_Content/upload/") + (Eval("Photo") == DBNull.Value ? "noimage.png" : Eval("Photo")) %>' class="photo"/>

<div class="details">

<b>ID :</b> <%# Eval("StudentId") %> <br/>

<b>Name :</b> <%# Eval("StudentName") %> <br/>

<b>Course :</b> <%# Eval("Course_Name") %> <br/>

<b>Mobile :</b> <%# Eval("Mobile") %>

</div>

</div>


<div class="footer">

<svg viewBox="0 0 500 120" width="100%" height="90">

<path d="M0,80 C150,20 350,20 500,80 L500,120 L0,120 Z" fill="black"></path>
<path d="M0,95 C150,40 350,40 500,95 L500,120 L0,120 Z" fill="#d40000"></path>

</svg>

</div>

</div>

</ItemTemplate>

</asp:Repeater>

</div>

</asp:Content>