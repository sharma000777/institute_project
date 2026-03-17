<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true"
    CodeFile="Dues_Notified.aspx.cs" Inherits="Admin_Dues_Notified" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Dues Notified | Institute Management Software</title>
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

        .update-link {
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
                        <h5><span class="text-muted fw-light">Master /</span> Dues Notified</h5>
                    </div>

                </div>
                <div class="card-header flex-column flex-md-row" style="display: flex; justify-content: space-between;">
                    <div class="dt-action-buttons pt-3 pt-md-0" id="left_Search">
                        <div class="dt-buttons btn-group" style="width: 100%; display: flex;">
                            <div class="row" style="width: 100%">
                                <div class="col-md-8">
                                    <div class="form-floating form-floating-outline mb-3" style="margin-right: 1rem;
                                        width: 100%">
                                        <select name="txtSearchByMobile" id="txtSearchByMobile" class="select2 form-select"
                                            data-allow-clear="true">
                                            <option value="">Select Mobile</option>
                                        </select>
                                        <label for="txtSearchByMobile">Filter by Mobile</label>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                    <div class="dt-action-buttons pt-3 pt-md-0" id="right_Export">

                        <%--<div class="dt-buttons btn-group" style="width: 100%; display: flex; justify-content: end">
                            <div id="reportrange" style="background: #fff; cursor: pointer; padding: 10px 10px;
                                border: 1px solid #ccc; max-width: fit-content;">
                                <i class="ri-calendar-2-line"></i>&nbsp;<span></span><i class="ri-arrow-down-s-line"
                                    style="margin-left: 5px"></i>
                            </div>
                        </div>--%>
                    </div>
                </div>
                <div class="card-body">
                    <div class="table-responsive text-nowrap">
                        <table class="table nowrap" id="tblDues_Notified">
                            <caption class="ms-4">
                                List of Dues Notified
                            </caption>
                            <thead>
                                <tr>
                                    <th>SlNo</th>
                                    <th>View All</th>
                                    <th>Student Name</th>
                                    <th>Mobile</th>
                                    <th>Next Dues Date</th>
                                    <th>Next Dues Amount</th>
                                    <th>Installment No</th>
                                    <th>Total Dues</th>
                                    <th>Remaining Installment</th>
                                </tr>
                            </thead>
                        </table>

                    </div>
                </div>

            </div>
        </div>
    </div>
    <!-- Edit User Modal -->
    <div class="modal fade" id="AddUpdateCommentModal" tabindex="-1" aria-hidden="true"
        data-bs-backdrop="static" data-bs-keyboard="false">
        <div class="modal-dialog modal-dialog-centered modal-lg modal-simple modal-edit-user">
            <div class="modal-content">
                <div class="modal-body p-0">
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
                    </button>
                    <div class="text-center mb-6">
                        <h4 class="mb-2">All Notification</h4>
                    </div>
                    <div class="row g-5" id="formAuthentication1">
                        <div class="col-12 col-md-6">
                            <i class="ri-user-3-line ri-24px"></i><span class="fw-medium mx-2">Full Name:</span>
                            <span id="txtName1"></span>
                        </div>
                        <div class="col-12 col-md-6">
                            <i class="ri-phone-line ri-24px"></i><span class="fw-medium mx-2">Contact:</span>
                            <span id="txtMobile1"></span>
                        </div>
                        <div class="col-12 col-md-12">
                            <div class="card-body">
                                <div class="table-responsive text-nowrap">
                                    <table class="table nowrap" id="tblAll_Notified">
                                        <caption class="ms-4">
                                            List of All Notified
                                        </caption>
                                        <thead>
                                            <tr>
                                                <th>SlNo</th>
                                                <th>Installment No</th>
                                                <th>Notify Date</th>
                                            </tr>
                                        </thead>
                                    </table>

                                </div>
                            </div>
                        </div>

                        <div class="col-12 text-center">
                            <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal" aria-label="Close">
                                Cancel</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--/ Edit User Modal -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>


    <script type="text/javascript">

        let SearchByMobile;
        let table, url, BtnAdd, BtnUpdate, dataToSend, selectedDateRangeName;
        let formAuthentication1 = document.querySelector("#formAuthentication1");
        let formValidationInstance1;
        const defaultRun = async () => {
            try {
                var url = "Dues_Notified.aspx/Get_DuesNotified";
                await GetDuesNotified(url);
                //await DateRange();
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

            $(document).on("click", "a.update-link", OnClick_update_link);

            SearchByMobile.change(OnChange_SearchByMobile);


        });
        async function OnClick_update_link() {
            try {
                await Show_Spinner();
                $('#AddUpdateCommentModal').on('shown.bs.modal', function () {
                    $('#AddUpdateCommentModal').modal('show');

                });

                Id = this.name;

                $("#txtName1").html($(this).data("name"));
                $("#txtMobile1").html($(this).data("mobile"));

                var parameters = {
                    StudentId: this.name,
                };
                var dataToSend = "";
                for (var key in parameters) {
                    if (parameters.hasOwnProperty(key)) {
                        dataToSend += key + "='" + parameters[key] + "'&";
                    }
                }
                // Remove the trailing '&' character
                dataToSend = dataToSend.slice(0, -1);
                var url = "Dues_Notified.aspx/Get_AllNotified?" + dataToSend;
                await GetAllNotified(url);


            } catch (err) {
                console.log(err);
            }
            finally {
                await Hide_Spinner();
            }

        }
        async function GetDuesNotified(url) {

            try {
                return new Promise((resolve, reject) => {
                    table = $('#tblDues_Notified').DataTable();

                    if ($.fn.DataTable.isDataTable('#tblDues_Notified')) {
                        table.destroy();

                    }
                    table = $('#tblDues_Notified').DataTable(
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
                                    "data": "StudentId",
                                    "render": function (data, type, row, meta) { // Added parameters
                                        var rowHtml = "";
                                        rowHtml += '<a class="update-link" data-tooltip="View All Notification" name="' + data + '" data-name="' + row.StudentName + '" data-mobile="' + row.Mobile + '" href="javascript:void(0);" data-bs-toggle="modal" data-bs-target="#AddUpdateCommentModal"><i class="menu-icon tf-icons ri-notification-2-line"></i></a>';
                                        return rowHtml;
                                    },
                                    "orderable": false,
                                    "width": "0rem"
                                },
                                { "data": "StudentName", "name": "StudentName", "autoWidth": true },
                                { "data": "Mobile", "name": "Mobile", "autoWidth": true },
                                { "data": "Dues_Date", "name": "Dues_Date", "autoWidth": true },
                                {
                                    "data": "Installment_Amount",
                                    "render": function (data, type, row, meta) { // Added parameters
                                        var rowHtml = "";
                                        rowHtml = "₹ " + data
                                        return rowHtml;
                                    },
                                    "orderable": false,
                                    "autoWidth": true
                                },
                                { "data": "InstallmentNo", "name": "InstallmentNo", "autoWidth": true },
                                {
                                    "data": "Total_Dues",
                                    "render": function (data, type, row, meta) { // Added parameters
                                        var rowHtml = "";
                                        rowHtml = "₹ " + data
                                        return rowHtml;
                                    },
                                    "orderable": false,
                                    "autoWidth": true
                                },
                                { "data": "Total_Installment", "name": "Total_Installment", "autoWidth": true }
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
                                "emptyTable": "No Dues Notified within 5 days to display on " + selectedDateRangeName + ". Please check back later or review previous records."

                            }
                        });

                })
            } catch (err) {
                console.log(err);
                throw err;
            }



        }
        async function GetAllNotified(url) {

            try {
                return new Promise((resolve, reject) => {
                    table = $('#tblAll_Notified').DataTable();

                    if ($.fn.DataTable.isDataTable('#tblAll_Notified')) {
                        table.destroy();

                    }
                    table = $('#tblAll_Notified').DataTable(
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
                                { "data": "InstallmentNo", "name": "InstallmentNo", "autoWidth": true },
                                { "data": "NotifyDate", "name": "NotifyDate", "autoWidth": true }
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
                                "emptyTable": "No Dues Notified within 5 days to display on " + selectedDateRangeName + ". Please check back later or review previous records."

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
                    var url = "Dues_Notified.aspx/Get_StudentFee_ByDate?" + dataToSend;
                    await GetDuesNotified(url);
                    $('#tblDues_Notified').DataTable().ajax.reload();
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
                const response = await Ajax_GetResult_WithoutParameter("Dues_Notified.aspx", "Get_MinDate");
                return response.d;
            } catch (err) {
                console.log(err);
            }

        }
        async function Get_MaxDate() {
            try {
                const response = await Ajax_GetResult_WithoutParameter("Dues_Notified.aspx", "Get_MaxDate");
                return response.d;
            } catch (err) {
                console.log(err);
            }

        }
        async function renderSearchByStudent() {
            try {
                const response = await Ajax_GetResult_WithoutParameter("Dues_Notified.aspx", "Get_SearchByStudent");
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

                var url = "Dues_Notified.aspx/Get_StudentFee_ByMobile?" + dataToSend;
                await GetDuesNotified(url);

            } catch (err) {
                console.log(err);
            }
            finally {
                await Hide_Spinner();
                $('#tblDues_Notified').DataTable().ajax.reload();
            }
        }



    </script>
</asp:Content>

