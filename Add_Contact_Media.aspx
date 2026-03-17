<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true" CodeFile="Add_Contact_Media.aspx.cs" Inherits="Admin_Add_Contact_Media" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <title>Add Contact Media | Institute Management Software</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row g-6 mb-6">
        <div class="col-md">
            <div class="card">
                <div class="card-header row" style="justify-content: space-between;">
                    <div class="col-md-4">
                        <h5><span class="text-muted fw-light">Master /</span><a href="Contact_Media.aspx"> <span class=" fw-light">Contact Media /</span></a> Add Contact Media</h5>
                    </div>
                    <div id="top-right-date" class="col-md-8" style="display: flex; justify-content: end;">
                        <div class="">
                            <a href="Contact_Media.aspx" class="btn btn-primary waves-effect waves-light" style="margin-right: 10px"><i class="menu-icon ri-arrow-left-line"></i>Back</a>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <div class="row g-5 mb-5">
                        <div class="col-lg-8 mx-auto">
                            <div class="row g-6" id="formAuthentication1">

                                <div class="col-12 col-md-6">
                                    <div class="form-floating form-floating-outline">
                                        <input type="text" id="txtContact_MediaName" name="txtContact_MediaName" class="form-control" placeholder="Enter Contact_Medianame" />
                                        <label for="txtContact_MediaName">Media Name *</label>
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

        var Contact_Media_Name;
        var BtnAdd, dataToSend;



        var formAuthentication = document.querySelector("#formAuthentication1");
        var formValidationInstance;


        $(document).ready(function () {

            Contact_Media_Name = $('#txtContact_MediaName');
            
            BtnAdd = $("#BtnAdd");



            $(document).on("click", "#BtnAdd", OnClick_BtnAdd);

            OnKeyPressValidation(Contact_Media_Name, validateAlphabeticOrSpace);

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
                                    Contact_Media_Name: Contact_Media_Name.val() 
                                }

                                const response = await Ajax_GetResult("Add_Contact_Media.aspx", "Add_Contact_Media", dataToSend);
                                if (response.d > 0)
                                    Success_Redirect("Added", "Contact Media Added Successfully", "Contact_Media.aspx");
                                else if (response.d === -1) {
                                    Warning("Already added!");
                                    Contact_Media_Name.val("");
                                }
                                else
                                    Failed("Contact Media Added Failed !")


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
                    txtContact_MediaName: {
                        validators: {
                            notEmpty: {
                                message: "Please enter Contact_Media Name"
                            },
                            stringLength: {
                                min: 3,
                                message: "Contact_Media Name must be more than 3 characters"
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

