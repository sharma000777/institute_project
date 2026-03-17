<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true" CodeFile="Enquiry.aspx.cs" Inherits="Admin_Enquiry" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Enquiry | Institute Management Software</title>
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
                        <h5><span class="text-muted fw-light">Master /</span> Add Enquiry</h5>
                    </div>
                    <div id="top-right-date" class="col-md-8" style="display: flex; justify-content: end;">
                        <div class="">
                            <a href="Add_Enquiry.aspx" class="btn btn-primary waves-effect waves-light" style="margin-right: 10px"><i class="menu-icon ri-function-add-fill"></i>Add New</a>
                        </div>
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
                                    <th>Enquiry Date</th>
                                    <th>Contact Media</th>
                                    <th>Name</th>
                                    <th>Mobile</th>
                                    <th>Qualification</th>
                                    <th>Course Name</th>
                                    <th>Duration</th>
                                    <th>Fee</th>
                                    <th>Comment</th>
                                    <th>Reason</th>
                                    <th>Follow Up</th>
                                </tr>
                            </thead>
                        </table>

                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Edit User Modal -->
    <div class="modal fade" id="AddUpdateModal" tabindex="-1" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
        <div class="modal-dialog modal-dialog-centered modal-lg modal-simple modal-edit-user">
            <div class="modal-content">
                <div class="modal-body p-0">
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    <div class="text-center mb-6">
                        <h4 class="mb-2">Edit / Update Enquiry</h4>
                    </div>
                    <div class="row g-5" id="formAuthentication">
                        <div class="col-12 col-md-4">
                            <div class="form-floating form-floating-outline">
                                <input type="text" id="txtName" name="txtName" class="form-control" placeholder="Enter name" />
                                <label for="txtName">Name *</label>
                            </div>
                        </div>
                        <div class="col-12 col-md-4">
                            <div class="form-floating form-floating-outline">
                                <input type="text" id="txtMobile" name="txtMobile" class="form-control" placeholder="Enter Mobile" />
                                <label for="txtMobile">Mobile *</label>
                            </div>
                        </div>
                        <div class="col-12 col-md-4">
                            <div class="form-floating form-floating-outline">
                                <input type="text" id="txtQualification" name="txtQualification" class="form-control" placeholder="Enter Highest Qualifiaction" />
                                <label for="txtQualification">Highest Qualification *</label>
                            </div>
                        </div>
                        <div class="col-12 col-md-6">
                            <div class="form-floating form-floating-outline validation">
                                <div class="select2-primary">
                                    <select id="txtCourseId" name="txtCourseId" class="select2 form-select">
                                    </select>
                                </div>
                                <label for="txtCourseId">Course *</label>
                            </div>
                        </div>
                        <div class="col-12 col-md-6">
                            <div class="form-floating form-floating-outline">
                                <input type="date" id="txtFollowUpDate" name="txtFollowUpDate" class="form-control" />
                                <label for="txtFollowUpDate">Follow Up *</label>
                            </div>
                        </div>
                        <div class="col-12 col-md-12">
                            <div class="form-floating form-floating-outline">
                                <textarea id="txtAddress" name="txtAddress" class="form-control" placeholder="Enter address ..." style="height: 6rem"></textarea>
                                <label for="txtAddress">Address *</label>
                            </div>
                        </div>
                        <div class="col-12 col-md-12 hide" id="tblCourseDiv">
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


                        <div class="col-12 text-center">
                            <button id="BtnUpdate" type="button" class="btn btn-primary me-3" style="width: 25%;">Update</button>
                            <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal" aria-label="Close">Cancel</button>
                        </div>
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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>


    <script type="text/javascript">

        let Id, Name, Mobile, Qualification, CourseId, FollowUpDate, Address, Comment;
        let table, url, BtnAdd, BtnUpdate, dataToSend, selectedDateRangeName;
        let EnquiryType, AllEnquiry, CallEnquiry, VisitorEnquiry;
        let formAuthentication = document.querySelector("#formAuthentication");
        let formValidationInstance;
        EnquiryType = "All";
        let formAuthentication1 = document.querySelector("#formAuthentication1");
        let formValidationInstance1;


        const defaultRun = async () => {
            try {
                await renderEnquiry();
            } catch (err) {
                console.log(err);
            }
        }

        $(document).ready(function () {
            AllEnquiry = $("#txtAllEnquiry");
            CallEnquiry = $("#txtCallEnquiry");
            VisitorEnquiry = $("#txtVisitorEnquiry");


            Name = $('#txtName');
            Mobile = $('#txtMobile');
            Qualification = $('#txtQualification');
            CourseId = $('#txtCourseId');
            FollowUpDate = $('#txtFollowUpDate');
            Address = $('#txtAddress');
            Comment = $("#txtComment");
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

            $(document).on("click", "a.delete-link", OnClick_BtnDelete);
            $(document).on("click", "a.update-link", OnClick_update_link);
            $(document).on("click", "#BtnUpdate", OnClick_BtnUpdate);
            $(document).on("click", "a.update-link1", OnClick_update_link1);
            $(document).on("click", "#BtnAdd", OnClick_BtnAdd);


            CourseId.change(OnChange_CourseId);

            OnKeyPressValidation(Name, validateAlphabeticOrSpace);
            OnKeyPressValidation(Mobile, validateMobileNumber);

        });
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
                var url = "Enquiry.aspx/Get_Enquiry_Detail?" + dataToSend;
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
                                        rowHtml += '<a class="dropdown-item update-link" name="' + data + '" href="javascript:void(0);" data-bs-toggle="modal" data-bs-target="#AddUpdateModal"><i class="menu-icon ri-pencil-line me-1"></i>Edit/Update</a>'; // Changed here
                                        rowHtml += '<a class="dropdown-item delete-link" name="' + data + '" href="javascript:void(0);"><i class="menu-icon ri-delete-bin-6-line me-1"></i>Delete</a>';
                                        if (row.Comment == "")
                                            rowHtml += '<a class="dropdown-item update-link1" name="' + data + '" data-name="' + row.Name + '" data-mobile="' + row.Mobile + '" data-comment="' + row.Comment + '" href="javascript:void(0);" data-bs-toggle="modal" data-bs-target="#AddUpdateCommentModal"><i class="menu-icon ri-message-2-line me-1"></i> Add Comment</a>';
                                        else
                                            rowHtml += '<a class="dropdown-item update-link1" name="' + data + '" data-name="' + row.Name + '" data-mobile="' + row.Mobile + '" data-comment="' + row.Comment + '" href="javascript:void(0);" data-bs-toggle="modal" data-bs-target="#AddUpdateCommentModal"><i class="menu-icon ri-message-2-line me-1"></i> Update Comment</a>';
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
                                { "data": "Date", "name": "Date", "autoWidth": true },
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
                                { "data": "Reason", "name": "Reason", "autoWidth": true },
                                { "data": "FollowUpDate", "name": "FollowUpDate", "autoWidth": true }
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
                                "emptyTable": "No new enquiries to display on " + selectedDateRangeName+". Please check back later or review previous records."
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

                //var start = moment(minDate.format('MMMM D, YYYY'));
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
                    var url = "Enquiry.aspx/Get_Enquiry_Detail_ByDate?" + dataToSend;
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

                cb(start, end,"Today");

            } catch (err) {
                console.log(err);
            }

        }
        async function Get_MinDate() {
            try {
                const response = await Ajax_GetResult_WithoutParameter("Enquiry.aspx", "Get_MinDate");
                return response.d;
            } catch (err) {
                console.log(err);
            }

        }

        async function OnClick_BtnDelete() {
            const result = await Confirm("Yes, Delete it!", "Are you sure want to delete?");
            if (result.isConfirmed) {
                try {
                    await Show_Spinner();
                    dataToSend = {
                        Id: this.name
                    };
                    const response = await Ajax_GetResult("Enquiry.aspx", "Delete_Enquiry_Detail", dataToSend);

                    $('#tblEnquiry').DataTable().ajax.reload();
                    if (response.d > 0)
                        Success("Deleted", "You have deleted this Enquiry successfully");
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
                const courseResponse = await Ajax_GetResult_WithoutParameter("Add_Enquiry.aspx", "Get_Course");
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
                const response = await Ajax_GetResult("Add_Enquiry.aspx", "Get_CourseDetail", dataToSend);
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
                $('#AddUpdateModal').on('shown.bs.modal', function () {
                    $('#AddUpdateModal').modal('show');

                });


                Id = this.name;
                dataToSend = {
                    Id: this.name
                };
                const response = await Ajax_GetResult("Enquiry.aspx", "Get_UpdateDetail", dataToSend);
                const data = JSON.parse(response.d);
                console.log(data)

                await renderCourse();

                const courseIdToSelect = String(data[0].CourseId);
                const CourseOption = CourseId.find(`option[value="${courseIdToSelect}"]`);

                Name.val(data[0].Name);
                Mobile.val(data[0].Mobile);
                Qualification.val(data[0].Qualification).trigger('change');

                if (CourseOption.length > 0) {
                    CourseId.val(courseIdToSelect).trigger('change');
                }


                FollowUpDate.val(data[0].FollowUpDate);
                Address.val(data[0].Address);

            } catch (err) {
                console.log(err);
            }
            finally {
                await Hide_Spinner();
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

                                const response = await Ajax_GetResult("Enquiry.aspx", "Add_Comment", dataToSend);
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
        async function OnClick_BtnUpdate() {

            if (formAuthentication) {
                formValidationInstance.validate().then(async function (status) {
                    if (status === 'Valid') {
                        try {
                            const result = await Confirm("Yes, Update it !", "Are you sure want to Update ?")

                            if (result.isConfirmed) {
                                await Show_Spinner();

                                dataToSend = {
                                    Id: Id,
                                    Name: Name.val(),
                                    Mobile: Mobile.val(),
                                    Qualification: Qualification.val(),
                                    CourseId: CourseId.val(),
                                    FollowUpDate: FollowUpDate.val(),
                                    Address: Address.val()
                                }

                                const response = await Ajax_GetResult("Enquiry.aspx", "Update_Enquiry_Detail", dataToSend);
                                if (response.d > 0) {
                                    $('#tblEnquiry').DataTable().ajax.reload();
                                    $('#AddUpdateModal').modal('toggle');
                                    Success("Updated", "Enquiry Updated Successfully",);
                                }
                                else {
                                    Failed("Updated Failed !")
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
            const CourseSelect = jQuery(formAuthentication.querySelector('[name="txtCourseId"]'));

            // Initialize the form validation
            formValidationInstance = FormValidation.formValidation(formAuthentication, {
                fields: {
                    txtName: {
                        validators: {
                            notEmpty: {
                                message: "Please enter Name"
                            },
                            stringLength: {
                                min: 3,
                                message: "Name must be more than 3 characters"
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
                    txtQualification: {
                        validators: {
                            notEmpty: {
                                message: "Please enter Qualification"
                            },
                            stringLength: {
                                min: 3,
                                message: "Name must be more than 3 characters"
                            }
                        }
                    },
                    txtCourseId: {
                        validators: {
                            notEmpty: {
                                message: "Please enter course"
                            }
                        }
                    },
                    txtFollowUpDate: {
                        validators: {
                            notEmpty: {
                                message: "Please select Follow Up"
                            }
                        }
                    },
                    txtAddress: {
                        validators: {
                            notEmpty: {
                                message: "Please enter address"
                            },
                            stringLength: {
                                min: 6,
                                message: "address must be more than 6 characters"
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
            if (CourseSelect.length) {
                select2Focus(CourseSelect);
                CourseSelect.wrap('<div class="position-relative"></div>');
                CourseSelect.select2({
                    placeholder: "Select Course",
                    dropdownParent: CourseSelect.parent()
                }).on("change", function () {
                    formValidationInstance.revalidateField("txtCourseId");
                });
            }

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

        });
    </script>
</asp:Content>

