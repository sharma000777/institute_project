<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true" CodeFile="Student_Admission.aspx.cs" Inherits="Admin_Student_Admission" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Student Admission | Institute Management Software</title>
    <style>
        .table th {
            color: #433c50;
        }

        @media screen and (min-width: 768px) {
            #left_Search {
                width: 50%;
            }

            #right_Export {
                width: 60%;
            }
        }

        @media screen and (max-width: 768px) {
            #left_Search {
                width: 100%;
            }

                #left_Search > div {
                    flex-wrap: wrap;
                }

            #right_Export {
                width: 100%;
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row g-6 mb-6">
        <div class="col-md">
            <div class="card">
                <div class="card-header row" style="justify-content: space-between;">
                    <div class="col-md-4">
                        <h5><span class="text-muted fw-light">Students Section /</span> Student Admission</h5>
                    </div>
                    <div id="top-right-date" class="col-md-8" style="display: flex; justify-content: end;">
                        <div class="">
                            <a href="Add_Student_Admission.aspx" class="btn btn-primary waves-effect waves-light" style="margin-right: 10px"><i class="menu-icon ri-function-add-fill"></i>Take New Admission</a>
                        </div>
                    </div>
                </div>
                <div class="card-header flex-column flex-md-row" style="display: flex; justify-content: space-between;">
                    <div class="dt-action-buttons pt-3 pt-md-0" id="left_Search">
                        <div class="row g-6" style="font-size: 1rem;">
                            <div class="col-4 mb-3 ">
                                <div class="mt-2 mb-2">
                                    <label for="txtAllStudent" style="cursor: pointer"><i class="menu-icon tf-icons ri-list-radio"></i>All</label>
                                    <input type="radio" id="txtAllStudent"
                                        name="Student" class="form-check-input" checked>
                                </div>
                            </div>
                            <div class="col-4 mb-3 ">
                                <div class="mt-2 mb-2">
                                    <label for="txtActiveStudent" style="cursor: pointer"><i class="menu-icon ri-graduation-cap-fill"></i>Active</label>
                                    <input type="radio" id="txtActiveStudent"
                                        name="Student" class="form-check-input">
                                </div>
                            </div>
                            <div class="col-4 mb-3">
                                <div class="mt-2 mb-2">
                                    <label for="txtDropoutStudent" style="cursor: pointer"><i class="menu-icon tf-icons ri-graduation-cap-line"></i>Dropout</label>
                                    <input type="radio" id="txtDropoutStudent"
                                        name="Student" class="form-check-input">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="dt-action-buttons pt-3 pt-md-0" id="right_Export">
                        <div class="dt-buttons btn-group hide" style="width: 100%; display: flex; justify-content: end" id="dropoutDateDiv">
                            <div id="reportrange" style="background: #fff; cursor: pointer; padding: 10px 10px; border: 1px solid #ccc; max-width: fit-content;">
                                <i class="ri-calendar-2-line"></i>&nbsp;<span></span><i class="ri-arrow-down-s-line" style="margin-left: 5px"></i>
                            </div>
                            <div class="btn-group">
                                <button type="button" class="btn btn-primary dropdown-toggle waves-effect waves-light" data-bs-toggle="dropdown" aria-expanded="false">
                                    <i class="fa fa-download"></i>&nbsp;Export
                     
                                </button>
                                <ul class="dropdown-menu">
                                    <li><a id="exportToExcel" class="dropdown-item waves-effect" href="javascript:void(0);">Excel</a></li>
                                    <li><a id="exportToCSV" class="dropdown-item waves-effect" href="javascript:void(0);">CSV</a></li>
                                    <li><a id="exportToPDF" class="dropdown-item waves-effect" href="javascript:void(0);">PDF</a></li>
                                    <li><a id="exportToPrint" class="dropdown-item waves-effect" href="javascript:void(0);">Print</a></li>
                                </ul>
                               
                            </div>
                        </div>
                        
                    </div>
                </div>
                <div class="card-body">
                    <div class="table-responsive text-nowrap">
                        <table class="table nowrap" id="tblStudentAdmission">
                            <caption class="ms-4">
                                List of Visitor
                            </caption>
                            <thead>
                                <tr>
                                    <th>SlNo</th>
                                    <th>Action</th>
                                    <th>Status</th>
                                    <th>Date of Admission</th>
                                    <th>Student Id</th>
                                    <th>Admission No</th>
                                    <th>Photo</th>
                                    <th>Student Name</th>
                                    <th>Roll No</th>
                                    <th>Mobile</th>
                                    <th>Gender</th>
                                    <th>Email</th>
                                    <th>DOB</th>
                                    <th>Father Name</th>
                                    <th>Father Occupation</th>
                                    <th>Father ContactNo</th>
                                    <th>Mother Name</th>
                                    <th>State</th>
                                    <th>City</th>
                                    <th>Pincode</th>
                                    <th>Address</th>
                                    <th>DropoutDate</th>
                                    <th>Aadhaar</th>

                                </tr>
                            </thead>
                        </table>

                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Edit User Modal -->
    <div class="modal fade" id="EditUpdateStudentModal" tabindex="-1" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
        <div class="modal-dialog modal-dialog-centered modal-lg modal-simple modal-edit-user">
            <div class="modal-content">
                <div class="modal-body p-0">
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    <div class="text-center mb-6">
                        <h4 class="mb-2">Edit / Update Student</h4>
                    </div>
                    <div class="row g-5" id="formAuthentication">
                        <div class="col-md-12">
                            <!-- 1. Delivery Address -->
                            <h5 class="my-4">Student Detail</h5>
                            <div class="row g-6">
                                <div class="col-12 col-md-4">
                                    <div class="form-floating form-floating-outline validation">
                                        <input type="text" id="txtStudentId" name="txtStudentId" class="form-control" placeholder="Enter student id" readonly />
                                        <label for="txtStudentId">Student Id</label>
                                    </div>
                                </div>
                                <div class="col-12 col-md-4">
                                    <div class="form-floating form-floating-outline validation">
                                        <input type="text" id="txtAdmissionNo" name="txtAdmissionNo" class="form-control" placeholder="Enter Admission No" readonly />
                                        <label for="txtAdmissionNo">Admission No</label>
                                    </div>
                                </div>
                                <div class="col-12 col-md-4">
                                    <div class="form-floating form-floating-outline validation">
                                        <input type="text" id="txtRollNo" name="txtRollNo" class="form-control" placeholder="Enter roll no" readonly />
                                        <label for="txtRollNo">Roll No</label>
                                    </div>
                                </div>
                                <div class="col-12 col-md-6">
                                    <div class="form-floating form-floating-outline validation">
                                        <input type="text" id="txtStudentName" name="txtStudentName" class="form-control" placeholder="Enter student name" />
                                        <label for="txtStudentName">Student Name *</label>
                                    </div>
                                </div>
                                <div class="col-12 col-md-6">
                                    <div class="form-floating form-floating-outline validation">
                                        <input type="text" id="txtMobile" name="txtMobile" class="form-control" placeholder="Enter mobile" />
                                        <label for="txtMobile">Mobile *</label>
                                    </div>
                                </div>
                                <div class="col-12 col-md-6">
                                    <div class="form-floating form-floating-outline validation">
                                        <select name="txtGender" id="txtGender" class="select2 form-select" data-allow-clear="true">
                                            <option value="">Select Gender</option>
                                            <option value="Male">Male</option>
                                            <option value="Female">Female</option>
                                            <option value="Other">Other</option>
                                        </select>
                                        <label for="txtCity">Gender *</label>
                                    </div>
                                </div>
                                <div class="col-12 col-md-6">
                                    <div class="form-floating form-floating-outline validation">
                                        <input type="text" id="txtEmail" name="txtEmail" class="form-control" placeholder="Enter email" />
                                        <label for="txtEmail">Email *</label>
                                    </div>
                                </div>
                                <div class="col-12 col-md-6">
                                    <div class="form-floating form-floating-outline validation">
                                        <input type="date" id="txtDOB" name="txtDOB" class="form-control" />
                                        <label for="txtDOB">DOB *</label>
                                    </div>
                                </div>
                                <div class="col-12 col-md-6">
                                    <div class="form-floating form-floating-outline validation">
                                        <input type="text" id="txtFatherName" name="txtFatherName" class="form-control" placeholder="Enter father name" />
                                        <label for="txtFatherName">Father Name *</label>
                                    </div>
                                </div>
                                <div class="col-12 col-md-6">
                                    <div class="form-floating form-floating-outline validation">
                                        <input type="text" id="txtFatherOccupation" name="txtFatherOccupation" class="form-control" placeholder="Enter father Occupation" />
                                        <label for="txtFatherOccupation">Father Occupation *</label>
                                    </div>
                                </div>
                                <div class="col-12 col-md-6">
                                    <div class="form-floating form-floating-outline validation">
                                        <input type="text" id="txtFatherContactNo" name="txtFatherContactNo" class="form-control" placeholder="Enter father contact no" />
                                        <label for="txtFatherContactNo">Father Contact No *</label>
                                    </div>
                                </div>
                                <div class="col-12 col-md-6">
                                    <div class="form-floating form-floating-outline validation">
                                        <input type="text" id="txtMotherName" name="txtMotherName" class="form-control" placeholder="Enter mother name" />
                                        <label for="txtMotherName">Mother Name *</label>
                                    </div>
                                </div>

                                <div class="col-12 col-md-6">
                                    <div class="form-floating form-floating-outline validation">
                                        <select name="txtState" id="txtState" class="select2 form-select" data-allow-clear="true">
                                            <option value="">Select State</option>
                                        </select>
                                        <label for="txtCity">State *</label>
                                    </div>
                                </div>
                                <div class="col-12 col-md-6">
                                    <div class="form-floating form-floating-outline validation">
                                        <select name="txtCity" id="txtCity" class="select2 form-select" data-allow-clear="true">
                                            <option value="">Select City</option>
                                        </select>
                                        <label for="txtCity">City *</label>
                                    </div>
                                </div>
                                <div class="col-12 col-md-6">
                                    <div class="form-floating form-floating-outline validation">
                                        <input type="text" id="txtPincode" name="txtPincode" class="form-control" placeholder="Enter pincode" />
                                        <label for="txtPincode">Pincode *</label>
                                    </div>
                                </div>
                                <div class="col-12 col-md-12">
                                    <div class="form-floating form-floating-outline validation">
                                        <textarea type="text" id="txtAddress" name="txtAddress" class="form-control" placeholder="Enter address" style="height: 8rem"></textarea>
                                        <label for="txtAddress">Address *</label>
                                    </div>
                                </div>


                            </div>
                            <hr>
                        </div>
                        <div class="col-12 text-center">
                            <button id="BtnUpdate" type="button" class="btn btn-primary me-3" style="width: 25%;">Update</button>
                            <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal" aria-label="Close">Cancel</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--/ Edit User Modal -->
    <!-- Edit User Modal -->
    <div class="modal fade" id="ViewCourseModal" tabindex="-1" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
        <div class="modal-dialog modal-dialog-centered modal-lg modal-simple modal-edit-user">
            <div class="modal-content">
                <div class="modal-body p-0">
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    <div class="text-center mb-6">
                        <h4 class="mb-2">Courses & Fee</h4>
                    </div>
                    <div class="row g-5">
                        <h5 class="mb-2 my-4">Courses</h5>
                        <div class="col-12 col-md-12 " id="tblCourseDiv">
                            <div class="table-responsive text-nowrap">
                                <table class="table nowrap">
                                    <caption class="ms-4">
                                        List of Course
                                    </caption>
                                    <thead>
                                        <tr>
                                            <th>SlNo</th>
                                            <th>Course Name</th>
                                            <th>Course Duration</th>
                                            <th>Fee</th>
                                        </tr>
                                    </thead>
                                    <tbody id="tblCourse">
                                        <tr>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                        </tr>
                                    </tbody>
                                </table>

                            </div>
                        </div>
                        <h5 class="mb-2 my-4">Fee</h5>
                        <div class="col-12 col-md-6">
                            <i class="ri-money-rupee-circle-line ri-24px"></i><span class="fw-medium mx-2">Total Amount:</span>₹ <span id="txtTotalAmount"></span>
                        </div>
                        <div class="col-12 col-md-6">
                            <i class="ri-discount-percent-line ri-24px"></i><span class="fw-medium mx-2">Concession:</span> <span id="txtConcession"></span> %
                        </div>
                        <div class="col-12 col-md-6">
                            <i class="ri-money-rupee-circle-line ri-24px"></i><span class="fw-medium mx-2">Net Amount:</span>₹ <span id="txtNetAmount"></span>
                        </div>
                        <div class="col-12 col-md-6">
                            <i class="ri-verified-badge-line ri-24px"></i><span class="fw-medium mx-2">Paid Amount:</span>₹ <span id="txtPaidAmount"></span>
                        </div>
                        <div class="col-12 col-md-6">
                            <i class="ri-exchange-funds-line ri-24px"></i><span class="fw-medium mx-2">Dues Amount:</span>₹ <span id="txtDuesAmount"></span>
                        </div>
                        <div class="col-12 col-md-6">
                            <i class="ri-bank-card-2-line ri-24px"></i><span class="fw-medium mx-2">Payment Mode:</span> <span id="txtPaymentMode"></span>
                        </div>
                        
                      
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--/ Edit User Modal -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>


    <script type="text/javascript">

        let Id,StudentId, AdmissionNo, RollNo, StudentName, Mobile, Gender, Email, DOB, FatherName, FatherOccupation, FatherContactNo, MotherName, State, City, Pincode, Address, CourseId, TotalAmount, Concession, NetAmount, PaidAmount, TotalDues, PaymentMode;
        let table, url, BtnAdd, BtnUpdate, dataToSend, selectedDateRangeName, dropoutDateDiv;
        let StudentType, AllStudent, ActiveStudent, DropoutStudent;
        let formAuthentication = document.querySelector("#formAuthentication");
        let formValidationInstance;
        StudentType = "All";
        let config = {
            cUrl: 'https://api.countrystatecity.in/v1/countries',
            ckey: 'NHhvOEcyWk50N2Vna3VFTE00bFp3MjFKR0ZEOUhkZlg4RTk1MlJlaA=='
        };

        const defaultRun = async () => {
            try {
                await renderStudent();
            } catch (err) {
                console.log(err);
            }
        }

        $(document).ready(function () {
            AllStudent = $("#txtAllStudent");
            ActiveStudent = $("#txtActiveStudent");
            DropoutStudent = $("#txtDropoutStudent");
            dropoutDateDiv = $("#dropoutDateDiv");


            StudentId = $("#txtStudentId");
            AdmissionNo = $("#txtAdmissionNo");
            RollNo = $("#txtRollNo");
            StudentName = $("#txtStudentName");
            Mobile = $("#txtMobile");
            Gender = $("#txtGender");
            Email = $("#txtEmail");
            DOB = $("#txtDOB");
            FatherName = $("#txtFatherName");
            FatherOccupation = $("#txtFatherOccupation");
            FatherContactNo = $("#txtFatherContactNo");
            MotherName = $("#txtMotherName");
            State = $("#txtState");
            City = $("#txtCity");
            Pincode = $("#txtPincode");
            Address = $("#txtAddress");
            CourseId = $("#txtCourseId");
            TotalAmount = $("#txtTotalAmount");
            Concession = $("#txtConcession");
            NetAmount = $("#txtNetAmount");
            PaidAmount = $("#txtPaidAmount");
            TotalDues = $("#txtDuesAmount");
            PaymentMode = $("#txtPaymentMode");

            (async function () {
                await Show_Spinner();
                await defaultRun().finally(async () => {
                    await Hide_Spinner();
                })
            })();
            $(document).on("click", "#txtAllStudent", OnClick_AllStudent);
            $(document).on("click", "#txtActiveStudent", OnClick_ActiveStudent);
            $(document).on("click", "#txtDropoutStudent", OnClick_DropoutStudent);


            $(document).on("click", "a.delete-link", OnClick_BtnDelete);
            $(document).on("click", "a.update-link", OnClick_update_link);
            $(document).on("click", "#BtnUpdate", OnClick_BtnUpdate);
            $(document).on("click", "a.courseDetail-link", OnClick_courseDetail_link);
            $(document).on("click", "#BtnAdd", OnClick_BtnAdd);


            CourseId.change(OnChange_CourseId);

            OnKeyPressValidation(StudentName, validateAlphabeticOrSpace);
            OnKeyPressValidation(Mobile, validateMobileNumber);

        });
        async function OnClick_AllStudent() {
            try {
                await Show_Spinner();
                if ($(this).is(":checked")) {
                    StudentType = "All";
                    await renderStudent();
                    dropoutDateDiv.addClass("hide");
                }
                else {

                }
            } catch (err) {
                console.log(err);
            }
            finally {
                await Hide_Spinner();
            }
        }
        async function OnClick_ActiveStudent() {
            try {
                await Show_Spinner();
                if ($(this).is(":checked")) {
                    StudentType = "Active";
                    await renderStudent();
                    dropoutDateDiv.addClass("hide");
                }
                else {

                }
            } catch (err) {
                console.log(err);
            }
            finally {
                await Hide_Spinner();
            }
        }
        async function OnClick_DropoutStudent() {
            try {
                await Show_Spinner();
                if ($(this).is(":checked")) {
                    StudentType = "Dropout";
                    await renderStudent();
                    await DateRange();
                    dropoutDateDiv.removeClass("hide");
                }
                else {

                }
            } catch (err) {
                console.log(err);
            }
            finally {
                await Hide_Spinner();
            }
        }
        async function renderStudent() {
            try {
                var parameters = {
                    StudentType: StudentType,
                };
                var dataToSend = "";
                for (var key in parameters) {
                    if (parameters.hasOwnProperty(key)) {
                        dataToSend += key + "='" + parameters[key] + "'&";
                    }
                }
                // Remove the trailing '&' character
                dataToSend = dataToSend.slice(0, -1);
                var url = "Student_Admission.aspx/Get_Student_Admission?" + dataToSend;
                await GetStudent_Admission(url);
                
            } catch (err) {
                console.log(err);
            }
        }
        async function DateRange() {
            try {
                const response = await Get_MinDate();

                var minDate = moment(response, "MM-DD-YYYY HH:mm:ss");

                var start = moment(minDate.format('MMMM D, YYYY'));
                var end = moment();

                async function cb(start, end, rangeName) {
                    //$('#reportrange span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
                    var StartDate = start.format('YYYY-MM-DD');
                    var EndDate = end.format('YYYY-MM-DD');
                    selectedDateRangeName = rangeName || 'Custom Range';
                    var parameters = {
                        StudentType: StudentType,
                        StartDate: StartDate,
                        EndDate: EndDate,
                    };
                    var dataToSend = "";
                    for (var key in parameters) {
                        if (parameters.hasOwnProperty(key)) {
                            dataToSend += key + "='" + parameters[key] + "'&";
                        }
                    }
                    // Remove the trailing '&' character
                    dataToSend = dataToSend.slice(0, -1);
                    var url = "Student_Admission.aspx/Get_Student_Admission_ByDate?" + dataToSend;
                    await GetStudent_Admission(url);
                    $('#tblStudentAdmission').DataTable().ajax.reload();
                }

                $('#reportrange').daterangepicker({
                    startDate: start,
                    endDate: end,
                    ranges: {
                        'Today': [moment(), moment()],
                        'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
                        'Last 7 Days': [moment().subtract(6, 'days'), moment()],
                        'Last 30 Days': [moment().subtract(29, 'days'), moment()],
                        'This Month': [moment().startOf('month'), moment().endOf('month')],
                        'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
                    }
                }, cb);

                cb(start, end, "Custom Range");

            } catch (err) {
                console.log(err);
            }

        }
        async function Get_MinDate() {
            try {
                const response = await Ajax_GetResult_WithoutParameter("Student_Admission.aspx", "Get_MinDate");
                return response.d;
            } catch (err) {
                console.log(err);
            }

        }

        async function GetStudent_Admission(url) {

            try {
                return new Promise((resolve, reject) => {
                    table = $('#tblStudentAdmission').DataTable();

                    if ($.fn.DataTable.isDataTable('#tblStudentAdmission')) {
                        table.destroy();

                    }
                    table = $('#tblStudentAdmission').DataTable(
                        {
                            "ajax":
                            {
                                "url": url,
                                "contentType": "application/json",
                                "type": "GET",
                                "dataType": "JSON",
                                "data": function (d) {
                                    return d;
                                },
                                "dataSrc": function (json) {
                                    json.draw = json.d.draw;
                                    json.recordsTotal = json.d.recordsTotal;
                                    json.recordsFiltered = json.d.recordsFiltered;
                                    json.data = json.d.data;
                                    var return_data = json;
                                    return return_data.data;
                                },
                                "error": function (err) {
                                    reject(err);
                                }
                            },
                            "columns": [
                                { "data": "SlNo", "name": "SlNo", "width": "0rem", "orderable": true },
                                {
                                    "data": "Mobile",
                                    "render": function (data, type, row, meta) { // Added parameters
                                        var rowHtml = "";
                                        rowHtml += '<a class="dropdown-item" name="' + data + '" href="Student_Profile.aspx?Mobile=' + data + '"><i class="menu-icon ri-profile-line me-1"></i>View Profile</a>';
                                        return rowHtml;
                                    },
                                    "orderable": false,
                                    "autoWidth": true
                                },
                                {
                                    "data": "Status",
                                    "render": function (data, type, row, meta) { // Added parameters
                                        var rowHtml;
                                        if (data === "Active")
                                            rowHtml = '<span class="badge rounded-pill text-bg-success me-1" style="font-size:14px;">' + data + '</span>';
                                        else
                                            rowHtml = '<span class="badge rounded-pill bg-label-danger me-1" style="font-size:14px;">' + data + '</span>';
                                        return rowHtml;
                                    },
                                    "orderable": false,
                                    "width": "0rem"
                                },
                                { "data": "Date", "name": "Date", "autoWidth": true },
                                { "data": "StudentId", "name": "StudentId", "autoWidth": true },
                                { "data": "AdmissionNo", "name": "AdmissionNo", "autoWidth": true },
                                {
                                    "data": "Photo",
                                    "render": function (data, type, JsonResultRow, meta) {
                                        return '<img src="../UserLogin_Content/upload/' + data + '" class="imag-fluid" style="width: 2rem;height: 3rem;">';
                                    },
                                    "autoWidth": true,
                                    "orderable": false
                                },
                                { "data": "StudentName", "name": "StudentName", "autoWidth": true },
                                { "data": "RollNo", "name": "RollNo", "autoWidth": true },
                                { "data": "Mobile", "name": "Mobile", "autoWidth": true },
                                { "data": "Gender", "name": "Gender", "autoWidth": true },
                                { "data": "Email", "name": "Email", "autoWidth": true },
                                { "data": "DOB", "name": "DOB", "autoWidth": true },
                                { "data": "FatherName", "name": "FatherName", "autoWidth": true },
                                { "data": "FatherOccupation", "name": "FatherOccupation", "autoWidth": true },
                                { "data": "FatherContactNo", "name": "FatherContactNo", "autoWidth": true },
                                { "data": "MotherName", "name": "MotherName", "autoWidth": true },
                                { "data": "State", "name": "State", "autoWidth": true },
                                { "data": "City", "name": "City", "autoWidth": true },
                                { "data": "Pincode", "name": "Pincode", "autoWidth": true },
                                { "data": "Address", "name": "Address", "autoWidth": true },
                                { "data": "DropoutDate", "name": "DropoutDate", "autoWidth": true }
                            ],
                            "initComplete": function (settings, json) {
                                resolve();
                            },
                            "serverSide": true, // Removed quotes around true
                            "processing": true, // Removed quotes around true
                            "ordering": true, // Removed quotes around true
                            "responsive": true,
                            "language": {
                                "processing": "processing....",
                                "emptyTable": "No student to display on " + selectedDateRangeName + ". Please check back later or review previous records."

                            },
                            "dom": 'lBfrtip',
                            "buttons": [
                                {
                                    extend: 'excel',
                                    className: 'button-excel',
                                    exportOptions: {
                                        modifier: {
                                            page: 'all' // Export all data, not just the visible page
                                        }
                                    },
                                    init: function (api, node, config) {
                                        $(node).hide();
                                    }
                                },
                                {
                                    extend: 'csv',
                                    className: 'button-csv',
                                    init: function (api, node, config) {
                                        $(node).hide();
                                    }
                                },
                                {
                                    extend: 'pdf',
                                    className: 'button-pdf',
                                    init: function (api, node, config) {
                                        $(node).hide();
                                    }
                                },
                                {
                                    extend: 'print',
                                    className: 'button-print',
                                    init: function (api, node, config) {
                                        $(node).hide();
                                    }
                                }
                            ]
                        });
                    // Attach event listeners to export buttons
                    $('#exportToExcel').off('click').on('click', function (e) {
                        e.preventDefault();
                        table.buttons('.button-excel').trigger();
                    });
                    $('#exportToCSV').off('click').on('click', function (e) {
                        e.preventDefault();
                        table.buttons('.button-csv').trigger();
                    });
                    $('#exportToPDF').off('click').on('click', function (e) {
                        e.preventDefault();
                        table.buttons('.button-pdf').trigger();
                    });
                    $('#exportToPrint').off('click').on('click', function (e) {
                        e.preventDefault();
                        table.buttons('.button-print').trigger();
                    });
                })
            } catch (err) {
                console.log(err);
                throw err;
            }



        }


        async function OnClick_BtnDelete() {
            const result = await Confirm("Yes, Delete it!", "Are you sure want to delete?");
            if (result.isConfirmed) {
                try {
                    await Show_Spinner();
                    dataToSend = {
                        StudentId: this.name
                    };
                    const response = await Ajax_GetResult("Student_Admission.aspx", "Delete_Student_Admission", dataToSend);

                    $('#tblStudentAdmission').DataTable().ajax.reload();
                    if (response.d > 0)
                        Success("Deleted", "You have deleted this Student successfully");
                    else
                        Failed("Deleted Failed !");

                } catch (err) {
                    console.log(err);
                }
                finally {
                    await Hide_Spinner();
                }
            }

        }
        async function renderCourse() {
            try {
                const courseResponse = await Ajax_GetResult_WithoutParameter("Student_Admission.aspx", "Get_Course");
                const courseData = JSON.parse(courseResponse.d);

                if (courseData.length > 0) {
                    CourseId.empty().append('<option value="" selected>Select Course</option>');

                    $.each(courseData, function (index, item) {
                        CourseId.append($('<option>', {
                            value: item.Id,
                            text: item.Course_Name
                        }));
                    });

                } else {
                    console.warn("No course data available.");
                }

            } catch (err) {
                console.error("Error in rendering course options:", err);
            }
        }
        async function OnChange_CourseId() {
            try {
                dataToSend = {
                    Id: CourseId.val()
                }
                const response = await Ajax_GetResult("Student_Admission.aspx", "Get_CourseDetail", dataToSend);
                const data = JSON.parse(response.d);
                console.log(data);
                if (data.length > 0) {
                    var html = "";
                    $("#tblCourse").empty();
                    $.each(data, function (index, item) {

                        html += `
                        <tr>
                            <td>${item.SlNo}</td>
                            <td>${item.Course_Name}</td>
                            <td>${item.Course_Duration} ${item.Duration_Type}</td>
                            <td>₹ ${item.Fee}</td>
                        </tr>
                    `;
                    })
                    $("#tblCourse").html(html);
                    $("#tblCourseDiv").removeClass("hide");
                }
                else {
                    $("#tblCourseDiv").addClass("hide");
                }

            } catch (err) {
                console.log(err);
            }
        }
        async function OnClick_update_link() {
            try {
                await Show_Spinner();
                $('#EditUpdateStudentModal').on('shown.bs.modal', function () {
                    $('#EditUpdateStudentModal').modal('show');

                });


                Id = this.name;
                dataToSend = {
                    StudentId: this.name
                };
                const response = await Ajax_GetResult("Student_Admission.aspx", "Get_UpdateDetail", dataToSend);
                const data = JSON.parse(response.d);
                console.log(data)

                const item = data[0];

                StudentId.val(item.StudentId);
                AdmissionNo.val(item.AdmissionNo);
                RollNo.val(item.RollNo);
                StudentName.val(item.StudentName);
                Mobile.val(item.Mobile);
                Gender.val(item.Gender).trigger('change');
                Email.val(item.Email);
                DOB.val(item.DOB);
                FatherName.val(item.FatherName);
                FatherOccupation.val(item.FatherOccupation);
                FatherContactNo.val(item.FatherContactNo);
                MotherName.val(item.MotherName);
                await renderStates();
                const stateOption = State.find('option').filter(function () {
                    return $(this).text() === item.State;
                });
                if (stateOption.length) {
                    State.val(stateOption.val()).trigger('change');
                }
                await renderCities();
              
                const cityOption = City.find('option').filter(function () {
                    return $(this).text() === item.City;
                });
                if (cityOption.length) {
                    City.val(cityOption.val()).trigger('change');
                }
                Pincode.val(item.Pincode);
                Address.val(item.Address);

                

            } catch (err) {
                console.log(err);
            }
            finally {
                await Hide_Spinner();
            }

        }
        async function renderStates() {
            try {
                return new Promise((resolve, reject) => {
                    console.log("Load State");
                    State.prop('disabled', false).css('pointer-events', 'auto');
                    City.prop('disabled', true).css('pointer-events', 'none');

                    const selectedCountryCode = "IN";
                    State.html('<option value="">Select State</option>');
                    City.html('<option value="">Select City</option>');

                    $.ajax({
                        url: `${config.cUrl}/${selectedCountryCode}/states`,
                        headers: { "X-CSCAPI-KEY": config.ckey },
                        method: 'GET',
                        success: function (data) {
                            $.each(data, function (index, state) {
                                State.append($('<option>', {
                                    value: state.iso2,
                                    text: state.name
                                }));
                            });
                            resolve();
                        },
                        error: function (error) {
                            reject(error);
                        }
                    });
                })

            } catch (err) {
                console.log(err);
            }

        }

        async function renderCities() {
            try {
                return new Promise((resolve, reject) => {
                    Show_Spinner();

                    City.prop('disabled', false).css('pointer-events', 'auto');

                    const selectedCountryCode = "IN";
                    const selectedStateCode = State.val();
                    City.html('<option value="">Select City</option>');

                    if (selectedStateCode != "") {
                        $.ajax({
                            url: `${config.cUrl}/${selectedCountryCode}/states/${selectedStateCode}/cities`,
                            headers: { "X-CSCAPI-KEY": config.ckey },
                            method: 'GET',
                            success: function (data) {
                                $.each(data, function (index, city) {
                                    City.append($('<option>', {
                                        value: city.iso2,
                                        text: city.name
                                    }));
                                });
                                Hide_Spinner();
                                resolve();
                            },
                            error: function (error) {
                                reject(error);
                            }
                        });
                    }
                    else {
                        City.prop('disabled', true).css('pointer-events', 'auto');
                        Hide_Spinner();
                    }
                })


            } catch (err) {
                console.log(err);
            }

        }

        async function OnClick_courseDetail_link() {
            try {
                await Show_Spinner();
                $('#AddUpdateCommentModal').on('shown.bs.modal', function () {
                    $('#AddUpdateCommentModal').modal('show');

                });

                Id = this.name;
                dataToSend = {
                    StudentId: $(this).data("studentid")
                };
                const response = await Ajax_GetResult("Student_Admission.aspx", "Get_CourseDetail", dataToSend);
                const data = JSON.parse(response.d);
                console.log(data);
                if (data.length > 0) {
                    var html = "";
                    $("#tblCourse").empty();
                    $.each(data, function (index, item) {

                        html += `
                        <tr>
                            <td>${item.SlNo}</td>
                            <td>${item.Course_Name}</td>
                            <td>${item.Course_Duration} ${item.Duration_Type}</td>
                            <td>₹ ${item.Fee}</td>
                        </tr>
                    `;
                    })
                    $("#tblCourse").html(html);
                    $("#tblCourseDiv").removeClass("hide");
                }
                else {
                    $("#tblCourseDiv").addClass("hide");
                }

                dataToSend = {
                    StudentId: $(this).data("studentid")
                };
                const response1 = await Ajax_GetResult("Student_Admission.aspx", "Get_FeeDetail", dataToSend);
                const data1 = JSON.parse(response1.d);
                console.log(data1)

                const item = data1[0];

                TotalAmount.html(item.TotalAmount);
                Concession.html(item.Concession);
                NetAmount.html(item.NetAmount);
                PaidAmount.html(item.PaidAmount);
                TotalDues.html(item.DuesAmount);
                PaymentMode.html(item.PaymentMode);




            } catch (err) {
                console.log(err);
            }
            finally {
                await Hide_Spinner();
            }

        }
        async function OnClick_BtnAdd() {
            if (formAuthentication) {
                formValidationInstance.validate().then(async function (StudentId) {
                    if (StudentId === 'Valid') {
                        try {
                            const result = await Confirm("Yes, Add it !", "Are you sure want to Add ?")

                            if (result.isConfirmed) {
                                await Show_Spinner();

                                dataToSend = {
                                    Id: Id,
                                    Comment: Comment.val()
                                }

                                const response = await Ajax_GetResult("Student_Admission.aspx", "Add_Comment", dataToSend);
                                if (response.d > 0)
                                    Success("Added", "Comment Added Successfully");
                                else
                                    Failed("Comment Added Failed !")


                            }
                        } catch (err) {
                            console.log(err);
                        }
                        finally {
                            await Hide_Spinner();
                            $('#tblStudentAdmission').DataTable().ajax.reload();
                            $('#AddUpdateCommentModal').modal('toggle');
                        }



                    } else {
                        console.log('Form is invalid, display errors.');
                    }
                });
            }
        }
        async function OnClick_BtnUpdate() {

            if (formAuthentication) {
                formValidationInstance.validate().then(async function (status) {
                    if (status === 'Valid') {
                        try {
                            const result = await Confirm("Yes, Update it !", "Are you sure want to Update ?")

                            if (result.isConfirmed) {
                                await Show_Spinner();

                                dataToSend = {
                                    StudentId: StudentId.val(),
                                    AdmissionNo: AdmissionNo.val(),
                                    RollNo: RollNo.val(),
                                    StudentName: StudentName.val(),
                                    Mobile: Mobile.val(),
                                    Gender: Gender.val(),
                                    Email: Email.val(),
                                    DOB: DOB.val(),
                                    FatherName: FatherName.val(),
                                    FatherOccupation: FatherOccupation.val(),
                                    FatherContactNo: FatherContactNo.val(),
                                    MotherName: MotherName.val(),
                                    State: State.find('option:selected').text(),
                                    City: City.find('option:selected').text(),
                                    Pincode: Pincode.val(),
                                    Address: Address.val()
                                }

                                const response = await Ajax_GetResult("Student_Admission.aspx", "Update_Student_Admission", dataToSend);
                                if (response.d > 0) {
                                    $('#tblStudentAdmission').DataTable().ajax.reload();
                                    $('#EditUpdateStudentModal').modal('toggle');
                                    Success("Updated", "Student Updated Successfully",);
                                }
                                else {
                                    Failed("Student Updated Failed !")
                                }


                            }
                        } catch (err) {
                            console.log(err);
                        }
                        finally {
                            await Hide_Spinner();
                        }



                    } else {
                        console.log('Form is invalid, display errors.');
                    }
                });
            }



        }

        document.addEventListener('DOMContentLoaded', function () {
            // Ensure the form exists before trying to validate it

            if (!formAuthentication) {
                console.error("Form not found!");
                return;
            }
            console.log("Form found:", formAuthentication);


            const GenderSelect = jQuery(formAuthentication.querySelector('[name="txtGender"]'));
            const StateSelect1 = jQuery(formAuthentication.querySelector('[name="txtState"]'));
            const CitySelect1 = jQuery(formAuthentication.querySelector('[name="txtCity"]'));
            // Initialize the form validation
            formValidationInstance = FormValidation.formValidation(formAuthentication, {
                fields: {
                    txtStudentName: {
                        validators: {
                            notEmpty: {
                                message: "Please enter student name"
                            },
                            stringLength: {
                                min: 3,
                                message: "Student Name must be more than 3 characters"
                            }
                        }
                    },
                    txtMobile: {
                        validators: {
                            notEmpty: {
                                message: "Please enter Mobile"
                            },
                            regexp: {
                                regexp: /^\d{10}$/,
                                message: "Please enter a valid mobile number with 10 digits"
                            }
                        }
                    },
                    txtGender: {
                        validators: {
                            notEmpty: {
                                message: "Please select gender"
                            }
                        }
                    },
                    txtEmail: {
                        validators: {
                            notEmpty: {
                                message: "Please enter your email"
                            },
                            emailAddress: {
                                message: "Please enter valid email address"
                            }
                        }
                    },
                    txtDOB: {
                        validators: {
                            notEmpty: {
                                message: "Please select DOB"
                            }
                        }
                    },
                    txtFatherName: {
                        validators: {
                            notEmpty: {
                                message: "Please enter father name"
                            },
                            stringLength: {
                                min: 3,
                                message: "Father Name must be more than 3 characters"
                            }
                        }
                    },
                    txtFatherOccupation: {
                        validators: {
                            notEmpty: {
                                message: "Please enter father Occupation"
                            },
                            stringLength: {
                                min: 3,
                                message: "Father Occupation must be more than 3 characters"
                            }
                        }
                    },
                    txtFatherContactNo: {
                        validators: {
                            notEmpty: {
                                message: "Please enter father ContactNo"
                            },
                            regexp: {
                                regexp: /^\d{10}$/,
                                message: "Please enter a valid mobile number with 10 digits"
                            }
                        }
                    },
                    txtMotherName: {
                        validators: {
                            notEmpty: {
                                message: "Please enter mother name"
                            },
                            stringLength: {
                                min: 3,
                                message: "Mother Name must be more than 3 characters"
                            }
                        }
                    },
                    txtState: {
                        validators: {
                            notEmpty: {
                                message: "Please select State"
                            }
                        }
                    },
                    txtCity: {
                        validators: {
                            notEmpty: {
                                message: "Please select City"
                            }
                        }
                    },
                    txtPincode: {
                        validators: {
                            notEmpty: {
                                message: "Please enter Pincode"
                            },
                            regexp: {
                                regexp: /^\d{6}$/,
                                message: "Please enter a valid pincode with 6 digits"
                            }
                        }
                    },
                    txtAddress: {
                        validators: {
                            notEmpty: {
                                message: "Please enter Address"
                            },
                            stringLength: {
                                min: 6,
                                message: "Address must be more than 6 characters"
                            }
                        }
                    }
                },
                plugins: {
                    trigger: new FormValidation.plugins.Trigger(),
                    bootstrap5: new FormValidation.plugins.Bootstrap5({
                        eleValidClass: "",
                        rowSelector: ".validation"
                    }),
                    submitButton: new FormValidation.plugins.SubmitButton(),
                    autoFocus: new FormValidation.plugins.AutoFocus()
                },
                init: function (instance) {
                    instance.on("plugins.message.placed", function (event) {
                        if (event.element.parentElement.classList.contains("input-group")) {
                            event.element.parentElement.insertAdjacentElement("afterend", event.messageElement);
                        }
                    });
                }
            });

            if (GenderSelect.length) {
                select2Focus(GenderSelect);
                GenderSelect.wrap('<div class="position-relative"></div>');
                GenderSelect.select2({
                    placeholder: "Select Gender",
                    dropdownParent: GenderSelect.parent()
                }).on("change", function () {
                    formValidationInstance.revalidateField("txtGender");
                });
            }
            if (StateSelect1.length) {
                select2Focus(StateSelect1);
                StateSelect1.wrap('<div class="position-relative"></div>');
                StateSelect1.select2({
                    placeholder: "Select State",
                    dropdownParent: StateSelect1.parent()
                }).on("change", function () {
                    formValidationInstance.revalidateField("txtState");
                });
            }

            if (CitySelect1.length) {
                select2Focus(CitySelect1);
                CitySelect1.wrap('<div class="position-relative"></div>');
                CitySelect1.select2({
                    placeholder: "Select City",
                    dropdownParent: CitySelect1.parent()
                }).on("change", function () {
                    formValidationInstance.revalidateField("txtCity");
                });
            }
            
            
        });
    </script>
</asp:Content>

