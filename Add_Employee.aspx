<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true" CodeFile="Add_Employee.aspx.cs" Inherits="Admin_Add_Employee" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Add Employee | Institute Management Software</title>
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
                        <h5><span class="text-muted fw-light">Employee Section /</span><a href="Employee.aspx"> <span class=" fw-light">Employee /</span></a> Add Employee</h5>
                    </div>
                    <div id="top-right-date" class="col-md-4" style="display: flex; justify-content: end;">
                        <div class="">
                            <a href="Employee.aspx" class="btn btn-primary waves-effect waves-light" style="margin-right: 10px"><i class="menu-icon ri-arrow-left-line"></i>Back</a>
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
                                        <h3 class="text-center" style="letter-spacing: 1px; text-transform: uppercase; font-weight: 600; font-size: 22px;">Employee</h3>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="card col-lg-8 mx-auto" id="formAuthentication">
                                    <!-- 1. Delivery Address -->
                                    <h5 class="my-4">1. Employee Detail</h5>
                                    <div class="row g-6">
                                        <div class="col-12 col-md-4">
                                            <div class="form-floating form-floating-outline validation">
                                                <input type="text" id="txtEmployeeId" name="txtEmployeeId" class="form-control" placeholder="Enter Employee id" readonly />
                                                <label for="txtEmployeeId">Employee Id</label>
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-8">
                                            <div class="form-floating form-floating-outline validation">
                                                <input type="text" id="txtEmployeeName" name="txtEmployeeName" class="form-control" placeholder="Enter Employee name" />
                                                <label for="txtEmployeeName">Employee Name *</label>
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
                                                <input type="text" id="txtAadharNo" name="txtAadharNo" class="form-control" placeholder="Enter aadhar no" />
                                                <label for="txtAadharNo">Aadhar No *</label>
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
                                    <h5 class="my-6">2. Job Detail</h5>
                                    <div class="row g-6">
                                        <div class="col-12 col-md-6">
                                            <div class="form-floating form-floating-outline validation">
                                                <div class="select2-primary">
                                                    <select id="txtDepartment" name="txtDepartment" class="select2 form-select">
                                                    </select>
                                                </div>
                                                <label for="txtDepartment">Department *</label>
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-6">
                                            <div class="form-floating form-floating-outline validation">
                                                <div class="select2-primary">
                                                    <select id="txtDesignation" name="txtDesignation" class="select2 form-select">
                                                    </select>
                                                </div>
                                                <label for="txtDesignation">Designation *</label>
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-6">
                                            <div class="form-floating form-floating-outline validation">
                                                <input type="date" id="txtJoiningDate" name="txtJoiningDate" class="form-control" />
                                                <label for="txtJoiningDate">Joining Date *</label>
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-6">
                                            <div class="form-floating form-floating-outline validation">
                                                <input type="text" id="txtSalary" name="txtSalary" class="form-control" placeholder="Enter salary" />
                                                <label for="txtSalary">Salary *</label>
                                            </div>
                                        </div>

                                    </div>
                                    <hr>
                                    <!-- 4. Apply Promo code -->
                                    <h5 class="my-4">4. Employee Photo</h5>
                                    <div class="row g-4">
                                        <div class="col-12 col-md-12">
                                            <label for="largeInput" style="width: 100%; color: #aba8b1; padding: 1rem;">
                                                Upload Employee Photo *</label>
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
                                    </div>
                                    <hr>
                                    <div class="row g-6">
                                        <div class="col-12 text-center">
                                            <button id="BtnAdd" type="button" class="btn btn-primary me-3 waves-effect waves-light">Add Employee</button>
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
    var uploadedFileName = "";   // ✅ GLOBAL VARIABLE

    myDropzone = new Dropzone("#dropzone-basic", {

        url: "FileUploadHandler.ashx",
        autoProcessQueue: false,
        maxFiles: 1,
        paramName: "file",
        maxFilesize: 2,
        acceptedFiles: "image/*",

        init: function () {

            myDropzone = this;

            this.on("maxfilesexceeded", function (file) {
                this.removeAllFiles();
                this.addFile(file);
            });

            this.on("success", function (file, response) {

                if (response.startsWith("ERROR")) {
                    alert(response);
                    return;
                }

                uploadedFileName = response;   // ✅ SAVE FILENAME

                console.log("Uploaded File:", uploadedFileName);
            });

            this.on("error", function (file, response) {
                console.log("Upload Error:", response);
            });

        }
    });
