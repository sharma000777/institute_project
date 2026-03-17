<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true" CodeFile="Add_Course.aspx.cs" Inherits="Admin_Add_Course" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Add Course | Institute Management Software</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row g-6 mb-6">
        <div class="col-md">
            <div class="card">
                <div class="card-header row" style="justify-content: space-between;">
                    <div class="col-md-4">
                        <h5><span class="text-muted fw-light">Master /</span><a href="Course.aspx"> <span class=" fw-light">Course /</span></a> Add Course</h5>
                    </div>
                    <div id="top-right-date" class="col-md-8" style="display: flex; justify-content: end;">
                        <div class="">
                            <a href="Course.aspx" class="btn btn-primary waves-effect waves-light" style="margin-right: 10px"><i class="menu-icon ri-arrow-left-line"></i>Back</a>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <div class="row g-5 mb-5">
                        <div class="col-lg-8 mx-auto">
                            <div class="row g-6" id="formAuthentication1">

                                <div class="col-12 col-md-6">
                                    <div class="form-floating form-floating-outline">
                                        <input type="text" id="txtCourseName" name="txtCourseName" class="form-control" placeholder="Enter coursename" />
                                        <label for="txtCourseName">Course Name *</label>
                                    </div>
                                </div>
                                <div class="col-12 col-md-6">
                                    <div class="form-floating form-floating-outline">
                                        <input type="text" id="txtCourseFee" name="txtCourseFee" class="form-control" placeholder="Enter fee" />
                                        <label for="txtCourseFee">Course Fee *</label>
                                    </div>
                                </div>
                                <div class="col-12 col-md-6">
                                    <div class="form-floating form-floating-outline">
                                        <input type="text" id="txtCourseDuration" name="txtCourseDuration" class="form-control" placeholder="Enter duration" />
                                        <label for="txtCourseDuration">Course Duration *</label>
                                    </div>
                                </div>
                                <div class="col-12 col-md-6">
                                    <div class="form-floating form-floating-outline validation">
                                        <div class="select2-primary">
                                            <select id="txtDurationType" name="txtDurationType" class="select2 form-select">
                                                <option value="">Select</option>
                                                <option value="Day">Day</option>
                                                <option value="Month">Month</option>
                                                <option value="Year">Year</option>
                                            </select>
                                        </div>
                                        <label for="txtDurationType">Duration Type *</label>
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

        var Course_Name, Course_Duration, Duration_Type, Fee;
        var BtnAdd, dataToSend;



        var formAuthentication = document.querySelector("#formAuthentication1");
        var formValidationInstance;


        $(document).ready(function () {

            Course_Name = $('#txtCourseName');
            Course_Duration = $('#txtCourseDuration');
            Duration_Type = $('#txtDurationType');
            Fee = $('#txtCourseFee');

            BtnAdd = $("#BtnAdd");



            $(document).on("click", "#BtnAdd", OnClick_BtnAdd);

            OnKeyPressValidation(Course_Duration, validateOnlyNumber);
            OnKeyPressValidation(Fee, validatePrice);

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
                                    Course_Name: Course_Name.val(),
                                    Course_Duration: Course_Duration.val(),
                                    Duration_Type: Duration_Type.val(),
                                    Fee: Fee.val()
                                }

                                const response = await Ajax_GetResult("Add_Course.aspx", "Add_Course", dataToSend);
                                if (response.d > 0)
                                    Success_Redirect("Added", "Course Added Successfully", "Course.aspx");
                                else
                                    Failed("Course Added Failed !")


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
            const DurationTypeSelect = jQuery(formAuthentication.querySelector('[name="txtDurationType"]'));

            // Initialize the form validation
            formValidationInstance = FormValidation.formValidation(formAuthentication, {
                fields: {
                    txtCourseName: {
                        validators: {
                            notEmpty: {
                                message: "Please enter CourseName"
                            },
                            stringLength: {
                                min: 3,
                                message: "CourseName must be more than 3 characters"
                            }
                        }
                    },
                    txtCourseFee: {
                        validators: {
                            notEmpty: {
                                message: "Please enter CourseFee"
                            },
                            regexp: {
                                regexp: /^\d*\.?\d+$/,
                                message: "Please enter a valid positive number"
                            }
                        }
                    },
                    txtCourseDuration: {
                        validators: {
                            notEmpty: {
                                message: "Please enter CourseDuration"
                            },
                            regexp: {
                                regexp: /^\d*\.?\d+$/,
                                message: "Please enter a valid positive number"
                            }
                        }
                    },
                    txtDurationType: {
                        validators: {
                            notEmpty: {
                                message: "Please select Duration Type"
                            }
                        }
                    },

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

            if (DurationTypeSelect.length) {
                select2Focus(DurationTypeSelect);
                DurationTypeSelect.wrap('<div class="position-relative"></div>');
                DurationTypeSelect.select2({
                    placeholder: "Select Duration Type",
                    dropdownParent: DurationTypeSelect.parent()
                }).on("change", function () {
                    formValidationInstance.revalidateField("txtDurationType");
                });
            }
        });

    </script>
</asp:Content>

