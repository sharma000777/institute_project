<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true" CodeFile="Add_Designation.aspx.cs" Inherits="Admin_Add_Designation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Add Designation | Institute Management Software</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row g-6 mb-6">
        <div class="col-md">
            <div class="card">
                <div class="card-header row" style="justify-content: space-between;">
                    <div class="col-md-4">
                        <h5><span class="text-muted fw-light">Master /</span><a href="Designation.aspx"> <span class=" fw-light">Designation /</span></a> Add Designation</h5>
                    </div>
                    <div id="top-right-date" class="col-md-8" style="display: flex; justify-content: end;">
                        <div class="">
                            <a href="Designation.aspx" class="btn btn-primary waves-effect waves-light" style="margin-right: 10px"><i class="menu-icon ri-arrow-left-line"></i>Back</a>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <div class="row g-5 mb-5">
                        <div class="col-lg-8 mx-auto">
                            <div class="row g-6" id="formAuthentication">

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
                                        <input type="text" id="txtDesignationName" name="txtDesignationName" class="form-control" placeholder="Enter Designationname" />
                                        <label for="txtDesignationName">Designation Name *</label>
                                    </div>
                                </div>

                                <div class="col-12 text-center">
                                    <button id="BtnAdd" type="button" class="btn btn-primary me-3" style="width: 25%;">Add</button>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <script type="text/javascript">

        var Department,Designation_Name;
        var BtnAdd, dataToSend;



        var formAuthentication = document.querySelector("#formAuthentication");
        var formValidationInstance;

        const defaultRun = async () => {
            try {
                await renderDepartment()
            } catch (err) {
                console.log(err);
            }
        }

        $(document).ready(function () {

            Department = $("#txtDepartment");
            Designation_Name = $('#txtDesignationName');

            BtnAdd = $("#BtnAdd");

            (async function () {
                await Show_Spinner();
                await defaultRun().finally(async () => {
                    await Hide_Spinner();
                });
            })();

            $(document).on("click", "#BtnAdd", OnClick_BtnAdd);

            OnKeyPressValidation(Designation_Name, validateAlphabeticOrSpace);

        })
        async function renderDepartment() {
            try {
                const response = await Ajax_GetResult_WithoutParameter("Add_Designation.aspx", "Get_Department");
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

        async function OnClick_BtnAdd() {
            if (formAuthentication) {
                formValidationInstance.validate().then(async function (status) {
                    if (status === 'Valid') {
                        try {
                            const result = await Confirm("Yes, Add it !", "Are you sure want to Add ?")

                            if (result.isConfirmed) {
                                await Show_Spinner();

                                dataToSend = {
                                    Department: Department.val(),
                                    Designation_Name: Designation_Name.val()
                                }

                                const response = await Ajax_GetResult("Add_Designation.aspx", "Add_Designation", dataToSend);
                                if (response.d > 0)
                                    Success_Redirect("Added", "Designation Added Successfully", "Designation.aspx");
                                else
                                    Failed("Designation Added Failed !")


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
            const DepartmentSelect = jQuery(formAuthentication.querySelector('[name="txtDepartment"]'));

            // Initialize the form validation
            formValidationInstance = FormValidation.formValidation(formAuthentication, {
                fields: {
                    txtDepartment: {
                        validators: {
                            notEmpty: {
                                message: "Please select Department"
                            }
                        }
                    },
                    txtDesignationName: {
                        validators: {
                            notEmpty: {
                                message: "Please enter Designation Name"
                            },
                            stringLength: {
                                min: 3,
                                message: "Designation Name must be more than 3 characters"
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

        });

    </script>
</asp:Content>

