<%@ Page Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true" CodeFile="Certificate_Print.aspx.cs" Inherits="Admin_Certificate_Print" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

<style>

body{
margin:0;
background:#d7e3e6;
font-family:'Times New Roman';
}

/* certificate container */

.certificate{
width:1000px;
height:900px;
background:#fff;
margin:20px auto;
position:relative;
overflow:hidden;
}

/* top wave */

.top-wave{
position:absolute;
top:0;
left:0;
width:100%;
height:110px;
}

/* bottom wave */

.bottom-wave{
position:absolute;
bottom:0;
left:0;
width:100%;
height:120px;
}

/* institute logo */

.logo{
position:absolute;
top:60px;
left:70px;
}

.logo img{
height:120px;
width:200px;
}

/* ISO text */

.iso{
position:absolute;
top:145px;
left:70px;
font-size:18px;
color:#444;
}

/* student photo */

.photo{
position:absolute;
top:190px;
left:90px;
width:140px;
height:160px;
border:3px solid #444;
background:#fff;
}

.photo img{
width:100%;
height:100%;
object-fit:cover;
}

/* certificate heading */

.title{
position:absolute;
top:200px;
left:390px;
font-size:42px;
letter-spacing:3px;
font-weight:bold;
color:#1c2c4c;
}

.subtitle{
position:absolute;
top:250px;
left:455px;
font-size:16px;
color:#555;
}

/* student name */

.student{
position:absolute;
top:275px;
left:360px;
font-size:42px;
font-weight:bold;
color:#2b2b2b;
}

/* divider */

.line{
position:absolute;
top:360px;
left:90px;
width:820px;
height:2px;
background:#444;
}

/* certificate paragraph */

.text{
position:absolute;
top:370px;
left:90px;
width:820px;
font-size:20px;
line-height:34px;
color:#333;
}

/* bottom logos */

.bottomlogos{
position:absolute;
bottom:150px;
left:90px;
}

.bottomlogos img{
height:75px;
margin-right:15px;
}

/* institute name */

.institute{
position:absolute;
bottom:150px;
right:140px;
text-align:center;
font-size:24px;
color:red;
}

.institute span{
font-size:20px;
color:#000;
}

/* marks system */

.marks{
position:absolute;
bottom:95px;
width:100%;
text-align:center;
font-size:14px;
color:red;
}

/* print button */

.print-btn{
text-align:center;
margin-top:25px;
}

@media print {

body *{
visibility:hidden;
}

.certificate,
.certificate *{
visibility:visible;
}

.certificate{
position:absolute;
left:0;
top:0;
width:1000px;
height:700px;
margin:0;
}

.print-btn{
display:none;
}

}
</style>

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


<div class="certificate">

<!-- TOP WAVE -->

<svg class="top-wave" viewBox="0 0 1440 150">

<path fill="black"
d="M0,0 L1440,0 L1440,80 C1100,120 900,40 600,70 C350,100 200,80 0,60 Z"></path>

<path fill="red"
d="M0,60 C200,80 350,100 600,70 C900,40 1100,120 1440,80 L1440,95 C1100,140 900,60 600,90 C350,120 200,100 0,80 Z"></path>

</svg>

<!-- LOGO -->

<div class="logo">
<img src="../Images/institutelogo.png">
</div>

<div class="iso">
An ISO 9001:2015 Certified Company
</div>

<!-- PHOTO -->

<div class="photo">
<asp:Image ID="imgPhoto" runat="server"/>
</div>

<!-- TITLE -->

<div class="title">CERTIFICATE</div>

<div class="subtitle">PROUDLY PRESENTED TO</div>

<div class="student">
<asp:Label ID="lblStudentName" runat="server"></asp:Label>
</div>

<!-- LINE -->

<div class="line"></div>

<!-- TEXT -->

<div class="text">

This is to certify that <b><asp:Label ID="lblStudentName2" runat="server"></asp:Label></b>
son of <b><asp:Label ID="lblFatherName" runat="server"></asp:Label></b>

(D.O.B <asp:Label ID="lblDOB" runat="server"></asp:Label>)
<b>Reg. No. <asp:Label ID="lblRegNo" runat="server"></asp:Label></b>

Has successfully completed

<b><asp:Label ID="lblCourseName" runat="server"></asp:Label></b>

with grade <b>"<asp:Label ID="lblGrade" runat="server"></asp:Label>"</b>

Given under our hand and issue on <b><asp:Label ID="lblIssueDate" runat="server"></asp:Label></b>

at Ahmedabad (Gujarat) India.

</div>

<!-- MSME + ISO -->

<div class="bottomlogos">

<img src="../Images/blogo.png">
<img src="../Images/iso.png">

</div>

<!-- INSTITUTE -->

<div class="institute">

MS Technical Institute  
<br>

<span>And Training Centre</span>

</div>

<!-- MARKS -->

<div class="marks">

Marks System: Outstanding (>80%) | Excellent (70-79%) | Good (60-69%) | Fair (50-59%)

</div>

<!-- BOTTOM WAVE -->

<svg class="bottom-wave" viewBox="0 0 1440 150">

<path fill="red"
d="M0,70 C200,40 350,60 600,30 C900,0 1100,60 1440,20 L1440,60 L0,60 Z"></path>

<path fill="black"
d="M0,90 C200,60 350,80 600,50 C900,20 1100,80 1440,40 L1440,150 L0,150 Z"></path>

</svg>

</div>


<div class="print-btn">
<button class="btn btn-primary" onclick="window.print()">Print</button>
</div>


</asp:Content>