<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true" CodeFile="Report_Certificate.aspx.cs" Inherits="Admin_Report_Certificate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

<div class="card">

<div class="card-header">
<h4>Bulk Certificate Generate</h4>
</div>

<div class="card-body">

<button id="btnGenerateBulk" class="btn btn-success">
Generate Bulk Certificate
</button>

<hr/>

<table class="table table-bordered" id="tblStudents">

<thead>

<tr>

<th>Select</th>
<th>Student Name</th>
<th>Course</th>
<th>Mobile</th>

</tr>

</thead>

<tbody>

<asp:Repeater ID="rptStudents" runat="server">

<ItemTemplate>

<tr>

<td>
<input type="checkbox" class="chkStudent" value='<%# Eval("Mobile") %>' />
</td>

<td><%# Eval("StudentName") %></td>

<td><%# Eval("Course_Name") %></td>

<td><%# Eval("Mobile") %></td>

</tr>

</ItemTemplate>

</asp:Repeater>

</tbody>

</table>

</div>

</div>


   <script>

       $("#btnGenerateBulk").click(function () {

           let students = [];

           $(".chkStudent:checked").each(function () {

               students.push($(this).val());

           });

           if (students.length == 0) {

               alert("Select students");

               return;

           }

           $.ajax({

               type: "POST",

               url: "Report_Certificate.aspx/GenerateBulk",

               data: JSON.stringify({ mobiles: students }),

               contentType: "application/json; charset=utf-8",

               dataType: "json",

               success: function (response) {

                   // server se jo message aayega wo show hoga

                   alert(response.d);

                   // agar redirect karna ho to popup ke baad
                    window.location = "Report_Certificate_List.aspx";

               },

               error: function () {

                   alert("Error while generating certificate");

               }

           });

       });

   </script>


</asp:Content>