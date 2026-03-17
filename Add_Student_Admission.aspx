<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true" CodeFile="Add_Student_Admission.aspx.cs" Inherits="Admin_Add_Student_Admission" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Add Student Admission | Institute Management Software</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/dropzone/5.9.2/dropzone.min.css">

    <style>
        .dropzone .dz-preview .dz-image img {
            width: max-content;
        }

        .dropzone .dz-preview .dz-image {
            display: flex;
            justify-content: center;
            width: 100%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row g-6 mb-6">
        <div class="col-md">
            <div class="card">
                <div class="card-header row" style="justify-content: space-between;">
                    <div class="col-md-8">
                        <h5><span class="text-muted fw-light">Students Section /</span><a href="Student_Admission.aspx"> <span class=" fw-light">Student Admission /</span></a> Take New Admission</h5>
                    </div>
                    <div id="top-right-date" class="col-md-4" style="display: flex; justify-content: end;">
                        <div class="">
                            <a href="Student_Admission.aspx" class="btn btn-primary waves-effect waves-light" style="margin-right: 10px"><i class="menu-icon ri-arrow-left-line"></i>Back</a>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <!-- Sticky Actions -->
                    <div class="row">
                        <div class="col-12">
                            <div class="row g-5 mb-5">
                                <div class="card col-lg-8 mx-auto">
                                    <div class="card-body">
                                        <h3 class="text-center" style="letter-spacing: 1px; text-transform: uppercase; font-weight: 600; font-size: 22px;">Student Admission</h3>
                                    </div>
                                    <div class="card-body row g-6">
                                        <div class="col-4">
                                            <label for="txtNewStudent" style="cursor: pointer"><i class="menu-icon tf-icons ri-user-add-line"></i>New</label>
                                            <input type="radio" id="txtNewStudent"
                                                name="Customer" class="form-check-input" checked>
                                        </div>
                                        <div class="col-4">
                                            <label for="txtCallEnquiryStudent" style="cursor: pointer"><i class="menu-icon tf-icons ri-phone-line"></i>Call Enquiry</label>
                                            <input type="radio" id="txtCallEnquiryStudent"
                                                name="Customer" class="form-check-input">
                                        </div>
                                        <div class="col-4">
                                            <label for="txtVisitorEnquiryStudent" style="cursor: pointer"><i class="menu-icon tf-icons ri-government-line"></i>Visitor Enquiry</label>
                                            <input type="radio" id="txtVisitorEnquiryStudent"
                                                name="Customer" class="form-check-input">
                                        </div>
                                        <div class="col-12 col-md-12 hide" id="SearchStudentDiv" style="margin-top: 2.25rem !important; margin-bottom: 0.25rem !important;">
                                            <div class="form-floating form-floating-outline validation">
                                                <div class="select2-primary">
                                                    <select id="txtSearchStudent" name="txtSearchStudent" class="select2 form-select">
                                                    </select>
                                                </div>
                                                <label for="txtSearchStudent">Search Student</label>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="card col-lg-8 mx-auto" id="formAuthentication">
                                    <!-- 1. Delivery Address -->
                                    <h5 class="my-4">1. Student Detail</h5>
                                    <div class="row g-6">
                                        <div class="col-12 col-md-4">
                                            <div class="form-floating form-floating-outline validation">
                                                <input type="text" id="txtStudentId" name="txtStudentId" class="form-control" placeholder="Enter student id" readonly />
                                                <label for="txtStudentId">Student Id</label>
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-4">
                                            <div class="form-floating form-floating-outline validation">
                                                <input type="text" id="txtAdmissionNo" name="txtAdmissionNo" class="form-control" placeholder="Enter Admission No" readonly />
                                                <label for="txtAdmissionNo">Admission No</label>
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-4">
                                            <div class="form-floating form-floating-outline validation">
                                                <input type="text" id="txtRollNo" name="txtRollNo" class="form-control" placeholder="Enter roll no" readonly />
                                                <label for="txtRollNo">Roll No</label>
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-6">
                                            <div class="form-floating form-floating-outline validation">
                                                <input type="text" id="txtStudentName" name="txtStudentName" class="form-control" placeholder="Enter student name" />
                                                <label for="txtStudentName">Student Name *</label>
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-6">
                                            <div class="form-floating form-floating-outline validation">
                                                <input type="text" id="txtMobile" name="txtMobile" class="form-control" placeholder="Enter mobile" />
                                                <label for="txtMobile">Mobile *</label>
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-6">
                                            <div class="form-floating form-floating-outline validation">
                                                <select name="txtGender" id="txtGender" class="select2 form-select" data-allow-clear="true">
                                                    <option value="">Select Gender</option>
                                                    <option value="Male">Male</option>
                                                    <option value="Female">Female</option>
                                                    <option value="Other">Other</option>
                                                </select>
                                                <label for="txtCity">Gender *</label>
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-6">
                                            <div class="form-floating form-floating-outline validation">
                                                <input type="text" id="txtEmail" name="txtEmail" class="form-control" placeholder="Enter email" />
                                                <label for="txtEmail">Email *</label>
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-6">
                                            <div class="form-floating form-floating-outline validation">
                                                <input type="date" id="txtDOB" name="txtDOB" class="form-control" />
                                                <label for="txtDOB">DOB *</label>
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-6">
                                            <div class="form-floating form-floating-outline validation">
                                                <input type="text" id="txtFatherName" name="txtFatherName" class="form-control" placeholder="Enter father name" />
                                                <label for="txtFatherName">Father Name *</label>
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-6">
                                            <div class="form-floating form-floating-outline validation">
                                                <input type="text" id="txtFatherOccupation" name="txtFatherOccupation" class="form-control" placeholder="Enter father Occupation" />
                                                <label for="txtFatherOccupation">Father Occupation *</label>
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-6">
                                            <div class="form-floating form-floating-outline validation">
                                                <input type="text" id="txtFatherContactNo" name="txtFatherContactNo" class="form-control" placeholder="Enter father contact no" />
                                                <label for="txtFatherContactNo">Father Contact No *</label>
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-6">
                                            <div class="form-floating form-floating-outline validation">
                                                <input type="text" id="txtMotherName" name="txtMotherName" class="form-control" placeholder="Enter mother name" />
                                                <label for="txtMotherName">Mother Name *</label>
                                            </div>
                                        </div>

                                        <div class="col-12 col-md-6">
                                            <div class="form-floating form-floating-outline validation">
                                                <select name="txtState" id="txtState" class="select2 form-select" data-allow-clear="true">
                                                    <option value="">Select State</option>
                                                </select>
                                                <label for="txtCity">State *</label>
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-6">
                                            <div class="form-floating form-floating-outline validation">
                                                <select name="txtCity" id="txtCity" class="select2 form-select" data-allow-clear="true">
                                                    <option value="">Select City</option>
                                                </select>
                                                <label for="txtCity">City *</label>
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-6">
                                            <div class="form-floating form-floating-outline validation">
                                                <input type="text" id="txtPincode" name="txtPincode" class="form-control" placeholder="Enter pincode" />
                                                <label for="txtPincode">Pincode *</label>
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-12">
                                            <div class="form-floating form-floating-outline validation">
                                                <textarea type="text" id="txtAddress" name="txtAddress" class="form-control" placeholder="Enter address" style="height: 8rem"></textarea>
                                                <label for="txtAddress">Address *</label>
                                            </div>
                                        </div>


                                    </div>
                                    <hr>
                                    <!-- 2. Delivery Type -->
                                    <h5 class="my-6">2. Course Detail</h5>
                                    <div class="row gy-3">
                                        <div class="col-12 col-md-12">
                                            <div class="form-floating form-floating-outline validation">
                                                <div class="select2-primary">
                                                    <select id="txtCourseId" name="txtCourseId" class="select2 form-select">
                                                    </select>
                                                </div>
                                                <label for="txtCourseId">Course *</label>
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-12 " id="tblCourseDiv">
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
                                    </div>
                                    <hr>
                                    <!-- 3. Apply Promo code -->
                                    <h5 class="my-4">3. Fee & Payment</h5>
                                    <div class="row g-4">
                                        <div class="col-12 col-md-6 ">
                                            <div class="form-floating form-floating-outline validation">
                                                <input class="form-control" type="text" name="txtTotalAmount" id="txtTotalAmount" placeholder="eg.499" readonly />
                                                <label for="txtTotalAmount">Total Amount *</label>
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-6">
                                            <div class="form-floating form-floating-outline validation">
                                                <input type="text" name="txtConcession" id="txtConcession" class="form-control" placeholder="eg.10">
                                                <label for="txtConcession">Concession(%) *</label>
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-6">
                                            <div class="form-floating form-floating-outline validation">
                                                <input type="text" name="txtNetAmount" id="txtNetAmount" class="form-control" placeholder="eg.499" readonly>
                                                <label for="txtNetAmount">Net Amount *</label>
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-6">
                                            <div class="form-floating form-floating-outline validation">
                                                <select name="txtPaymentMode" id="txtPaymentMode" class="select2 form-select" data-allow-clear="true">
                                                    <option value="" selected>Select Mode</option>
                                                    <option value="Full">Pay by Full</option>
                                                    <option value="Installment">Pay by Installment</option>
                                                </select>
                                                <label for="txtPaymentMode">Payment Mode *</label>
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-12 hide" id="InstallmentPlanDiv">
                                            <div class="form-floating form-floating-outline validation">
                                                <select name="txtInstallmentPlan" id="txtInstallmentPlan" class="select2 form-select" data-allow-clear="true">
                                                    <option value="" selected>Select Plan</option>
                                                    <option value="2">2</option>
                                                    <option value="3">3</option>
                                                    <option value="4">4</option>
                                                    <option value="5">5</option>
                                                    <option value="6">6</option>
                                                    <option value="7">7</option>
                                                    <option value="8">8</option>
                                                    <option value="9">9</option>
                                                    <option value="10">10</option>
                                                    <option value="11">11</option>
                                                    <option value="12">12</option>
                                                </select>
                                                <label for="txtInstallmentPlan">Installment Plan *</label>
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-12 hide" id="tblPaymentInstallmentDiv">
                                            <div class="table-responsive text-nowrap text-center">
                                                <table class="table nowrap">
                                                    <caption class="ms-4">
                                                        List of Installments
   
                                                    </caption>
                                                    <thead>
                                                        <tr>
                                                            <th>#</th>
                                                            <th>Installment</th>
                                                            <th>Total Amount</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="tblPaymentInstallment">
                                                        <tr>
                                                            <td>
                                                                <input type="radio" name="PaymentMode" id="txtTwoInstallment" class="form-check-input" data-installmentamount="22275" data-installmentno="2">
                                                            </td>
                                                            <td>
                                                                <label for="txtTwoInstallment" style="cursor: pointer;">22275 x 2</label>
                                                            </td>
                                                            <td>
                                                                <label for="txtTwoInstallment" style="cursor: pointer;">44550</label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <input type="radio" name="PaymentMode" id="txtThreeInstallment" class="form-check-input" data-installmentamount="14850" data-installmentno="3">
                                                            </td>
                                                            <td>
                                                                <label for="txtThreeInstallment" style="cursor: pointer;">14850 x 3</label>
                                                            </td>
                                                            <td>
                                                                <label for="txtThreeInstallment" style="cursor: pointer;">44550</label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <input type="radio" name="PaymentMode" id="txtFourInstallment" class="form-check-input" data-installmentamount="11137.50" data-installmentno="4">
                                                            </td>
                                                            <td>
                                                                <label for="txtFourInstallment" style="cursor: pointer;">11137.50 x 4</label>
                                                            </td>
                                                            <td>
                                                                <label for="txtFourInstallment" style="cursor: pointer;">44550</label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <input type="radio" name="PaymentMode" id="txtFiveInstallment" class="form-check-input" data-installmentamount="8910" data-installmentno="5">
                                                            </td>
                                                            <td>
                                                                <label for="txtFiveInstallment" style="cursor: pointer;">8910 x 5</label>
                                                            </td>
                                                            <td>
                                                                <label for="txtFiveInstallment" style="cursor: pointer;">44550</label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <input type="radio" name="PaymentMode" id="txtSixInstallment" class="form-check-input" data-installmentamount="7425" data-installmentno="6">
                                                            </td>
                                                            <td>
                                                                <label for="txtSixInstallment" style="cursor: pointer;">7425 x 6</label>
                                                            </td>
                                                            <td>
                                                                <label for="txtSixInstallment" style="cursor: pointer;">44550</label>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>

                                            </div>
                                        </div>
                                        <div class="col-12 col-md-6">
                                            <div class="form-floating form-floating-outline validation">
                                                <input type="text" name="txtPaidAmount" id="txtPaidAmount" class="form-control" placeholder="eg.499">
                                                <label for="txtPaidAmount">Paid Amount <span id="paymodeText"></span>*</label>
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-6 hide" id="nextDueDateDiv">
                                            <div class="form-floating form-floating-outline validation">
                                                <input type="date" name="txtNextDueDate" id="txtNextDueDate" class="form-control" placeholder="eg.499">
                                                <label for="txtNextDueDate">Next Due Date *</label>
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-6">
                                            <div class="form-floating form-floating-outline validation">
                                                <select name="txtPaymentMethod" id="txtPaymentMethod" class="select2 form-select" data-allow-clear="true">
                                                    <option value="">Select Mode</option>
                                                    <option value="Cash">Cash</option>
                                                    <option value="UPI">UPI</option>
                                                    <option value="Bank transfers">Bank transfers</option>
                                                    <option value="Nifty">Nifty</option>
                                                    <option value="Cheque">Cheque</option>
                                                </select>
                                                <label for="txtPaymentMethod">Payment Method *</label>
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-12 hide" id="tblMyPaymentInstallmentDiv">
                                            <div class="table-responsive text-nowrap text-center">
                                                <table class="table nowrap">
                                                    <caption class="ms-4">
                                                        List of My Installments
   
                                                    </caption>
                                                    <thead>
                                                        <tr>
                                                            <th>#</th>
                                                            <th>Installment Dues</th>
                                                            <th>Total Dues</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="tblMyInstallment">
                                                        <tr>
                                                            <td>
                                                                <span>1</span>
                                                            </td>
                                                            <td>
                                                                <label for="txtMyInstallment" style="cursor: pointer;"><span id="MyInstallmentAmount"></span>x <span id="MyInstallmentNo"></span></label>
                                                            </td>
                                                            <td>
                                                                <label for="txtMyInstallment" style="cursor: pointer;"><span id="MyTotalDuesAmount"></span></label>
                                                            </td>
                                                        </tr>

                                                    </tbody>
                                                </table>

                                            </div>
                                        </div>

                                    </div>
                                    <hr>
                                    <!-- 4. Apply Promo code -->
                                    <h5 class="my-4">4. Student Batch & Photo</h5>
                                    <div class="row g-4">
                                        <div class="col-12 col-md-6 ">
                                            <div class="form-floating form-floating-outline validation">
                                                <div class="select2-primary">
                                                    <select id="txtSession" name="txtSession" class="select2 form-select">
                                                    </select>
                                                </div>
                                                <label for="txtSession">Session *</label>
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-6 ">
                                            <div class="form-floating form-floating-outline validation">
                                                <div class="select2-primary">
                                                    <select id="txtBatchName" name="txtBatchName" class="select2 form-select">
                                                    </select>
                                                </div>
                                                <label for="txtBatchName">Batch Name *</label>
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-12 " id="tblBatchDiv">
                                            <div class="table-responsive text-nowrap">
                                                <table class="table nowrap">
                                                    <caption class="ms-4">
                                                        List of Batch
                                                    </caption>
                                                    <thead>
                                                        <tr>
                                                            <th>Batch Id</th>
                                                            <th>Course Name</th>
                                                            <th>Batch Name</th>
                                                            <th>Batch Duration</th>
                                                            <th>Start Date</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="tblBatch">
                                                        <tr>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                        </tr>
                                                    </tbody>
                                                </table>

                                            </div>
                                        </div>
                                        <div class="col-12 col-md-12">
                                            <label for="largeInput" style="width: 100%; color: #aba8b1; padding: 1rem;">
                                                Upload Student Photo *</label>
                                            <div action="upload" class="dropzone needsclick" id="dropzone-basic">
                                                <div class="dz-message needsclick">
                                                    <i class="menu-icon ri-upload-cloud-2-fill"></i>Drop files here or click to select
                               
                                                </div>
                                                <div class="fallback">
                                                    <input name="file" type="file" />
                                                </div>
                                            </div>
                                            <progress id="compression-progress" value="0" max="100" style="display: none;"></progress>

                                        </div>
                                        <div class="col-12 col-md-12">
    <label style="width: 100%; color: #aba8b1; padding: 1rem;">
        Upload Aadhaar Document *
    </label>
    <div action="upload" class="dropzone needsclick" id="dropzone-aadhaar">
        <div class="dz-message needsclick">
            <i class="menu-icon ri-upload-cloud-2-fill"></i>
            Drop Aadhaar here or click to upload
        </div>
        <div class="fallback">
            <input name="aadhaarFile" type="file" />
        </div>
    </div>
                                             <progress id="compression-progressAddhar" value="0" max="100" style="display: none;"></progress>
</div>
                                    </div>
                                    <hr>
                                    <div class="row g-6">
                                        <div class="col-12 text-center">
                                            <button id="BtnTakeAdmission" type="button" class="btn btn-primary me-3 waves-effect waves-light">Take Admission</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- /Sticky Actions -->
                </div>
            </div>
        </div>

    </div>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/dropzone/5.9.2/dropzone.min.js"></script>

    <script>
        // Function to compress images
        const compressAndResizeImage = async (file, { quality = 1, type = file.type }) => {
            const imageBitmap = await createImageBitmap(file);

            // Create a canvas to draw the image
            const canvas = document.createElement('canvas');
            const ctx = canvas.getContext('2d');

            // Resize logic (e.g., reduce dimensions to 75%)
            const scaleFactor = 0.75; // Adjust this factor as needed
            canvas.width = imageBitmap.width * scaleFactor;
            canvas.height = imageBitmap.height * scaleFactor;
            ctx.drawImage(imageBitmap, 0, 0, canvas.width, canvas.height);

            return new Promise((resolve, reject) => {
                canvas.toBlob((blob) => {
                    if (blob) {
                        const compressedFile = new File([blob], file.name, {
                            type: file.type,
                            lastModified: Date.now()
                        });
                        resolve(compressedFile);
                    } else {
                        reject(new Error("Blob creation failed"));
                    }
                }, type, quality);
            });
        };

        // Dropzone setup
        Dropzone.autoDiscover = false;
        var myDropzone;
        var aadhaarDropzone;

        aadhaarDropzone = new Dropzone("#dropzone-aadhaar", {
            url: 'FileUploadHandler.ashx',
            autoProcessQueue: false,
            maxFiles: 1,
            paramName: "aadhaarFile",
            maxFilesize: 500,
            acceptedFiles: ".pdf,.jpg,.jpeg,.png",
            init: function () {

                aadhaarDropzone = this;


                this.on("maxfilesexceeded", function (file) {
                    this.removeAllFiles();
                    this.addFile(file);
                });

                this.on("addedfile", async function (file) {

                    if (file.type === "application/pdf") {
                        console.log("PDF detected - skipping image compression");
                        return; // skip compression for PDF
                    }

                    
                

                    // Prevent multiple processing
                    if (file.processing) return;
                    file.processing = true; // Mark as processing
                    const progressBar = document.getElementById('compression-progressAddhar');
                    progressBar.style.display = 'block';
                    try {
                        let compressedFile = file;
                        let quality = 0.9;
                        let attempts = 0;
                        const maxAttempts = 10; // Prevent infinite loops

                        while (compressedFile.size > 50 * 1024 && attempts < maxAttempts) {

                            progressBar.value = (attempts / maxAttempts) * 100;

                            compressedFile = await compressAndResizeImage(compressedFile, {
                                quality: quality,
                                type: file.type
                            });

                            console.log(`Attempt ${attempts + 1}: Compressed file size: ${compressedFile.size} bytes`);

                            if (compressedFile.size <= 50 * 1024) {
                                console.log('Successfully compressed:', compressedFile.name);
                                break; // Exit loop if size is acceptable
                            }

                            quality -= 0.1;
                            attempts++; // Increment attempts

                            if (quality < 0.1) {
                                console.log("Reached minimum quality threshold.");
                                break; // Exit if quality goes too low
                            }
                        }

                        // Final check
                        progressBar.value = 100;
                        if (compressedFile.size > 50 * 1024) {
                            console.log(`Failed to compress ${file.name} under 50 KB after ${attempts} attempts.`);
                            this.removeAllFiles(); // Remove the original file
                            this.addFile(compressedFile); // Add the compressed file only once
                        } else {
                            this.removeAllFiles(); // Remove the original file
                            this.addFile(compressedFile); // Add the compressed file only once
                        }
                    } catch (err) {
                        console.error("Compression error: ", err);
                    }
                    finally {
                        progressBar.style.display = 'none'; // Hide progress bar after processing
                        progressBar.value = 0; // Reset progress bar
                    }
                });

                this.on("success", function (file, response) {
                    console.log("File uploaded successfully");
                });

                this.on("error", function (file, response) {
                    console.log("Error uploading file");
                });
            }
        });
        myDropzone = new Dropzone("#dropzone-basic", {
            url: 'FileUploadHandler.ashx',
            autoProcessQueue: false,
            maxFiles: 1,
            paramName: "file",
            maxFilesize: 500,
            acceptedFiles: "image/*",
            init: function () {

                myDropzone = this;
            

                this.on("maxfilesexceeded", function (file) {
                    this.removeAllFiles();
                    this.addFile(file);
                });

                this.on("addedfile", async function (file) {
                    console.log("Added file: ", file.name);

                    // Prevent multiple processing
                    if (file.processing) return;
                    file.processing = true; // Mark as processing
                    const progressBar = document.getElementById('compression-progress');
                    progressBar.style.display = 'block';
                    try {
                        let compressedFile = file;
                        let quality = 0.9;
                        let attempts = 0;
                        const maxAttempts = 10; // Prevent infinite loops

                        while (compressedFile.size > 50 * 1024 && attempts < maxAttempts) {

                            progressBar.value = (attempts / maxAttempts) * 100;

                            compressedFile = await compressAndResizeImage(compressedFile, {
                                quality: quality,
                                type: file.type
                            });

                            console.log(`Attempt ${attempts + 1}: Compressed file size: ${compressedFile.size} bytes`);

                            if (compressedFile.size <= 50 * 1024) {
                                console.log('Successfully compressed:', compressedFile.name);
                                break; // Exit loop if size is acceptable
                            }

                            quality -= 0.1;
                            attempts++; // Increment attempts

                            if (quality < 0.1) {
                                console.log("Reached minimum quality threshold.");
                                break; // Exit if quality goes too low
                            }
                        }

                        // Final check
                        progressBar.value = 100;
                        if (compressedFile.size > 50 * 1024) {
                            console.log(`Failed to compress ${file.name} under 50 KB after ${attempts} attempts.`);
                            this.removeAllFiles(); // Remove the original file
                            this.addFile(compressedFile); // Add the compressed file only once
                        } else {
                            this.removeAllFiles(); // Remove the original file
                            this.addFile(compressedFile); // Add the compressed file only once
                        }
                    } catch (err) {
                        console.error("Compression error: ", err);
                    }
                    finally {
                        progressBar.style.display = 'none'; // Hide progress bar after processing
                        progressBar.value = 0; // Reset progress bar
                    }
                });

                this.on("success", function (file, response) {
                    console.log("File uploaded successfully");
                });

                this.on("error", function (file, response) {
                    console.log("Error uploading file");
                });
            }
        });
    </script>
    

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <script type="text/javascript">

        let NewStudent, CallEnquiryStudent, VisitorEnquiryStudent, SearchStudentDiv, CheckedValue = "New";
        let PaymentInstallmentDiv, PaymentInstallment, MyPaymentInstallmentDiv, MyPaymentInstallment, tblpaymentModes, InstallmentAmount, InstallmentNo, MyInstallmentAmount, MyInstallmentNo, MyTotalDuesAmount, nextDueDateDiv, InstallmentPlan;
        let StudentId, AdmissionNo, RollNo, StudentName, Mobile, Gender, Email, DOB, FatherName, FatherOccupation, FatherContactNo, MotherName, State, City, Pincode, Address, CourseId, TotalAmount, Concession, NetAmount, PaymentMode, PaidAmount, NextDueDate, TotalDues, PaymentMethod, Session, BatchName, BatchId;
        var BtnAdd, dataToSend;

        let formAuthentication = document.querySelector("#formAuthentication");
        let formValidationInstance;

        let config = {
            cUrl: 'https://api.countrystatecity.in/v1/countries',
            ckey: 'NHhvOEcyWk50N2Vna3VFTE00bFp3MjFKR0ZEOUhkZlg4RTk1MlJlaA=='
        };

        const defaultRun = async () => {
            try {
                await renderStudentId();
                await renderAdmissionNo();
                await renderRollNo();
                await renderStates();
                await renderCourse();
                await renderSession();
                restrictBeforeDate();
                restrictAfterDate();
            } catch (err) {
                console.log(err);
            }
        }

        $(document).ready(function () {

            NewStudent = $("#txtNewStudent");
            CallEnquiryStudent = $("#txtCallEnquiryStudent");
            VisitorEnquiryStudent = $("#txtVisitorEnquiryStudent");
            SearchStudentDiv = $("#SearchStudentDiv");
            PaymentInstallmentDiv = $("#tblPaymentInstallmentDiv");
            PaymentInstallment = $("#tblPaymentInstallment");

            MyPaymentInstallment = $("#tblMyPaymentInstallment");
            MyPaymentInstallmentDiv = $("#tblMyPaymentInstallmentDiv");
            MyInstallmentAmount = $("#MyInstallmentAmount");
            MyInstallmentNo = $("#MyInstallmentNo");
            MyTotalDuesAmount = $("#MyTotalDuesAmount");
            nextDueDateDiv = $("#nextDueDateDiv");
            InstallmentPlan = $("#txtInstallmentPlan");

            SearchStudent = $("#txtSearchStudent");

            StudentId = $("#txtStudentId");
            AdmissionNo = $("#txtAdmissionNo");
            RollNo = $("#txtRollNo");
            StudentName = $("#txtStudentName");
            Mobile = $("#txtMobile");
            Gender = $("#txtGender");
            Email = $("#txtEmail");
            DOB = $("#txtDOB");
            FatherName = $("#txtFatherName");
            FatherOccupation = $("#txtFatherOccupation");
            FatherContactNo = $("#txtFatherContactNo");
            MotherName = $("#txtMotherName");
            State = $("#txtState");
            City = $("#txtCity");
            Pincode = $("#txtPincode");
            Address = $("#txtAddress");
            CourseId = $("#txtCourseId");
            TotalAmount = $("#txtTotalAmount");
            Concession = $("#txtConcession");
            NetAmount = $("#txtNetAmount");
            PaymentMode = $("#txtPaymentMode");
            PaidAmount = $("#txtPaidAmount");
            NextDueDate = $("#txtNextDueDate");
            PaymentMethod = $("#txtPaymentMethod");
            Session = $("#txtSession");
            BatchName = $("#txtBatchName");

            (async function () {
                await Show_Spinner();
                await defaultRun().finally(async () => {
                    await Hide_Spinner();
                });
            })();


            $(document).on("click", "#txtNewStudent", OnClick_NewStudent);
            $(document).on("click", "#txtCallEnquiryStudent", OnClick_CallEnquiryStudent);
            $(document).on("click", "#txtVisitorEnquiryStudent", OnClick_VisitorEnquiryStudent);
            $(document).on("click", "#BtnTakeAdmission", OnClick_TakeAdmission);

            SearchStudent.change(OnChange_SearchStudent);
            State.change(renderCities);
            CourseId.change(OnChange_CourseId);
            BatchName.change(OnChange_BatchName);
            Mobile.change(OnChange_Mobile);
            Concession.keyup(OnChange_Concession);
            PaymentMode.change(OnChange_PaymentMode);
            InstallmentPlan.change(OnChange_InstallmentPlan);
            Session.change(OnChange_Session);
            PaidAmount.keyup(OnChange_PaidAmount);

            OnKeyPressValidation(StudentName, validateAlphabeticOrSpace);
            OnKeyPressValidation(FatherName, validateAlphabeticOrSpace);
            OnKeyPressValidation(FatherOccupation, validateAlphabeticOrSpace);
            OnKeyPressValidation(MotherName, validateAlphabeticOrSpace);
            OnKeyPressValidation(Mobile, validateMobileNumber);
            OnKeyPressValidation(FatherContactNo, validateMobileNumber);
            OnKeyPressValidation(Pincode, validatePincode);
            OnKeyPressValidation(Concession, validateOnlyNumber);
            OnKeyPressValidation(PaidAmount, validatePrice);



        })
        async function OnClick_NewStudent() {
            try {
                await Show_Spinner();
                if ($(this).is(":checked")) {
                    CheckedValue = "New";
                    SearchStudentDiv.addClass("hide");
                    formValidationInstance.resetForm(true);
                    $("#tblCourseDiv").addClass("hide");
                    await defaultRun();

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
        async function OnClick_CallEnquiryStudent() {
            try {
                await Show_Spinner();
                if ($(this).is(":checked")) {
                    CheckedValue = "CallEnquiry";
                    SearchStudentDiv.removeClass("hide");
                    await renderSearchCallEnquiryStudent();
                    formValidationInstance.resetForm(true);
                    $("#tblCourseDiv").addClass("hide");
                    await defaultRun();
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
        async function OnClick_VisitorEnquiryStudent() {
            try {
                await Show_Spinner();
                if ($(this).is(":checked")) {
                    CheckedValue = "VisitorEnquiry";
                    SearchStudentDiv.removeClass("hide");
                    await renderSearchVisitorEnquiryStudent();
                    formValidationInstance.resetForm(true);
                    $("#tblCourseDiv").addClass("hide");
                    await defaultRun();
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
        async function renderSearchCallEnquiryStudent() {
            try {
                const response = await Ajax_GetResult_WithoutParameter("Add_Student_Admission.aspx", "Get_SearchCallEnquiryStudent");
                const data = JSON.parse(response.d);
                console.log(data);
                SearchStudent.empty();
                if (data.length > 0) {
                    SearchStudent.html('<option value="" Selected>Select Student</option>');
                    $.each(data, function (index, item) {
                        SearchStudent.append($('<option>', {
                            value: item.Mobile,
                            text: item.Name + " ( " + item.Mobile + " )"
                        }));
                    });
                }
                else {
                    Warning("No Call Enquiry Found !");
                }

            } catch (err) {
                console.log(err);
            }
        }
        async function renderSearchVisitorEnquiryStudent() {
            try {
                const response = await Ajax_GetResult_WithoutParameter("Add_Student_Admission.aspx", "Get_SearchVisitorEnquiryStudent");
                const data = JSON.parse(response.d);
                console.log(data)
                SearchStudent.empty();
                if (data.length > 0) {
                    SearchStudent.html('<option value="" Selected>Select Student</option>');
                    $.each(data, function (index, item) {
                        SearchStudent.append($('<option>', {
                            value: item.Mobile,
                            text: item.Name + " ( " + item.Mobile + " )"
                        }));
                    });
                } else {
                    Warning("No Visitor Enquiry Found !");
                }


            } catch (err) {
                console.log(err);
            }
        }
        async function OnChange_SearchStudent() {
            try {
                await Show_Spinner();
                dataToSend = {
                    CheckedValue: CheckedValue,
                    Mobile: SearchStudent.val()
                }
                const response = await Ajax_GetResult("Add_Student_Admission.aspx", "Get_SearchDetail", dataToSend);
                const data = JSON.parse(response.d);
                if (data.length > 0) {
                    StudentName.val(data[0].Name);
                    Mobile.val(data[0].Mobile);
                    CourseId.val(data[0].CourseId).trigger("change");
                    Address.val(data[0].Address);
                }
            } catch (err) {
                console.log(err);
            }
            finally {
                await Hide_Spinner();
            }
        }
        async function renderStudentId() {
            try {
                const response = await Ajax_GetResult_WithoutParameter("Add_Student_Admission.aspx", "Get_StudentId");
                if (response.d != "") {
                    StudentId.val(response.d);
                }
            } catch (err) {
                console.log(err);
            }
        }
        async function renderAdmissionNo() {
            try {
                const response = await Ajax_GetResult_WithoutParameter("Add_Student_Admission.aspx", "Get_AdmissionNo");
                if (response.d != "") {
                    AdmissionNo.val(response.d);
                }
            } catch (err) {
                console.log(err);
            }
        }
        async function renderRollNo() {
            try {
                const response = await Ajax_GetResult_WithoutParameter("Add_Student_Admission.aspx", "Get_RollNo");
                if (response.d != "") {
                    RollNo.val(response.d);
                }
            } catch (err) {
                console.log(err);
            }
        }
        async function renderStates() {
            try {
                return new Promise((resolve, reject) => {
                    console.log("Load State");
                    State.prop('disabled', false).css('pointer-events', 'auto');
                    City.prop('disabled', true).css('pointer-events', 'none');

                    const selectedCountryCode = "IN";
                    State.html('<option value="">Select State</option>');
                    City.html('<option value="">Select City</option>');

                    $.ajax({
                        url: `${config.cUrl}/${selectedCountryCode}/states`,
                        headers: { "X-CSCAPI-KEY": config.ckey },
                        method: 'GET',
                        success: function (data) {
                            $.each(data, function (index, state) {
                                State.append($('<option>', {
                                    value: state.iso2,
                                    text: state.name
                                }));
                            });
                            resolve();
                        },
                        error: function (error) {
                            reject(error);
                        }
                    });
                })

            } catch (err) {
                console.log(err);
            }

        }

        async function renderCities() {
            try {
                return new Promise((resolve, reject) => {
                    Show_Spinner();

                    City.prop('disabled', false).css('pointer-events', 'auto');

                    const selectedCountryCode = "IN";
                    const selectedStateCode = State.val();
                    City.html('<option value="">Select City</option>');

                    if (selectedStateCode != "") {
                        $.ajax({
                            url: `${config.cUrl}/${selectedCountryCode}/states/${selectedStateCode}/cities`,
                            headers: { "X-CSCAPI-KEY": config.ckey },
                            method: 'GET',
                            success: function (data) {
                                $.each(data, function (index, city) {
                                    City.append($('<option>', {
                                        value: city.iso2,
                                        text: city.name
                                    }));
                                });
                                Hide_Spinner();
                                resolve();
                            },
                            error: function (error) {
                                reject(error);
                            }
                        });
                    }
                    else {
                        City.prop('disabled', true).css('pointer-events', 'auto');
                        Hide_Spinner();
                    }
                })


            } catch (err) {
                console.log(err);
            }

        }
        async function renderCourse() {
            try {
                const response = await Ajax_GetResult_WithoutParameter("Add_Student_Admission.aspx", "Get_Course");
                const data = JSON.parse(response.d);
                if (data.length > 0) {
                    CourseId.html('<option value="" Selected>Select Course</option>');
                    $.each(data, function (index, item) {
                        CourseId.append($('<option>', {
                            value: item.Id,
                            text: item.Course_Name
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
                            <td>? ${item.Fee}</td>
                        </tr>
                    `;

                        TotalAmount.val(item.Fee);
                    })
                    $("#tblCourse").html(html);
                    $("#tblCourseDiv").removeClass("hide");
                }
                else {
                    $("#tblCourseDiv").addClass("hide");
                }
                await renderSession();
                BatchName.empty();
                $("#tblBatchDiv").addClass("hide");
                formValidationInstance.resetField("txtTotalAmount");

            } catch (err) {
                console.log(err);
            }
            finally {
                await Hide_Spinner();
            }
        }
        async function OnChange_BatchName() {
            try {
                await Show_Spinner();
                dataToSend = {
                    SessionId: Session.val(),
                    CourseId: CourseId.val(),
                    BatchName: BatchName.val()
                }

                const response = await Ajax_GetResult("Add_Student_Admission.aspx", "Get_BatchDetail", dataToSend);
                const data = JSON.parse(response.d);
                console.log(data);
                if (data.length > 0) {
                    var html = "";
                    $("#tblBatch").empty();
                    $.each(data, function (index, item) {

                        BatchId = item.Id;

                        html += `
                        <tr>
                            <td>${item.Id}</td>
                            <td>${item.Course_Name}</td>
                            <td>${item.BatchName}</td>
                            <td>${item.BatchStartTime} - ${item.BatchEndTime}</td>
                            <td>${item.StartDate}</td>
                        </tr>
                    `;

                    })
                    $("#tblBatch").html(html);
                    $("#tblBatchDiv").removeClass("hide");
                }
                else {
                    $("#tblBatchDiv").addClass("hide");
                }

                formValidationInstance.resetField("txtTotalAmount");

            } catch (err) {
                console.log(err);
            }
            finally {
                await Hide_Spinner();
            }
        }

        async function OnChange_Concession() {
            if (TotalAmount.val() === "") {
                Warning("Invalid 'Total Amount'!");
                Concession.val("");
            }
            else {
                const total = parseFloat(TotalAmount.val());
                const conc = parseFloat(Concession.val()) || 0;

                const perValue = (conc * total) / 100;
                const rest = total - perValue;
                NetAmount.val(parseFloat(rest).toFixed(2))

                formValidationInstance.resetField("txtNetAmount");
                await BindInstallmentTable()
                await renderMyInstallment();
            }

        }
        async function OnChange_Session() {
            try {
                if (CourseId.val() === "") {
                    Warning("Please select course!");
                    await renderSession();
                } else {
                    await Show_Spinner();
                    dataToSend = {
                        SessionId: Session.val(),
                        CourseId: CourseId.val()
                    }
                    const response = await Ajax_GetResult("Batch.aspx", "Get_BatchName", dataToSend);
                    const data = JSON.parse(response.d);
                    if (data.length > 0) {
                        BatchName.html('<option value="" Selected>Select Batch Name</option>');
                        $.each(data, function (index, item) {
                            BatchName.append($('<option>', {
                                value: item.BatchName,
                                text: item.BatchName
                            }));
                        });
                    }
                    else {
                        Warning("No Batch available!");
                        await renderSession();
                        BatchName.empty();
                    }

                }

            } catch (err) {
                console.log(err);
            }
            finally {
                await Hide_Spinner();
            }
        }
        async function OnChange_Mobile() {
            try {
                dataToSend = {
                    Mobile: Mobile.val(),
                }
                const response = await Ajax_GetResult("Add_Student_Admission.aspx", "Is_MobileExist", dataToSend);
                if (response.d == 1) {
                    Warning("Mobile no already exist!");
                    Mobile.val("");
                }

            } catch (err) {
                console.log(err);
            }
        }

        async function renderSession() {
            try {
                const response = await Ajax_GetResult_WithoutParameter("Batch.aspx", "Get_Session");
                const data = JSON.parse(response.d);
                if (data.length > 0) {
                    Session.html('<option value="" Selected>Select Session</option>');
                    $.each(data, function (index, item) {
                        Session.append($('<option>', {
                            value: item.Id,
                            text: item.SessionStart + " - " + item.SessionEnd
                        }));
                    });
                }

            } catch (err) {
                console.log(err);
            }
        }

        async function OnChange_PaymentMode() {
            const total = parseFloat(NetAmount.val());
            if (NetAmount.val() === "") {
                Warning("Invalid 'Net Amount'!");
            }
            else {
                console.log($(this).val())
                if ($(this).val() === "Full") {
                    $("#InstallmentPlanDiv").addClass("hide");
                    PaidAmount.val(total.toFixed(2));
                    PaymentInstallmentDiv.addClass("hide");
                    MyPaymentInstallmentDiv.addClass("hide");
                    nextDueDateDiv.addClass("hide");
                    $("#paymodeText").html("(Full)");
                    InstallmentPlan.val("").trigger('change');
                    InstallmentAmount = "0";
                    InstallmentNo = "0";
                    MyTotalDuesAmount.html("0");
                }
                else if ($(this).val() === "Installment") {

                    PaidAmount.val("");

                    $("#InstallmentPlanDiv").removeClass("hide");
                    PaymentInstallmentDiv.addClass("hide");


                }


                formValidationInstance.resetField("txtPaidAmount");
            }

        }
        async function OnChange_InstallmentPlan() {
            if (InstallmentPlan.val() != "") {
                await BindInstallmentTable(InstallmentPlan.val());

                tblpaymentModes = document.querySelectorAll('input[name="InstallmentOption"]');
                console.log(tblpaymentModes);

                tblpaymentModes.forEach((paymentMode) => {
                    console.log(paymentMode)
                    paymentMode.addEventListener('change', async function () {
                        MyPaymentInstallmentDiv.removeClass("hide");
                        InstallmentAmount = $(this).data("installmentamount");
                        InstallmentNo = $(this).data("installmentno");
                        await renderPaidDues();
                    });
                });
                MyPaymentInstallmentDiv.addClass("hide");
                PaymentInstallmentDiv.removeClass("hide");
                nextDueDateDiv.removeClass("hide");
                $("#paymodeText").html("(1st Installment)");
                PaidAmount.val("");
            }

        }
        async function BindInstallmentTable(total) {
            const TotalInstallment = parseFloat(total);
            const TotalAmount = parseFloat(NetAmount.val()); // Get the total amount
            const data = [];

            // Generate data for up to 10 installments
            for (let i = 2; i <= TotalInstallment; i++) {
                const installmentAmount = TotalAmount / i;
                data.push({
                    installmentAmount: installmentAmount.toFixed(2),
                    installmentNo: i,
                    totalAmount: TotalAmount.toFixed(2)
                });
            }

            let html = "";
            $.each(data, function (index, item) {
                html += `
                        <tr>
                            <td>
                                <input type="radio" name="InstallmentOption" id="txtInstallment${item.installmentNo}" class="form-check-input" data-installmentamount="${item.installmentAmount}" data-installmentno="${item.installmentNo}">
                            </td>
                            <td>
                                <label for="txtInstallment${item.installmentNo}" style="cursor:pointer;">${item.installmentAmount} x ${item.installmentNo}</label>
                            </td>
                            <td>
                                <label for="txtInstallment${item.installmentNo}" style="cursor:pointer;">${item.totalAmount}</label>
                            </td>
                        </tr>
                    `;
            });

            PaymentInstallment.html(html); // Bind the generated HTML to the table body
        }

        async function renderPaidDues() {

            PaidAmount.val(InstallmentAmount);

            await renderMyInstallment();
        }
        async function renderMyInstallment() {
            const PayingAmount = parseFloat(PaidAmount.val()) || 0;
            const TotalAmountVal = parseFloat(NetAmount.val()) || 0;

            if (!InstallmentNo || parseInt(InstallmentNo) <= 1) {
                MyInstallmentAmount.html("0");
                MyInstallmentNo.html("0");
                MyTotalDuesAmount.html("0");
                return;
            }

            const MyNewTotalDues = TotalAmountVal - PayingAmount;
            const MyInstallmentNumber = parseInt(InstallmentNo) - 1;

            if (MyInstallmentNumber <= 0) {
                MyInstallmentAmount.html("0");
                MyInstallmentNo.html("0");
                MyTotalDuesAmount.html(MyNewTotalDues.toFixed(2));
                return;
            }

            const NewInstallmentAmount = MyNewTotalDues / MyInstallmentNumber;

            MyInstallmentAmount.html(NewInstallmentAmount.toFixed(2));
            MyInstallmentNo.html(MyInstallmentNumber);
            MyTotalDuesAmount.html(MyNewTotalDues.toFixed(2));
        }
        async function OnChange_PaidAmount() {

            await renderMyInstallment();
        }

        function uploadSingleDropzone(dropzone, label) {
            return new Promise((resolve, reject) => {
                const acceptedFiles = dropzone.getAcceptedFiles();
                if (!acceptedFiles || acceptedFiles.length === 0) {
                    reject(label + " is missing.");
                    return;
                }

                let uploadedServerFileName = "";
                const onSuccess = function (file, response) {
                    uploadedServerFileName = (response || "").toString().trim();
                };
                const onError = function (file, response) {
                    cleanup();
                    reject("Error uploading " + label + ": " + (response || "Unknown error"));
                };
                const onComplete = function () {
                    cleanup();
                    if (!uploadedServerFileName || uploadedServerFileName.startsWith("ERROR")) {
                        reject("Unable to upload " + label + ".");
                    } else {
                        resolve(uploadedServerFileName);
                    }
                };

                function cleanup() {
                    dropzone.off("success", onSuccess);
                    dropzone.off("error", onError);
                    dropzone.off("queuecomplete", onComplete);
                }

                dropzone.on("success", onSuccess);
                dropzone.on("error", onError);
                dropzone.on("queuecomplete", onComplete);
                dropzone.processQueue();
            });
        }

        async function uploadAdmissionFiles() {
            const photoServerName = await uploadSingleDropzone(myDropzone, "photo");
            const aadhaarServerName = await uploadSingleDropzone(aadhaarDropzone, "aadhaar file");
            return { photoServerName, aadhaarServerName };
        }

        async function OnClick_TakeAdmission() {

            if (!formAuthentication) return;

            formValidationInstance.validate().then(async function (status) {

                if (status !== 'Valid') {
                    console.log("Form is invalid");
                    return;
                }

                if (myDropzone.getAcceptedFiles().length === 0) {
                    NotifyWarning("Please select a Photo.");
                    return;
                }

                if (aadhaarDropzone.getAcceptedFiles().length === 0) {
                    NotifyWarning("Please upload Aadhaar document.");
                    return;
                }

                if (!BatchId) {
                    NotifyWarning("Please select Batch properly.");
                    return;
                }

                if (PaymentMode.val() === "Installment") {

                    if (!InstallmentAmount || !InstallmentNo) {
                        NotifyWarning("Please select Installment Plan.");
                        return;
                    }

                    if (!NextDueDate.val()) {
                        NotifyWarning("Please select Next Due Date.");
                        return;
                    }
                }
                else {
                    InstallmentAmount = "0";
                    InstallmentNo = "0";
                    MyInstallmentAmount.html("0");
                    MyInstallmentNo.html("0");
                    MyTotalDuesAmount.html("0");
                }

                try {

                    const result = await Confirm(
                        "Yes, Take Admission!",
                        "Are you sure you want to Take Admission?"
                    );

                    if (!result.isConfirmed) return;

                    await Show_Spinner();
                    const uploadedFiles = await uploadAdmissionFiles();

                    const dataToSend = {
                        StudentId: StudentId.val(),
                        AdmissionNo: AdmissionNo.val(),
                        RollNo: RollNo.val(),
                        StudentName: StudentName.val(),
                        Mobile: Mobile.val(),
                        Gender: Gender.val(),
                        Email: Email.val(),
                        DOB: DOB.val(),
                        FatherName: FatherName.val(),
                        FatherOccupation: FatherOccupation.val(),
                        FatherContactNo: FatherContactNo.val(),
                        MotherName: MotherName.val(),
                        State: State.find('option:selected').text(),
                        City: City.find('option:selected').text(),
                        Pincode: Pincode.val(),
                        Address: Address.val(),
                        Photo: uploadedFiles.photoServerName,
                        AadhaarFile: uploadedFiles.aadhaarServerName,
                        CourseId: CourseId.val(),
                        TotalAmount: TotalAmount.val() || "0",
                        Concession: Concession.val() || "0",
                        NetAmount: NetAmount.val() || "0",
                        PaymentMode: PaymentMode.val(),
                        InstallmentAmount: InstallmentAmount || "0",
                        InstallmentNo: InstallmentNo || "0",
                        PaidAmount: PaidAmount.val() || "0",
                        NextDueDate: NextDueDate.val() || "",
                        PaymentMethod: PaymentMethod.val(),
                        MyInstallmentAmount: MyInstallmentAmount.html() || "0",
                        MyInstallmentNo: MyInstallmentNo.html() || "0",
                        MyTotalDuesAmount: MyTotalDuesAmount.html() || "0",
                        BatchId: BatchId,
                        CheckedValue: CheckedValue
                    };

                    console.log("Sending Data:", dataToSend);

                    const response = await Ajax_GetResult(
                        "Add_Student_Admission.aspx",
                        "Take_Admission",
                        dataToSend
                    );

                    console.log("Server Response:", response.d);


                    if (response.d && !response.d.startsWith("ERROR")) {

                        window.open(
                            'Admission_Success.aspx?InvoiceNo=' + response.d +
                            '&Mobile=' + Mobile.val() +
                            '&PayMode=' + PaymentMode.val(),
                            '_blank'
                        );

                        Success_Redirect(
                            "Admitted",
                            "Admission Successfully",
                            "Student_Admission.aspx"
                        );

                    }
 else {

                        Failed(response.d || "Admission Failed!");
                    }

                } catch (err) {
                    console.error("Admission Error:", err);
                    Failed("Something went wrong!");
                }
                finally {
                    await Hide_Spinner();
                }

            });
        }

        function restrictBeforeDate() {
            var currentDate = new Date();
            var tomorrowDate = new Date(currentDate);
            tomorrowDate.setDate(currentDate.getDate());

            var minDate = tomorrowDate.getFullYear() + '-' + ('0' + (tomorrowDate.getMonth() + 1)).slice(-2) + '-' + ('0' + tomorrowDate.getDate()).slice(-2);

            NextDueDate.attr('min', minDate);
        }
        function restrictAfterDate() {
            var currentDate = new Date();
            var tomorrowDate = new Date(currentDate);
            tomorrowDate.setDate(currentDate.getDate());

            var maxDate = tomorrowDate.getFullYear() + '-' + ('0' + (tomorrowDate.getMonth() + 1)).slice(-2) + '-' + ('0' + tomorrowDate.getDate()).slice(-2);

            DOB.attr('max', maxDate);
        }
        document.addEventListener('DOMContentLoaded', function () {
            // Ensure the form exists before trying to validate it

            if (!formAuthentication) {
                console.error("Form not found!");
                return;
            }
            console.log("Form found:", formAuthentication);


            const GenderSelect = jQuery(formAuthentication.querySelector('[name="txtGender"]'));
            const StateSelect1 = jQuery(formAuthentication.querySelector('[name="txtState"]'));
            const CitySelect1 = jQuery(formAuthentication.querySelector('[name="txtCity"]'));
            const CourseSelect = jQuery(formAuthentication.querySelector('[name="txtCourseId"]'));
            const PaymentMethodSelect = jQuery(formAuthentication.querySelector('[name="txtPaymentMethod"]'));
            const PaymentModeSelect = jQuery(formAuthentication.querySelector('[name="txtPaymentMode"]'));
            const SessionSelect = jQuery(formAuthentication.querySelector('[name="txtSession"]'));
            const BatchNameSelect = jQuery(formAuthentication.querySelector('[name="txtBatchName"]'));
            // Initialize the form validation
            formValidationInstance = FormValidation.formValidation(formAuthentication, {
                fields: {
                    txtStudentName: {
                        validators: {
                            notEmpty: {
                                message: "Please enter student name"
                            },
                            stringLength: {
                                min: 3,
                                message: "Student Name must be more than 3 characters"
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
                    txtGender: {
                        validators: {
                            notEmpty: {
                                message: "Please select gender"
                            }
                        }
                    },
                    txtEmail: {
                        validators: {
                            notEmpty: {
                                message: "Please enter your email"
                            },
                            emailAddress: {
                                message: "Please enter valid email address"
                            }
                        }
                    },
                    txtDOB: {
                        validators: {
                            notEmpty: {
                                message: "Please select DOB"
                            }
                        }
                    },
                    txtFatherName: {
                        validators: {
                            notEmpty: {
                                message: "Please enter father name"
                            },
                            stringLength: {
                                min: 3,
                                message: "Father Name must be more than 3 characters"
                            }
                        }
                    },
                    txtFatherOccupation: {
                        validators: {
                            notEmpty: {
                                message: "Please enter father Occupation"
                            },
                            stringLength: {
                                min: 3,
                                message: "Father Occupation must be more than 3 characters"
                            }
                        }
                    },
                    txtFatherContactNo: {
                        validators: {
                            notEmpty: {
                                message: "Please enter father ContactNo"
                            },
                            regexp: {
                                regexp: /^\d{10}$/,
                                message: "Please enter a valid mobile number with 10 digits"
                            }
                        }
                    },
                    txtMotherName: {
                        validators: {
                            notEmpty: {
                                message: "Please enter mother name"
                            },
                            stringLength: {
                                min: 3,
                                message: "Mother Name must be more than 3 characters"
                            }
                        }
                    },
                    txtState: {
                        validators: {
                            notEmpty: {
                                message: "Please select State"
                            }
                        }
                    },
                    txtCity: {
                        validators: {
                            notEmpty: {
                                message: "Please select City"
                            }
                        }
                    },
                    txtPincode: {
                        validators: {
                            notEmpty: {
                                message: "Please enter Pincode"
                            },
                            regexp: {
                                regexp: /^\d{6}$/,
                                message: "Please enter a valid pincode with 6 digits"
                            }
                        }
                    },
                    txtAddress: {
                        validators: {
                            notEmpty: {
                                message: "Please enter Address"
                            },
                            stringLength: {
                                min: 6,
                                message: "Address must be more than 6 characters"
                            }
                        }
                    },
                    txtCourseId: {
                        validators: {
                            notEmpty: {
                                message: "Please select CourseId"
                            }
                        }
                    },
                    txtTotalAmount: {
                        validators: {
                            notEmpty: {
                                message: "Please enter the total amount"
                            },
                            numeric: {
                                message: "Please enter a valid number"
                            }
                        }
                    },
                    txtConcession: {
                        validators: {
                            notEmpty: {
                                message: "Please enter the Concession"
                            },
                            numeric: {
                                message: "Please enter a valid number"
                            }
                        }
                    },
                    txtNetAmount: {
                        validators: {
                            notEmpty: {
                                message: "Please enter the Net Amount"
                            },
                            numeric: {
                                message: "Please enter a valid number"
                            }
                        }
                    },
                    txtPaymentMode: {
                        validators: {
                            notEmpty: {
                                message: "Please select payment mode"
                            }
                        }
                    },
                    txtPaidAmount: {
                        validators: {
                            notEmpty: {
                                message: "Please enter the Paid Amount"
                            },
                            numeric: {
                                message: "Please enter a valid number"
                            }
                        }
                    },
                    txtPaymentMethod: {
                        validators: {
                            notEmpty: {
                                message: "Please select Payment Method"
                            }
                        }
                    },
                    txtSession: {
                        validators: {
                            notEmpty: {
                                message: "Please select session"
                            }
                        }
                    },
                    txtBatchName: {
                        validators: {
                            notEmpty: {
                                message: "Please select batch name"
                            }
                        }
                    }
                },
                plugins: {
                    trigger: new FormValidation.plugins.Trigger(),
                    bootstrap5: new FormValidation.plugins.Bootstrap5({
                        eleValidClass: "",
                        rowSelector: ".validation"
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

            if (GenderSelect.length) {
                select2Focus(GenderSelect);
                GenderSelect.wrap('<div class="position-relative"></div>');
                GenderSelect.select2({
                    placeholder: "Select Gender",
                    dropdownParent: GenderSelect.parent()
                }).on("change", function () {
                    formValidationInstance.revalidateField("txtGender");
                });
            }
            if (StateSelect1.length) {
                select2Focus(StateSelect1);
                StateSelect1.wrap('<div class="position-relative"></div>');
                StateSelect1.select2({
                    placeholder: "Select State",
                    dropdownParent: StateSelect1.parent()
                }).on("change", function () {
                    formValidationInstance.revalidateField("txtState");
                });
            }

            if (CitySelect1.length) {
                select2Focus(CitySelect1);
                CitySelect1.wrap('<div class="position-relative"></div>');
                CitySelect1.select2({
                    placeholder: "Select City",
                    dropdownParent: CitySelect1.parent()
                }).on("change", function () {
                    formValidationInstance.revalidateField("txtCity");
                });
            }
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
            if (PaymentModeSelect.length) {
                select2Focus(PaymentModeSelect);
                PaymentModeSelect.wrap('<div class="position-relative"></div>');
                PaymentModeSelect.select2({
                    placeholder: "Select Payment Mode",
                    dropdownParent: PaymentModeSelect.parent()
                }).on("change", function () {
                    formValidationInstance.revalidateField("txtPaymentMode");
                });
            }
            if (PaymentMethodSelect.length) {
                select2Focus(PaymentMethodSelect);
                PaymentMethodSelect.wrap('<div class="position-relative"></div>');
                PaymentMethodSelect.select2({
                    placeholder: "Select Payment Method",
                    dropdownParent: PaymentMethodSelect.parent()
                }).on("change", function () {
                    formValidationInstance.revalidateField("txtPaymentMethod");
                });
            }
            if (SessionSelect.length) {
                select2Focus(SessionSelect);
                SessionSelect.wrap('<div class="position-relative"></div>');
                SessionSelect.select2({
                    placeholder: "Select Session",
                    dropdownParent: SessionSelect.parent()
                }).on("change", function () {
                    formValidationInstance.revalidateField("txtSession");
                });
            }
            if (BatchNameSelect.length) {
                select2Focus(BatchNameSelect);
                BatchNameSelect.wrap('<div class="position-relative"></div>');
                BatchNameSelect.select2({
                    placeholder: "Select Batch Name",
                    dropdownParent: BatchNameSelect.parent()
                }).on("change", function () {
                    formValidationInstance.revalidateField("txtBatchName");
                });
            }


        });
    </script>

</asp:Content>



