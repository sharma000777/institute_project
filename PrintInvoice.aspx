<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintInvoice.aspx.cs" Inherits="Admin_PrintInvoice" %>

<!DOCTYPE html>

<html lang="en" class="light-style layout-navbar-fixed layout-menu-fixed layout-compact " dir="ltr" data-theme="theme-bordered" data-assets-path="../../assets/" data-template="vertical-menu-template-bordered" data-style="light">
<head runat="server">
    <title>Reciept | Institute Management Software</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
    <meta name="description" content="Start your development with a Dashboard for Bootstrap 5" />
    <meta name="keywords" content="dashboard, material, material design, bootstrap 5 dashboard, bootstrap 5 design, bootstrap 5">
    <link rel="icon" type="image/x-icon" href="../Images/fav_icon.ico" />
    <link rel="preconnect" href="https://fonts.googleapis.com/">
    <link rel="preconnect" href="https://fonts.gstatic.com/" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&amp;display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../UserLogin_Content/assets/vendor/fonts/remixicon/remixicon.css" />
    <link rel="stylesheet" href="../UserLogin_Content/assets/vendor/fonts/flag-icons.css" />
    <link rel="stylesheet" href="../UserLogin_Content/assets/vendor/libs/node-waves/node-waves.css" />
    <link rel="stylesheet" href="../UserLogin_Content/assets/vendor/css/rtl/core.css" class="template-customizer-core-css" />
    <link rel="stylesheet" href="../UserLogin_Content/assets/vendor/css/rtl/theme-bordered.css?v=7" class="template-customizer-theme-css" />
    <link rel="stylesheet" href="../UserLogin_Content/assets/css/demo.css" />
    <link rel="stylesheet" href="../UserLogin_Content/assets/vendor/libs/flatpickr/flatpickr.css" />
    <link rel="stylesheet" href="../UserLogin_Content/assets/vendor/libs/@form-validation/form-validation.css" />
    <link rel="stylesheet" href="../UserLogin_Content/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
    <link rel="stylesheet" href="../UserLogin_Content/assets/vendor/libs/typeahead-js/typeahead.css" />
    <link rel="stylesheet" href="../UserLogin_Content/assets/vendor/libs/bs-stepper/bs-stepper.css" />
    <link rel="stylesheet" href="../UserLogin_Content/assets/vendor/libs/bootstrap-select/bootstrap-select.css" />
    <link rel="stylesheet" href="../UserLogin_Content/assets/vendor/libs/select2/select2.css" />
    <link rel="stylesheet" href="../UserLogin_Content/assets/vendor/libs/dropzone/dropzone.css" />
    <link rel="stylesheet" href="../UserLogin_Content/assets/vendor/libs/bootstrap-maxlength/bootstrap-maxlength.css" />
    <link rel="stylesheet" href="../UserLogin_Content/assets/vendor/css/pages/page-auth.css" />
    <link rel="stylesheet" href="../UserLogin_Content/assets/vendor/libs/animate-css/animate.css" />
    <link rel="stylesheet" href="../UserLogin_Content/assets/vendor/libs/sweetalert2/sweetalert2.css" />

    <link rel="stylesheet" href="../UserLogin_Content/assets/vendor/css/pages/app-invoice.css" />

    <script src="../UserLogin_Content/assets/vendor/js/helpers.js"></script>
    <script src="../UserLogin_Content/assets/js/config.js"></script>
    <style>
        .table > :not(caption) > * > * {
            padding: 1.284rem 1.25rem;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Content -->

        <div class="" id="print">

            <div class="row invoice-preview">
                <!-- Invoice -->
                <div class="col-12 mb-md-0 mb-6">
                    <div class="card invoice-preview-card p-sm-12 p-6">
                        <div class="card-body invoice-preview-header rounded p-6 text-heading">
                            <div class="d-flex justify-content-between flex-wrap row-gap-2">
                                <div class="mb-xl-0 mb-6" style="width: 50%">
                                    <div class="d-flex svg-illustration align-items-center gap-3 mb-6">
                                        <img id="lblInstitutePhoto" src="../Images/logo.png" alt="P. Singh Chemistry Classes" class="logo" style="mix-blend-mode: luminosity; width: 3rem;">
                                        <span class="mb-0 app-brand-text fw-semibold" id="lblInstituteName">P. SINGH CHEMISTRY CLASSES</span>
                                    </div>
                                    <p class="mb-1" style="width: 100%" id="lblInstituteAddress">Vivekanand Marg, 1st Right Turn, 2nd Building 1st Floor, House No. 25, Rainbow Street Opp. A. N. College, Boring Road, Patna</p>
                                    <p class="mb-0" id="lblInstituteMobile">9334127740, 7979747426</p>
                                </div>
                                <div>
                                    <h5 class="mb-6 text-nowrap">Invoice #<span id="lblInvoiceNo"></span></h5>
                                    <div class="mb-1">
                                        <span>Payment Date:</span><br />
                                        <span id="lblDateIssue">April 25, 2021</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <span class="mb-0 app-brand-text fw-semibold" style="text-align: center; margin: 2rem; font-size: 1.6rem; text-decoration: underline;">Reciept Detail</span>
                        <div class="table-responsive rounded mt-5" style="margin-top: 2rem !important;">
                            <table class="table m-0">
                                <tbody>
                                    <tr>
                                        <td colspan="2">Name : <span style="position: relative"><strong id="lblName" style="position: absolute; bottom: 2px; width: 100%; text-align: center">Akshat Gupta</strong><span>_______________________________________________________</span></span>Roll No : <span style="position: relative"><strong id="lblRollNo" style="position: absolute; bottom: 2px; width: 100%; text-align: center">01</strong><span>_________________</span></span></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">Course Name : <span style="position: relative"><strong id="lblCourseName" style="position: absolute; bottom: 2px; width: 100%; text-align: center">JEE Mains</strong><span>_________________________________________________________________________</span></span></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">Batch Name : <span style="position: relative"><strong id="lblBatchName" style="position: absolute; bottom: 2px; width: 100%; text-align: center">Batch 1</strong><span>____________________________</span></span>Batch Timing : <span style="position: relative"><strong id="lblBatchStartTime" style="position: absolute; bottom: 2px; width: 100%; text-align: center">13:30 - 15.30</strong><span>_______________________________</span></span></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">Pay By : <span style="position: relative"><strong style="position: absolute; bottom: 2px; width: 100%; text-align: center"><strong id="lblInstallmentNo" style="margin-right: 5px">1st</strong><strong id="lblPayMode">Installment</strong></strong><span>___________________________________</span></span>Payment Method : <span style="position: relative"><strong id="lblPaymentMethod" style="position: absolute; bottom: 2px; width: 100%; text-align: center">UPI</strong><span>_________________________</span></span></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">The Sum of Rs : <span style="position: relative"><strong id="lblTotalAmountInWord" style="position: absolute; bottom: 2px; width: 100%; text-align: center">Twenty-five thousand three hundred and twenty</strong><span>___________________________________________________________________</span></span> only</td>
                                    </tr>
                                    <tr class="my-3">
                                        <td colspan="2">
                                            <div class="card-body invoice-preview-header rounded p-6 text-heading" style="display: flex; flex-direction: column; justify-content: center; align-items: center;">
                                                <div class="my-3">Next Installment Amount. : <span style="position: relative"><strong id="lblNextInstallmentAmount" style="position: absolute; width: 100%; text-align: center">0125</strong><span>______________________</span></span></div>
                                                <div class="my-3">Next Installment Date : <span style="position: relative"><strong id="lblNextInstallmentDate" style="position: absolute; width: 100%; text-align: center">1-10-2024</strong><span>_________________________</span></span></div>
                                            </div>
                                        </td>

                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="table-responsive">
                            <table class="table m-0 table-borderless">
                                <tbody>
                                    <tr>
                                        <td class="align-top pe-6 ps-0 py-6" style="width: 50%;">
                                            <div style="display: flex; justify-content: center; align-items: center">
                                                <div style="width: 75%; height: 5rem; border: 3px solid #787272; display: flex; justify-content: center; align-items: center; font-size: 2rem;">
                                                    <span style="margin-right: 5px;">₹</span><span id="lblTotalAmount">25320</span>
                                                </div>
                                            </div>

                                        </td>
                                        <td class="px-0 py-6 w-px-100">
                                            <div style="display: flex; justify-content: center; align-items: end;margin-bottom: 2.5rem;">Sign. of Student</div>
                                            <div style="display: flex; justify-content: center; align-items: end">Sign. of Admission In-charge</div>
                                        </td>

                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <hr class="mt-0 mb-6">
                        <div class="card-body p-0">
                            <div class="row">
                                <div class="col-12">
                                    <span class="fw-medium text-heading">Note:</span>
                                    <span>* Money once paid won't be refunded<br>
                    * The Receipt is valid only when it is signed by Admission In-charge. Thank You!</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /Invoice -->

            </div>



        </div>
        <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="../UserLogin_Content/Scripts/Ajax_Crud.js?v=5"></script>
    <script src="../UserLogin_Content/Scripts/Upload_Mult_Image.js"></script>
    <script src="../UserLogin_Content/Scripts/notify.min.js"></script>
    <script src="../UserLogin_Content/Scripts/ValidatingAllInput.js?v=1"></script>
    <script src="../UserLogin_Content/tinymce/js/tinymce/tinymce.min.js"></script>
    <script src="../UserLogin_Content/Scripts/SweetAlert.js?v=5"></script>
        <script>
            let SearchMobile, SearchInvoiceNo, SearchPayMode, DateIssue, InstitutePhoto, InstituteName, CourseName, InstituteAddress, InstituteMobile, InvoiceNo, InvoiceDate, RollNo, BatchName, BatchTime, Name, PayMode, InstallmentNo, PaymentMethod, TotalAmountInWord, NextInstallmentAmount, NextInstallmentDate, TotalAmount;
            
            const defaultRun = async () => {
                try {
                    console.log("helo")
                    var urlParams = new URLSearchParams(window.location.search);
                    var lblMobile = urlParams.get('Mobile');
                    var lblInvoiceNo = urlParams.get('InvoiceNo');
                    var lblPayMode = urlParams.get('PayMode');
                    if (lblMobile)
                        SearchMobile = lblMobile;
                    else
                        SearchMobile = "";
                    if (lblInvoiceNo)
                        SearchInvoiceNo = lblInvoiceNo;
                    else
                        SearchInvoiceNo = "";
                    if (lblPayMode)
                        SearchPayMode = lblPayMode;
                    else
                        SearchPayMode = "";

                    await renderInvoice();

                } catch (err) {
                    console.log(err);
                }
            }
            $(document).ready(function () {
                
                DateIssue = $("#lblDateIssue");
                InstitutePhoto = $("#lblInstitutePhoto");
                InstituteName = $("#lblInstituteName");
                InstituteAddress = $("#lblInstituteAddress");
                InstituteMobile = $("#lblInstituteMobile");
                InvoiceNo = $("#lblInvoiceNo");
                InvoiceDate = $("#lblInvoiceDate");
                RollNo = $("#lblRollNo");
                BatchName = $("#lblBatchName");
                BatchStartTime = $("#lblBatchStartTime");
                Name = $("#lblName");
                PayMode = $("#lblPayMode");
                InstallmentNo = $("#lblInstallmentNo");
                PaymentMethod = $("#lblPaymentMethod");
                TotalAmountInWord = $("#lblTotalAmountInWord");
                NextInstallmentAmount = $("#lblNextInstallmentAmount");
                NextInstallmentDate = $("#lblNextInstallmentDate");
                TotalAmount = $("#lblTotalAmount");
                CourseName = $("#lblCourseName");

                (async function () {
                    
                    await defaultRun().finally(() => {
                        
                        printDiv();
                    });
                })();

            })
            function printDiv() {
                var divContents = document.getElementById("print").innerHTML;
                var a = window.open('', '', 'height=' + screen.height + ', width=' + screen.width);
                a.document.write('<html>');
                a.document.write('<head><title>Print</title>');

                var headContents = document.getElementsByTagName('head')[0].innerHTML;
                a.document.write(headContents);
                a.document.write('<style>@media print { body { margin: 0; } }</style>');
                a.document.write('</head>');
                a.document.write('<body>');
                a.document.write(divContents);
                a.document.write('</body></html>');
                a.document.close();
                a.print();
            }
            async function renderInvoice() {
                try {
                    dataToSend = {
                        InvoiceNo: SearchInvoiceNo,
                        Mobile: SearchMobile
                    }
                    const response1 = await Ajax_GetResult_WithoutParameter("PrintInvoice.aspx", "Get_Institute");
                    const data1 = JSON.parse(response1.d);
                    console.log(data1)
                    if (data1.length > 0) {
                        InstitutePhoto.attr("src", "../UserLogin_Content/upload/" + data1[0].Photo);
                        InstituteName.html(data1[0].InstituteName);
                        InstituteAddress.html(data1[0].Address);
                        InstituteMobile.html(data1[0].Mobile);
                    }
                    dataToSend = {
                        InvoiceNo: SearchInvoiceNo,
                        Mobile: SearchMobile,
                        PayMode: SearchPayMode
                    }
                    console.log(dataToSend)
                    const response = await Ajax_GetResult("PrintInvoice.aspx", "Get_InvoiceDetail", dataToSend);
                    const data = JSON.parse(response.d);
                    console.log(data)
                    if (data.length > 0) {
                        DateIssue.html(data[0].Date);
                        InvoiceNo.html(data[0].InvoiceNo);
                        InvoiceDate.html(data[0].Date);
                        RollNo.html(data[0].RollNo);
                        BatchName.html(data[0].BatchName);
                        BatchStartTime.html(data[0].BatchStartTime + " - " + data[0].BatchEndTime);
                        Name.html(data[0].StudentName);
                        if (SearchPayMode == "Installment")
                            InstallmentNo.html(data[0].Installment_No);
                        else
                            InstallmentNo.html("");
                        PayMode.html(data[0].PaymentMode);
                        PaymentMethod.html(data[0].PaymentMethod);
                        TotalAmountInWord.html(convertToWords(data[0].Paid_Amount));
                        if (SearchPayMode == "Installment")
                            NextInstallmentAmount.html(data[0].Installment_Amount);
                        else
                            NextInstallmentAmount.html("0");
                       
                        CourseName.html(data[0].Course_Name);
                        if (data[0].Installment_Amount === "0.00" || data[0].Installment_Amount === "0")
                            NextInstallmentDate.html("No Due");
                        else {
                            NextInstallmentDate.html(data[0].Dues_Date);
                        }
                        TotalAmount.html(data[0].Paid_Amount);
                    }
                } catch (err) {
                    console.log(err);
                }
            }
            function convertToWords(TotalAmount) {
                var amountInput = TotalAmount;
                var amount = parseFloat(amountInput);

                if (isNaN(amount)) {
                    return "Please enter a valid numeric amount.";
                } else {
                    var words = convertNumberToWords(amount);
                    return words;
                }
            }
            function formatDate(inputDate) {
                // Split the input date by "-"
                var dateParts = inputDate.split("-");

                // Create a Date object
                var year = dateParts[0];
                var month = dateParts[1] - 1; // Months are 0-indexed in JavaScript
                var day = dateParts[2];
                var dateObj = new Date(year, month, day);

                // Create an array of month names
                var monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

                // Format the date into dd MMM yyyy
                var formattedDate = ("0" + dateObj.getDate()).slice(-2) + " " + monthNames[dateObj.getMonth()] + " " + dateObj.getFullYear();

                return formattedDate;
            }
            function convertNumberToWords(number) {
                const units = ['Zero', 'One', 'Two', 'Three', 'Four', 'Five', 'Six', 'Seven', 'Eight', 'Nine'];
                const teens = ['Ten', 'Eleven', 'Twelve', 'Thirteen', 'Fourteen', 'Fifteen', 'Sixteen', 'Seventeen', 'Eighteen', 'Nineteen'];
                const tens = ['Zero', 'Ten', 'Twenty', 'Thirty', 'Forty', 'Fifty', 'Sixty', 'Seventy', 'Eighty', 'Ninety'];

                function convertGroup(num) {
                    if (num === 0) return '';
                    else if (num < 10) return units[num];
                    else if (num < 20) return teens[num - 10]; // Corrected from num - 11 to num - 10
                    else if (num < 100) return tens[Math.floor(num / 10)] + (num % 10 !== 0 ? ' ' + units[num % 10] : '');
                    else return units[Math.floor(num / 100)] + ' Hundred ' + (num % 100 !== 0 ? convertGroup(num % 100) : '');
                }

                function convertAmount(amount) {
                    if (amount === 0) {
                        return 'Zero';
                    } else {
                        var words = '';

                        // Convert lakh part
                        var lakhPart = Math.floor(amount / 100000);
                        if (lakhPart > 0) {
                            words += convertGroup(lakhPart) + ' Lakh ';
                        }

                        // Convert thousand part
                        var thousandPart = Math.floor((amount % 100000) / 1000);
                        if (thousandPart > 0) {
                            words += convertGroup(thousandPart) + ' Thousand ';
                        }

                        // Convert remaining part
                        var remainingPart = amount % 1000;
                        if (remainingPart > 0) {
                            if (lakhPart > 0 || thousandPart > 0) {
                                words += 'and ';
                            }
                            words += convertGroup(remainingPart);
                        }

                        return words.trim();
                    }
                }

                return convertAmount(number);
            }
            async function Show_Spinner() {
                return new Promise((resolve) => {
                    $("#spinner-div").fadeIn(300, () => {
                        resolve();
                    });
                });
            }
            async function Hide_Spinner() {
                return new Promise((resolve) => {
                    $("#spinner-div").fadeOut(300, () => {
                        resolve();
                    });
                });
            }
            
        </script>
        <!-- / Content -->
        <!-- Core JS -->
        <!-- build:js ../UserLogin_Content/assets/vendor/js/core.js -->
        <script src="../UserLogin_Content/assets/vendor/libs/jquery/jquery.js"></script>
        <script src="../UserLogin_Content/assets/vendor/libs/popper/popper.js"></script>
        <script src="../UserLogin_Content/assets/vendor/js/bootstrap.js"></script>
        <script src="../UserLogin_Content/assets/vendor/libs/node-waves/node-waves.js"></script>
        <script src="../UserLogin_Content/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
        <script src="../UserLogin_Content/assets/vendor/libs/hammer/hammer.js"></script>
        <script src="../UserLogin_Content/assets/vendor/libs/i18n/i18n.js"></script>
        <script src="../UserLogin_Content/assets/vendor/libs/typeahead-js/typeahead.js"></script>
        <script src="../UserLogin_Content/assets/vendor/js/menu.js"></script>

        <!-- endbuild -->

        <!-- Vendors JS -->
        <script src="../UserLogin_Content/assets/vendor/libs/bs-stepper/bs-stepper.js"></script>
        <script src="../UserLogin_Content/assets/vendor/libs/bootstrap-select/bootstrap-select.js"></script>
        <script src="../UserLogin_Content/assets/vendor/libs/@form-validation/popular.js"></script>
        <script src="../UserLogin_Content/assets/vendor/libs/@form-validation/bootstrap5.js"></script>
        <script src="../UserLogin_Content/assets/vendor/libs/@form-validation/auto-focus.js"></script>
        <script src="../UserLogin_Content/assets/vendor/libs/dropzone/dropzone.js"></script>
        <script src="../UserLogin_Content/assets/vendor/libs/autosize/autosize.js"></script>
        <script src="../UserLogin_Content/assets/vendor/libs/cleavejs/cleave.js"></script>
        <script src="../UserLogin_Content/assets/vendor/libs/cleavejs/cleave-phone.js"></script>
        <script src="../UserLogin_Content/assets/vendor/libs/bootstrap-maxlength/bootstrap-maxlength.js"></script>
        <script src="../UserLogin_Content/assets/vendor/libs/jquery-repeater/jquery-repeater.js"></script>
        <script src="../UserLogin_Content/assets/vendor/libs/flatpickr/flatpickr.js"></script>
        <script src="../UserLogin_Content/assets/vendor/libs/sweetalert2/sweetalert2.js?v=2"></script>
        <script src="../UserLogin_Content/assets/vendor/libs/select2/select2.js"></script>

        <!-- Main JS -->
        <script src="../UserLogin_Content/assets/js/main.js"></script>

        <!-- Page JS -->
        <script src="../UserLogin_Content/assets/js/pages-auth.js"></script>

        <!-- Page JS -->
        <script src="../UserLogin_Content/assets/js/forms-selects.js"></script>
        <script src="../UserLogin_Content/assets/js/forms-tagify.js"></script>
        <script src="../UserLogin_Content/assets/js/forms-typeahead.js"></script>

        <!-- Page JS -->
        <script src="../UserLogin_Content/assets/js/modal-edit-user.js"></script>
        <script src="../UserLogin_Content/assets/js/forms-file-upload.js"></script>
        <script src="../UserLogin_Content/assets/js/forms-extras.js"></script>
        <script src="../UserLogin_Content/assets/js/tables-datatables-basic.js"></script>



        
        
    </form>
</body>
</html>
