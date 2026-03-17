<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Admission_Confirmation_Print.aspx.cs" Inherits="Admin_Admission_Confirmation_Print" %>

<!DOCTYPE html>

<html>
<head runat="server">
<title>Admission Confirmation</title>

<style>

body{
font-family: Arial;
}

.container{
width:800px;
margin:auto;
border:1px solid #000;
padding:30px;
}

.title{
text-align:center;
font-size:26px;
font-weight:bold;
margin-bottom:20px;
}

.section{
margin-top:20px;
}

table{
width:100%;
border-collapse:collapse;
}

table td{
padding:8px;
border:1px solid #ccc;
}

.sign{
margin-top:60px;
display:flex;
justify-content:space-between;
}
ol{
padding-left:18px;
}

ol li{
margin-bottom:6px;
}
</style>

</head>

<body onload="window.print()">

<div class="container">

<div class="title">
ADMISSION CONFIRMATION
</div>

<div class="section">

<table>

<tr>
<td>Student Name</td>
<td><asp:Label ID="lblStudentName" runat="server"/></td>
</tr>

<tr>
<td>Mobile</td>
<td><asp:Label ID="lblMobile" runat="server"/></td>
</tr>

<tr>
<td>Course</td>
<td><asp:Label ID="lblCourse" runat="server"/></td>
</tr>

<tr>
<td>Batch</td>
<td><asp:Label ID="lblBatch" runat="server"/></td>
</tr>

<tr>
<td>Total Fee</td>
<td><asp:Label ID="lblFee" runat="server"/></td>
</tr>

<tr>
<td>Paid Amount</td>
<td><asp:Label ID="lblPaid" runat="server"/></td>
</tr>

<tr>
<td>Due Amount</td>
<td><asp:Label ID="lblDue" runat="server"/></td>
</tr>

</table>

</div>

<div class="section">

<b>Institute Terms & Conditions</b>

<ol style="font-size:13px; line-height:20px; margin-top:10px;">

<li>Admission will be considered valid only after full course fees are paid within the time specified by the institute.</li>

<li>A minimum of 75% attendance is mandatory to be eligible for course completion and certification.</li>

<li>If a student joins the course late or misses classes, the responsibility for covering missed topics will lie solely with the student.</li>

<li>The institute reserves the right to change batch timings, class schedules, syllabus, or faculty whenever required.</li>

<li>Students must strictly follow all rules, instructions, and guidelines given by trainers during classes and practical sessions.</li>

<li>Touching any machine, equipment, tool, or object during class, practical sessions, or live demonstrations without permission is strictly prohibited.</li>

<li>Any injury, accident, or loss caused due to negligence or non-compliance with safety instructions during practical training will be the sole responsibility of the student.</li>

<li>Any damage caused to institute machines, tools, equipment, or property must be fully compensated by the student.</li>

<li>Use of mobile phones, photography, audio recording, or video recording during class hours is strictly prohibited.</li>

<li>Maintaining discipline, proper behavior, and professional conduct within the institute premises is mandatory for all students.</li>

<li>Misbehavior with trainers, staff members, or fellow students may result in cancellation of admission without any fee refund.</li>

<li>The institute will provide complete guidance and support related to jobs and business opportunities; however, job or business placement is not guaranteed for all students.</li>

<li>Admission fees and course fees are non-refundable and non-transferable under any circumstances.</li>

<li>If any information or documents provided by the student are found to be false or incorrect, the admission may be cancelled immediately.</li>

<li>The institute shall not be responsible for the safety of personal belongings such as mobile phones, wallets, books, bags, or documents.</li>

<li>In case of failure in the final test or assessment, re-training or re-test will be conducted as per institute policy and may involve additional charges.</li>

<li>The validity of the admitted course will remain only for the specified duration; no claims will be accepted after expiry of the course period.</li>

<li>After course completion, limited calling support will be provided for technical guidance as per institute policy.</li>

<li>Calling support will not be provided for minor issues, general queries, or repeated unnecessary calls.</li>

<li>Calling support will be available only to students who successfully pass the final test conducted after course completion.</li>

<li>The timing, duration, and scope of calling support will be decided by the institute and must be strictly followed.</li>

<li>The institute will not be responsible for any loss or damage arising from practice or work performed outside the institute premises.</li>

<li>Smoking, consumption of tobacco, alcohol, or any intoxicating substances within the institute premises is strictly prohibited.</li>

<li>The institute reserves full rights over students’ photographs and videos, which may be used for training, promotional, or official purposes.</li>

<li>After course completion, students may visit or contact the institute for clearing doubts within a limited period, as per institute policy.</li>

<li>In case of any dispute, Ahmedabad jurisdiction only shall be applicable.</li>

</ol>

</div>


<div class="section" style="margin-top:30px; font-size:13px;">

<b>Student Declaration</b>

<p>
I hereby confirm that the information provided by me is true and correct. I have read and understood all the rules,
regulations, and terms & conditions of MS Technical Institute and Training Centre and agree to abide by them.
</p>

<p style="text-align:center; margin-top:15px;">
<b>MS Technical Institute, Ahmedabad</b><br/>
Mobile: +91 93165 53058<br/>
Email: msinstituteoffice@gmail.com
</p>

</div>


<div class="sign" style="margin-top:60px;">

<div>
Student Signature: __________________
</div>

<div>
Authorized Signature & Stamp: __________________
</div>

</div>


<div style="text-align:center; margin-top:30px; font-style:italic;">
"Learning Today, Earning Tomorrow."
</div>

<div class="sign">



</div>

</div>

</body>
</html>