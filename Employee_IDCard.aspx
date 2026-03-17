<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true" CodeFile="Employee_IDCard.aspx.cs" Inherits="Admin_Employee_IDCard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

<style>

.id-container{
display:flex;
justify-content:center;
margin-top:30px;
}

.id-card{
width:380px;
height:330px;
background:#f4f4f7;
border-radius:10px;
overflow:hidden;
box-shadow:0 10px 25px rgba(0,0,0,0.25);
position:relative;
font-family:Arial;
}

/* HEADER WAVE */

.header{
position:absolute;
top:0;
width:100%;
z-index:1;
}

/* FOOTER WAVE */

.footer-wave{
position:absolute;
bottom:0;
width:100%;
z-index:1;
}

/* LOGO */

.logo-box{
text-align:center;
margin-top:10px;
position:relative;
z-index:2;
}

.logo{
width:140px;
 height:60px;
}

/* INSTITUTE NAME */

.inst-name{
text-align:center;
font-weight:bold;
font-size:14px;
color:#6a11cb;
margin-top:3px;
position:relative;
z-index:2;
}

/* BODY */

.body{
display:flex;
padding:10px 20px;
margin-top:15px;
position:relative;
z-index:2;
}

/* PHOTO */

.photo{
width:95px;
height:120px;
border:3px solid #6a11cb;
background:white;
object-fit:cover;
margin-right:15px;
border-radius:5px;
}

/* DETAILS */

.details{
font-size:14px;
line-height:20px;
display:grid;
grid-template-columns:110px auto;
column-gap:1.5px;
row-gap:1px;
}

.details b{
display:inline-block;
width:100px;
}

/* FOOTER TEXT */

.footer-text{
position:absolute;
color:black;
bottom:12px;
width:100%;
text-align:center;
font-weight:800;
font-size:14px;
z-index:2;
}

/* PRINT */

@media print{

body *{
visibility:hidden;
}

.id-card, .id-card *{
visibility:visible;
}

.id-card{
position:absolute;
left:0;
top:0;
}

.print-btn{
display:none;
}

}

.print-btn{
text-align:center;
margin-top:25px;
}

</style>

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="id-container">

<div class="id-card">

<!-- HEADER WAVE -->

<div class="header">

<svg viewBox="0 0 500 120" width="100%" height="90">

<path d="M0,0 L500,0 L500,40 C350,90 150,90 0,40 Z" fill="black"></path>

<path d="M0,25 C150,100 350,100 500,25 L500,60 L0,60 Z" fill="#7b2cbf"></path>

</svg>

</div>


<!-- LOGO -->

<div class="logo-box">

<img src="../Images/Institutelogo1.png" class="logo"/>

</div>

<div class="inst-name">
MS Technical Institute & Training Centre
</div>


<!-- BODY -->

<div class="body">

<asp:Image ID="imgPhoto" runat="server" CssClass="photo" />

<div class="details">

<div><b>ID :</b></div>
<div><asp:Label ID="lblEmployeeId" runat="server"></asp:Label></div>

<div><b>Name :</b></div>
<div><asp:Label ID="lblName" runat="server"></asp:Label></div>

<div><b>Department :</b></div>
<div><asp:Label ID="lblDepartment" runat="server"></asp:Label></div>

<div><b>Designation :</b></div>
<div><asp:Label ID="lblDesignation" runat="server"></asp:Label></div>

<div><b>Mobile :</b></div>
<div><asp:Label ID="lblMobile" runat="server"></asp:Label></div>

</div>

</div>


<!-- FOOTER WAVE -->

<div class="footer-wave">

<svg viewBox="0 0 500 120" width="100%" height="90">

<path d="M0,80 C150,20 350,20 500,80 L500,120 L0,120 Z" fill="black"></path>

<path d="M0,95 C150,40 350,40 500,95 L500,120 L0,120 Z" fill="#7b2cbf"></path>

</svg>

</div>


<div class="footer-text">
Authorized Staff
</div>

</div>

</div>


<div class="print-btn">
<button class="btn btn-primary" onclick="window.print()">Print ID Card</button>
</div>

</asp:Content>