</script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <script type="text/javascript">

        let NewClient, OldClient, SearchClientDiv, CheckedValue;

        let EmployeeId, EmployeeName, Mobile, Gender, Email, DOB, AadharNo, FatherName, State, City, Pincode, Address, Department, Designation, JoiningDate, Salary;
        var BtnAdd, dataToSend;

        let formAuthentication = document.querySelector("#formAuthentication");
        let formValidationInstance;

        let config = {
            cUrl: 'https://api.countrystatecity.in/v1/countries',
            ckey: 'NHhvOEcyWk50N2Vna3VFTE00bFp3MjFKR0ZEOUhkZlg4RTk1MlJlaA=='
        };

        const defaultRun = async () => {
            try {
                await renderEmployeeId();
                await renderStates();
                await renderDepartment()
            } catch (err) {
                console.log(err);
            }
        }

        $(document).ready(function () {


            EmployeeId = $("#txtEmployeeId");
            EmployeeName = $("#txtEmployeeName");
            Mobile = $("#txtMobile");
            Gender = $("#txtGender");
            Email = $("#txtEmail");
            DOB = $("#txtDOB");
            AadharNo = $("#txtAadharNo");
            FatherName = $("#txtFatherName");
            State = $("#txtState");
            City = $("#txtCity");
            Pincode = $("#txtPincode");
            Address = $("#txtAddress");
            Department = $("#txtDepartment");
            Designation = $("#txtDesignation");
            JoiningDate = $("#txtJoiningDate");
            Salary = $("#txtSalary");

            (async function () {
                await Show_Spinner();
                await defaultRun().finally(async () => {
                    await Hide_Spinner();
                });
            })();

            $(document).on("click", "#BtnAdd", OnClick_BtnAdd);

            State.change(renderCities);
            Department.change(OnChange_Department);

            OnKeyPressValidation(EmployeeName, validateAlphabeticOrSpace);
            OnKeyPressValidation(FatherName, validateAlphabeticOrSpace);
            OnKeyPressValidation(Mobile, validateMobileNumber);
            OnKeyPressValidation(Pincode, validatePincode);
        })

        async function renderEmployeeId() {
            try {
                const response = await Ajax_GetResult_WithoutParameter("Add_Employee.aspx", "Get_EmployeeId");
                if (response.d != "") {
                    EmployeeId.val(response.d);
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
        async function renderDepartment() {
            try {
                const response = await Ajax_GetResult_WithoutParameter("Add_Employee.aspx", "Get_Department");
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
                const response = await Ajax_GetResult("Add_Employee.aspx", "Get_Designation", dataToSend);
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

            } catch (err) {
                console.log(err);
            }
            finally {
                await Hide_Spinner();
            }
        }

        async function OnClick_BtnAdd() {

            if (myDropzone.getAcceptedFiles().length === 0) {
                NotifyWarning("Please select a Photo.");
                return;
            }

            try {

                await uploadFiles();   // upload file first

                dataToSend = {

                    EmployeeId: EmployeeId.val(),
                    EmployeeName: EmployeeName.val(),
                    Mobile: Mobile.val(),
                    Gender: Gender.val(),
                    Email: Email.val(),
                    DOB: DOB.val(),
                    AadharNo: AadharNo.val(),
                    FatherName: FatherName.val(),
                    State: State.find('option:selected').text(),
                    City: City.find('option:selected').text(),
                    Pincode: Pincode.val(),
                    Address: Address.val(),
                    Photo: uploadedFileName,   // ✅ CORRECT VALUE
                    Department: Department.val(),
                    Designation: Designation.val(),
                    JoiningDate: JoiningDate.val(),
                    Salary: Salary.val()

                };

                console.log(dataToSend);

                var response = await Ajax_GetResult("Add_Employee.aspx", "Create_Employee", dataToSend);

                if (response.d > 0) {

                    Success_Redirect("Added", "Employee Added Successfully", "Employee.aspx");

                } else {

                    Failed("Employee Add Failed!");

                }

            }
            catch (err) {

                console.log(err);

            }

        }
        async function uploadFiles() {

            return new Promise((resolve, reject) => {

                myDropzone.on("queuecomplete", function () {

                    resolve("Upload Complete");

                });

                myDropzone.on("error", function (file, response) {

                    reject(response);

                });

                myDropzone.processQueue();

            });

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
            const DepartmentSelect = jQuery(formAuthentication.querySelector('[name="txtDepartment"]'));
            const DesignationSelect = jQuery(formAuthentication.querySelector('[name="txtDesignation"]'));
            // Initialize the form validation
            formValidationInstance = FormValidation.formValidation(formAuthentication, {
                fields: {
                    txtEmployeeName: {
                        validators: {
                            notEmpty: {
                                message: "Please enter Employee name"
                            },
                            stringLength: {
                                min: 3,
                                message: "Employee Name must be more than 3 characters"
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
                    txtAadharNo: {
                        validators: {
                            notEmpty: {
                                message: "Please select Aadhar No"
                            },
                            stringLength: {
                                min: 12,
                                max: 12,
                                message: "Aadhar No must be more than 12 characters"
                            },
                            numeric: {
                                message: "Please enter a valid number"
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
                    txtDepartment: {
                        validators: {
                            notEmpty: {
                                message: "Please select Department"
                            }
                        }
                    },
                    txtDesignation: {
                        validators: {
                            notEmpty: {
                                message: "Please select Designation"
                            }
                        }
                    },
                    txtJoiningDate: {
                        validators: {
                            notEmpty: {
                                message: "Please select Joining Date"
                            }
                        }
                    },
                    txtSalary: {
                        validators: {
                            notEmpty: {
                                message: "Please enter Salary"
                            },
                            numeric: {
                                message: "Please enter a valid number"
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
            if (DepartmentSelect.length) {
                select2Focus(DepartmentSelect);
                DepartmentSelect.wrap('<div class="position-relative"></div>');
                DepartmentSelect.select2({
                    placeholder: "Select Department",
                    dropdownParent: DepartmentSelect.parent()
                }).on("change", function () {
                    formValidationInstance.revalidateField("txtDepartment");
                });
            }
            if (DesignationSelect.length) {
                select2Focus(DesignationSelect);
                DesignationSelect.wrap('<div class="position-relative"></div>');
                DesignationSelect.select2({
                    placeholder: "Select Designation",
                    dropdownParent: DesignationSelect.parent()
                }).on("change", function () {
                    formValidationInstance.revalidateField("txtDesignation");
                });
            }


        });
    </script>

</asp:Content>

