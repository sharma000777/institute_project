<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true" CodeFile="Report_Admission.aspx.cs" Inherits="Admin_Report_Admission" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Admission Report | Institute Management Software</title>
    <style>
        .table th {
            color: #433c50;
        }

        @media screen and (min-width: 768px) {
            #left_Search {
                width: 50%;
            }
            #left_Search0 {
                width: 60%;
            }
            #left_Search1 {
                min-width: 100%;
            }

            #right_Export,#right_Export1 {
                width: 60%;
            }
            #right_Export0 {
                width: 40%;
            }
        }

        @media screen and (max-width: 768px) {
            #left_Search,#left_Search0,#left_Search1 {
                width: 100%;
            }

                #left_Search.#left_Search0,#left_Search1 > div {
                    flex-wrap: wrap;
                }

            #right_Export,#right_Export0,#right_Export1 {
                width: 100%;
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row g-6 mb-6">
        <div class="col-md">
            <div class="card">
                <div class="card-header flex-column flex-md-row" style="display: flex; justify-content: space-between;">
                    <div class="dt-action-buttons pt-3 pt-md-0" id="left_Search0">
                        <div class="row g-6" style="font-size: 1rem;">
                            <div class="col-md-4">
                                <h5><span class="text-muted fw-light">Reports /</span> Admission Report</h5>
                            </div>
                        </div>
                    </div>
                    <div class="dt-action-buttons pt-3 pt-md-0" id="right_Export0">
                        <div class="row g-6" style="font-size: 1rem;justify-content:end">
                            <div class="col-md-8 mb-3 hide" id="OperatorDiv">
                                <div class="form-floating form-floating-outline">
                                    <div class="select2-primary">
                                        <select id="txtOperator" name="txtOperator" class="select2 form-select">
                                        </select>
                                    </div>
                                    <label for="txtOperator">Select Operator *</label>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <label class="switch switch-lg">
                                    <input type="checkbox" class="switch-input" id="txtOperatorToggle">
                                    <span class="switch-toggle-slider">
                                        <span class="switch-on">
                                            <i class="ri-check-line"></i>
                                        </span>
                                        <span class="switch-off">
                                            <i class="ri-close-line"></i>
                                        </span>
                                    </span>
                                    <span class="switch-label">Operator</span>
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card-header flex-column flex-md-row" style="display: flex; justify-content: space-between;">
                    <div class="dt-action-buttons pt-3 pt-md-0" id="left_Search">
                        <div class="dt-buttons btn-group" style="width: 100%; display: flex;">
                            <div class="row" style="width: 100%">
                                <div class="col-md-8">
                                    <div class="form-floating form-floating-outline mb-3" style="margin-right: 1rem; width: 100%">
                                        <select name="txtCourseId" id="txtCourseId" class="select2 form-select" data-allow-clear="true">
                                            <option value="">Select Course</option>
                                        </select>
                                        <label for="txtCourseId">Filter by Course</label>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                    <div class="dt-action-buttons pt-3 pt-md-0" id="right_Export">

                        <div class="dt-buttons btn-group" style="width: 100%; display: flex; justify-content: end">
                            <div id="reportrange" style="background: #fff; cursor: pointer; padding: 10px 10px; border: 1px solid #ccc; max-width: fit-content;">
                                <i class="ri-calendar-2-line"></i>&nbsp;<span></span><i class="ri-arrow-down-s-line" style="margin-left:5px"></i>
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
                <div class="card-header flex-column flex-md-row" style="display: flex; justify-content: space-between;">
                    <div class="dt-action-buttons pt-3 pt-md-0" id="left_Search1">
                        <div class="row g-6" style="font-size: 1rem;">
                            <div class="col-3 mb-3 ">
                                <div class="mt-2 mb-2">
                                    <label for="txtAllStudent" style="cursor: pointer"><i class="menu-icon tf-icons ri-list-radio"></i>All</label>
                                    <input type="radio" id="txtAllStudent"
                                        name="Enrollment" class="form-check-input" checked>
                                </div>
                            </div>
                            <div class="col-3 mb-3 ">
                                <div class="mt-2 mb-2">
                                    <label for="txtNewStudent" style="cursor: pointer"><i class="menu-icon tf-icons ri-file-add-line"></i>New</label>
                                    <input type="radio" id="txtNewStudent"
                                        name="Enrollment" class="form-check-input">
                                </div>
                            </div>
                            <div class="col-3 mb-3 ">
                                <div class="mt-2 mb-2">
                                    <label for="txtCallStudent" style="cursor: pointer"><i class="menu-icon tf-icons ri-phone-line"></i>From Call</label>
                                    <input type="radio" id="txtCallStudent"
                                        name="Enrollment" class="form-check-input">
                                </div>
                            </div>
                            <div class="col-3 mb-3">
                                <div class="mt-2 mb-2">
                                    <label for="txtVisitorStudent" style="cursor: pointer"><i class="menu-icon tf-icons ri-government-line"></i>From Visitor</label>
                                    <input type="radio" id="txtVisitorStudent"
                                        name="Enrollment" class="form-check-input">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="dt-action-buttons pt-3 pt-md-0" id="right_Export1">

                        
                    </div>
                </div>
                <div class="card-body">
                    <div class="table-responsive text-nowrap">
                        <table class="table nowrap" id="tblAdmission">
                            <caption class="ms-4">
                                List of Admission
                            </caption>
                            <thead>
                                <tr>
                                    <th>SlNo</th>
                                    <th>Photo</th>
                                    <th>Admission Type</th>
                                    <th>Date of Admission</th>
                                    <th>Admission No</th>
                                    <th>Student Name</th>
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
                                    <th>Student Id</th>
                                    <th>Roll No</th>
                                </tr>
                            </thead>
                        </table>

                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script type="text/javascript">

        let CourseId;
        let table, url, dataToSend, selectedDateRangeName, OperatorToggle, OperatorDiv, IsOperator, Operator;
        let StudentType, AllStudent, NewStudent, CallStudent, VisitorStudent;

        StudentType = "All";
        IsOperator = false;

        const defaultRun = async () => {
            try {
                await renderStudentAdmission();
                await renderCourse();
            } catch (err) {
                console.log(err);
            }
        }

        $(document).ready(function () {
            OperatorToggle = $("#txtOperatorToggle");
            Operator = $("#txtOperator");
            OperatorDiv = $("#OperatorDiv");

            AllStudent = $("#txtAllStudent");
            NewStudent = $("#txtNewStudent");
            CallStudent = $("#txtCallStudent");
            VisitorStudent = $("#txtVisitorStudent");

            CourseId = $("#txtCourseId");

            (async function () {
                await Show_Spinner();
                await defaultRun().finally(async () => {
                    await Hide_Spinner();
                })
            })();
            $(document).on("click", "#txtOperatorToggle", OnClick_OperatorToggle);

            $(document).on("click", "#txtAllStudent", OnClick_AllStudent);
            $(document).on("click", "#txtNewStudent", OnClick_NewStudent);
            $(document).on("click", "#txtCallStudent", OnClick_CallStudent);
            $(document).on("click", "#txtVisitorStudent", OnClick_VisitorStudent);

            Operator.change(OnChange_Operator);
            CourseId.change(OnChange_CourseId);

        });
        async function OnClick_OperatorToggle() {
            try {
                await Show_Spinner();
                if ($(this).is(":checked")) {
                    IsOperator = true;
                    OperatorDiv.removeClass("hide");
                    await renderOperator();
                    await renderCourse();
                }
                else {
                    IsOperator = false;
                    AllStudent.prop("checked", true);
                    StudentType = "All";
                    await renderCourse();
                    await renderStudentAdmission();
                    OperatorDiv.addClass("hide");

                }
            } catch (err) {
                console.log(err);
            }
            finally {
                await Hide_Spinner();
            }
        }
        async function OnClick_AllStudent() {
            try {
                await Show_Spinner();
                if ($(this).is(":checked")) {
                    StudentType = "All";
                    await renderStudentAdmission();
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
        async function OnClick_NewStudent() {
            try {
                await Show_Spinner();
                if ($(this).is(":checked")) {
                    StudentType = "New";
                    await renderStudentAdmission();
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
        async function OnClick_CallStudent() {
            try {
                await Show_Spinner();
                if ($(this).is(":checked")) {
                    StudentType = "Call";
                    await renderStudentAdmission();
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
        async function OnClick_VisitorStudent() {
            try {
                await Show_Spinner();
                if ($(this).is(":checked")) {
                    StudentType = "Visitor";
                    await renderStudentAdmission();
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
                        OperatorId: Operator.val(),
                        IsOperator: IsOperator
                    };
                    var dataToSend = "";
                    for (var key in parameters) {
                        if (parameters.hasOwnProperty(key)) {
                            dataToSend += key + "='" + parameters[key] + "'&";
                        }
                    }
                    // Remove the trailing '&' character
                    dataToSend = dataToSend.slice(0, -1);
                    var url = "Report_Admission.aspx/Get_Admission_Detail_ByDate?" + dataToSend;
                    await GetAdmission_Details(url);
                    $('#tblAdmission').DataTable().ajax.reload();
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

                cb(start, end,"Custom Range");

            } catch (err) {
                console.log(err);
            }

        }
        async function Get_MinDate() {
            try {
                const response = await Ajax_GetResult_WithoutParameter("Report_Admission.aspx", "Get_MinDate");
                return response.d;
            } catch (err) {
                console.log(err);
            }

        }
        async function GetAdmission_Details(url) {
            try {
                return new Promise((resolve, reject) => {

                    // Destroy existing DataTable if it exists
                    if ($.fn.DataTable.isDataTable('#tblAdmission')) {
                        $('#tblAdmission').DataTable().destroy();
                    }

                    // Initialize DataTable
                    const table = $('#tblAdmission').DataTable({
                        "ajax": {
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
                                return json.data;
                            },
                            "error": function (err) {
                                reject(err);
                            }
                        },
                        "columns": [
                            { "data": "SlNo", "name": "SlNo", "width": "0rem", "orderable": true },
                            {
                                "data": "Photo",
                                "render": function (data, type, JsonResultRow, meta) {
                                    return '<img src="../UserLogin_Content/upload/' + data + '" class="imag-fluid" style="width: 2rem;height: 3rem;">';
                                },
                                "autoWidth": true,
                                "orderable": false
                            },
                            {
                                "data": "AdmissionType",
                                "render": function (data, type, row, meta) { // Added parameters
                                    var rowHtml;
                                    if (data === "New")
                                        rowHtml = '<span class="badge rounded-pill text-bg-Success me-1" style="font-size:14px;">' + data + '</span>';
                                    else if (data === "Call")
                                        rowHtml = '<span class="badge rounded-pill text-bg-info me-1" style="font-size:14px;">' + data + '</span>';
                                    else if (data == "Visitor")
                                        rowHtml = '<span class="badge rounded-pill text-bg-primary me-1" style="font-size:14px;">' + data + '</span>';
                                    else
                                        rowHtml = '<span class="badge rounded-pill bg-label-Success me-1" style="font-size:14px;">' + data + '</span>';
                                    return rowHtml;
                                },
                                "orderable": false,
                                "width": "0rem"
                            },
                            { "data": "Date", "name": "Date", "autoWidth": true },
                            { "data": "AdmissionNo", "name": "AdmissionNo", "autoWidth": true },
                            { "data": "StudentName", "name": "StudentName", "autoWidth": true },
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
                            { "data": "StudentId", "name": "StudentId", "autoWidth": true },
                            { "data": "RollNo", "name": "RollNo", "autoWidth": true }
                        ],
                        "initComplete": function () {
                            resolve();
                        },
                        "serverSide": true,
                        "processing": true,
                        "ordering": true,
                        "responsive": true,
                        "language": {
                            "processing": "Processing...",
                            "emptyTable": "No admission to display on " + selectedDateRangeName + ". Please check back later or review previous records."

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
                });
            } catch (err) {
                console.log(err);
            }
        }
        async function renderStudentAdmission() {
            try {
                var parameters = {
                    StudentType: StudentType,
                    OperatorId: Operator.val(),
                    IsOperator: IsOperator
                };
                var dataToSend = "";
                for (var key in parameters) {
                    if (parameters.hasOwnProperty(key)) {
                        dataToSend += key + "='" + parameters[key] + "'&";
                    }
                }
                // Remove the trailing '&' character
                dataToSend = dataToSend.slice(0, -1);
                var url = "Report_Admission.aspx/Get_Student_Admission?" + dataToSend;
                await GetAdmission_Details(url);
                await DateRange();
            } catch (err) {
                console.log(err);
            }
        }
        async function renderCourse() {
            try {
                const courseResponse = await Ajax_GetResult_WithoutParameter("Report_Admission.aspx", "Get_Course");
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
        async function renderOperator() {
            try {
                const response = await Ajax_GetResult_WithoutParameter("Report_Admission.aspx", "Get_Operator");
                const data = JSON.parse(response.d);
                if (data.length > 0) {
                    Operator.html('<option value="" Selected>Select Operator</option>');
                    $.each(data, function (index, item) {
                        Operator.append($('<option>', {
                            value: item.LoginId,
                            text: item.Name + "( " + item.Mobile + " )"
                        }));
                    });
                }

            } catch (err) {
                console.log(err);
            }
        }
        async function OnChange_CourseId() {
            try {
                await Show_Spinner();
                var parameters = {
                    CourseId: CourseId.val(),
                    StudentType: StudentType,
                    OperatorId: Operator.val(),
                    IsOperator: IsOperator
                };
                var dataToSend = "";
                for (var key in parameters) {
                    if (parameters.hasOwnProperty(key)) {
                        dataToSend += key + "='" + parameters[key] + "'&";
                    }
                }
                // Remove the trailing '&' character
                dataToSend = dataToSend.slice(0, -1);

                var url = "Report_Admission.aspx/Get_Admission_Detail_ByCourse?" + dataToSend;
                await GetAdmission_Details(url);

            } catch (err) {
                console.log(err);
            }
            finally {
                await Hide_Spinner();
                $('#tblAdmission').DataTable().ajax.reload();
            }


        }
        async function OnChange_Operator() {
            try {
                await Show_Spinner();
                AllStudent.prop("checked", true);
                StudentType = "All";
                await renderCourse();
                await renderStudentAdmission();

            } catch (err) {
                console.log(err);
            }
            finally {
                await Hide_Spinner();
                $('#tblAdmission').DataTable().ajax.reload();
            }
        }

    </script>
</asp:Content>

