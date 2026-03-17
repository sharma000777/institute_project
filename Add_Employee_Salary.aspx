<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true" CodeFile="Add_Employee_Salary.aspx.cs" Inherits="Admin_Add_Employee_Salary" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <title>Add Employee Salary | Institute Management Software</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row g-6 mb-6">
        <div class="col-md">
            <div class="card">
                <div class="card-header row" style="justify-content: space-between;">
                    <div class="col-md-8">
                        <h5><span class="text-muted fw-light">Employee Section /</span><a href="Employee_Salary.aspx"> <span class=" fw-light">Employee Salary /</span></a> Add Employee Salary</h5>
                    </div>
                    <div id="top-right-date" class="col-md-4" style="display: flex; justify-content: end;">
                        <div class="">
                            <a href="Employee_Salary.aspx" class="btn btn-primary waves-effect waves-light" style="margin-right: 10px"><i class="menu-icon ri-arrow-left-line"></i>Back</a>
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
                                        <h3 class="text-center" style="letter-spacing: 1px; text-transform: uppercase; font-weight: 600; font-size: 22px;">Employee Salary</h3>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="card col-lg-8 mx-auto" id="formAuthentication">
                                    <div class="row g-6">
                                        <div class="col-12 col-md-6">
                                            <div class="form-floating form-floating-outline validation">
                                                <select name="txtSearchEmployee" id="txtSearchEmployee" class="select2 form-select" data-allow-clear="true">
                                                </select>
                                                <label for="txtSearchEmployee">Search Employee</label>
                                            </div>
                                        </div>
                                    </div>
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
                                                <input type="text" id="txtEmployeeName" name="txtEmployeeName" class="form-control" placeholder="Enter Employee name" readonly />
                                                <label for="txtEmployeeName">Employee Name</label>
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-6">
                                            <div class="form-floating form-floating-outline validation">
                                                <input type="text" id="txtMobile" name="txtMobile" class="form-control" placeholder="Enter mobile" readonly />
                                                <label for="txtMobile">Mobile</label>
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-6">
                                            <div class="form-floating form-floating-outline validation">
                                                <input type="text" id="txtEmail" name="txtEmail" class="form-control" placeholder="Enter email" readonly />
                                                <label for="txtEmail">Email</label>
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-6">
                                            <div class="form-floating form-floating-outline validation">
                                                <input type="text" id="txtDepartment" name="txtDepartment" class="form-control" placeholder="Enter email" readonly />
                                                <label for="txtDepartment">Department</label>
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-6">
                                            <div class="form-floating form-floating-outline validation">
                                                <input type="text" id="txtDesignation" name="txtDesignation" class="form-control" placeholder="Enter email" readonly />
                                                <label for="txtDesignation">Designation</label>
                                            </div>
                                        </div>

                                    </div>
                                    <hr>
                                    <!-- 2. Delivery Type -->
                                    <h5 class="my-6">2. Salary Detail</h5>
                                    <div class="row g-6">
                                        <div class="col-12 col-md-7">
                                            <div class="form-floating form-floating-outline validation">
                                                <input type="text" id="txtTotalSalary" name="txtTotalSalary" class="form-control" placeholder="Enter salary" readonly />
                                                <label for="txtTotalSalary">Total Salary *</label>
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-6">
                                            <div class="form-floating form-floating-outline validation">
                                                <div class="select2-primary">
                                                    <select id="txtMonth" name="txtMonth" class="select2 form-select">
                                                    </select>
                                                </div>
                                                <label for="txtMonth">Month *</label>
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-6">
                                            <div class="form-floating form-floating-outline validation">
                                                <input type="text" id="txtTotalDays" name="txtTotalDays" class="form-control" placeholder="Enter total days" readonly />
                                                <label for="txtTotalDays">Days / Month</label>
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-6">
                                            <div class="form-floating form-floating-outline validation">
                                                <input type="text" id="txtWorkingDays" name="txtWorkingDays" class="form-control" placeholder="Enter working days" />
                                                <label for="txtWorkingDays">No Of Working Days *</label>
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-6">
                                            <div class="form-floating form-floating-outline validation">
                                                <input type="text" id="txtSalary" name="txtSalary" class="form-control" placeholder="Enter salary"  readonly/>
                                                <label for="txtSalary">Salary *</label>
                                            </div>
                                        </div>
                                        
                                    </div>
                                    <hr>
                                    
                                    <div class="row g-6">
                                        <div class="col-12 text-center">
                                            <button id="BtnAdd" type="button" class="btn btn-primary me-3 waves-effect waves-light">Add Salary</button>
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

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <script type="text/javascript">

        let SearchEmployee;

        let EmployeeId, EmployeeName, Mobile, Email, Department, Designation, TotalSalary, Month, TotalDays, WorkingDays, Salary;
        var BtnAdd, dataToSend;

        let formAuthentication = document.querySelector("#formAuthentication");
        let formValidationInstance;

        const defaultRun = async () => {
            try {
                await renderSearchEmployee();
                await renderMonthDay();
            } catch (err) {
                console.log(err);
            }
        }

        $(document).ready(function () {

           
            SearchEmployee = $("#txtSearchEmployee");
            EmployeeId = $("#txtEmployeeId");
            EmployeeName = $("#txtEmployeeName");
            Mobile = $("#txtMobile");
            Email = $("#txtEmail");
            Department = $("#txtDepartment");
            Designation = $("#txtDesignation");

            TotalSalary = $("#txtTotalSalary");
            Month = $("#txtMonth");
            TotalDays = $("#txtTotalDays");
            WorkingDays = $("#txtWorkingDays");
            Salary = $("#txtSalary");

            (async function () {
                await Show_Spinner();
                await defaultRun().finally(async () => {
                    await Hide_Spinner();
                });
            })();

            $(document).on("click", "#BtnAdd", OnClick_BtnAdd);

            SearchEmployee.change(OnClick_SearchEmployee);
            WorkingDays.keyup(OnClick_WorkingDays);

            OnKeyPressValidation(WorkingDays, validateOnlyNumber);

        })
        
        
        

        async function renderSearchEmployee() {
            try {
                const response = await Ajax_GetResult_WithoutParameter("Add_Employee_Salary.aspx", "Get_SearchEmployee");
                const data = JSON.parse(response.d);
                if (data.length > 0) {
                    console.log(data)
                    SearchEmployee.html('<option value="" Selected>Select Employee</option>');
                    $.each(data, function (index, item) {
                        SearchEmployee.append($('<option>', {
                            value: item.EmployeeId,
                            text: item.EmployeeName + " (" + item.Mobile+")"
                        }));
                    });
                }

            } catch (err) {
                console.log(err);
            }
        }

        async function OnClick_SearchEmployee() {
            try {
                await Show_Spinner();
                dataToSend = {
                    EmployeeId: SearchEmployee.val()
                };
                const response = await Ajax_GetResult("Add_Employee_Salary.aspx", "Get_EmployeeDetail", dataToSend);
                const data = JSON.parse(response.d);
                console.log(data)

                const item = data[0];

                EmployeeId.val(item.EmployeeId);
                EmployeeName.val(item.EmployeeName);
                Mobile.val(item.Mobile);
                Email.val(item.Email);
                Department.val(item.Department);
                Designation.val(item.Designation);
                TotalSalary.val(item.Salary);

            } catch (err) {
                console.log(err);
            }
            finally {
                await Hide_Spinner();
            }
        }

        async function renderMonthDay() {
            var months = [
                { name: "January", days: 31 },
                { name: "February", days: 28 }, // 29 in leap years
                { name: "March", days: 31 },
                { name: "April", days: 30 },
                { name: "May", days: 31 },
                { name: "June", days: 30 },
                { name: "July", days: 31 },
                { name: "August", days: 31 },
                { name: "September", days: 30 },
                { name: "October", days: 31 },
                { name: "November", days: 30 },
                { name: "December", days: 31 }
            ];

            // Populate the txtMonth select element
            $.each(months, function (index, month) {
                $('#txtMonth').append($('<option>', {
                    value: month.name,
                    text: month.name
                }));
            });

            // Adjust February days for leap years
            function isLeapYear(year) {
                return (year % 4 === 0 && year % 100 !== 0) || (year % 400 === 0);
            }

            var currentYear = new Date().getFullYear();
            if (isLeapYear(currentYear)) {
                months[1].days = 29; // Update February to 29 days
            }

            // Update the txtTotalDays input when a month is selected
            $('#txtMonth').on('change', function () {
                var selectedMonth = $(this).val();
                var days = months.find(function (month) {
                    return month.name === selectedMonth;
                }).days;
                $('#txtTotalDays').val(days);
            });

            // Trigger change event to set the initial days when the page loads
            $('#txtMonth').trigger('change');
        }
        async function OnClick_WorkingDays() {

            // Get the number of working days from the input
            const totalDays = parseInt($('#txtTotalDays').val());
            const workingDays = parseInt($('#txtWorkingDays').val());

            // Get the actual salary from the input
            const actualSalary = parseFloat($('#txtTotalSalary').val());

            
            if (isNaN(workingDays) || workingDays < 0) {
                alert("Please enter a valid number of working days.");
                return;
            }

            if (isNaN(actualSalary) || actualSalary <= 0) {
                alert("Please enter a valid salary.");
                return;
            }

            // Calculate the daily rate
            const dailyRate = actualSalary / totalDays;

            // Calculate the salary
            const salary = workingDays * dailyRate;

            // Update the salary input field with the calculated salary
            $('#txtSalary').val(parseFloat(salary).toFixed(2));
        }
        async function OnClick_BtnAdd() {
            if (formAuthentication) {
                formValidationInstance.validate().then(async function (status) {
                    if (status === 'Valid') {
                        try {

                            dataToSend1 = {
                                EmployeeId: EmployeeId.val(),
                                Month: Month.val()
                            }
                            const response1 = await Ajax_GetResult("Add_Employee_Salary.aspx", "IsExist", dataToSend1);
                            if (response1.d == 1) {
                                Warning("You have already added salary for this month !");
                            }
                            else {
                                const result = await Confirm("Yes, Add it !", "Are you sure want to add salary ?")

                                if (result.isConfirmed) {
                                    await Show_Spinner();

                                    dataToSend = {
                                        EmployeeId: EmployeeId.val(),
                                        TotalSalary: TotalSalary.val(),
                                        Month: Month.val(),
                                        TotalDays: TotalDays.val(),
                                        WorkingDays: WorkingDays.val(),
                                        Salary: Salary.val()
                                    }
                                    console.log(dataToSend);
                                    var response = await Ajax_GetResult("Add_Employee_Salary.aspx", "Create_Employee_Salary", dataToSend);
                                    if (response.d > 0) {
                                        Success_Redirect("Added", "Added Successfully", "Employee_Salary.aspx");
                                    }
                                    else
                                        Failed("Added Failed !")
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


            const SearchEmployeeSelect = jQuery(formAuthentication.querySelector('[name="txtSearchEmployee"]'));

            // Initialize the form validation
            formValidationInstance = FormValidation.formValidation(formAuthentication, {
                fields: {
                    txtSearchEmployee: {
                        validators: {
                            notEmpty: {
                                message: "Please select Employee"
                            }
                        }
                    },
                    txtWorkingDays: {
                        validators: {
                            notEmpty: {
                                message: "Please enter working days"
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

            if (SearchEmployeeSelect.length) {
                select2Focus(SearchEmployeeSelect);
                SearchEmployeeSelect.wrap('<div class="position-relative"></div>');
                SearchEmployeeSelect.select2({
                    placeholder: "Select Employee",
                    dropdownParent: SearchEmployeeSelect.parent()
                }).on("change", function () {
                    formValidationInstance.revalidateField("txtSearchEmployee");
                });
            }

        });
    </script>

</asp:Content>

