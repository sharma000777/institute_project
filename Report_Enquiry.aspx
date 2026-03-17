<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true" CodeFile="Report_Enquiry.aspx.cs" Inherits="Admin_Report_Enquiry" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Enquiry Report | Institute Management Software</title>
    <style>
        .table th {
            color: #433c50;
        }

        @media screen and (min-width: 768px) {
            #left_Search {
                width: 100%;
            }
           #left_Search0 {
                width: 60%;
            }

            #left_Search1 {
                width: 100%;
            }

            #right_Export {
                width: 30%;
            }
            #right_Export0 {
                width: 40%;
            }

            #right_Export1 {
                width: 30%;
            }
        }

        @media screen and (max-width: 768px) {
            #left_Search,#left_Search0, #left_Search1 {
                width: 100%;
            }

                #left_Search,#left_Search0, #left_Search1 > div {
                    flex-wrap: wrap;
                }

            #right_Export,#right_Export0, #right_Export1 {
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
                                <h5><span class="text-muted fw-light">Reports /</span> Enquiry Report</h5>
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
                        <div class="row g-6" style="font-size: 1rem;">
                            <div class="col-xl-2 col-md-3 mb-3 ">
                                <div class="mt-2 mb-2">
                                    <label for="txtAllEnquiry" style="cursor: pointer"><i class="menu-icon tf-icons ri-list-radio"></i>Both</label>
                                    <input type="radio" id="txtAllEnquiry"
                                        name="Customer" class="form-check-input" checked>
                                </div>
                            </div>
                            <div class="col-xl-2 col-md-3 mb-3 ">
                                <div class="mt-2 mb-2">
                                    <label for="txtCallEnquiry" style="cursor: pointer"><i class="menu-icon tf-icons ri-phone-line"></i>Call</label>
                                    <input type="radio" id="txtCallEnquiry"
                                        name="Customer" class="form-check-input">
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-3 mb-3">
                                <div class="mt-2 mb-2">
                                    <label for="txtVisitorEnquiry" style="cursor: pointer"><i class="menu-icon tf-icons ri-government-line"></i>Visitor</label>
                                    <input type="radio" id="txtVisitorEnquiry"
                                        name="Customer" class="form-check-input">
                                </div>
                            </div>
                            <div class="col-xl-4 col-md-6 mb-3">
                                <div class="form-floating form-floating-outline">
                                    <div class="select2-primary">
                                        <select id="txtContactMedia" name="txtContactMedia" class="select2 form-select">
                                        </select>
                                    </div>
                                    <label for="txtContactMedia">Contact Media *</label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="dt-action-buttons pt-3 pt-md-0" id="right_Export">

                        <div class="dt-buttons btn-group" style="width: 100%; display: flex; justify-content: end">
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
                <div class="card-header flex-column flex-md-row" style="display: flex; justify-content: space-between;">
                    <div class="dt-action-buttons pt-3 pt-md-0" id="left_Search1">
                        <div class="row g-6" style="font-size: 1rem;">
                            <div class="col-lg-2 col-md-2 mb-3 ">
                                <div class="mt-2 mb-2">
                                    <label for="txtAllStudent" style="cursor: pointer"><i class="menu-icon tf-icons ri-list-radio"></i>All</label>
                                    <input type="radio" id="txtAllStudent"
                                        name="Enrollment" class="form-check-input" checked>
                                </div>
                            </div>
                            <div class="col-xl-3 col-lg-3 col-md-3 mb-3">
                                <div class="mt-2 mb-2">
                                    <label for="txtEnrolled" style="cursor: pointer"><i class="menu-icon tf-icons ri-checkbox-circle-line"></i>Enrolled</label>
                                    <input type="radio" id="txtEnrolled"
                                        name="Enrollment" class="form-check-input">
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 mb-3 ">
                                <div class="mt-2 mb-2">
                                    <label for="txtPendingEnrolled" style="cursor: pointer"><i class="menu-icon tf-icons ri-calendar-schedule-line"></i>Pending Enrollee</label>
                                    <input type="radio" id="txtPendingEnrolled"
                                        name="Enrollment" class="form-check-input">
                                </div>
                            </div>

                            <div class="col-lg-3 col-md-3 mb-3">
                                <div class="mt-2 mb-2">
                                    <label for="txtNotEnrolled" style="cursor: pointer"><i class="menu-icon tf-icons ri-close-circle-line"></i>Not Enrolled</label>
                                    <input type="radio" id="txtNotEnrolled"
                                        name="Enrollment" class="form-check-input">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="dt-action-buttons pt-3 pt-md-0" id="right_Export1">
                        <div class="form-floating form-floating-outline validation" id="ReasonDiv">
                            <select name="txtReason" id="txtReason" class="select2 form-select" data-allow-clear="true">
                                <option value="">Select Reason</option>
                            </select>
                            <label for="txtReason">Reason *</label>
                        </div>

                    </div>
                </div>
                <div class="card-body">
                    <div class="table-responsive text-nowrap">
                        <table class="table nowrap" id="tblEnquiry">
                            <caption class="ms-4">
                                List of Enquiry
                            </caption>
                            <thead>
                                <tr>
                                    <th>SlNo</th>
                                    <th>Enquiry Type</th>
                                    <th>Status</th>
                                    <th>Enquiry Date</th>
                                    <th>Follow Up</th>
                                    <th>Contact Media</th>
                                    <th>Name</th>
                                    <th>Mobile</th>
                                    <th>Qualification</th>
                                    <th>Course Name</th>
                                    <th>Duration</th>
                                    <th>Fee</th>
                                    <th>Comment</th>
                                    <th>Reason</th>
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

        let table, url, BtnAdd, BtnUpdate, dataToSend, selectedDateRangeName, ContactMedia, OperatorToggle, OperatorDiv, IsOperator, Operator;
        let EnquiryType, EnrollmentType, AllEnquiry, CallEnquiry, VisitorEnquiry, AllStudent, Enrolled, PendingEnrolled, NotEnrolled, Reason, ReasonDiv;

        EnquiryType = "All";
        EnrollmentType = "All";
        IsOperator = false;


        const defaultRun = async () => {
            try {
                await renderEnquiry();
                await renderReason();
                await renderContactMedia();
            } catch (err) {
                console.log(err);
            }
        }

        $(document).ready(function () {
            OperatorToggle = $("#txtOperatorToggle");
            Operator = $("#txtOperator");
            OperatorDiv = $("#OperatorDiv");

            AllEnquiry = $("#txtAllEnquiry");
            CallEnquiry = $("#txtCallEnquiry");
            VisitorEnquiry = $("#txtVisitorEnquiry");

            AllStudent = $("#txtAllStudent");
            Enrolled = $("#txtEnrolled");
            PendingEnrolled = $("#txtPendingEnrolled");
            NotEnrolled = $("#txtNotEnrolled");
            Reason = $("#txtReason");
            ReasonDiv = $("#ReasonDiv");
            ContactMedia = $('#txtContactMedia');

            (async function () {
                await Show_Spinner();
                await defaultRun().finally(async () => {
                    await Hide_Spinner();
                })
            })();

            
            $(document).on("click", "#txtOperatorToggle", OnClick_OperatorToggle);

            $(document).on("click", "#txtAllEnquiry", OnClick_AllEnquiry);
            $(document).on("click", "#txtCallEnquiry", OnClick_CallEnquiry);
            $(document).on("click", "#txtVisitorEnquiry", OnClick_VisitorEnquiry);

            $(document).on("click", "#txtAllStudent", OnClick_AllStudent);
            $(document).on("click", "#txtEnrolled", OnClick_Enrolled);
            $(document).on("click", "#txtPendingEnrolled", OnClick_PendingEnrolled);
            $(document).on("click", "#txtNotEnrolled", OnClick_NotEnrolled);

            Operator.change(OnChange_Operator);
            Reason.change(OnChange_Reason);
            ContactMedia.change(OnChange_ContactMedia);

        });
        async function OnClick_OperatorToggle() {
            try {
                await Show_Spinner();
                if ($(this).is(":checked")) {
                    IsOperator = true;
                    OperatorDiv.removeClass("hide");
                    await renderOperator();
                }
                else {
                    IsOperator = false;

                    AllEnquiry.prop("checked", true);
                    AllStudent.prop("checked", true);
                    EnquiryType = "All";
                    EnrollmentType = "All";
                    await renderContactMedia();
                    await renderReason();
                    await renderEnquiry();

                    OperatorDiv.addClass("hide");
                    
                }
            } catch (err) {
                console.log(err);
            }
            finally {
                await Hide_Spinner();
            }
        }
        async function OnClick_AllEnquiry() {
            try {
                await Show_Spinner();
                if ($(this).is(":checked")) {
                    EnquiryType = "All";
                    await renderEnquiry();
                    await renderContactMedia();
                    await renderReason();
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
        async function OnClick_CallEnquiry() {
            try {
                await Show_Spinner();
                if ($(this).is(":checked")) {
                    EnquiryType = "Call";
                    await renderEnquiry();
                    await renderContactMedia();
                    await renderReason();
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
        async function OnClick_VisitorEnquiry() {
            try {
                await Show_Spinner();
                if ($(this).is(":checked")) {
                    EnquiryType = "Visitor";
                    await renderEnquiry();
                    await renderContactMedia();
                    await renderReason();
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

        async function OnClick_AllStudent() {
            try {
                await Show_Spinner();
                if ($(this).is(":checked")) {
                    EnrollmentType = "All";
                    await renderEnquiry();
                    await renderContactMedia();
                    ReasonDiv.removeClass("hide");
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
        async function OnClick_Enrolled() {
            try {
                await Show_Spinner();
                if ($(this).is(":checked")) {
                    EnrollmentType = "Enrolled";
                    await renderEnquiry();
                    await renderContactMedia();
                    ReasonDiv.addClass("hide");
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
        async function OnClick_PendingEnrolled() {
            try {
                await Show_Spinner();
                if ($(this).is(":checked")) {
                    EnrollmentType = "Pending Enrolled";
                    await renderEnquiry();
                    await renderContactMedia();
                    ReasonDiv.addClass("hide");
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
        async function OnClick_NotEnrolled() {
            try {
                await Show_Spinner();
                if ($(this).is(":checked")) {
                    EnrollmentType = "Not Enrolled";
                    await renderEnquiry();
                    await renderContactMedia();
                    ReasonDiv.removeClass("hide");
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

        async function renderEnquiry() {
            try {
                var parameters = {
                    EnquiryType: EnquiryType,
                    EnrollmentType: EnrollmentType,
                    OperatorId: Operator.val(),
                    IsOperator: IsOperator
                };
                console.log(parameters)
                var dataToSend = "";
                for (var key in parameters) {
                    if (parameters.hasOwnProperty(key)) {
                        dataToSend += key + "='" + parameters[key] + "'&";
                    }
                }
                // Remove the trailing '&' character
                dataToSend = dataToSend.slice(0, -1);
                var url = "Report_Enquiry.aspx/Get_Enquiry_Detail?" + dataToSend;
                await GetEnquiry(url);
                await DateRange();
            } catch (err) {
                console.log(err);
            }
        }
        async function renderReason() {
            try {
                const response = await Ajax_GetResult_WithoutParameter("Report_Enquiry.aspx", "Get_Reason");
                const data = JSON.parse(response.d);
                if (data.length > 0) {
                    Reason.html('<option value="" Selected>Select Reason</option>');
                    $.each(data, function (index, item) {
                        Reason.append($('<option>', {
                            value: item.Reason_Name,
                            text: item.Reason_Name
                        }));
                    });
                }

            } catch (err) {
                console.log(err);
            }
        }
        async function renderOperator() {
            try {
                const response = await Ajax_GetResult_WithoutParameter("Report_Enquiry.aspx", "Get_Operator");
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
        async function renderContactMedia() {
            try {
                const response = await Ajax_GetResult_WithoutParameter("Report_Enquiry.aspx", "Get_ContactMedia");
                const data = JSON.parse(response.d);
                if (data.length > 0) {
                    ContactMedia.html('<option value="" Selected>Select Contact Media</option>');
                    $.each(data, function (index, item) {
                        ContactMedia.append($('<option>', {
                            value: item.Media_Name,
                            text: item.Media_Name
                        }));
                    });
                }

            } catch (err) {
                console.log(err);
            }
        }
        async function GetEnquiry(url) {

            try {
                return new Promise((resolve, reject) => {
                    table = $('#tblEnquiry').DataTable();

                    if ($.fn.DataTable.isDataTable('#tblEnquiry')) {
                        table.destroy();

                    }
                    table = $('#tblEnquiry').DataTable(
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
                                    console.log(return_data.data)
                                    return return_data.data;
                                },
                                "error": function (err) {
                                    reject(err);
                                }
                            },
                            "columns": [
                                { "data": "SlNo", "name": "SlNo", "width": "0rem", "orderable": true },
                                {
                                    "data": "EnquiryType",
                                    "render": function (data, type, row, meta) { // Added parameters
                                        var rowHtml;
                                        if (data === "Call")
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
                                {
                                    "data": "Status",
                                    "render": function (data, type, row, meta) { // Added parameters
                                        var rowHtml;
                                        if (data === "Completed" && row.Reason != "")
                                            rowHtml = '<span class="badge rounded-pill text-bg-danger me-1" style="font-size:14px;">Not Enrolled</span>';
                                        else if (data == "Completed" && row.Reason == "")
                                            rowHtml = '<span class="badge rounded-pill text-bg-info me-1" style="font-size:14px;">Pending Enrollee</span>';
                                        else if (data == "Admitted")
                                            rowHtml = '<span class="badge rounded-pill text-bg-success me-1" style="font-size:14px;">Enrolled</span>';
                                        else
                                            rowHtml = '<span class="badge rounded-pill bg-label-Success me-1" style="font-size:14px;"></span>';
                                        return rowHtml;
                                    },
                                    "orderable": false,
                                    "width": "0rem"
                                },
                                { "data": "Date", "name": "Date", "autoWidth": true },
                                { "data": "FollowUpDate", "name": "FollowUpDate", "autoWidth": true },
                                { "data": "ContactMedia", "name": "ContactMedia", "autoWidth": true },
                                { "data": "Name", "name": "Name", "autoWidth": true },
                                { "data": "Mobile", "name": "Mobile", "autoWidth": true },
                                { "data": "Qualification", "name": "Qualification", "autoWidth": true },
                                { "data": "Course_Name", "name": "Course_Name", "autoWidth": true },
                                {
                                    "data": "Course_Duration",
                                    "render": function (data, type, row, meta) { // Added parameters
                                        var rowHtml = "";
                                        rowHtml = data + " " + row.Duration_Type;
                                        return rowHtml;
                                    },
                                    "orderable": false,
                                    "autoWidth": true
                                },
                                { "data": "Fee", "name": "Fee", "autoWidth": true },
                                { "data": "Comment", "name": "Comment", "autoWidth": true },
                                { "data": "Reason", "name": "Reason", "autoWidth": true }
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
                                "emptyTable": "No enquiries to display on " + selectedDateRangeName + ". Please check back later or review previous records."

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
                        EnquiryType: EnquiryType,
                        EnrollmentType: EnrollmentType,
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
                    var url = "Report_Enquiry.aspx/Get_Enquiry_Detail_ByDate?" + dataToSend;
                    await GetEnquiry(url);
                    $('#tblEnquiry').DataTable().ajax.reload();
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
                const response = await Ajax_GetResult_WithoutParameter("Report_Enquiry.aspx", "Get_MinDate");
                return response.d;
            } catch (err) {
                console.log(err);
            }

        }
        async function OnChange_Operator() {
            try {
                await Show_Spinner();
                AllEnquiry.prop("checked", true);
                AllStudent.prop("checked", true);
                EnquiryType = "All";
                EnrollmentType = "All";
                await renderEnquiry();
                await renderContactMedia();
                await renderReason();

            } catch (err) {
                console.log(err);
            }
            finally {
                await Hide_Spinner();
                $('#tblEnquiry').DataTable().ajax.reload();
            }
        }
        async function OnChange_Reason() {
            try {
                await Show_Spinner();
                await renderContactMedia();
                var parameters = {
                    EnquiryType: EnquiryType,
                    EnrollmentType: EnrollmentType,
                    Reason: Reason.val(),
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

                var url = "Report_Enquiry.aspx/Get_Enquiry_Detail_ByReason?" + dataToSend;
                await GetEnquiry(url);

            } catch (err) {
                console.log(err);
            }
            finally {
                await Hide_Spinner();
                $('#tblEnquiry').DataTable().ajax.reload();
            }
        }
        async function OnChange_ContactMedia() {
            try {
                await Show_Spinner();
                await renderReason();
                var parameters = {
                    EnquiryType: EnquiryType,
                    EnrollmentType: EnrollmentType,
                    ContactMedia: ContactMedia.val(),
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

                var url = "Report_Enquiry.aspx/Get_Enquiry_Detail_ByContactMedia?" + dataToSend;
                await GetEnquiry(url);

            } catch (err) {
                console.log(err);
            }
            finally {
                await Hide_Spinner();
                $('#tblEnquiry').DataTable().ajax.reload();
            }
        }

    </script>
</asp:Content>

