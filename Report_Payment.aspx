<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true" CodeFile="Report_Payment.aspx.cs" Inherits="Admin_Report_Payment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Payment Report | Institute Management Software</title>
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
        .update-link{
                color: #757a7b;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row g-6 mb-6">
        <div class="col-md">
            <div class="card">
                <div class="card-header row" style="justify-content: space-between;">
                    <div class="col-md-4">
                        <h5><span class="text-muted fw-light">Reports /</span>Payment Report</h5>
                    </div>
                     <div class="col-md-8">
                         <div class="bg-label-primary p-4 rounded my-3" style="width: max-content;">
                        <div class="d-flex">
                            <div class="avatar flex-shrink-0 me-4">
                                <div class="avatar-initial bg-label-primary rounded">
                                    <div>
                                        <img src="../UserLogin_Content/assets/img/icons/unicons/briefcase.png" alt="paypal">
                                    </div>
                                </div>
                            </div>
                            <div class="d-flex w-100 flex-wrap align-items-center justify-content-between gap-2">
                                <div class="me-2">
                                    <h6 class="mb-0">Total</h6>
                                    <strong class="small">Collection</strong>
                                </div>
                                <div class="user-progress">
                                    <div class="d-flex justify-content-center">
                                        <sup class="mt-5 mb-0 text-heading small">₹ </sup>
                                        <h4 class="fw-medium mb-0" id="lblTotalCollection"></h4>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                     </div>
                </div>

                <div class="card-header flex-column flex-md-row" style="display: flex; justify-content: space-between;">
                    <div class="dt-action-buttons pt-3 pt-md-0" id="left_Search">
                        <div class="dt-buttons btn-group" style="width: 100%; display: flex;">
                            <div class="row" style="width: 100%">
                                <div class="col-md-6">
                                    <div class="form-floating form-floating-outline mb-3" style="margin-right: 1rem; width: 100%">
                                        <select name="txtCourseId" id="txtCourseId" class="select2 form-select" data-allow-clear="true">
                                            <option value="">Select Course</option>
                                        </select>
                                        <label for="txtCourseId">Filter by Course</label>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-floating form-floating-outline mb-3" style="margin-right: 1rem; width: 100%">
                                        <select name="txtSearchByMobile" id="txtSearchByMobile" class="select2 form-select" data-allow-clear="true">
                                            <option value="">Select Mobile</option>
                                        </select>
                                        <label for="txtSearchByMobile">Filter by Student</label>
                                    </div>
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
                        <table class="table nowrap" id="tblPayment">
                            <caption class="ms-4">
                                List of Payment
                            </caption>
                            <thead>
                                <tr>
                                    <th>SlNo</th>
                                    <th>Action</th>
                                    <th>Paid Date</th>
                                    <th>Invoice No</th>
                                    <th>Student Name</th>
                                    <th>Mobile</th>
                                    <th>Course Name</th>
                                    <th>Paid Amount</th>
                                    <th>Payment Method</th>
                                    <th>Installment No</th>
                                    <th>Batch Name</th>
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

        let CourseId, SearchByMobile;
        let table, url, dataToSend, selectedDateRangeName;


        const defaultRun = async () => {
            try {
                var url = "Report_Payment.aspx/Get_Payment_Detail";
                await GetPayment_Details(url);
                await DateRange();
                await renderCourse();
                await renderSearchByStudent();
            } catch (err) {
                console.log(err);
            }
        }

        $(document).ready(function () {

            CourseId = $("#txtCourseId");
            SearchByMobile = $("#txtSearchByMobile");

            (async function () {
                await Show_Spinner();
                await defaultRun().finally(async () => {
                    await Hide_Spinner();
                })
            })();

            CourseId.change(OnChange_CourseId);
            SearchByMobile.change(OnChange_SearchByMobile);
        });
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
                    var url = "Report_Payment.aspx/Get_Payment_Detail_ByDate?" + dataToSend;
                    await GetPayment_Details(url);
                    $('#tblPayment').DataTable().ajax.reload();
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
                const response = await Ajax_GetResult_WithoutParameter("Report_Payment.aspx", "Get_MinDate");
                return response.d;
            } catch (err) {
                console.log(err);
            }

        }
        async function GetPayment_Details(url) {
            try {
                return new Promise((resolve, reject) => {

                    // Destroy existing DataTable if it exists
                    if ($.fn.DataTable.isDataTable('#tblPayment')) {
                        $('#tblPayment').DataTable().destroy();
                    }

                    // Initialize DataTable
                    const table = $('#tblPayment').DataTable({
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
                                if (json.d && json.d.data && json.d.data.length > 0) {
                                    $("#lblTotalCollection").html(json.data[0].TotalPaidAmount);
                                }
                                else {
                                    $("#lblTotalCollection").html("0");
                                }
                                return json.data;
                            },
                            "error": function (err) {
                                reject(err);
                            }
                        },
                        "columns": [
                            { "data": "SlNo", "name": "SlNo", "width": "0rem", "orderable": true },
                            {
                                "data": "InvoiceNo",
                                "render": function (data, type, row, meta) { // Added parameters
                                    var rowHtml = "";
                                    rowHtml += '<a class="update-link" data-tooltip="Print Invoice" name="' + data + '" href="Print.aspx?InvoiceNo=' + row.InvoiceNo + '&Mobile=' + row.Mobile + '" target="_blank"><i class="menu-icon tf-icons ri-printer-fill"></i></a>';
                                    return rowHtml;
                                },
                                "orderable": false,
                                "width": "0rem"
                            },
                            { "data": "Date", "name": "Date", "autoWidth": true },
                            { "data": "InvoiceNo", "name": "InvoiceNo", "autoWidth": true },
                            { "data": "StudentName", "name": "StudentName", "autoWidth": true },
                            { "data": "Mobile", "name": "Mobile", "autoWidth": true },
                            {
                                "data": "Course_Name",
                                "render": function (data, type, row, meta) { // Added parameters
                                    var rowHtml = "";
                                    rowHtml = `<a href="Student_Profile.aspx?Mobile=${row.Mobile}" data-tooltip="View Detail" style="Cursor:pointer">
                                                        ${data}
                                                    </a>`;
                                    return rowHtml;
                                },
                                "orderable": false,
                                "autoWidth": true
                            },
                            {
                                "data": "Paid_Amount",
                                "render": function (data, type, row, meta) { // Added parameters
                                    var rowHtml = "";
                                    rowHtml = "₹ " + data
                                    return rowHtml;
                                },
                                "orderable": false,
                                "autoWidth": true
                            },
                            { "data": "PaymentMethod", "name": "PaymentMethod", "autoWidth": true },
                            { "data": "Installment_No", "name": "Installment_No", "autoWidth": true },
                            {
                                "data": "BatchName",
                                "render": function (data, type, row, meta) { // Added parameters
                                    var rowHtml = "";
                                    rowHtml = `<a href="Student_Batch.aspx?Mobile=${row.Mobile}" data-tooltip="View Detail" style="Cursor:pointer">
                                                        ${data}
                                                    </a>`;
                                    return rowHtml;
                                },
                                "orderable": false,
                                "autoWidth": true
                            },
                            { "data": "RollNo", "name": "RollNo", "autoWidth": true },
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
                            "emptyTable": "No collection to display on " + selectedDateRangeName+". Please check back later or review previous records."

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

        async function renderCourse() {
            try {
                const courseResponse = await Ajax_GetResult_WithoutParameter("Report_Payment.aspx", "Get_Course");
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

        async function renderSearchByStudent() {
            try {
                const response = await Ajax_GetResult_WithoutParameter("Report_Payment.aspx", "Get_SearchByStudent");
                const data = JSON.parse(response.d);
                console.log(data);
                SearchByMobile.empty();
                if (data.length > 0) {
                    SearchByMobile.html('<option value="" Selected>Select Student</option>');
                    $.each(data, function (index, item) {
                        SearchByMobile.append($('<option>', {
                            value: item.Mobile,
                            text: item.StudentName + " ( " + item.Mobile + " )"
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
                await renderSearchByStudent();
                var parameters = {
                    CourseId: CourseId.val()
                };
                var dataToSend = "";
                for (var key in parameters) {
                    if (parameters.hasOwnProperty(key)) {
                        dataToSend += key + "='" + parameters[key] + "'&";
                    }
                }
                // Remove the trailing '&' character
                dataToSend = dataToSend.slice(0, -1);

                var url = "Report_Payment.aspx/Get_Payment_Detail_ByCourse?" + dataToSend;
                await GetPayment_Details(url);

            } catch (err) {
                console.log(err);
            }
            finally {
                await Hide_Spinner();
                $('#tblPayment').DataTable().ajax.reload();
            }


        }

        async function OnChange_SearchByMobile() {
            try {
                await Show_Spinner();
                await renderCourse();
                var parameters = {
                    Mobile: SearchByMobile.val()
                };
                var dataToSend = "";
                for (var key in parameters) {
                    if (parameters.hasOwnProperty(key)) {
                        dataToSend += key + "='" + parameters[key] + "'&";
                    }
                }
                // Remove the trailing '&' character
                dataToSend = dataToSend.slice(0, -1);

                var url = "Report_Payment.aspx/Get_Payment_Detail_ByMobile?" + dataToSend;
                await GetPayment_Details(url);

            } catch (err) {
                console.log(err);
            }
            finally {
                await Hide_Spinner();
                $('#tblPayment').DataTable().ajax.reload();
            }
        }
    </script>
</asp:Content>

