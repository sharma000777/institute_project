<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true" CodeFile="Dues_Installment.aspx.cs" Inherits="Admin_Dues_Installment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Dues Installment | Institute Management Software</title>
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
                        <h5><span class="text-muted fw-light">Master /</span> Dues Installment</h5>
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
                        <table class="table nowrap" id="tblDuesInstallment">
                            <caption class="ms-4">
                                List of Fee Payment
                            </caption>
                            <thead>
                                <tr>
                                    <th>SlNo</th>
                                    <th>Action</th>
                                    <th>Due Date</th>
                                    <th>Due Amount</th>
                                    <th>Student Name</th>
                                    <th>Mobile</th>
                                    <th>Course Name</th>
                                    <th>Batch Name</th>
                                    <th>Roll No</th>
                                    <th>Student Id</th>
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
                        <h4 class="mb-2">Dues Payment</h4>
                    </div>
                    <div class="row g-6">
                        <div class="card col-md-6">
                            <h5 class="mb-2 my-4">Student Info</h5>
                            <div class="row g-4 text-center">
                                <div class="col-6">
                                    <div class="d-flex align-items-center justify-content-center mb-1">
                                        <div class="badge badge-dot bg-primary me-2"></div>
                                        <p class="mb-0">Student Id</p>
                                    </div>
                                    <p class="fw-medium mb-0"><span id="txtStudentId"></span></p>
                                </div>
                                <div class="col-6">
                                    <div class="d-flex align-items-center justify-content-center mb-1">
                                        <div class="badge badge-dot bg-primary me-2"></div>
                                        <p class="mb-0">Admission No</p>
                                    </div>
                                    <p class="fw-medium mb-0"><span id="txtAdmissionNo"></span></p>
                                </div>
                                <div class="col-6">
                                    <div class="d-flex align-items-center justify-content-center mb-1">
                                        <div class="badge badge-dot bg-primary me-2"></div>
                                        <p class="mb-0">Student Name</p>
                                    </div>
                                    <p class="fw-medium mb-0"><span id="txtStudentName"></span></p>
                                </div>
                                <div class="col-6">
                                    <div class="d-flex align-items-center justify-content-center mb-1">
                                        <div class="badge badge-dot bg-primary me-2"></div>
                                        <p class="mb-0">Mobile</p>
                                    </div>
                                    <p class="fw-medium mb-0"><span id="txtMobile"></span></p>
                                </div>
                            </div>
                            
                        </div>
                        <div class="card col-md-6">
                            <h5 class="mb-2 my-4" style="">Current Installment Info</h5>
                            <div class="row g-4 text-center">
                                <div class="col-6">
                                    <div class="d-flex align-items-center justify-content-center mb-1">
                                        <div class="badge badge-dot bg-primary me-2"></div>
                                        <p class="mb-0">Due Amount</p>
                                    </div>
                                    <p class="fw-medium mb-0">₹ <span id="lblMyNextInstallmentAmount"></span></p>
                                </div>
                                <div class="col-6">
                                    <div class="d-flex align-items-center justify-content-center mb-1">
                                        <div class="badge badge-dot bg-primary me-2"></div>
                                        <p class="mb-0">Remaining Tenure</p>
                                    </div>
                                    <p class="fw-medium mb-0"><span id="lblMyRemainingInstallmentNo"></span></p>
                                </div>
                                <div class="col-6">
                                    <div class="d-flex align-items-center justify-content-center mb-1">
                                        <div class="badge badge-dot bg-primary me-2"></div>
                                        <p class="mb-0">Total Dues Amount</p>
                                    </div>
                                    <p class="fw-medium mb-0">₹ <span id="lblMyTotalDuesAmount"></span></p>
                                </div>
                                <div class="col-6">
                                    <div class="d-flex align-items-center justify-content-center mb-1">
                                        <div class="badge badge-dot bg-primary me-2"></div>
                                        <p class="mb-0">Dues Date</p>
                                    </div>
                                    <p class="fw-medium mb-0"><span id="lblMyNextDuesDate"></span></p>
                                </div>
                            </div>
                        </div>


                        <div class="col-12 col-md-12">
                            <h6>After Make Payment :</h6>
                            <div class="table-responsive text-nowrap text-center" style="overflow-x: scroll">
                                <table class="table nowrap">
                                    <caption class="ms-4">
                                        List of My Installments
   
                                    </caption>
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Next Installment Dues</th>
                                            <th>Total Dues</th>
                                        </tr>
                                    </thead>
                                    <tbody id="tblMyInstallment">
                                        <tr>
                                            <td>
                                                <span>1</span>
                                            </td>
                                            <td>
                                                <label for="txtMyInstallment" style="cursor: pointer;"><span id="lblMyNewDuesInstallment" style="margin-right:5px"></span>x <span id="lblMyNewDuesInstallmentNo"></span></label>
                                            </td>
                                            <td>
                                                <label for="txtMyInstallment" style="cursor: pointer;"><span id="lblMyNewTotalDuesAmount"></span></label>
                                            </td>
                                        </tr>

                                    </tbody>
                                </table>

                            </div>
                        </div>

                        <div class="col-12 col-md-7 offset-md-5" id="NewNextDueDateDiv">
                            <div class="form-floating form-floating-outline validation">
                                <input type="date" id="txtNewNextDueDate" name="txtNewNextDueDate" class="form-control" />
                                <label for="txtNewNextDueDate">Next Due Date *</label>
                            </div>
                        </div>
                        <div class="col-12 col-md-7 offset-md-5">
                            <div class="form-floating form-floating-outline validation">
                                <input type="text" id="txtAmountToPay" name="txtAmountToPay" class="form-control" placeholder="Enter amount" />
                                <label for="txtAmountToPay">Amount to Pay *</label>
                            </div>
                        </div>
                        <div class="col-12 col-md-7 offset-md-5">
                            <div class="form-floating form-floating-outline validation">
                                <select name="txtNewPaymentMethod" id="txtNewPaymentMethod" class="select2 form-select" data-allow-clear="true">
                                    <option value="">Select Mode</option>
                                    <option value="Cash">Cash</option>
                                    <option value="UPI">UPI</option>
                                    <option value="Bank transfers">Bank transfers</option>
                                    <option value="Nifty">Nifty</option>
                                    <option value="Cheque">Cheque</option>
                                </select>
                                <label for="txtNewPaymentMethod">Payment Method *</label>
                            </div>

                        </div>

                        <div class="col-12 text-center">
                            <button id="BtnPay" type="button" class="btn btn-primary me-3" style="width: 25%;">Pay Dues</button>
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

        let StudentId, AdmissionNo, StudentName, Mobile, AmountToPay, DuesAmount, NewNextDueDate, NewNextDueDateDiv, NewPaymentMethod;
        let SearchByMobile, MyNextInstallmentAmount, MyRemainingInstallmentNo, MyTotalDuesAmount, MyNextDuesDate, MyNewDuesInstallment, MyNewDuesInstallmentNo, MyNewTotalDuesAmount;
        let table, url, BtnAdd, BtnUpdate, dataToSend, selectedDateRangeName;
        let IsNextInstallment;

        const defaultRun = async () => {
            try {
                var url = "Dues_Installment.aspx/Get_Fee_Payment_Detail";
                await GetDuesInstallment(url);
                await DateRange();
                await renderSearchByStudent();
            } catch (err) {
                console.log(err);
            }
        }

        $(document).ready(function () {

            StudentId = $("#txtStudentId");
            AdmissionNo = $("#txtAdmissionNo");
            StudentName = $("#txtStudentName");
            Mobile = $("#txtMobile");
            AmountToPay = $("#txtAmountToPay");
            NewPaymentMethod = $("#txtNewPaymentMethod");
            NewNextDueDate = $("#txtNewNextDueDate");
            NewNextDueDateDiv = $("#NewNextDueDateDiv");

            SearchByMobile = $("#txtSearchByMobile");

            MyNextInstallmentAmount = $("#lblMyNextInstallmentAmount");
            MyRemainingInstallmentNo = $("#lblMyRemainingInstallmentNo");
            MyTotalDuesAmount = $("#lblMyTotalDuesAmount");
            MyNextDuesDate = $("#lblMyNextDuesDate");

            MyNewDuesInstallment = $("#lblMyNewDuesInstallment");
            MyNewDuesInstallmentNo = $("#lblMyNewDuesInstallmentNo");
            MyNewTotalDuesAmount = $("#lblMyNewTotalDuesAmount");

            (async function () {
                await Show_Spinner();
                await defaultRun().finally(async () => {
                    await Hide_Spinner();
                })
            })();

            $(document).on("click", "a.update-link", OnClick_update_link);
            $(document).on("click", "#BtnPay", OnClick_BtnPay);


            SearchByMobile.change(OnChange_SearchByMobile);
            AmountToPay.keyup(OnChange_AmountToPay);



        });

        async function GetDuesInstallment(url) {

            try {
                return new Promise((resolve, reject) => {
                    table = $('#tblDuesInstallment').DataTable();

                    if ($.fn.DataTable.isDataTable('#tblDuesInstallment')) {
                        table.destroy();

                    }
                    table = $('#tblDuesInstallment').DataTable(
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
                                        rowHtml += '<a class="btn btn-danger btn-xs update-link" name="' + data + '" href="javascript:void(0);" data-bs-toggle="modal" data-bs-target="#AddUpdateModal">Pay Dues</a>'; // Changed here
                                        return rowHtml;
                                    },
                                    "orderable": false,
                                    "width": "0rem"
                                },
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
                                { "data": "StudentId", "name": "StudentId", "autoWidth": true },


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
                                "emptyTable": "No dues installment to display on " + selectedDateRangeName +". Please check back later or review previous records."

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
                    };
                    var dataToSend = "";
                    for (var key in parameters) {
                        if (parameters.hasOwnProperty(key)) {
                            dataToSend += key + "='" + parameters[key] + "'&";
                        }
                    }
                    // Remove the trailing '&' character
                    dataToSend = dataToSend.slice(0, -1);
                    var url = "Dues_Installment.aspx/Get_DuesInstallment_ByDate?" + dataToSend;
                    await GetDuesInstallment(url);
                    $('#tblDuesInstallment').DataTable().ajax.reload();
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
                const response = await Ajax_GetResult_WithoutParameter("Dues_Installment.aspx", "Get_MinDate");
                return response.d;
            } catch (err) {
                console.log(err);
            }

        }
        async function Get_MaxDate() {
            try {
                const response = await Ajax_GetResult_WithoutParameter("Dues_Installment.aspx", "Get_MaxDate");
                return response.d;
            } catch (err) {
                console.log(err);
            }

        }
        async function renderSearchByStudent() {
            try {
                const response = await Ajax_GetResult_WithoutParameter("Dues_Installment.aspx", "Get_SearchByStudent");
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

                var url = "Dues_Installment.aspx/Get_DuesInstallment_ByMobile?" + dataToSend;
                await GetDuesInstallment(url);

            } catch (err) {
                console.log(err);
            }
            finally {
                await Hide_Spinner();
                $('#tblDuesInstallment').DataTable().ajax.reload();
            }
        }
        async function OnClick_update_link() {
            try {
                await Show_Spinner();
                restrictDate();
                $('#AddUpdateModal').on('shown.bs.modal', function () {
                    $('#AddUpdateModal').modal('show');

                });


                Id = this.name;
                dataToSend = {
                    StudentId: this.name
                };
                const response = await Ajax_GetResult("Dues_Installment.aspx", "Get_UpdateDetail", dataToSend);
                const data = JSON.parse(response.d);
                console.log(data)

                const item = data[0];

                StudentId.html(item.StudentId);
                AdmissionNo.html(item.AdmissionNo);
                StudentName.html(item.StudentName);
                Mobile.html(item.Mobile);
                AmountToPay.val(item.Installment_Amount);
                DuesAmount = item.Installment_Amount

                MyNextInstallmentAmount.html(item.Installment_Amount);
                MyRemainingInstallmentNo.html(item.Total_Installment);
                MyTotalDuesAmount.html(item.Total_Dues);
                MyNextDuesDate.html(item.Dues_Date);

                await renderMyDuesInstallment();

            } catch (err) {
                console.log(err);
            }
            finally {
                await Hide_Spinner();
            }

        }
        async function OnChange_AmountToPay() {
            await renderMyDuesInstallment();
            if (MyNewTotalDuesAmount.html() === "0") {
                NewNextDueDateDiv.addClass("hide");
                MyNewDuesInstallmentNo.html("0");
            }
            else {
                NewNextDueDateDiv.removeClass("hide");
            }
        }
        async function renderMyDuesInstallment() {
            const PayingAmount = parseFloat(AmountToPay.val());
            const TotalAmount = parseFloat(MyTotalDuesAmount.html());
            const MyNewTotalDues = TotalAmount - PayingAmount;
            var MyInstallmentNumber;
            console.log("MyRemainingInstallmentNo.html()")
            console.log(MyRemainingInstallmentNo.html())
            if ((MyNewTotalDues != "0" || MyNewTotalDues != "0.00") && MyRemainingInstallmentNo.html() === "1")
                MyInstallmentNumber = 1;
            else
                MyInstallmentNumber = parseFloat(MyRemainingInstallmentNo.html()) - 1;

            const NewInstallmentAmount = MyNewTotalDues / MyInstallmentNumber;

            if (MyNewTotalDues == "0" || MyNewTotalDues == "0.00") {
                MyNewDuesInstallment.html("0");
                IsNextInstallment = false;
                NewNextDueDateDiv.addClass("hide");
            }
            else {
                MyNewDuesInstallment.html(NewInstallmentAmount.toFixed(2));
                IsNextInstallment = true;
                NewNextDueDateDiv.removeClass("hide");

            }
            if ((MyNewTotalDues == "0" || MyNewTotalDues == "0.00") && MyRemainingInstallmentNo.html() === "1") {
                AmountToPay.attr("readOnly", true);
            }
            else {
                AmountToPay.attr("readOnly", false);

            }
            MyNewDuesInstallmentNo.html(MyInstallmentNumber);
            MyNewTotalDuesAmount.html(MyNewTotalDues);
        }
        async function Validate1() {
            var flag;
            if (NewNextDueDate.val() === "") {
                flag = false;
                Warning("Please Select Next Due Date");
            }
            else if (AmountToPay.val() === "") {
                flag = false;
                Warning("Please enter Amount to Pay");
            }
            else if (NewPaymentMethod.val() === "") {
                flag = false;
                Warning("Please select Payment Method");
            }
            else {
                flag = true;
            }
            return flag;
        }
        async function Validate2() {
            var flag;
            if (AmountToPay.val() === "") {
                flag = false;
                Warning("Please enter Amount to Pay");
            }
            else if (NewPaymentMethod.val() === "") {
                flag = false;
                Warning("Please select Payment Method");
            }
            else {
                flag = true;
            }
            return flag;
        }
        async function OnClick_BtnPay() {

            try {
                let IsValid;
                var modifyNextDueDate = NewNextDueDate.val();
                if (!IsNextInstallment) {
                    modifyNextDueDate = ""
                    IsValid = await Validate2();
                }
                else {
                    IsValid = await Validate1();
                }

                if (IsValid) {
                    const result = await Confirm("Yes, Pay it !", "Are you sure want to Clear Dues ?")

                    if (result.isConfirmed) {
                        await Show_Spinner();


                        dataToSend = {
                            StudentId: StudentId.html(),
                            AmountToPay: AmountToPay.val(),
                            MyNewDuesInstallment: MyNewDuesInstallment.html(),
                            MyNewDuesInstallmentNo: MyNewDuesInstallmentNo.html(),
                            MyNewTotalDuesAmount: MyNewTotalDuesAmount.html(),
                            NewNextDueDate: modifyNextDueDate,
                            NewPaymentMethod: NewPaymentMethod.val()
                        }

                        const response = await Ajax_GetResult("Dues_Installment.aspx", "Pay_Dues_Installment", dataToSend);
                        if (response.d != "") {
                            dataToSend = {
                                StudentId: StudentId.html()
                            }
                            await Ajax_GetResult("Dues_Installment.aspx", "Update_Status", dataToSend);
                            $('#tblDuesInstallment').DataTable().ajax.reload();
                            $('#AddUpdateModal').modal('toggle');
                            Success("Paid", "Dues Paid Successfully");
                            window.open('PrintInvoice.aspx?InvoiceNo=' + response.d + '&Mobile=' + Mobile.html() + '&PayMode=Installment', '_blank');

                        }
                        else {
                            Failed("Paid Failed !")
                        }


                    }
                }


            } catch (err) {
                console.log(err);
            }
            finally {
                await Hide_Spinner();
            }

        }
        function restrictDate() {
            var currentDate = new Date();
            var tomorrowDate = new Date(currentDate);
            tomorrowDate.setDate(currentDate.getDate());

            var minDate = tomorrowDate.getFullYear() + '-' + ('0' + (tomorrowDate.getMonth() + 1)).slice(-2) + '-' + ('0' + tomorrowDate.getDate()).slice(-2);

            NewNextDueDate.attr('min', minDate);
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

