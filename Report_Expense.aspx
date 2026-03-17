<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true" CodeFile="Report_Expense.aspx.cs" Inherits="Admin_Report_Expense" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Expense Report | Institute Management Software</title>
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
                        <h5><span class="text-muted fw-light">Reports /</span>Expense Report</h5>
                    </div>

                </div>

                <div class="card-header flex-column flex-md-row" style="display: flex; justify-content: space-between;">
                    <%--<div class="dt-action-buttons pt-3 pt-md-0" id="left_Search">
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
                    </div>--%>
                    <div class="dt-action-buttons pt-3 pt-md-0" id="right_Export" style="width: 100%;">

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
                <div class="card-body">
                    <div class="table-responsive text-nowrap">
                        <table class="table nowrap" id="tblExpense">
                            <caption class="ms-4">
                                List of Expense
                            </caption>
                            <thead>
                                <tr>
                                    <th>SlNo</th>
                                    <th>Action</th>
                                    <th>ExpenseBy</th>
                                    <th>Purpose</th>
                                    <th>Amount</th>
                                    <th>Reciever Name</th>
                                    <th>Payment Method</th>
                                    <th>Transaction No</th>
                                    <th>Bank Name</th>
                                    <th>Date</th>
                                    <th>Remarks</th>
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
        let table, url, dataToSend, selectedDateRangeName;


        const defaultRun = async () => {
            try {
                var url = "Report_Expense.aspx/Get_Expense_Detail";
                await GetExpense_Details(url);
                await DateRange();
            } catch (err) {
                console.log(err);
            }
        }

        $(document).ready(function () {

            (async function () {
                await Show_Spinner();
                await defaultRun().finally(async () => {
                    await Hide_Spinner();
                })
            })();

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
                    var url = "Report_Expense.aspx/Get_Expense_Detail_ByDate?" + dataToSend;
                    await GetExpense_Details(url);
                    $('#tblExpense').DataTable().ajax.reload();
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

                cb(start, end, 'Custom Range');

            } catch (err) {
                console.log(err);
            }

        }
        async function Get_MinDate() {
            try {
                const response = await Ajax_GetResult_WithoutParameter("Report_Expense.aspx", "Get_MinDate");
                return response.d;
            } catch (err) {
                console.log(err);
            }

        }
        async function GetExpense_Details(url) {
            try {
                return new Promise((resolve, reject) => {

                    // Destroy existing DataTable if it exists
                    if ($.fn.DataTable.isDataTable('#tblExpense')) {
                        $('#tblExpense').DataTable().destroy();
                    }

                    // Initialize DataTable
                    const table = $('#tblExpense').DataTable({
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
                                "data": "Id",
                                "render": function (data, type, row, meta) { // Added parameters
                                    var row = "";
                                    row += '<div class="dropdown">';
                                    row += '<button type="button" class="btn p-0 dropdown-toggle hide-arrow" data-bs-toggle="dropdown"><i class="ri-more-2-line"></i></button>';
                                    row += '<div class="dropdown-menu">';
                                    row += '<a class="dropdown-item update-link" name="' + data + '" href="javascript:void(0);" data-bs-toggle="modal" data-bs-target="#AddUpdateModal"><i class="menu-icon ri-pencil-line me-1"></i>Edit/Update</a>'; // Changed here
                                    row += '<a class="dropdown-item delete-link" name="' + data + '" href="javascript:void(0);"><i class="menu-icon ri-delete-bin-6-line me-1"></i>Delete</a>';
                                    row += '</div>';
                                    row += '</div>';
                                    return row;
                                },
                                "orderable": false,
                                "width": "0rem"
                            },
                            { "data": "ExpenseBy", "name": "ExpenseBy", "autoWidth": true },
                            { "data": "Purpose", "name": "Purpose", "autoWidth": true },
                            { "data": "Amount", "name": "Amount", "autoWidth": true },
                            { "data": "RecieverName", "name": "RecieverName", "autoWidth": true },
                            { "data": "PaymentMethod", "name": "PaymentMethod", "autoWidth": true },
                            { "data": "TransactionNo", "name": "TransactionNo", "autoWidth": true },
                            { "data": "BankName", "name": "BankName", "autoWidth": true },
                            { "data": "Date", "name": "Date", "autoWidth": true },
                            { "data": "Remarks", "name": "Remarks", "autoWidth": true }

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
                            "emptyTable": "No expense to display on " + selectedDateRangeName +". Please check back later or review previous records."

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
                const courseResponse = await Ajax_GetResult_WithoutParameter("Report_Expense.aspx", "Get_Course");
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

       

    </script>
</asp:Content>

