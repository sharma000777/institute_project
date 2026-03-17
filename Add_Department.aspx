<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true" CodeFile="Add_Department.aspx.cs" Inherits="Admin_Add_Department" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <title>Add Department | Institute Management Software</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row g-6 mb-6">
        <div class="col-md">
            <div class="card">
                <div class="card-header row" style="justify-content: space-between;">
                    <div class="col-md-4">
                        <h5><span class="text-muted fw-light">Master /</span><a href="Department.aspx"> <span class=" fw-light">Department /</span></a> Add Department</h5>
                    </div>
                    <div id="top-right-date" class="col-md-8" style="display: flex; justify-content: end;">
                        <div class="">
                            <a href="Department.aspx" class="btn btn-primary waves-effect waves-light" style="margin-right: 10px"><i class="menu-icon ri-arrow-left-line"></i>Back</a>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <div class="row g-5 mb-5">
                        <div class="col-lg-8 mx-auto">
                            <div class="row g-6" id="formAuthentication1">

                                <div class="col-12 col-md-6">
                                    <div class="form-floating form-floating-outline">
                                        <input type="text" id="txtDepartmentName" name="txtDepartmentName" class="form-control" placeholder="Enter Departmentname" />
                                        <label for="txtDepartmentName">Department Name *</label>
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

        var Department_Name;
        var BtnAdd, dataToSend;



        var formAuthentication = document.querySelector("#formAuthentication1");
        var formValidationInstance;


        $(document).ready(function () {

            Department_Name = $('#txtDepartmentName');
            
            BtnAdd = $("#BtnAdd");



            $(document).on("click", "#BtnAdd", OnClick_BtnAdd);

            OnKeyPressValidation(Department_Name, validateAlphabeticOrSpace);

        })

        async function OnClick_BtnAdd() {
            if (formAuthentication) {
                formValidationInstance.validate().then(async function (status) {
                    if (status === 'Valid') {
                        try {
                            const result = await Confirm("Yes, Add it !", "Are you sure want to Add ?")

                            if (result.isConfirmed) {
                                await Show_Spinner();

                                dataToSend = {
                                    Department_Name: Department_Name.val() 
                                }

                                const response = await Ajax_GetResult("Add_Department.aspx", "Add_Department", dataToSend);
                                if (response.d > 0)
                                    Success_Redirect("Added", "Department Added Successfully", "Department.aspx");
                                else if (response.d === -1) {
                                    Warning("Already added!");
                                    Department_Name.val("");
                                }
                                else
                                    Failed("Department Added Failed !")


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

            // Initialize the form validation
            formValidationInstance = FormValidation.formValidation(formAuthentication, {
                fields: {
                    txtDepartmentName: {
                        validators: {
                            notEmpty: {
                                message: "Please enter Department Name"
                            },
                            stringLength: {
                                min: 3,
                                message: "Department Name must be more than 3 characters"
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

