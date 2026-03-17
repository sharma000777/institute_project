<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true" CodeFile="Employee.aspx.cs" Inherits="Admin_Employee" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Employee | Institute Management Software</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row g-6 mb-6">
        <div class="col-md">
            <div class="card">
                <div class="card-header row" style="justify-content: space-between;">
                    <div class="col-md-4">
                        <h5><span class="text-muted fw-light">Employee Section /</span> Employee</h5>
                    </div>
                    <div id="top-right-date" class="col-md-8" style="display: flex; justify-content: end;">
                        <div class="">
                            <a href="Add_Employee.aspx" class="btn btn-primary waves-effect waves-light" style="margin-right: 10px"><i class="menu-icon ri-function-add-fill"></i>Add New</a>
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
                                    <th>Action</th>
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
    <!-- Edit User Modal -->
    <div class="modal fade" id="EditUpdateEmployeeModal" tabindex="-1" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
        <div class="modal-dialog modal-dialog-centered modal-lg modal-simple modal-edit-user">
            <div class="modal-content">
                <div class="modal-body p-0">
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    <div class="text-center mb-6">
                        <h4 class="mb-2">Edit / Update Employee</h4>
                    </div>
                    <div class="row g-5" id="formAuthentication">
                        <div class="col-md-12">
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
                                        <input type="text" id="txtSalary" name="txtSalary" class="form-control" placeholder="Enter salary" />
                                        <label for="txtSalary">Salary *</label>
                                    </div>
                                </div>

                            </div>
                            <hr>
                        </div>
                        <div class="col-12 text-center">
                            <button id="BtnUpdate" type="button" class="btn btn-primary me-3" style="width: 25%;">Update</button>
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

        let Id, EmployeeId, EmployeeName, Mobile, Gender, Email, DOB, AadharNo, FatherName, State, City, Pincode, Address, Department, Designation, JoiningDate, Salary;
        let table, url, BtnAdd, BtnUpdate, dataToSend;

        let formAuthentication = document.querySelector("#formAuthentication");
        let formValidationInstance;

        let config = {
            cUrl: 'https://api.countrystatecity.in/v1/countries',
            ckey: 'NHhvOEcyWk50N2Vna3VFTE00bFp3MjFKR0ZEOUhkZlg4RTk1MlJlaA=='
        };

        const defaultRun = async () => {
            try {
                var url = "Employee.aspx/Get_Employee_Detail";
                await GetEmployee_Detail(url);
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
            Salary = $("#txtSalary");

            (async function () {
                await Show_Spinner();
                await defaultRun().finally(async () => {
                    await Hide_Spinner();
                })
            })();

            $(document).on("click", "a.delete-link", OnClick_BtnDelete);
            $(document).on("click", "a.update-link", OnClick_update_link);
            $(document).on("click", "#BtnUpdate", OnClick_BtnUpdate);

            Department.change(OnChange_Department);


            OnKeyPressValidation(EmployeeName, validateAlphabeticOrSpace);
            OnKeyPressValidation(FatherName, validateAlphabeticOrSpace);
            OnKeyPressValidation(Mobile, validateMobileNumber);
            OnKeyPressValidation(Pincode, validatePincode);

        });

        async function GetEmployee_Detail(url) {

            try {
                return new Promise((resolve, reject) => {
                    table = $('#tblEmployee').DataTable();

                    if ($.fn.DataTable.isDataTable('#tblEmployee')) {
                        table.destroy();

                    }
                    table = $('#tblEmployee').DataTable(
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
                                    return return_data.data;
                                },
                                "error": function (err) {
                                    reject(err);
                                }
                            },
                            "columns": [
                                { "data": "SlNo", "name": "SlNo", "width": "0rem", "orderable": true },
                                {
                                    "data": "EmployeeId",
                                    "render": function (data, type, row, meta) { // Added parameters
                                        var rowHtml = "";
                                        rowHtml += '<div class="dropdown">';
                                        rowHtml += '<button type="button" class="btn p-0 dropdown-toggle hide-arrow" data-bs-toggle="dropdown"><i class="ri-more-2-line"></i></button>';
                                        rowHtml += '<div class="dropdown-menu">';
                                        rowHtml += '<a class="dropdown-item update-link" name="' + data + '" href="javascript:void(0);" data-bs-toggle="modal" data-bs-target="#EditUpdateEmployeeModal"><i class="menu-icon ri-pencil-line me-1"></i>Edit/Update</a>'; // Changed here
                                        rowHtml += '<a class="dropdown-item delete-link" name="' + data + '" href="javascript:void(0);"><i class="menu-icon ri-delete-bin-6-line me-1"></i>Delete</a>';
                                        rowHtml += '<a class="dropdown-item" target="_blank" href="Employee_IDCard.aspx?EmployeeId=' + data + '"><i class="menu-icon ri-printer-line me-1"></i>ID Card</a>';
                                        rowHtml += '</div>';
                                        rowHtml += '</div>';
                                        return rowHtml;
                                    },
                                    "orderable": false,
                                    "width": "0rem"
                                },
                                { "data": "EmployeeId", "name": "EmployeeId", "autoWidth": true },
                                {
                                    "data": "Photo",
                                    "render": function (data) {

                                        if (data && data !== "") {
                                            return '<img src="/UserLogin_Content/upload/' + data + '" style="width:45px;height:55px;border-radius:5px;border:1px solid #ddd;">';
                                        }
                                        else {
                                            return '<img src="/Images/noimage.png" style="width:45px;height:55px;border-radius:5px;border:1px solid #ddd;">';
                                        }

                                    },
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
                            "initComplete": function (settings, json) {
                                resolve();
                            },
                            "serverSide": true, // Removed quotes around true
                            "processing": true, // Removed quotes around true
                            "ordering": true, // Removed quotes around true
                            "responsive": true,
                            "language": {
                                "processing": "processing...."
                            }
                        });

                })
            } catch (err) {
                console.log(err);
                throw err;
            }



        }


        async function OnClick_BtnDelete() {
            const result = await Confirm("Yes, Delete it!", "Are you sure want to delete?");
            if (result.isConfirmed) {
                try {
                    await Show_Spinner();
                    dataToSend = {
                        EmployeeId: this.name
                    };
                    const response = await Ajax_GetResult("Employee.aspx", "Delete_Employee_Detail", dataToSend);

                    $('#tblEmployee').DataTable().ajax.reload();
                    if (response.d > 0)
                        Success("Deleted", "You have deleted this Visitor successfully");
                    else
                        Failed("Deleted Failed !");

                } catch (err) {
                    console.log(err);
                }
                finally {
                    await Hide_Spinner();
                }
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

        async function OnClick_update_link() {
            try {
                await Show_Spinner();
                $('#EditUpdateEmployeeModal').on('shown.bs.modal', function () {
                    $('#EditUpdateEmployeeModal').modal('show');

                });


                Id = this.name;
                dataToSend = {
                    EmployeeId: this.name
                };
                const response = await Ajax_GetResult("Employee.aspx", "Get_UpdateDetail", dataToSend);
                const data = JSON.parse(response.d);
                console.log(data)

                const item = data[0];

                EmployeeId.val(item.EmployeeId);
                EmployeeName.val(item.EmployeeName);
                Mobile.val(item.Mobile);
                Gender.val(item.Gender).trigger('change');;
                Email.val(item.Email);
                DOB.val(item.DOB);
                AadharNo.val(item.AadharNo);
                FatherName.val(item.FatherName);

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

                await renderDepartment();
                const DepartmentOption = Department.find('option').filter(function () {
                    return $(this).text() === item.Department;
                });
                if (DepartmentOption.length) {
                    Department.val(DepartmentOption.val()).trigger('change');
                }

                await OnChange_Department();
                const DesignationOption = Designation.find('option').filter(function () {
                    return $(this).text() === item.Designation;
                });
                if (DesignationOption.length) {
                    Designation.val(DesignationOption.val()).trigger('change');
                }


                Salary.val(item.Salary);

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
                                    Department: Department.val(),
                                    Designation: Designation.val(),
                                    Salary: Salary.val()
                                }

                                const response = await Ajax_GetResult("Employee.aspx", "Update_Employee_Detail", dataToSend);
                                if (response.d > 0) {
                                    $('#tblEmployee').DataTable().ajax.reload();
                                    $('#EditUpdateEmployeeModal').modal('toggle');
                                    Success("Updated", "Employee Updated Successfully",);
                                }
                                else {
                                    Failed("Employee Updated Failed !")
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

