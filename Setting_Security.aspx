<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true" CodeFile="Setting_Security.aspx.cs" Inherits="Admin_Setting_Security" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="nav-align-top card-body">
                    <ul class="nav nav-pills flex-column flex-md-row gap-2 gap-lg-0">
                        <li class="nav-item"><a class="nav-link" href="Setting_MyAccount.aspx"><i class="ri-group-line me-1_5"></i>Account</a></li>
                        <li class="nav-item"><a class="nav-link active" href="javascript:void(0);"><i class="ri-lock-line me-1_5"></i>Security</a></li>

                    </ul>
                </div>
            </div>
            <!-- Change Password -->
            <div class="card mb-6">
                <h5 class="card-header">Change Password</h5>
                <div class="card-body pt-1">
                    <div id="formAuthentication">
                        <div class="row">
                            <div class="mb-5 col-md-6 form-password-toggle">
                                <div class="input-group input-group-merge">
                                    <div class="form-floating form-floating-outline">
                                        <input class="form-control" type="password" name="txtCurrentPassword" id="txtCurrentPassword" placeholder="&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;" />
                                        <label for="txtCurrentPassword">Current Password</label>
                                    </div>
                                    <span class="input-group-text cursor-pointer"><i class="ri-eye-off-line ri-20px"></i></span>
                                </div>
                            </div>
                        </div>
                        <div class="row g-5 mb-6">
                            <div class="col-md-6 form-password-toggle">
                                <div class="input-group input-group-merge">
                                    <div class="form-floating form-floating-outline">
                                        <input class="form-control" type="password" id="txtNewPassword" name="txtNewPassword" placeholder="&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;" />
                                        <label for="txtNewPassword">New Password</label>
                                    </div>
                                    <span class="input-group-text cursor-pointer"><i class="ri-eye-off-line ri-20px"></i></span>
                                </div>
                            </div>
                            <div class="col-md-6 form-password-toggle">
                                <div class="input-group input-group-merge">
                                    <div class="form-floating form-floating-outline">
                                        <input class="form-control" type="password" name="txtConfirmPassword" id="txtConfirmPassword" placeholder="&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;" />
                                        <label for="txtConfirmPassword">Confirm New Password</label>
                                    </div>
                                    <span class="input-group-text cursor-pointer"><i class="ri-eye-off-line ri-20px"></i></span>
                                </div>
                            </div>
                        </div>
                        <h6 class="text-body">Password Requirements:</h6>
                        <ul class="ps-4 mb-0">
                            <li class="mb-4">Minimum 8 characters long - the more, the better</li>
                            <li class="mb-4">At least one lowercase character</li>
                            <li>At least one number, symbol, or whitespace character</li>
                        </ul>
                        <div class="mt-6">
                            <button id="BtnUpdate" type="button" class="btn btn-primary me-3">Save changes</button>
                        </div>
                    </div>
                </div>
            </div>
            <!--/ Change Password -->
        </div>
    </div>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    
    <script>
        let CurrentPass, NewPass, ConfirmPass;

        let formAuthentication = document.querySelector("#formAuthentication");
        let formValidationInstance;

        
        $(document).ready(function () {

            CurrentPass = $("#txtCurrentPassword");
            NewPass = $("#txtNewPassword");
            ConfirmPass = $("#txtConfirmPassword");

            $(document).on("click", "#BtnUpdate", OnClick_BtnUpdate);

        })
        async function OnClick_BtnUpdate() {
            if (formAuthentication) {
                formValidationInstance.validate().then(async function (status) {
                    if (status === 'Valid') {
                        await Show_Spinner();
                        try {
                            const response1 = await Match_CurrentPass();
                            if (response1 == "1") {
                                const result = await Confirm("Yes,Update it!", "Are you sure want to update ?");
                                if (result.isConfirmed) {
                                    const response2 = await Update_NewPass();
                                    if (response2 == 1) {
                                        Success("Updated", "Your password has been changed successfully");
                                        formValidationInstance.resetForm(true);
                                    }
                                    else {
                                        Failed("Updated failed!");
                                    }
                                }
                            }
                            else {
                                Warning("Please enter your correct current password!");
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
        async function Match_CurrentPass() {
            try {
                const response = await Ajax_GetResult_WithoutParameter("Setting_Security.aspx", "Get_CurrentPass");
                if (response.d == CurrentPass.val())
                    return("1");
                else
                    return ("0");

            } catch (err) {
                console.log(err);
                return "0";
            }
            
        }
        async function Update_NewPass() {
            try {
                dataToSend = {
                    Password: NewPass.val()
                }
                const response = await Ajax_GetResult("Setting_Security.aspx", "Update_NewPass", dataToSend);
                return response.d;
            } catch (err) {
                console.log(err);
                return "0";
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
                    txtCurrentPassword: {
                        validators: {
                            notEmpty: {
                                message: "Please enter current password"
                            },
                            stringLength: {
                                min: 1,
                                message: "Password must be more than 1 characters"
                            }
                        }
                    },
                    txtNewPassword: {
                        validators: {
                            notEmpty: {
                                message: "Please enter new password"
                            },
                            stringLength: {
                                min: 8,
                                message: "Password must be more than 8 characters"
                            }
                        }
                    },
                    txtConfirmPassword: {
                        validators: {
                            notEmpty: {
                                message: "Please confirm new password"
                            },
                            identical: {
                                compare: function () {
                                    return formAuthentication.querySelector('[name="txtNewPassword"]').value;
                                },
                                message: "The password and its confirm are not the same"
                            },
                            stringLength: {
                                min: 8,
                                message: "Password must be more than 8 characters"
                            }
                        }
                    },
                    
                },
                plugins: {
                    trigger: new FormValidation.plugins.Trigger(),
                    bootstrap5: new FormValidation.plugins.Bootstrap5({
                        eleValidClass: "",
                        rowSelector: ".input-group-merge"
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

