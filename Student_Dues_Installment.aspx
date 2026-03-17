<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true" CodeFile="Student_Dues_Installment.aspx.cs" Inherits="Admin_Student_Dues_Installment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Dues Installment | Institute Management Software</title>
    <link rel="stylesheet" href="../UserLogin_Content/assets/vendor/css/pages/page-user-view.css" />

    <style>
        #swal2-html-container {
            overflow: unset;
            z-index: 9;
        }

        .form-control {
            display: block;
            width: 100%;
            padding: .8555rem 1rem !important;
            font-size: 0.9375rem;
            font-weight: 400;
            line-height: 1.375 !important;
            color: #433c50;
            appearance: none;
            background-color: rgba(0, 0, 0, 0);
            background-clip: padding-box;
            border: 1px solid #d1cfd4;
            border-radius: .375rem;
            transition: border-color .15s ease-in-out, box-shadow .15s ease-in-out;
        }

        .form-floating > .form-control {
            height: 3.0000625rem;
            min-height: 3.0000625rem;
            line-height: 1.375;
        }

        .form-floating > label {
            width: 100%;
            color: #aba8b1;
            padding: .8125rem 1rem;
        }

        .form-floating > label {
            position: absolute;
            top: 0;
            left: 0;
            z-index: 2;
            height: 100%;
            padding: .8555rem 1rem;
            overflow: hidden;
            text-align: start;
            text-overflow: ellipsis;
            white-space: nowrap;
            pointer-events: none;
            border: 1px solid rgba(0, 0, 0, 0);
            transform-origin: 0 0;
            transition: opacity .2s ease-in-out, transform .2s ease-in-out;
        }

        .form-control[readonly] {
            background-color: white;
            opacity: 1;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="row">
        <!-- User Sidebar -->
        <div class="col-xl-4 col-lg-5 col-md-5 order-1 order-md-0">
            <!-- User Card -->
            <div class="card mb-6">
                <div class="card-body pt-12">
                    <div class="user-avatar-section">
                        <div class=" d-flex align-items-center flex-column">
                            <img id="lblPhoto" class="img-fluid rounded mb-4" src="../UserLogin_Content/assets/img/avatars/10.png" height="120" width="120" alt="User avatar" />
                            <div class="user-info text-center">
                                <h5><span id="lblStudentName">John Doe</span></h5>
                                <span class="badge bg-label-danger rounded-pill"><i class="menu-icon ri-graduation-cap-line"></i>Student</span>
                            </div>
                        </div>
                    </div>
                    <div class="d-flex justify-content-around flex-wrap my-6 gap-0 gap-md-3 gap-lg-4">
                        <div class="d-flex align-items-center me-5 gap-4">
                            <div class="avatar">
                                <div class="avatar-initial bg-label-primary rounded">
                                    <i class='ri-focus-2-fill ri-24px'></i>
                                </div>
                            </div>
                            <div>

                                <h5 class="mb-0"><span id="lblStudentId"></span></h5>
                                <span>Student Id</span>
                            </div>
                        </div>
                        <div class="d-flex align-items-center gap-4">
                            <div class="avatar">
                                <div class="avatar-initial bg-label-primary rounded">
                                    <i class='ri-focus-fill ri-24px'></i>
                                </div>
                            </div>
                            <div>
                                <h5 class="mb-0"><span id="lblAdmissionNo"></span></h5>
                                <span>Admission No</span>
                            </div>
                        </div>
                    </div>
                    <div class="d-flex justify-content-center mb-5">
                            <a href="javascript:;" id="BtnEdit" class="btn btn-primary me-4" data-bs-target="#editStudent" data-bs-toggle="modal">Edit</a>
                            <a href="javascript:;" id="BtnDropout" class="btn btn-outline-danger suspend-user me-4 hide">Dropout</a>
                            <a href="javascript:;" id="BtnActivate" class="btn btn-outline-success suspend-user me-4 hide">Activate</a>
                            <a href="javascript:;" id="BtnDelete" class="btn btn-danger suspend-user">Delete</a>
                        </div>
                    <h5 class="pb-4 border-bottom mb-4">Details</h5>
                    <div class="info-container">
                        <ul class="list-unstyled mb-6">
                            <li class="mb-2">
                                <span class="h6">Status:</span>
                                <span id="lblStatus" ></span>
                            </li>
                            <li class="mb-2">
                                <span class="h6">Roll No:</span>
                                <span id="lblRollNo">@violet.dev</span>
                            </li>
                            <li class="mb-2">
                                <span class="h6">Gender:</span>
                                <span id="lblGender">Male</span>
                            </li>
                            <li class="mb-2">
                                <span class="h6">Contact:</span>
                                <span id="lblMobile">(123) 456-7890</span>
                            </li>
                            <li class="mb-2">
                                <span class="h6">Email:</span>
                                <span id="lblEmail">vafgot@vultukir.org</span>
                            </li>
                            <li class="mb-2">
                                <span class="h6">DOB:</span>
                                <span id="lblDOB">Author</span>
                            </li>
                            <li class="mb-2">
                                <span class="h6">Father Name:</span>
                                <span id="lblFatherName">Tax-8965</span>
                            </li>
                            <li class="mb-2">
                                <span class="h6">Father Occupation:</span>
                                <span id="lblFatherOccupation">French</span>
                            </li>
                            <li class="mb-2">
                                <span class="h6">Father Contact:</span>
                                <span id="lblFatherContactNo">England</span>
                            </li>
                            <li class="mb-2">
                                <span class="h6">Mother Name:</span>
                                <span id="lblMotherName">England</span>
                            </li>
                            <li class="mb-2">
                                <span class="h6">State:</span>
                                <span id="lblState">England</span>
                            </li>
                            <li class="mb-2">
                                <span class="h6">City:</span>
                                <span id="lblCity">England</span>
                            </li>
                            <li class="mb-2">
                                <span class="h6">Pincode:</span>
                                <span id="lblPincode">England</span>
                            </li>
                            <li class="mb-2">
                                <span class="h6">Address:</span>
                                <span id="lblAddress">England</span>
                            </li>

                        </ul>
                        
                        
                    </div>
                </div>
            </div>
            <!-- /User Card -->
        </div>
        <!--/ User Sidebar -->


        <!-- User Content -->
        <div class="col-xl-8 col-lg-7 col-md-7 order-0 order-md-1">
            <!-- User Tabs -->
            <div class="nav-align-top">
                <ul class="nav nav-pills flex-column flex-md-row flex-wrap mb-6 row-gap-2">
                    <li class="nav-item"><a class="nav-link" id="Nav_Profile" href="javascript:void(0);"><i class="ri-group-line me-1_5"></i>Profile</a></li>
                    <li class="nav-item"><a class="nav-link" id="Nav_BatchInfo" href="javascript:void(0);"><i class="ri-bookmark-line me-1_5"></i>Batch Info</a></li>
                    <li class="nav-item"><a class="nav-link" id="Nav_PaidInstallment" href="javascript:void(0);"><i class="ri-verified-badge-line me-1_5"></i>Paid Installment</a></li>
                    <li class="nav-item"><a class="nav-link active" id="Nav_DuesInstallment" href="javascript:void(0);" style="background-color:#ff4c51"><i class="ri-hand-coin-line me-1_5"></i>Dues Installment</a></li>
                </ul>
            </div>
            <!--/ User Tabs -->

            <!-- My Dues Installment table -->
            <div class="card mb-6" id="MyRemainingInstallmentDiv">
                <div class="card-header">
                    <div class="d-flex align-items-center">
                        <div class="avatar" style="width: 3.5rem;">
                            <div class="avatar-initial bg-danger rounded shadow-xs">
                                <i class="ri-hand-coin-line ri-24px"></i>
                            </div>
                        </div>
                        <div class="ms-3">
                            <p class="mb-0">My Remaining Installment</p>
                            <h5 class="mb-0"></h5>
                        </div>
                    </div>
                </div>
                <div class="card-body text-center">
                    <div class="row align-items-center">
                        <div class="col-md-12 hide" id="NoInstallment">
                            No Dues
                        </div>
                        <div class="col-md-12" id="HasInstallment">
                            <div class="row g-4">
                                <div class="col-6">
                                    <div class="d-flex align-items-center justify-content-center mb-1">
                                        <div class="badge badge-dot bg-primary me-2"></div>
                                        <p class="mb-0">Next Installment Amount</p>
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
                                        <p class="mb-0">Next Dues Date</p>
                                    </div>
                                    <p class="fw-medium mb-0"><span id="lblMyNextDuesDate"></span></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--/ My Dues Installment Detail -->
        </div>
        <!--/ User Content -->
    </div>
    <!-- Edit User Modal -->
    <div class="modal fade" id="editStudent" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-simple modal-edit-user">
            <div class="modal-content">
                <div class="modal-body p-0">
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    <div class="text-center mb-6">
                        <h4 class="mb-2">Edit Student Information</h4>
                        <p class="mb-6">Updating user details will receive a privacy audit.</p>
                    </div>
                    <div class="row g-5" id="formAuthentication">
                        <div class="col-md-12">
                            <!-- 1. Delivery Address -->
                            <h5 class="my-4">Student Detail</h5>
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
                        </div>
                        <div class="col-12 text-center">
                            <button id="BtnUpdate" type="button" class="btn btn-primary me-3">Update</button>
                            <button type="reset" class="btn btn-outline-secondary" data-bs-dismiss="modal" aria-label="Close">Cancel</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--/ Edit User Modal -->

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script type="text/javascript">

        let Id, StudentId, AdmissionNo, RollNo, StudentName, Mobile, Gender, Email, DOB, FatherName, FatherOccupation, FatherContactNo, MotherName, State, City, Pincode, Address;

        let SearchMobile, MyRemainingInstallmentDiv, MyNextInstallmentAmount, MyRemainingInstallmentNo, MyTotalDuesAmount, MyNextDuesDate;
        let table, url, BtnAdd, BtnUpdate, dataToSend;

        var formAuthentication = document.querySelector("#formAuthentication");
        var formValidationInstance;

        let config = {
            cUrl: 'https://api.countrystatecity.in/v1/countries',
            ckey: 'NHhvOEcyWk50N2Vna3VFTE00bFp3MjFKR0ZEOUhkZlg4RTk1MlJlaA=='
        };

        const defaultRun = async () => {
            try {
                var urlParams = new URLSearchParams(window.location.search);
                var lblMobile = urlParams.get('Mobile');
                if (lblMobile)
                    SearchMobile = lblMobile;
                else
                    SearchMobile = await FindStudent();
                await renderStudent();

                await renderDuesInstallment();

            } catch (err) {
                console.log(err);
            }
        }

        $(document).ready(function () {

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

            MyRemainingInstallmentDiv = $("#MyRemainingInstallmentDiv");
            MyNextInstallmentAmount = $("#lblMyNextInstallmentAmount");
            MyRemainingInstallmentNo = $("#lblMyRemainingInstallmentNo");
            MyTotalDuesAmount = $("#lblMyTotalDuesAmount");
            MyNextDuesDate = $("#lblMyNextDuesDate");

            defaultRun().finally(() => { Hide_Spinner(); })

            $(document).on("click", "#BtnDelete", OnClick_BtnDelete);
            $(document).on("click", "#BtnDropout", OnClick_BtnDropout);
            $(document).on("click", "#BtnActivate", OnClick_BtnActivate);
            $(document).on("click", "#BtnEdit", OnClick_BtnEdit);
            $(document).on("click", "#BtnUpdate", OnClick_BtnUpdate);
            $(document).on("click", "#Nav_Profile", OnClick_Nav_Profile);
            $(document).on("click", "#Nav_BatchInfo", OnClick_Nav_BatchInfo);
            $(document).on("click", "#Nav_PaidInstallment", OnClick_Nav_PaidInstallment);
            $(document).on("click", "#Nav_DuesInstallment", OnClick_Nav_DuesInstallment);
        })
        async function FindStudent() {
            const result = await Swal.fire({
                title: "Find Student",
                html: `
                <div class="row">
                    <div class="col-md-12 mb-3">
                        <div class="form-floating form-floating-outline">
                            <div class="select2-primary">
                                <select id="txtSearchMobile" name="txtSearchMobile" class="select2 form-select" data-allow-clear="true">
                                    <!-- Options will be dynamically added here -->
                                </select>
                            </div>
                            <label for="txtSearchMobile">Search Mobile</label>
                        </div>
                    </div>
                </div>
                `,
                showCancelButton: true,
                confirmButtonText: "Find",
                showLoaderOnConfirm: true,
                customClass: {
                    confirmButton: "btn btn-primary me-3 waves-effect waves-light",
                    cancelButton: "btn btn-outline-danger waves-effect"
                },
                backdrop: true,
                allowOutsideClick: () => Swal.isLoading(),
                didOpen: async () => {
                    
                    await renderSearchMobile();
                    $('#txtSearchMobile').change(function () { console.log($(this).val()) })
                },
                preConfirm: () => {
                    const searchMobile = $('#txtSearchMobile').val();

                    if (!searchMobile) {
                        Swal.showValidationMessage("Please select a mobile number.");
                        return false;
                    }

                    return { searchMobile };
                }
            });

            if (result.isConfirmed) {
                return result.value.searchMobile;
                await Show_Spinner();
            } else if (result.dismiss === Swal.DismissReason.cancel) {
                window.location.href = "Student_Admission.aspx";
            }
        }

        async function renderSearchMobile() {
            try {
                const response = await Ajax_GetResult_WithoutParameter("Student_Dues_Installment.aspx", "Get_SearchMobile");
                const data = JSON.parse(response.d);

                if (data.length > 0) {
                    const selectElement = $('#txtSearchMobile');
                    selectElement.empty();
                    selectElement.append('<option value="">Select Mobile</option>');

                    data.forEach(item => {
                        selectElement.append($('<option>', {
                            value: item.Mobile,
                            text: item.Mobile + " - " + item.StudentName
                        }));
                    });

                    // Refresh Select2 to apply changes
                    selectElement.trigger('change');
                }
            } catch (err) {
                console.error(err);
            }
        }

        async function renderStudent() {
            try {
                dataToSend = {
                    Mobile: SearchMobile
                }
                const response = await Ajax_GetResult("Student_Dues_Installment.aspx", "Get_Student", dataToSend);
                const data = JSON.parse(response.d);
                if (data.length > 0) {
                    console.log(data);

                    $("#lblStatus").html(data[0]["Status"]);
                    if ($("#lblStatus").html() === "Active") {
                        $("#lblStatus").removeClass("badge bg-label-danger rounded-pill");
                        $("#lblStatus").addClass("badge bg-label-success rounded-pill");
                        $("#BtnActivate").addClass("hide");
                        $("#BtnDropout").removeClass("hide");
                    }
                    else if ($("#lblStatus").html() === "Dropout") {
                        $("#lblStatus").removeClass("badge bg-label-success rounded-pill");
                        $("#lblStatus").addClass("badge bg-label-danger rounded-pill");
                        $("#BtnDropout").addClass("hide");
                        $("#BtnActivate").removeClass("hide");
                    }
                    $("#lblStudentId").html(data[0]["StudentId"]);
                    $("#lblAdmissionNo").html(data[0]["AdmissionNo"]);
                    $("#lblRollNo").html(data[0]["RollNo"]);
                    $("#lblStudentName").html(data[0]["StudentName"]);
                    $("#lblMobile").html(data[0]["Mobile"]);
                    $("#lblGender").html(data[0]["Gender"]);
                    $("#lblEmail").html(data[0]["Email"]);
                    $("#lblDOB").html(data[0]["DOB"]);
                    $("#lblFatherName").html(data[0]["FatherName"]);
                    $("#lblFatherOccupation").html(data[0]["FatherOccupation"]);
                    $("#lblFatherContactNo").html(data[0]["FatherContactNo"]);
                    $("#lblMotherName").html(data[0]["MotherName"]);
                    $("#lblState").html(data[0]["State"]);
                    $("#lblCity").html(data[0]["City"]);
                    $("#lblPincode").html(data[0]["Pincode"]);
                    $("#lblAddress").html(data[0]["Address"]);
                    if (data[0]["Photo"] != null) {
                        $("#lblPhoto").attr("src", "../UserLogin_Content/upload/" + data[0]["Photo"]);
                    }

                }
            } catch (err) {
                console.log(err);
            }
        }
        async function OnClick_BtnEdit() {
            try {
                await Show_Spinner();
                $('#editStudent').on('shown.bs.modal', function () {
                    $('#editStudent').modal('show');

                });


                Id = this.name;
                dataToSend = {
                    Mobile: SearchMobile
                };
                const response = await Ajax_GetResult("Student_Admission.aspx", "Get_UpdateDetail", dataToSend);
                const data = JSON.parse(response.d);
                console.log(data)

                const item = data[0];

                StudentId.val(item.StudentId);
                AdmissionNo.val(item.AdmissionNo);
                RollNo.val(item.RollNo);
                StudentName.val(item.StudentName);
                Mobile.val(item.Mobile);
                Gender.val(item.Gender).trigger('change');
                Email.val(item.Email);
                DOB.val(item.DOB);
                FatherName.val(item.FatherName);
                FatherOccupation.val(item.FatherOccupation);
                FatherContactNo.val(item.FatherContactNo);
                MotherName.val(item.MotherName);
                await renderStates();
                const stateOption = State.find('option').filter(function () {
                    return $(this).text() === item.State;
                });
                if (stateOption.length) {
                    State.val(stateOption.val()).trigger('change');
                }
                await renderCities();

                const cityOption = City.find('option').filter(function () {
                    return $(this).text() === item.City;
                });
                if (cityOption.length) {
                    City.val(cityOption.val()).trigger('change');
                }
                Pincode.val(item.Pincode);
                Address.val(item.Address);



            } catch (err) {
                console.log(err);
            }
            finally {
                await Hide_Spinner();
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
        async function OnClick_BtnUpdate() {

            if (formAuthentication) {
                formValidationInstance.validate().then(async function (status) {
                    if (status === 'Valid') {
                        try {
                            const result = await Confirm("Yes, Update it !", "Are you sure want to Update ?")

                            if (result.isConfirmed) {
                                await Show_Spinner();

                                dataToSend = {
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
                                    Address: Address.val()
                                }

                                const response = await Ajax_GetResult("Student_Admission.aspx", "Update_Student_Admission", dataToSend);
                                if (response.d > 0) {
                                    $('#editStudent').modal('toggle');
                                    await renderStudent();
                                    Success("Updated", "Student Updated Successfully",);
                                }
                                else {
                                    Failed("Student Updated Failed !")
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

        
        function formatDate(dateString) {
            // Convert to Date object
            var date = new Date(dateString);

            // Array of month names
            var monthNames = [
                'January', 'February', 'March', 'April', 'May', 'June',
                'July', 'August', 'September', 'October', 'November', 'December'
            ];

            // Format the date
            return monthNames[date.getMonth()] + ' ' + date.getFullYear();
        }

        async function OnClick_BtnDelete() {
            const result = await Confirm("Yes, Delete it!", "Are you sure want to delete?");
            if (result.isConfirmed) {
                try {
                    Show_Spinner();

                    dataToSend = {
                        Mobile: SearchMobile
                    };
                    const response = await Ajax_GetResult("Student_Admission.aspx", "Delete_Student", dataToSend);
                    if (response.d > 0)
                        Success_Redirect("Deleted", "You have deleted this Student successfully", "Student_Admission.aspx");
                    else
                        Failed("Deleted Failed !");

                } catch (err) {
                    console.log(err);
                }
                finally {
                    Hide_Spinner();
                }
            }

        }
        async function OnClick_BtnDropout() {
            const result = await Confirm("Yes, Dropout!", "Are you sure want to Dropout?");
            if (result.isConfirmed) {
                try {
                    Show_Spinner();

                    dataToSend = {
                        Mobile: SearchMobile
                    };
                    const response = await Ajax_GetResult("Student_Admission.aspx", "Dropout_Student", dataToSend);

                    if (response.d > 0) {
                        Success("Dropout", "You have Dropout this Student successfully");
                        await renderStudent();
                    }
                    else
                        Failed("Dropout Failed !");

                } catch (err) {
                    console.log(err);
                }
                finally {
                    Hide_Spinner();
                }
            }

        }
        async function OnClick_BtnActivate() {
            const result = await Confirm("Yes, Activate Student!", "Are you sure want to Activate?");
            if (result.isConfirmed) {
                try {
                    Show_Spinner();

                    dataToSend = {
                        Mobile: SearchMobile
                    };
                    const response = await Ajax_GetResult("Student_Admission.aspx", "Activate_Student", dataToSend);

                    if (response.d > 0) {
                        Success("Activated", "You have Activate this Student successfully");
                        await renderStudent();
                    }
                    else
                        Failed("Activated Failed !");

                } catch (err) {
                    console.log(err);
                }
                finally {
                    Hide_Spinner();
                }
            }

        }
        async function OnClick_Nav_Profile() {
            window.location.href = "Student_Profile.aspx?Mobile=" + SearchMobile;
        }
        async function OnClick_Nav_BatchInfo() {
            window.location.href = "Student_Batch.aspx?Mobile=" + SearchMobile;
        }
        async function OnClick_Nav_PaidInstallment() {
            window.location.href = "Student_Paid_Installment.aspx?Mobile=" + SearchMobile;
        }
        async function OnClick_Nav_DuesInstallment() {
            window.location.href = "Student_Dues_Installment.aspx?Mobile=" + SearchMobile;
        }

        // page content

        async function renderDuesInstallment() {
            try {
                dataToSend = {
                    Mobile: SearchMobile
                }
                const response = await Ajax_GetResult("Student_Profile.aspx", "IsInstallment", dataToSend);
                if (response.d > 0) {
                    $("#NoInstallment").addClass("hide");
                    $("#HasInstallment").removeClass("hide");
                    const response1 = await Ajax_GetResult("Student_Dues_Installment.aspx", "fetchMyDuesInstallment", dataToSend);
                    const data1 = JSON.parse(response1.d);
                    if (data1.length > 0) {
                        MyNextInstallmentAmount.html(data1[0].Installment_Amount);
                        MyRemainingInstallmentNo.html(data1[0].Total_Installment);
                        MyTotalDuesAmount.html(data1[0].Total_Dues);
                        MyNextDuesDate.html(data1[0].Dues_Date);
                    }
                }
                else {
                    $("#NoInstallment").removeClass("hide");
                    $("#HasInstallment").addClass("hide");
                }
                
            } catch (err) {
                console.log(err);
            }
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


        });

    </script>

</asp:Content>

