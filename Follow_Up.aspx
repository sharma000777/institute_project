<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true" CodeFile="Follow_Up.aspx.cs" Inherits="Admin_Follow_Up" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Follow Up | Institute Management Software</title>
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
                        <h5><span class="text-muted fw-light">Master /</span> Follow Up</h5>
                    </div>
                </div>
                <div class="card-header flex-column flex-md-row" style="display: flex; justify-content: space-between;">
                    <div class="dt-action-buttons pt-3 pt-md-0" id="left_Search">
                        <div class="row g-6" style="font-size: 1rem;">
                            <div class="col-4 mb-3 ">
                                <div class="mt-2 mb-2">
                                    <label for="txtAllEnquiry" style="cursor: pointer"><i class="menu-icon tf-icons ri-list-radio"></i>Both</label>
                                    <input type="radio" id="txtAllEnquiry"
                                        name="Customer" class="form-check-input" checked>
                                </div>
                            </div>
                            <div class="col-4 mb-3 ">
                                <div class="mt-2 mb-2">
                                    <label for="txtCallEnquiry" style="cursor: pointer"><i class="menu-icon tf-icons ri-phone-line"></i>Call</label>
                                    <input type="radio" id="txtCallEnquiry"
                                        name="Customer" class="form-check-input">
                                </div>
                            </div>
                            <div class="col-4 mb-3">
                                <div class="mt-2 mb-2">
                                    <label for="txtVisitorEnquiry" style="cursor: pointer"><i class="menu-icon tf-icons ri-government-line"></i>Visitor</label>
                                    <input type="radio" id="txtVisitorEnquiry"
                                        name="Customer" class="form-check-input">
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
                <div class="card-body">
                    <div class="table-responsive text-nowrap">
                        <table class="table nowrap" id="tblEnquiry">
                            <caption class="ms-4">
                                List of Enquiry
                            </caption>
                            <thead>
                                <tr>
                                    <th>SlNo</th>
                                    <th>Action</th>
                                    <th>Enquiry Type</th>
                                    <th>FollowUp Date</th>
                                    <th>Name</th>
                                    <th>Mobile</th>
                                    <th>Qualification</th>
                                    <th>Course Name</th>
                                    <th>Duration</th>
                                    <th>Fee</th>
                                    <th>Date</th>
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

    <!-- Edit User Modal -->
    <div class="modal fade" id="AddUpdateCommentModal" tabindex="-1" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
        <div class="modal-dialog modal-dialog-centered modal-lg modal-simple modal-edit-user">
            <div class="modal-content">
                <div class="modal-body p-0">
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    <div class="text-center mb-6">
                        <h4 class="mb-2">Update Comment</h4>
                    </div>
                    <div class="row g-5" id="formAuthentication1">
                        <div class="col-12 col-md-6">
                            <i class="ri-user-3-line ri-24px"></i><span class="fw-medium mx-2">Full Name:</span> <span id="txtName1"></span>
                        </div>
                        <div class="col-12 col-md-6">
                            <i class="ri-phone-line ri-24px"></i><span class="fw-medium mx-2">Contact:</span> <span id="txtMobile1"></span>
                        </div>
                        <div class="col-12 col-md-12">
                            <div class="form-floating form-floating-outline">
                                <textarea id="txtComment" name="txtComment" class="form-control" placeholder="Enter comments" style="height: 8rem"></textarea>
                                <label for="txtComment">Enter Comment</label>
                            </div>
                        </div>

                        <div class="col-12 text-center">
                            <button id="BtnAdd" type="button" class="btn btn-primary me-3" style="width: 25%;">Update</button>
                            <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal" aria-label="Close">Cancel</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--/ Edit User Modal -->
    <!-- Edit User Modal -->
    <div class="modal fade" id="AddUpdateReasonModal" tabindex="-1" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
        <div class="modal-dialog modal-dialog-centered modal-lg modal-simple modal-edit-user">
            <div class="modal-content">
                <div class="modal-body p-0">
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    <div class="text-center mb-6">
                        <h4 class="mb-2">Add Reason for Not Being Enrolled</h4>
                    </div>
                    <div class="row g-5" id="formAuthentication2">
                        <div class="col-12 col-md-6">
                            <i class="ri-user-3-line ri-24px"></i><span class="fw-medium mx-2">Full Name:</span> <span id="txtName2"></span>
                        </div>
                        <div class="col-12 col-md-6">
                            <i class="ri-phone-line ri-24px"></i><span class="fw-medium mx-2">Contact:</span> <span id="txtMobile2"></span>
                        </div>
                        <div class="col-12 col-md-12">
                            <div class="form-floating form-floating-outline validation">
                                <div class="select2-primary">
                                    <select id="txtReason" name="txtReason" class="select2 form-select">
                                    </select>
                                </div>
                                <label for="txtReason">Reason *</label>
                            </div>
                        </div>

                        <div class="col-12 text-center">
                            <button id="BtnAdd2" type="button" class="btn btn-primary me-3" style="width: 25%;">Add</button>
                            <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal" aria-label="Close">Cancel</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--/ Edit User Modal -->
    <!-- Edit User Modal -->
    <div class="modal fade" id="AddUpdateFollowUpModal" tabindex="-1" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
        <div class="modal-dialog modal-dialog-centered modal-lg modal-simple modal-edit-user">
            <div class="modal-content">
                <div class="modal-body p-0">
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    <div class="text-center mb-6">
                        <h4 class="mb-2">Update Follow Up</h4>
                    </div>
                    <div class="row g-5" id="formAuthentication3">
                        <div class="col-12 col-md-6">
                            <i class="ri-user-3-line ri-24px"></i><span class="fw-medium mx-2">Full Name:</span> <span id="txtName3"></span>
                        </div>
                        <div class="col-12 col-md-6">
                            <i class="ri-phone-line ri-24px"></i><span class="fw-medium mx-2">Contact:</span> <span id="txtMobile3"></span>
                        </div>
                        <div class="col-12 col-md-12">
                            <div class="form-floating form-floating-outline validation">
                                <input type="date" id="txtFollowUp" name="txtFollowUp" class="form-control" placeholder="Enter pincode" />
                                <label for="txtFollowUp">Follow Up *</label>
                            </div>
                        </div>

                        <div class="col-12 text-center">
                            <button id="BtnAdd3" type="button" class="btn btn-primary me-3" style="width: 25%;">Update</button>
                            <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal" aria-label="Close">Cancel</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--/ Edit User Modal -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>


    <script type="text/javascript">

        let Id, Comment, Reason;
        let table, url, BtnAdd, BtnUpdate, dataToSend, selectedDateRangeName;
        let EnquiryType, AllEnquiry, CallEnquiry, VisitorEnquiry;
        EnquiryType = "All";
        let formAuthentication1 = document.querySelector("#formAuthentication1");
        let formValidationInstance1;

        let formAuthentication2 = document.querySelector("#formAuthentication2");
        let formValidationInstance2;

        let formAuthentication3 = document.querySelector("#formAuthentication3");
        let formValidationInstance3;


        const defaultRun = async () => {
            try {
                await renderEnquiry();
                await renderReason();
            } catch (err) {
                console.log(err);
            }
        }

        $(document).ready(function () {
            AllEnquiry = $("#txtAllEnquiry");
            CallEnquiry = $("#txtCallEnquiry");
            VisitorEnquiry = $("#txtVisitorEnquiry");

            Reason = $("#txtReason");
            Comment = $("#txtComment");
            FollowUpDate = $("#txtFollowUp");
            BtnUpdate = $("#BtnUpdate");

            (async function () {
                await Show_Spinner();
                await defaultRun().finally(async () => {
                    await Hide_Spinner();
                })
            })();
            $(document).on("click", "#txtAllEnquiry", OnClick_AllEnquiry);
            $(document).on("click", "#txtCallEnquiry", OnClick_CallEnquiry);
            $(document).on("click", "#txtVisitorEnquiry", OnClick_VisitorEnquiry);

            $(document).on("click", "a.update-link1", OnClick_update_link1);
            $(document).on("click", "a.update-link2", OnClick_update_link2);
            $(document).on("click", "a.update-link3", OnClick_update_link3);
            $(document).on("click", "#BtnAdd", OnClick_BtnAdd);
            $(document).on("click", "#BtnAdd2", OnClick_BtnAddReason);
            $(document).on("click", "#BtnAdd3", OnClick_BtnUpdateFollowUp);



        });
        async function renderReason() {
            try {
                const response = await Ajax_GetResult_WithoutParameter("Follow_Up.aspx", "Get_Reason");
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

        async function OnClick_AllEnquiry() {
            try {
                await Show_Spinner();
                if ($(this).is(":checked")) {
                    EnquiryType = "All";
                    await renderEnquiry();
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
                };
                var dataToSend = "";
                for (var key in parameters) {
                    if (parameters.hasOwnProperty(key)) {
                        dataToSend += key + "='" + parameters[key] + "'&";
                    }
                }
                // Remove the trailing '&' character
                dataToSend = dataToSend.slice(0, -1);
                var url = "Follow_Up.aspx/Get_Enquiry_Detail?" + dataToSend;
                await GetEnquiry(url);
                await DateRange();
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
                                    "data": "Id",
                                    "render": function (data, type, row, meta) { // Added parameters
                                        var rowHtml = "";
                                        rowHtml += '<div class="dropdown">';
                                        rowHtml += '<button type="button" class="badge rounded-pill text-bg-success me-1" style="font-size:14px" data-bs-toggle="dropdown">Manage</button>';
                                        rowHtml += '<div class="dropdown-menu">';
                                        rowHtml += '<a class="dropdown-item update-link3" name="' + data + '" data-name="' + row.Name + '" data-mobile="' + row.Mobile + '" data-followupdate="' + row.FollowUpDate + '" href="javascript:void(0);" data-bs-toggle="modal" data-bs-target="#AddUpdateFollowUpModal"><i class="menu-icon ri-calendar-2-line"></i> Update Follow Up</a>';
                                        rowHtml += '<a class="dropdown-item update-link1" name="' + data + '" data-name="' + row.Name + '" data-mobile="' + row.Mobile + '" data-comment="' + row.Comment + '" href="javascript:void(0);" data-bs-toggle="modal" data-bs-target="#AddUpdateCommentModal"><i class="menu-icon ri-message-2-line me-1"></i> Update Comment</a>';
                                        if (row.Reason == "")
                                            rowHtml += '<a class="dropdown-item update-link2" name="' + data + '" data-name="' + row.Name + '" data-mobile="' + row.Mobile + '" data-reason="' + row.Reason + '" href="javascript:void(0);" data-bs-toggle="modal" data-bs-target="#AddUpdateReasonModal"><i class="menu-icon ri-message-2-line me-1"></i> Add Reason</a>';
                                        else
                                            rowHtml += '<a class="dropdown-item update-link2" name="' + data + '" data-name="' + row.Name + '" data-mobile="' + row.Mobile + '" data-reason="' + row.Reason + '" href="javascript:void(0);" data-bs-toggle="modal" data-bs-target="#AddUpdateReasonModal"><i class="menu-icon ri-message-2-line me-1"></i> Update Reason</a>';
                                        rowHtml += '</div>';
                                        rowHtml += '</div>';
                                        return rowHtml;
                                    },
                                    "orderable": false,
                                    "width": "0rem"
                                },
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
                                { "data": "FollowUpDate", "name": "FollowUpDate", "autoWidth": true },
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
                                { "data": "Date", "name": "Date", "autoWidth": true },
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
                                "emptyTable": "No new follow Up to display on " + selectedDateRangeName + ". Please check back later or review previous records."

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
                const response1 = await Get_MaxDate();

                var minDate = moment(response, "MM-DD-YYYY HH:mm:ss");
                var maxDate = moment(response1, "MM-DD-YYYY HH:mm:ss");

                //var start = moment(minDate.format('MMMM D, YYYY'));
                //var end = moment(maxDate.format('MMMM D, YYYY'));
                var start = moment();
                var end = moment();
                async function cb(start, end, rangeName) {
                    //$('#reportrange span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
                    var StartDate = start.format('YYYY-MM-DD');
                    var EndDate = end.format('YYYY-MM-DD');
                    selectedDateRangeName = rangeName || 'Custom Range';
                    var parameters = {
                        EnquiryType: EnquiryType,
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
                    var url = "Follow_Up.aspx/Get_Enquiry_Detail_ByDate?" + dataToSend;
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

                cb(start, end, "Today");

            } catch (err) {
                console.log(err);
            }

        }
        async function Get_MinDate() {
            try {
                const response = await Ajax_GetResult_WithoutParameter("Follow_Up.aspx", "Get_MinDate");
                return response.d;
            } catch (err) {
                console.log(err);
            }

        }
        async function Get_MaxDate() {
            try {
                const response = await Ajax_GetResult_WithoutParameter("Follow_Up.aspx", "Get_MaxDate");
                return response.d;
            } catch (err) {
                console.log(err);
            }

        }

        async function OnClick_update_link1() {
            try {
                await Show_Spinner();
                $('#AddUpdateCommentModal').on('shown.bs.modal', function () {
                    $('#AddUpdateCommentModal').modal('show');

                });

                Id = this.name;

                $("#txtName1").html($(this).data("name"));
                $("#txtMobile1").html($(this).data("mobile"));
                Comment.val($(this).data("comment"));


            } catch (err) {
                console.log(err);
            }
            finally {
                await Hide_Spinner();
            }

        }
        async function OnClick_update_link2() {
            try {
                await Show_Spinner();
                $('#AddUpdateReasonModal').on('shown.bs.modal', function () {
                    $('#AddUpdateReasonModal').modal('show');

                });

                Id = this.name;

                $("#txtName2").html($(this).data("name"));
                $("#txtMobile2").html($(this).data("mobile"));
                Reason.val($(this).data("reason")).trigger("change");

            } catch (err) {
                console.log(err);
            }
            finally {
                await Hide_Spinner();
            }

        }
        async function OnClick_update_link3() {
            try {
                await Show_Spinner();
                restrictDate();
                $('#AddUpdateFollowUpModal').on('shown.bs.modal', function () {
                    $('#AddUpdateFollowUpModal').modal('show');

                });

                Id = this.name;

                $("#txtName3").html($(this).data("name"));
                $("#txtMobile3").html($(this).data("mobile"));
                var dateString = $(this).data("followupdate");
                var formattedDate = formatDateToYYYYMMDD(dateString);
                console.log(formattedDate)
                FollowUpDate.val(formattedDate);

            } catch (err) {
                console.log(err);
            }
            finally {
                await Hide_Spinner();
            }

        }
        function formatDateToYYYYMMDD(dateString) {
            // Parse the date
            var dateParts = dateString.split("-");
            var day = dateParts[0];
            var month = dateParts[1];
            var year = dateParts[2];

            // Convert month name to a number
            var monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
            var monthNumber = monthNames.indexOf(month) + 1;

            // Format month and day to two digits
            monthNumber = monthNumber < 10 ? '' + monthNumber : monthNumber;
            day = day < 10 ? '' + day : day;

            // Return in yyyy-MM-dd format
            return year + "-" + monthNumber + "-" + day;
        }
        function restrictDate() {
            var currentDate = new Date();
            var tomorrowDate = new Date(currentDate);
            tomorrowDate.setDate(currentDate.getDate());

            var minDate = tomorrowDate.getFullYear() + '-' + ('0' + (tomorrowDate.getMonth() + 1)).slice(-2) + '-' + ('0' + tomorrowDate.getDate()).slice(-2);

            FollowUpDate.attr('min', minDate);
        }

        async function OnClick_BtnAdd() {
            if (formAuthentication1) {
                formValidationInstance1.validate().then(async function (status) {
                    if (status === 'Valid') {
                        try {
                            const result = await Confirm("Yes, Update it !", "Are you sure want to Update ?")

                            if (result.isConfirmed) {
                                await Show_Spinner();

                                dataToSend = {
                                    Id: Id,
                                    Comment: Comment.val()
                                }

                                const response = await Ajax_GetResult("Follow_Up.aspx", "Add_Comment", dataToSend);
                                if (response.d > 0)
                                    Success("Update", "Comment Update Successfully");
                                else
                                    Failed("Comment Update Failed !")


                            }
                        } catch (err) {
                            console.log(err);
                        }
                        finally {
                            await Hide_Spinner();
                            $('#tblEnquiry').DataTable().ajax.reload();
                            $('#AddUpdateCommentModal').modal('toggle');
                        }



                    } else {
                        console.log('Form is invalid, display errors.');
                    }
                });
            }
        }
        async function OnClick_BtnAddReason() {
            if (formAuthentication2) {
                formValidationInstance2.validate().then(async function (status) {
                    if (status === 'Valid') {
                        try {
                            const result = await Confirm("Yes, Add it !", "Are you sure want to Add ?")

                            if (result.isConfirmed) {
                                await Show_Spinner();

                                dataToSend = {
                                    Id: Id,
                                    Reason: Reason.val()
                                }

                                const response = await Ajax_GetResult("Follow_Up.aspx", "Add_Reason", dataToSend);
                                if (response.d > 0)
                                    Success("Added", "Reason Added Successfully");
                                else
                                    Failed("Reason Added Failed !")


                            }
                        } catch (err) {
                            console.log(err);
                        }
                        finally {
                            await Hide_Spinner();
                            $('#tblEnquiry').DataTable().ajax.reload();
                            $('#AddUpdateReasonModal').modal('toggle');
                        }



                    } else {
                        console.log('Form is invalid, display errors.');
                    }
                });
            }
        }
        async function OnClick_BtnUpdateFollowUp() {
            if (formAuthentication3) {
                formValidationInstance3.validate().then(async function (status) {
                    if (status === 'Valid') {
                        try {
                            const result = await Confirm("Yes, Add it !", "Are you sure want to Add ?")

                            if (result.isConfirmed) {
                                await Show_Spinner();

                                dataToSend = {
                                    Id: Id,
                                    FollowUpDate: FollowUpDate.val()
                                }

                                const response = await Ajax_GetResult("Follow_Up.aspx", "Update_FollowUpDate", dataToSend);
                                if (response.d > 0)
                                    Success("Updated", "Follow Up updated successfully");
                                else
                                    Failed("Follow Up updated failed !")


                            }
                        } catch (err) {
                            console.log(err);
                        }
                        finally {
                            await Hide_Spinner();
                            $('#tblEnquiry').DataTable().ajax.reload();
                            $('#AddUpdateFollowUpModal').modal('toggle');
                        }



                    } else {
                        console.log('Form is invalid, display errors.');
                    }
                });
            }
        }

        document.addEventListener('DOMContentLoaded', function () {


            if (!formAuthentication1) {
                console.error("Form not found!");
                return;
            }
            console.log("Form found:", formAuthentication1);

            // Initialize the form validation
            formValidationInstance1 = FormValidation.formValidation(formAuthentication1, {
                fields: {
                    txtComment: {
                        validators: {
                            notEmpty: {
                                message: "Please enter comment"
                            },
                            stringLength: {
                                min: 3,
                                message: "Comments must be more than 3 characters"
                            }
                        }
                    }
                },
                plugins: {
                    trigger: new FormValidation.plugins.Trigger(),
                    bootstrap5: new FormValidation.plugins.Bootstrap5({
                        eleValidClass: "",
                        rowSelector: ".form-floating-outline"
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

            if (!formAuthentication2) {
                console.error("Form not found!");
                return;
            }
            console.log("Form found:", formAuthentication2);

            // Initialize the form validation
            formValidationInstance2 = FormValidation.formValidation(formAuthentication2, {
                fields: {
                    txtReason: {
                        validators: {
                            notEmpty: {
                                message: "Please select Reason"
                            }
                        }
                    }
                },
                plugins: {
                    trigger: new FormValidation.plugins.Trigger(),
                    bootstrap5: new FormValidation.plugins.Bootstrap5({
                        eleValidClass: "",
                        rowSelector: ".form-floating-outline"
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

            if (!formAuthentication3) {
                console.error("Form not found!");
                return;
            }
            console.log("Form found:", formAuthentication3);

            // Initialize the form validation
            formValidationInstance3 = FormValidation.formValidation(formAuthentication3, {
                fields: {
                    txtFollowUp: {
                        validators: {
                            notEmpty: {
                                message: "Please select Follow Up Date"
                            }
                        }
                    }
                },
                plugins: {
                    trigger: new FormValidation.plugins.Trigger(),
                    bootstrap5: new FormValidation.plugins.Bootstrap5({
                        eleValidClass: "",
                        rowSelector: ".form-floating-outline"
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

        });
    </script>
    
</asp:Content>

