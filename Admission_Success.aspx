<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Admission_Success.aspx.cs" Inherits="Admin_Admission_Success" %>

<!DOCTYPE html>
<html>
<head runat="server">
<title>Admission Success</title>

<style>

body{
font-family:Arial;
background:#f5f5f5;
}

.box{
width:500px;
margin:100px auto;
text-align:center;
background:white;
padding:40px;
border-radius:10px;
box-shadow:0 0 10px #ccc;
}

button{
padding:12px 25px;
margin:10px;
border:none;
background:#0d6efd;
color:white;
font-size:16px;
cursor:pointer;
border-radius:5px;
}

button:hover{
background:#084298;
}

</style>

</head>

<body>

<form id="form1" runat="server">

<div class="box">

<h2>Admission Completed Successfully</h2>

<br>

<button type="button" onclick="printInvoice()">Print Invoice</button>

<button type="button" onclick="printAdmission()">Print Admission Form</button>

</div>

</form>

<script>

function printInvoice(){

var invoice = '<%=Request.QueryString["InvoiceNo"]%>';
var mobile = '<%=Request.QueryString["Mobile"]%>';
var paymode = '<%=Request.QueryString["PayMode"]%>';

window.open(
'PrintInvoice.aspx?InvoiceNo=' + invoice + '&Mobile=' + mobile + '&PayMode=' + paymode,
'_blank'
);

}

function printAdmission(){

var mobile = '<%=Request.QueryString["Mobile"]%>';

window.open(
'Admission_Confirmation_Print.aspx?Mobile=' + mobile,
'_blank'
);

}

</script>

</body>
</html>