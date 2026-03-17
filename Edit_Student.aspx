<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master"
AutoEventWireup="true" CodeFile="Edit_Student.aspx.cs" Inherits="Admin_Edit_Student" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="card">
<div class="card-header">
<h4>Edit Student Admission</h4>
</div>

<div class="card-body">

<!-- STUDENT DETAILS -->

<div class="row">

<div class="col-md-4">
<label>Student Id</label>
<input type="text" id="txtStudentId" class="form-control" readonly />
</div>

<div class="col-md-4">
<label>Admission No</label>
<input type="text" id="txtAdmissionNo" class="form-control" readonly />
</div>

<div class="col-md-4">
<label>Roll No</label>
<input type="text" id="txtRollNo" class="form-control" readonly />
</div>

<div class="col-md-6">
<label>Student Name</label>
<input type="text" id="txtStudentName" class="form-control"/>
</div>

<div class="col-md-6">
<label>Mobile</label>
<input type="text" id="txtMobile" class="form-control"/>
</div>

<div class="col-md-6">
<label>Email</label>
<input type="text" id="txtEmail" class="form-control"/>
</div>

<div class="col-md-6">
<label>DOB</label>
<input type="date" id="txtDOB" class="form-control"/>
</div>

<div class="col-md-6">
<label>Father Name</label>
<input type="text" id="txtFatherName" class="form-control"/>
</div>

<div class="col-md-6">
<label>Father Contact</label>
<input type="text" id="txtFatherContactNo" class="form-control"/>
</div>

<div class="col-md-12">
<label>Address</label>
<textarea id="txtAddress" class="form-control"></textarea>
</div>

</div>

<hr/>

<!-- COURSE -->

<h5>Course</h5>

<select id="txtCourseId" class="form-control"></select>

<hr/>

<!-- PAYMENT -->

<div class="row">

<div class="col-md-4">
<label>Total Amount</label>
<input type="text" id="txtTotalAmount" class="form-control"/>
</div>

<div class="col-md-4">
<label>Concession</label>
<input type="text" id="txtConcession" class="form-control"/>
</div>

<div class="col-md-4">
<label>Net Amount</label>
<input type="text" id="txtNetAmount" class="form-control"/>
</div>

<div class="col-md-6">
<label>Payment Mode</label>

<select id="txtPaymentMode" class="form-control">
<option value="Full">Full</option>
<option value="Installment">Installment</option>
</select>

</div>

<div class="col-md-6">
<label>Paid Amount</label>
<input type="text" id="txtPaidAmount" class="form-control"/>
</div>

<div class="col-md-6">
<label>Next Due Date</label>
<input type="date" id="txtNextDueDate" class="form-control"/>
</div>

</div>

<hr/>

<!-- FILES -->

<div class="row">

<div class="col-md-6">
<label>Student Photo</label>
<input type="file" id="filePhoto"/>
</div>

<div class="col-md-6">
<label>Aadhaar</label>
<input type="file" id="fileAadhaar"/>
</div>

</div>

<hr/>

<div class="text-center">

<button id="BtnUpdateStudent" class="btn btn-primary">
Update Student
</button>

</div>

</div>
</div>


 <script>

     $(document).ready(function () {

         var mobile = new URLSearchParams(window.location.search).get("Mobile");

         loadStudent(mobile);

     });

     function loadStudent(mobile) {

         $.ajax({
             type: "POST",
             url: "Edit_Student.aspx/GetStudent",
             data: JSON.stringify({ Mobile: mobile }),
             contentType: "application/json; charset=utf-8",
             dataType: "json",
             success: function (response) {

                 var data = JSON.parse(response.d);

                 $("#txtStudentId").val(data[0].StudentId);
                 $("#txtAdmissionNo").val(data[0].AdmissionNo);
                 $("#txtRollNo").val(data[0].RollNo);
                 $("#txtStudentName").val(data[0].StudentName);
                 $("#txtMobile").val(data[0].Mobile);
                 $("#txtEmail").val(data[0].Email);
                 $("#txtDOB").val(data[0].DOB);
                 $("#txtFatherName").val(data[0].FatherName);
                 $("#txtFatherContactNo").val(data[0].FatherContactNo);
                 $("#txtAddress").val(data[0].Address);

                 $("#txtTotalAmount").val(data[0].TotalAmount);
                 $("#txtConcession").val(data[0].Concession);
                 $("#txtNetAmount").val(data[0].NetAmount);
                 $("#txtPaidAmount").val(data[0].PaidAmount);
                 $("#txtPaymentMode").val(data[0].PaymentMode);

             }
         });

     }


     // ================================
     // UPDATE STUDENT
     // ================================

     $("#BtnUpdateStudent").click(function () {

         var photoFileName = "";
         var aadhaarFileName = "";

         var uploadTasks = [];

         // PHOTO UPLOAD
         if ($("#filePhoto")[0].files.length > 0) {

             var photoData = new FormData();
             photoData.append("file", $("#filePhoto")[0].files[0]);

             uploadTasks.push(uploadFile(photoData).then(function (name) {
                 photoFileName = name;
             }));
         }

         // AADHAAR UPLOAD
         if ($("#fileAadhaar")[0].files.length > 0) {

             var aadhaarData = new FormData();
             aadhaarData.append("aadhaarFile", $("#fileAadhaar")[0].files[0]);

             uploadTasks.push(uploadFile(aadhaarData).then(function (name) {
                 aadhaarFileName = name;
             }));
         }

         Promise.all(uploadTasks).then(function () {

             var dataToSend = {

                 StudentId: $("#txtStudentId").val(),
                 StudentName: $("#txtStudentName").val(),
                 Mobile: $("#txtMobile").val(),
                 Email: $("#txtEmail").val(),
                 DOB: $("#txtDOB").val(),
                 FatherName: $("#txtFatherName").val(),
                 FatherContactNo: $("#txtFatherContactNo").val(),
                 Address: $("#txtAddress").val(),

                 TotalAmount: $("#txtTotalAmount").val(),
                 Concession: $("#txtConcession").val(),
                 NetAmount: $("#txtNetAmount").val(),
                 PaidAmount: $("#txtPaidAmount").val(),
                 PaymentMode: $("#txtPaymentMode").val(),

                 Photo: photoFileName,
                 AadhaarFile: aadhaarFileName

             };

             $.ajax({

                 type: "POST",
                 url: "Edit_Student.aspx/UpdateStudent",
                 data: JSON.stringify(dataToSend),
                 contentType: "application/json; charset=utf-8",
                 dataType: "json",

                 success: function (response) {

                     if (response.d > 0)
                         Success("Student Updated Successfully");
                     else
                         Failed("Update Failed");

                 }

             });

         });

     });


     // ================================
     // FILE UPLOAD
     // ================================

     function uploadFile(formData) {

         return new Promise(function (resolve, reject) {

             $.ajax({

                 url: "FileUploadHandler.ashx",
                 type: "POST",
                 data: formData,
                 contentType: false,
                 processData: false,

                 success: function (response) {

                     resolve(response);

                 },

                 error: function () {

                     reject("Upload Failed");

                 }

             });

         });

     }

 </script>

</asp:Content>