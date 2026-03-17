<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true" CodeFile="Student_IDCard.aspx.cs" Inherits="Admin_Student_IDCard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

<style>

.id-container{
display:flex;
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

/* HEADER */

.header{
position:absolute;
top:0;
width:100%;
z-index:1;
}

/* FOOTER */

.footer{
position:absolute;
bottom:0;
width:100%;

z-index:1;
}

/* LOGO */

.logo-box{
text-align:center;
margin-top:15px;
z-index:2;
position:relative;
}

.logo{
width:110px;
}

/* INSTITUTE NAME */

.inst-name{

text-align:center;
font-weight:bold;
font-size:14px;
color:#c40000;
margin-top:3px;
z-index:2;
position:relative;

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

width:85px;
height:100px;
border:3px solid #ddd;
background:white;
object-fit:cover;
margin-right:15px;

}

/* DETAILS */

.details{

font-size:14px;
line-height:24px;

}

.details b{
color:#000;
}

.print-btn{
text-align:center;
margin-top:25px;
}

@media print {

@page{
size:auto;
margin:0;
}

/* Hide whole page */

body *{
visibility:hidden;
}

/* Show only ID card */

.id-card,
.id-card *{
visibility:visible;
}

/* Position ID card for print */

.id-card{
position:absolute;
left:50%;
top:50%;
transform:translate(-50%,-50%);
}

/* Hide print button */

.print-btn{
display:none;
}

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

<path d="M0,25 C150,100 350,100 500,25 L500,60 L0,60 Z" fill="#d40000"></path>

</svg>

</div>


<!-- LOGO -->

<div class="logo-box">

<img src="../Images/Institutelogo1.png" class="logo"/>

</div>

<div class="inst-name">
MS Technical Institute & Training Centre
</div>


<!-- STUDENT BODY -->

<div class="body">

<asp:Image ID="imgPhoto" runat="server" CssClass="photo" />

<div class="details">

<b>ID :</b>
<asp:Label ID="lblStudentId" runat="server"></asp:Label>

<br/>

<b>Name :</b>
<asp:Label ID="lblStudentName" runat="server"></asp:Label>

<br/>

<b>Course :</b>
<asp:Label ID="lblCourse" runat="server"></asp:Label>

<br/>

<b>Mobile :</b>
<asp:Label ID="lblMobile" runat="server"></asp:Label>

</div>

</div>


<!-- FOOTER WAVE -->

<div class="footer">

<svg viewBox="0 0 500 120" width="100%" height="90">

<path d="M0,80 C150,20 350,20 500,80 L500,120 L0,120 Z" fill="black"></path>

<path d="M0,95 C150,40 350,40 500,95 L500,120 L0,120 Z" fill="#d40000"></path>

</svg>

</div>

</div>

</div>


<div class="print-btn">
<button class="btn btn-primary" onclick="window.print()">Print ID Card</button>
</div>

</asp:Content>