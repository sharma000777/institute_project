<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true" CodeFile="Student_Fee.aspx.cs" Inherits="Admin_Student_Fee" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Student Fee | Institute Management Software</title>
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
                        <h5><span class="text-muted fw-light">Master /</span> Student Fee</h5>
                    </div>

                </div>
                <div class="card-header flex-column flex-md-row" style="display: flex; justify-content: space-between;">
                    <div class="dt-action-buttons pt-3 pt-md-0" id="left_Search">
                        <div class="dt-buttons btn-group" style="width: 100%; display: flex;">
                            <div class="row" style="width: 100%">
                                <div class="col-md-8">
                                    <div class="form-floating form-floating-outline mb-3" style="margin-right: 1rem; width: 100%">
                                        <select name="txtSearchByMobile" id="txtSearchByMobile" class="select2 form-select" data-allow-clear="true">
                                            <option value="">Select Mobile</option>
                                        </select>
                                        <label for="txtSearchByMobile">Filter by Mobile</label>
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
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <div class="table-responsive text-nowrap">
                        <table class="table nowrap" id="tblStudent_Fee">
                            <caption class="ms-4">
                                List of Student Fee
                            </caption>
                            <thead>
                                <tr>
                                    <th>SlNo</th>
                                    <th>Action</th>
                                    <th>Status</th>
                                    <th>Student Name</th>
                                    <th>Mobile</th>
                                    <th>Total Amount</th>
                                    <th>Concession</th>
                                    <th>Net Amount</th>
                                    <th>Total Paid</th>
                                    <th>Total Dues</th>
                                    <th>Payment Mode</th>
                                    <th>Payment Method</th>
                                    <th>Total Installment</th>
                                    <th>Installment Due</th>
                                    <th>Date</th>
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

        let SearchByMobile;
        let table, url, BtnAdd, BtnUpdate, dataToSend, selectedDateRangeName;

        const defaultRun = async () => {
            try {
                var url = "Student_Fee.aspx/Get_StudentFee_Detail";
                await GetStudentFee(url);
                await DateRange();
                await renderSearchByStudent();
            } catch (err) {
                console.log(err);
            }
        }

        $(document).ready(function () {

            SearchByMobile = $("#txtSearchByMobile");

            (async function () {
                await Show_Spinner();
                await defaultRun().finally(async () => {
                    await Hide_Spinner();
                })
            })();

            SearchByMobile.change(OnChange_SearchByMobile);


        });

        async function GetStudentFee(url) {

            try {
                return new Promise((resolve, reject) => {
                    table = $('#tblStudent_Fee').DataTable();

                    if ($.fn.DataTable.isDataTable('#tblStudent_Fee')) {
                        table.destroy();

                    }
                    table = $('#tblStudent_Fee').DataTable(
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
                                    "data": "InvoiceNo",
                                    "render": function (data, type, row, meta) { // Added parameters
                                        var rowHtml = "";
                                        rowHtml += '<a class="update-link" data-tooltip="Print Invoice" name="' + data + '" href="PrintInvoice.aspx?InvoiceNo=' + row.InvoiceNo + '&Mobile=' + row.Mobile + '" target="_blank"><i class="menu-icon tf-icons ri-printer-fill"></i></a>';
                                        return rowHtml;
                                    },
                                    "orderable": false,
                                    "width": "0rem"
                                },
                                {
                                    "data": "Status",
                                    "render": function (data, type, row, meta) { // Added parameters
                                        var rowHtml = "";
                                        if (data == "Dues")
                                            rowHtml = '<span class="badge rounded-pill bg-label-danger me-1">' + data + '</span>'
                                        else
                                            rowHtml = '<span class="badge rounded-pill bg-label-primary me-1">' + data + '</span>'
                                        return rowHtml;
                                    },
                                    "orderable": false,
                                    "autoWidth": true
                                },
                                { "data": "StudentName", "name": "StudentName", "autoWidth": true },
                                { "data": "Mobile", "name": "Mobile", "autoWidth": true },
                                {
                                    "data": "TotalAmount",
                                    "render": function (data, type, row, meta) { // Added parameters
                                        var rowHtml = "";
                                        rowHtml = "₹ " + data
                                        return rowHtml;
                                    },
                                    "orderable": false,
                                    "autoWidth": true
                                },
                                { "data": "Concession", "name": "Concession", "autoWidth": true },
                                {
                                    "data": "NetAmount",
                                    "render": function (data, type, row, meta) { // Added parameters
                                        var rowHtml = "";
                                        rowHtml = "₹ " + data
                                        return rowHtml;
                                    },
                                    "orderable": false,
                                    "autoWidth": true
                                },
                                {
                                    "data": "PaidAmount",
                                    "render": function (data, type, row, meta) { // Added parameters
                                        var rowHtml = "";
                                        rowHtml = "₹ " + data
                                        return rowHtml;
                                    },
                                    "orderable": false,
                                    "autoWidth": true
                                },
                                {
                                    "data": "DuesAmount",
                                    "render": function (data, type, row, meta) { // Added parameters
                                        var rowHtml = "";
                                        rowHtml = "₹ " + data
                                        return rowHtml;
                                    },
                                    "orderable": false,
                                    "autoWidth": true
                                },
                                { "data": "PaymentMode", "name": "PaymentMode", "autoWidth": true },
                                { "data": "PaymentMethod", "name": "PaymentMethod", "autoWidth": true },
                                { "data": "TotalInstallment", "name": "TotalInstallment", "autoWidth": true },
                                { "data": "InstallmentDue", "name": "InstallmentDue", "autoWidth": true },
                                { "data": "Date", "name": "Date", "autoWidth": true }
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
                                "emptyTable": "No Student fee to display on " + selectedDateRangeName + ". Please check back later or review previous records."

                            }
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

                var start = moment(minDate.format('MMMM D, YYYY'));
                var end = moment(maxDate.format('MMMM D, YYYY'));

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
                    var url = "Student_Fee.aspx/Get_StudentFee_ByDate?" + dataToSend;
                    await GetStudentFee(url);
                    $('#tblStudent_Fee').DataTable().ajax.reload();
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
                const response = await Ajax_GetResult_WithoutParameter("Student_Fee.aspx", "Get_MinDate");
                return response.d;
            } catch (err) {
                console.log(err);
            }

        }
        async function Get_MaxDate() {
            try {
                const response = await Ajax_GetResult_WithoutParameter("Student_Fee.aspx", "Get_MaxDate");
                return response.d;
            } catch (err) {
                console.log(err);
            }

        }
        async function renderSearchByStudent() {
            try {
                const response = await Ajax_GetResult_WithoutParameter("Student_Fee.aspx", "Get_SearchByStudent");
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
        async function OnChange_SearchByMobile() {
            try {
                await Show_Spinner();

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

                var url = "Student_Fee.aspx/Get_StudentFee_ByMobile?" + dataToSend;
                await GetStudentFee(url);

            } catch (err) {
                console.log(err);
            }
            finally {
                await Hide_Spinner();
                $('#tblStudent_Fee').DataTable().ajax.reload();
            }
        }



    </script>
</asp:Content>

