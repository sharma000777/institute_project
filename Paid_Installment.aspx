<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true" CodeFile="Paid_Installment.aspx.cs" Inherits="Admin_Paid_Installment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Paid Installment | Institute Management Software</title>
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
            #right_Export {
                width: 60%;
            }
            #right_Export0 {
                width: 40%;
            }
        }

        @media screen and (max-width: 768px) {
            #left_Search,#left_Search0 {
                width: 100%;
            }

                #left_Search,#left_Search0 > div {
                    flex-wrap: wrap;
                }

            #right_Export,#right_Export0 {
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
                <div class="card-header flex-column flex-md-row" style="display: flex; justify-content: space-between;">
                    <div class="dt-action-buttons pt-3 pt-md-0" id="left_Search0">
                        <div class="row g-6" style="font-size: 1rem;">
                            <div class="col-md-4">
                                <h5><span class="text-muted fw-light">Fee /</span> Paid Installment</h5>
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
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <div class="table-responsive text-nowrap">
                        <table class="table nowrap" id="tblPaidInstallment">
                            <caption class="ms-4">
                                List of Fee Payment
                            </caption>
                            <thead>
                                <tr>
                                    <th>SlNo</th>
                                    <th>Action</th>
                                    <th>Paid Date</th>
                                    <th>Paid Amount</th>
                                    <th>Student Name</th>
                                    <th>Mobile</th>
                                    <th>Installment No</th>
                                    <th>Payment Method</th>
                                    <th>Course Name</th>
                                    <th>Roll No</th>
                                    <th>Batch Name</th>
                                    <th>Invoice No</th>
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

        let SearchByMobile, OperatorToggle, OperatorDiv, IsOperator, Operator;
        let table, url, BtnAdd, BtnUpdate, dataToSend, selectedDateRangeName;

        IsOperator = false;

        const defaultRun = async () => {
            try {
                await renderPaidInstallment();
                await renderSearchByStudent();
            } catch (err) {
                console.log(err);
            }
        }

        $(document).ready(function () {
            OperatorToggle = $("#txtOperatorToggle");
            Operator = $("#txtOperator");
            OperatorDiv = $("#OperatorDiv");

            SearchByMobile = $("#txtSearchByMobile");

            (async function () {
                await Show_Spinner();
                await defaultRun().finally(async () => {
                    await Hide_Spinner();
                })
            })();
            $(document).on("click", "#txtOperatorToggle", OnClick_OperatorToggle);

            Operator.change(OnChange_Operator);
            SearchByMobile.change(OnChange_SearchByMobile);

        });
        async function OnClick_OperatorToggle() {
            try {
                await Show_Spinner();
                if ($(this).is(":checked")) {
                    IsOperator = true;
                    OperatorDiv.removeClass("hide");
                    await renderOperator();
                    await renderSearchByStudent();
                }
                else {
                    IsOperator = false;
                    await renderSearchByStudent();
                    await renderPaidInstallment();
                    OperatorDiv.addClass("hide");

                }
            } catch (err) {
                console.log(err);
            }
            finally {
                await Hide_Spinner();
            }
        }
        async function renderPaidInstallment() {
            try {
                var parameters = {
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
                var url = "Paid_Installment.aspx/Get_Fee_Payment_Detail?" + dataToSend;
                await GetPaidInstallment(url);
                await DateRange();
            } catch (err) {
                console.log(err);
            }
        }
        async function GetPaidInstallment(url) {

            try {
                return new Promise((resolve, reject) => {
                    table = $('#tblPaidInstallment').DataTable();

                    if ($.fn.DataTable.isDataTable('#tblPaidInstallment')) {
                        table.destroy();

                    }
                    table = $('#tblPaidInstallment').DataTable(
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
                                { "data": "Date", "name": "Date", "autoWidth": true },
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
                                { "data": "StudentName", "name": "StudentName", "autoWidth": true },
                                { "data": "Mobile", "name": "Mobile", "autoWidth": true },
                                { "data": "Installment_No", "name": "Installment_No", "autoWidth": true },
                                { "data": "PaymentMethod", "name": "PaymentMethod", "autoWidth": true },
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
                                { "data": "RollNo", "name": "RollNo", "autoWidth": true },
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
                                { "data": "InvoiceNo", "name": "InvoiceNo", "autoWidth": true }
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
                                "emptyTable": "No installment paid to display on " + selectedDateRangeName + ". Please check back later or review previous records."

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
                    var url = "Paid_Installment.aspx/Get_PaidInstallment_ByDate?" + dataToSend;
                    await GetPaidInstallment(url);
                    $('#tblPaidInstallment').DataTable().ajax.reload();
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
                const response = await Ajax_GetResult_WithoutParameter("Paid_Installment.aspx", "Get_MinDate");
                return response.d;
            } catch (err) {
                console.log(err);
            }

        }
        async function Get_MaxDate() {
            try {
                const response = await Ajax_GetResult_WithoutParameter("Paid_Installment.aspx", "Get_MaxDate");
                return response.d;
            } catch (err) {
                console.log(err);
            }

        }
        async function renderSearchByStudent() {
            try {
                const response = await Ajax_GetResult_WithoutParameter("Paid_Installment.aspx", "Get_SearchByStudent");
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
                    Mobile: SearchByMobile.val(),
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

                var url = "Paid_Installment.aspx/Get_PaidInstallment_ByMobile?" + dataToSend;
                await GetPaidInstallment(url);

            } catch (err) {
                console.log(err);
            }
            finally {
                await Hide_Spinner();
                $('#tblPaidInstallment').DataTable().ajax.reload();
            }
        }
        async function renderOperator() {
            try {
                const response = await Ajax_GetResult_WithoutParameter("Paid_Installment.aspx", "Get_Operator");
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
        async function OnChange_Operator() {
            try {
                await Show_Spinner();
                await renderSearchByStudent();
                await renderPaidInstallment();

            } catch (err) {
                console.log(err);
            }
            finally {
                await Hide_Spinner();
                $('#tblPaidInstallment').DataTable().ajax.reload();
            }
        }

    </script>
</asp:Content>

