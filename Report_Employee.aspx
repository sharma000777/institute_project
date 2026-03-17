<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true" CodeFile="Report_Employee.aspx.cs" Inherits="Admin_Report_Employee" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Employee Report | Institute Management Software</title>
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
                        <h5><span class="text-muted fw-light">Reports /</span>Employee Report</h5>
                    </div>

                </div>

                <div class="card-header flex-column flex-md-row" style="display: flex; justify-content: space-between;">
                    <div class="dt-action-buttons pt-3 pt-md-0" id="left_Search">
                        <div class="dt-buttons btn-group" style="width: 100%; display: flex;">
                            <div class="row" style="width: 100%">
                                <div class="col-12 col-md-6">
                                    <div class="form-floating form-floating-outline validation">
                                        <div class="select2-primary">
                                            <select id="txtDepartment" name="txtDepartment" class="select2 form-select">
                                            </select>
                                        </div>
                                        <label for="txtDepartment">Filter By Department</label>
                                    </div>
                                </div>
                                <div class="col-12 col-md-6">
                                    <div class="form-floating form-floating-outline validation">
                                        <div class="select2-primary">
                                            <select id="txtDesignation" name="txtDesignation" class="select2 form-select">
                                            </select>
                                        </div>
                                        <label for="txtDesignation">Filter By Designation</label>
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
                <div class="card-body">
                    <div class="table-responsive text-nowrap">
                        <table class="table nowrap" id="tblEmployee">
                            <caption class="ms-4">
                                List of Employee
                            </caption>
                            <thead>
                                <tr>
                                    <th>SlNo</th>
                                    <th>Employee Id</th>
                                    <th>Photo</th>
                                    <th>Employee Name</th>
                                    <th>Department</th>
                                    <th>Designation</th>
                                    <th>Salary</th>
                                    <th>Mobile</th>
                                    <th>Gender</th>
                                    <th>Email</th>
                                    <th>DOB</th>
                                    <th>Aadhar No</th>
                                    <th>Father Name</th>
                                    <th>State</th>
                                    <th>City</th>
                                    <th>Pincode</th>
                                    <th>Address</th>
                                    <th>Joining Date</th>
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

        let Department, Designation;
        let table, url, dataToSend, selectedDateRangeName;


        const defaultRun = async () => {
            try {
                var url = "Report_Employee.aspx/Get_Employee_Detail";
                await GetEmployee_Details(url);
                await DateRange();
                await renderDepartment();
            } catch (err) {
                console.log(err);
            }
        }

        $(document).ready(function () {

            Department = $("#txtDepartment");
            Designation = $("#txtDesignation");

            (async function () {
                await Show_Spinner();
                await defaultRun().finally(async () => {
                    await Hide_Spinner();
                })
            })();

            Department.change(OnChange_Department);
            Designation.change(OnChange_Designation);

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
                    var url = "Report_Employee.aspx/Get_Employee_Detail_ByDate?" + dataToSend;
                    await GetEmployee_Details(url);
                    $('#tblEmployee').DataTable().ajax.reload();
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
                const response = await Ajax_GetResult_WithoutParameter("Report_Employee.aspx", "Get_MinDate");
                return response.d;
            } catch (err) {
                console.log(err);
            }

        }
        async function GetEmployee_Details(url) {
            try {
                return new Promise((resolve, reject) => {

                    // Destroy existing DataTable if it exists
                    if ($.fn.DataTable.isDataTable('#tblEmployee')) {
                        $('#tblEmployee').DataTable().destroy();
                    }

                    // Initialize DataTable
                    const table = $('#tblEmployee').DataTable({
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
                            { "data": "EmployeeId", "name": "EmployeeId", "autoWidth": true },
                            {
                                "data": "Photo",
                                "render": function (data, type, JsonResultRow, meta) {
                                    return '<img src="../UserLogin_Content/upload/' + data + '" class="imag-fluid" style="width: 2rem;height: 3rem;">';
                                },
                                "autoWidth": true,
                                "orderable": false
                            },
                            { "data": "EmployeeName", "name": "EmployeeName", "autoWidth": true },
                            { "data": "Department", "name": "Department", "autoWidth": true },
                            { "data": "Designation", "name": "Designation", "autoWidth": true },
                            { "data": "Salary", "name": "Salary", "autoWidth": true },
                            { "data": "Mobile", "name": "Mobile", "autoWidth": true },
                            { "data": "Gender", "name": "Gender", "autoWidth": true },
                            { "data": "Email", "name": "Email", "autoWidth": true },
                            { "data": "DOB", "name": "DOB", "autoWidth": true },
                            { "data": "AadharNo", "name": "AadharNo", "autoWidth": true },
                            { "data": "FatherName", "name": "FatherName", "autoWidth": true },
                            { "data": "State", "name": "State", "autoWidth": true },
                            { "data": "City", "name": "City", "autoWidth": true },
                            { "data": "Pincode", "name": "Pincode", "autoWidth": true },
                            { "data": "Address", "name": "Address", "autoWidth": true },
                            { "data": "JoiningDate", "name": "JoiningDate", "autoWidth": true }
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
                            "emptyTable": "No employee to display on " + selectedDateRangeName + ". Please check back later or review previous records."

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

        async function renderDepartment() {
            try {
                const response = await Ajax_GetResult_WithoutParameter("Report_Employee.aspx", "Get_Department");
                const data = JSON.parse(response.d);
                if (data.length > 0) {
                    Department.html('<option value="" Selected>Select Department</option>');
                    $.each(data, function (index, item) {
                        Department.append($('<option>', {
                            value: item.Department_Name,
                            text: item.Department_Name
                        }));
                    });
                }

            } catch (err) {
                console.log(err);
            }
        }

        async function OnChange_Department() {
            try {
                await Show_Spinner();
                dataToSend = {
                    Department: Department.val()
                }
                const response = await Ajax_GetResult("Report_Employee.aspx", "Get_Designation", dataToSend);
                const data = JSON.parse(response.d);
                if (data.length > 0) {
                    Designation.html('<option value="" Selected>Select Designation</option>');
                    $.each(data, function (index, item) {
                        Designation.append($('<option>', {
                            value: item.Designation_Name,
                            text: item.Designation_Name
                        }));
                    });
                }


                var parameters = {
                    Department: Department.val()
                };
                var dataToSend = "";
                for (var key in parameters) {
                    if (parameters.hasOwnProperty(key)) {
                        dataToSend += key + "='" + parameters[key] + "'&";
                    }
                }
                // Remove the trailing '&' character
                dataToSend = dataToSend.slice(0, -1);

                var url = "Report_Employee.aspx/Get_Employee_Detail_ByDepartment?" + dataToSend;
                await GetEmployee_Details(url);

            } catch (err) {
                console.log(err);
            }
            finally {
                await Hide_Spinner();
            }
        }
        async function OnChange_Designation() {
            try {
                await Show_Spinner();
                

                var parameters = {
                    Department: Department.val(),
                    Designation: Designation.val()
                };
                var dataToSend = "";
                for (var key in parameters) {
                    if (parameters.hasOwnProperty(key)) {
                        dataToSend += key + "='" + parameters[key] + "'&";
                    }
                }
                // Remove the trailing '&' character
                dataToSend = dataToSend.slice(0, -1);

                var url = "Report_Employee.aspx/Get_Employee_Detail_ByDesignation?" + dataToSend;
                await GetEmployee_Details(url);

            } catch (err) {
                console.log(err);
            }
            finally {
                await Hide_Spinner();
            }
        }

    </script>
</asp:Content>

