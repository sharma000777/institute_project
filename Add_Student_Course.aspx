<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true" CodeFile="Add_Student_Course.aspx.cs" Inherits="Admin_Add_Student_Course" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
<title>Add Course | Institute Management Software</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

<div class="card">
<div class="card-header">
<h4>Add Course To Student</h4>
</div>

<div class="card-body">

<div class="row">

<div class="col-md-4">
<label>Search Student</label>
<select id="ddlStudent" class="form-control"></select>
</div>

<div class="col-md-4">
<label>Select Course</label>
<select id="ddlCourse" class="form-control"></select>
</div>

<div class="col-md-4">
<label>Select Batch</label>
<select id="ddlBatch" class="form-control"></select>
</div>

<div class="col-md-4 mt-3">
<label>Fee</label>
<input type="text" id="txtFee" class="form-control" readonly />
</div>

<div class="col-md-4 mt-3">
<label>Payment Mode</label>
<select id="ddlPaymentMode" class="form-control">
<option value="Full">Full</option>
<option value="Installment">Installment</option>
</select>
</div>

<div class="col-md-4 mt-3">
<label>Paid Amount</label>
<input type="number" id="txtPaid" class="form-control" />
</div>

<div class="col-md-12 mt-4">
<button class="btn btn-success" id="btnAddCourse">Add Course</button>
</div>

</div>

</div>
</div>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<script>

$(document).ready(function(){

loadStudents();
loadCourses();

$("#ddlCourse").change(loadBatch);
$("#btnAddCourse").click(addCourse);

});


function loadStudents(){

$.ajax({
url:'Add_Student_Course.aspx/GetStudents',
type:'POST',
contentType:'application/json',
success:function(res){

let data = JSON.parse(res.d);

$("#ddlStudent").append(`<option value="">Select Student</option>`);

$.each(data,function(i,v){

$("#ddlStudent").append(`<option value="${v.StudentId}">${v.StudentName} - ${v.Mobile}</option>`);

});

}
});

}


function loadCourses(){

$.ajax({
url:'Add_Student_Course.aspx/GetCourses',
type:'POST',
contentType:'application/json',
success:function(res){

let data = JSON.parse(res.d);

$("#ddlCourse").append(`<option value="">Select Course</option>`);

$.each(data,function(i,v){

$("#ddlCourse").append(`<option value="${v.Id}" data-fee="${v.Fee}">${v.Course_Name}</option>`);

});

}
});

}


function loadBatch(){

let courseId = $("#ddlCourse").val();

let fee = $("#ddlCourse option:selected").data("fee");

$("#txtFee").val(fee);

$.ajax({

url:'Add_Student_Course.aspx/GetBatch',
type:'POST',
data:JSON.stringify({courseId:courseId}),
contentType:'application/json',

success:function(res){

let data = JSON.parse(res.d);

$("#ddlBatch").html("");

$.each(data,function(i,v){

$("#ddlBatch").append(`<option value="${v.Id}">${v.BatchName}</option>`);

});

}

});

}



function addCourse(){

let data={

studentId:$("#ddlStudent").val(),
batchId:$("#ddlBatch").val(),
paid:$("#txtPaid").val(),
fee:$("#txtFee").val(),
paymentMode:$("#ddlPaymentMode").val()

};

$.ajax({

url:'Add_Student_Course.aspx/AddCourse',
type:'POST',
data:JSON.stringify(data),
contentType:'application/json',

success:function(res){

alert(res.d);

}

});

}

</script>

</asp:Content>