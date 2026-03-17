<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true" CodeFile="Setting_MyAccount.aspx.cs" Inherits="Admin_Setting_MyAccount" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div class="col-md-12 ">
            <div class="card">
                <div class="nav-align-top card-body">
                    <ul class="nav nav-pills flex-column flex-md-row gap-2 gap-lg-0">
                        <li class="nav-item"><a class="nav-link active" href="javascript:void(0);"><i class="ri-group-line me-1_5"></i>Account</a></li>
                        <li class="nav-item"><a class="nav-link" href="Setting_Security.aspx"><i class="ri-lock-line me-1_5"></i>Security</a></li>
                    </ul>
                </div>
            </div>

            <div class="card mb-6">
                <!-- Account -->
                <div class="card-body">
                    <div class="d-flex align-items-start align-items-sm-center gap-6">
                        <img src="#" alt="user-avatar" class="d-block w-px-100 h-px-100 rounded" id="uploadedAvatar" />
                        <div class="button-wrapper">
                            <label for="upload" class="btn btn-sm btn-primary me-3 mb-4" tabindex="0">
                                <span class="d-none d-sm-block">Upload new photo</span>
                                <i class="ri-upload-2-line d-block d-sm-none"></i>
                                <input type="file" id="upload" class="account-file-input" hidden accept="image/png, image/jpeg" />
                            </label>

                            <div>Allowed JPG, GIF or PNG. Max size of 800K</div>
                        </div>
                    </div>
                </div>
                <div class="card-body pt-0">
                    <div id="formAuthentication">
                        <div class="row mt-1 g-5">
                            <div class="col-md-6">
                                <div class="form-floating form-floating-outline">
                                    <input type="text" id="txtName" name="txtName" class="form-control" placeholder="Enter name" />
                                    <label for="txtName">Name</label>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-floating form-floating-outline">
                                    <input type="text" id="txtEmail" name="txtEmail" class="form-control" placeholder="Enter email" />
                                    <label for="txtEmail">Email</label>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-floating form-floating-outline">
                                    <input type="text" id="txtMobile" name="txtMobile" class="form-control" placeholder="Enter mobile" />
                                    <label for="txtMobile">Mobile</label>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-floating form-floating-outline">
                                    <input type="text" id="txtAddress" name="txtAddress" class="form-control" placeholder="Enter mobile" />
                                    <label for="txtAddress">Address</label>
                                </div>
                            </div>
                            
                        </div>
                        <div class="mt-6">
                            <button id="BtnUpdate" type="button" class="btn btn-primary me-3">Save changes</button>
                        </div>
                    </div>
                </div>
                <!-- /Account -->
            </div>

        </div>
    </div>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <!-- Page JS -->
    <script>

        $(document).ready(function () {
            let uploadedAvatar = document.getElementById("uploadedAvatar");
            const accountFileInput = document.querySelector(".account-file-input");
            const accountImageReset = document.querySelector(".account-image-reset");


            if (uploadedAvatar) {
                const defaultAvatarSrc = uploadedAvatar.src;

                accountFileInput.onchange = () => {
                    if (accountFileInput.files[0]) {
                        uploadedAvatar.src = window.URL.createObjectURL(accountFileInput.files[0]);
                    }
                };

                accountImageReset.onclick = () => {
                    accountFileInput.value = "";
                    uploadedAvatar.src = defaultAvatarSrc;
                };
            }
        })

        let nameElement, emailElement, mobileElement, addressElement, ImageElement, BtnUpdate, BtnReset, dataToSend

        let formAuthentication = document.querySelector("#formAuthentication");
        let formValidationInstance;

        const defaultRun = async () => {
            try {
                await Bind_UserProfile();
            } catch (err) {
                console.log(err);
            }
        }

        $(document).ready(function () {

            nameElement = $("#txtName");
            emailElement = $("#txtEmail");
            mobileElement = $("#txtMobile");
            addressElement = $("#txtAddress");
            ImageElement = $("#upload");
            BtnUpdate = $("#BtnUpdate");
            BtnReset = $("#BtnReset");


            (async function () {
                await Show_Spinner();
                await defaultRun().finally(async () => {
                    await Hide_Spinner();
                })
            })();
            
            OnKeyPressValidation(nameElement, validateAlphabeticOrSpace);
            OnKeyPressValidation(mobileElement, validateMobileNumber);

            $(document).on("click", "#BtnUpdate", OnClick_BtnUpdate);

        })

        async function OnClick_BtnUpdate() {

            if (formAuthentication) {
                formValidationInstance.validate().then(async function (status) {
                    if (status === 'Valid') {
                        try {
                            const result = await Confirm("Yes,Update it!", "Are you sure want to update ?");
                            if (result.isConfirmed) {
                                await Show_Spinner();
                                var UpdaloadImage;
                                if (ImageElement[0].files.length > 0)
                                    UpdaloadImage = ImageElement[0].files[0].name;
                                else
                                    UpdaloadImage = $("#uploadedAvatar").attr("src").replace("../UserLogin_Content/upload/", "");


                                dataToSend = {
                                    Name: nameElement.val(),
                                    Email: emailElement.val(),
                                    Mobile: mobileElement.val(),
                                    Address: addressElement.val(),
                                    Image: UpdaloadImage
                                }
                                const response = await Ajax_GetResult("Setting_MyAccount.aspx", "Update_UserProfile", dataToSend);
                                if (response.d > 0) {
                                    await saveImage($('#upload')[0].files);
                                    await Bind_UserProfile();
                                    await Bind_UserProfile_Master();
                                    Success("Updated", "You have successfully update your profile.");
                                }
                                else {
                                    Failed("Update Failed!");
                                }

                            }
                            
                        } catch (err) {
                            console.log(err);
                        }
                        finally{
                            await Hide_Spinner();
                        }

                    } else {
                        console.log('Form is invalid, display errors.');
                    }
                });
            }

           
        }
        
        async function Bind_UserProfile() {
            try {
                const response = await Ajax_GetResult_WithoutParameter("Setting_MyAccount.aspx", "Get_UserProfile");
                const data = JSON.parse(response.d);
                if (data.length > 0) {
                    nameElement.val(data[0].Name);
                    emailElement.val(data[0].Email);
                    mobileElement.val(data[0].Mobile);
                    addressElement.val(data[0].Address);


                    if (data[0].Image == null) {
                        $("#uploadedAvatar").attr("src", "../UserLogin_Content/upload/1.png");
                    }
                    else {
                        $("#uploadedAvatar").attr("src", "../UserLogin_Content/upload/" + data[0].Image);
                    }
                }
                else {
                    $("#uploadedAvatar").attr("src", "../UserLogin_Content/upload/1.png");
                }
                
            } catch (err) {
                console.log(err);
            }

            
        }
        async function saveImage(MyImage) {
            try {
                return new Promise((resolve, reject) => {
                    var files = MyImage;
                    console.log(files);
                    var data = new FormData();
                    for (var i = 0; i < files.length; i++) {
                        data.append(files[i].name, files[i]);
                    }
                    $.ajax({
                        url: "../FileUploadHandler.ashx",
                        type: "POST",
                        data: data,
                        contentType: false,
                        processData: false,
                        success: function (result) {
                            resolve();
                        },
                        error: function (err) {
                            reject(err);
                        }
                    });
                })
            } catch (err) {
                console.log(err);
                throw err;
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
                    txtName: {
                        validators: {
                            notEmpty: {
                                message: "Please enter name"
                            },
                            stringLength: {
                                min: 6,
                                message: "Username must be more than 6 characters"
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
                    txtMobile: {
                        validators: {
                            notEmpty: {
                                message: "Please enter your mobile no"
                            },
                            regexp: {
                                regexp: /^\d{10}$/,
                                message: "Please enter a valid mobile number with 10 digits"
                            }
                        }
                    },
                    txtAddress: {
                        validators: {
                            notEmpty: {
                                message: "Please enter address"
                            },
                            stringLength: {
                                min: 20,
                                message: "Username must be more than 20 characters"
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

