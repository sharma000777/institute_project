<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true" CodeFile="Add_Enquiry.aspx.cs" Inherits="Admin_Add_Enquiry" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Add Enquiry | Institute Management Software</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row g-6 mb-6">
        <div class="col-md">
            <div class="card">
                <div class="card-header row" style="justify-content: space-between;">
                    <div class="col-md-4">
                        <h5><span class="text-muted fw-light">Master /</span><a href="Enquiry.aspx"> <span class=" fw-light">Enquiry /</span></a> Add Enquiry</h5>
                    </div>
                    <div id="top-right-date" class="col-md-8" style="display: flex; justify-content: end;">
                        <div class="">
                            <a href="Enquiry.aspx" class="btn btn-primary waves-effect waves-light" style="margin-right: 10px"><i class="menu-icon ri-arrow-left-line"></i>Back</a>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <div class="row g-5 mb-5">
                        <div class="col-lg-8 mx-auto">
                            <div class="card-body row g-6">
                                <div class="row g-5" style="font-size: 1.2rem; text-align: center; margin-bottom: 2rem;">
                                    <div class="col-6 mb-3 ">
                                        <div class="mt-2 mb-2">
                                            <label for="txtCallEnquiry" style="cursor: pointer"><i class="menu-icon tf-icons ri-phone-line"></i>Call</label>
                                            <input type="radio" id="txtCallEnquiry"
                                                name="Customer" class="form-check-input" checked>
                                        </div>
                                    </div>
                                    <div class="col-6 mb-3">
                                        <div class="mt-2 mb-2">
                                            <label for="txtVisitorEnquiry" style="cursor: pointer"><i class="menu-icon tf-icons ri-government-line"></i>Visitor</label>
                                            <input type="radio" id="txtVisitorEnquiry"
                                                name="Customer" class="form-check-input">
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <div class="row g-6" id="formAuthentication1">

                                <div class="col-12 col-md-4">
                                    <div class="form-floating form-floating-outline">
                                        <input type="text" id="txtName" name="txtName" class="form-control" placeholder="Enter name" />
                                        <label for="txtName">Name *</label>
                                    </div>
                                </div>
                                <div class="col-12 col-md-4">
                                    <div class="form-floating form-floating-outline">
                                        <input type="text" id="txtMobile" name="txtMobile" class="form-control" placeholder="Enter Mobile" />
                                        <label for="txtMobile">Mobile *</label>
                                    </div>
                                </div>
                                <div class="col-12 col-md-4">
                                    <div class="form-floating form-floating-outline">
                                        <input type="text" id="txtQualification" name="txtQualification" class="form-control" placeholder="Enter Highest Qualifiaction" />
                                        <label for="txtQualification">Highest Qualification *</label>
                                    </div>
                                </div>
                                <div class="col-12 col-md-6">
                                    <div class="form-floating form-floating-outline">
                                        <div class="select2-primary">
                                            <select id="txtCourseId" name="txtCourseId" class="select2 form-select">
                                            </select>
                                        </div>
                                        <label for="txtCourseId">Course *</label>
                                    </div>
                                </div>
                                <div class="col-12 col-md-6">
                                    <div class="form-floating form-floating-outline">
                                        <input type="date" id="txtFollowUpDate" name="txtFollowUpDate" class="form-control" />
                                        <label for="txtFollowUpDate">Follow Up *</label>
                                    </div>
                                </div>
                                <div class="col-12 col-md-12">
                                    <div class="form-floating form-floating-outline">
                                        <div class="select2-primary">
                                            <select id="txtContactMedia" name="txtContactMedia" class="select2 form-select">
                                            </select>
                                        </div>
                                        <label for="txtContactMedia">Contact Media *</label>
                                    </div>
                                </div>
                                <div class="col-12 col-md-12">
                                    <div class="form-floating form-floating-outline">
                                        <textarea id="txtAddress" name="txtAddress" class="form-control" placeholder="Enter address ..." style="height: 6rem"></textarea>
                                        <label for="txtAddress">Address *</label>
                                    </div>
                                </div>
                                <div class="col-12 col-md-12">
                                    <div class="form-floating form-floating-outline">
                                        <textarea id="txtComment" name="txtComment" class="form-control" placeholder="Enter comments" style="height: 8rem"></textarea>
                                        <label for="txtComment">Comment *</label>
                                    </div>
                                </div>
                                <div class="col-12 col-md-12 hide" id="tblCourseDiv">
                                    <div class="table-responsive text-nowrap">
                                        <table class="table nowrap">
                                            <caption class="ms-4">
                                                List of Course
                                            </caption>
                                            <thead>
                                                <tr>
                                                    <th>SlNo</th>
                                                    <th>Course Name</th>
                                                    <th>Course Duration</th>
                                                    <th>Fee</th>
                                                </tr>
                                            </thead>
                                            <tbody id="tblCourse">
                                                <tr>
                                                    <td></td>
                                                    <td></td>
                                                    <td></td>
                                                    <td></td>
                                                </tr>
                                            </tbody>
                                        </table>

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

        var Name, Mobile, Qualification, CourseId, FollowUpDate, Address, Comment, ContactMedia;
        let EnquiryType,CallEnquiry, VisitorEnquiry;
        var BtnAdd, dataToSend;
        EnquiryType = "Call";


        var formAuthentication = document.querySelector("#formAuthentication1");
        var formValidationInstance;


        const defaultRun = async () => {
            try {
                await renderCourse();
                await renderContactMedia();
                restrictDate();
            } catch (err) {
                console.log(err);
            }
        }

        $(document).ready(function () {
            CallEnquiry = $("#txtCallEnquiry");
            VisitorEnquiry = $("#txtVisitorEnquiry");

            Name = $('#txtName');
            Mobile = $('#txtMobile');
            Qualification = $('#txtQualification');
            CourseId = $('#txtCourseId');
            FollowUpDate = $('#txtFollowUpDate');
            Address = $('#txtAddress');
            Comment = $('#txtComment');
            ContactMedia = $('#txtContactMedia');

            $(document).on("click", "#txtCallEnquiry", OnClick_CallEnquiry);
            $(document).on("click", "#txtVisitorEnquiry", OnClick_VisitorEnquiry);
            BtnAdd = $("#BtnAdd");


            (async function () {
                await Show_Spinner();
                await defaultRun().finally(async () => {
                    await Hide_Spinner();
                })
            })();


            $(document).on("click", "#BtnAdd", OnClick_BtnAdd);

            CourseId.change(OnChange_CourseId);
            Mobile.change(OnChange_Mobile);

            OnKeyPressValidation(Name, validateAlphabeticOrSpace);
            OnKeyPressValidation(Mobile, validateMobileNumber);

        });
        async function OnClick_CallEnquiry() {
            try {
                await Show_Spinner();
                if ($(this).is(":checked")) {
                    EnquiryType = "Call";
                    formValidationInstance.resetForm(true);
                }
                else {

                }
            } catch (err) {
                console.log(err);
            }
            finally {
                await Hide_Spinner();
            }
        }
        async function OnClick_VisitorEnquiry() {
            try {
                await Show_Spinner();
                if ($(this).is(":checked")) {
                    EnquiryType = "Visitor";
                    formValidationInstance.resetForm(true);
                }
                else {

                }
            } catch (err) {
                console.log(err);
            }
            finally {
                await Hide_Spinner();
            }
        }
        async function renderCourse() {
            try {
                const response = await Ajax_GetResult_WithoutParameter("Add_Enquiry.aspx", "Get_Course");
                const data = JSON.parse(response.d);
                if (data.length > 0) {
                    CourseId.html('<option value="" Selected>Select Course</option>');
                    $.each(data, function (index, item) {
                        CourseId.append($('<option>', {
                            value: item.Id,
                            text: item.Course_Name
                        }));
                    });
                }

            } catch (err) {
                console.log(err);
            }
        }
        async function renderContactMedia() {
            try {
                const response = await Ajax_GetResult_WithoutParameter("Add_Enquiry.aspx", "Get_ContactMedia");
                const data = JSON.parse(response.d);
                if (data.length > 0) {
                    ContactMedia.html('<option value="" Selected>Select Contact Media</option>');
                    $.each(data, function (index, item) {
                        ContactMedia.append($('<option>', {
                            value: item.Media_Name,
                            text: item.Media_Name
                        }));
                    });
                }

            } catch (err) {
                console.log(err);
            }
        }
        async function OnChange_CourseId() {
            try {
                await Show_Spinner();
                dataToSend = {
                    Id: CourseId.val()
                }
                const response = await Ajax_GetResult("Add_Enquiry.aspx", "Get_CourseDetail", dataToSend);
                const data = JSON.parse(response.d);
                console.log(data);
                if (data.length > 0) {
                    var html = "";
                    $("#tblCourse").empty();
                    $.each(data, function (index, item) {

                        html += `
                        <tr>
                            <td>${item.SlNo}</td>
                            <td>${item.Course_Name}</td>
                            <td>${item.Course_Duration} ${item.Duration_Type}</td>
                            <td>₹ ${item.Fee}</td>
                        </tr>
                    `;
                    })
                    $("#tblCourse").html(html);
                    $("#tblCourseDiv").removeClass("hide");
                }
                else {
                    $("#tblCourseDiv").addClass("hide");
                }

            } catch (err) {
                console.log(err);
            }
            finally {
                await Hide_Spinner();
            }
        }
        async function OnChange_Mobile() {
            try {
                dataToSend = {
                    Mobile: Mobile.val(),
                }
                const response = await Ajax_GetResult("Add_Enquiry.aspx", "Is_MobileExist", dataToSend);
                if (response.d == 1) {
                    Warning("Mobile no already exist!");
                    Mobile.val("");
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
                                    EnquiryType: EnquiryType,
                                    Name: Name.val(),
                                    Mobile: Mobile.val(),
                                    Qualification: Qualification.val(),
                                    CourseId: CourseId.val(),
                                    FollowUpDate: FollowUpDate.val(),
                                    Address: Address.val(),
                                    Comment: Comment.val(),
                                    ContactMedia: ContactMedia.val()
                                }

                                const response = await Ajax_GetResult("Add_Enquiry.aspx", "Add_Enquiry", dataToSend);
                                if (response.d > 0)
                                    Success_Redirect("Added", "Enquiry Added Successfully", "Enquiry.aspx");
                                else
                                    Failed("Enquiry Added Failed !")


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
        function restrictDate() {
            var currentDate = new Date();
            var tomorrowDate = new Date(currentDate);
            tomorrowDate.setDate(currentDate.getDate());

            var minDate = tomorrowDate.getFullYear() + '-' + ('0' + (tomorrowDate.getMonth() + 1)).slice(-2) + '-' + ('0' + tomorrowDate.getDate()).slice(-2);

            FollowUpDate.attr('min', minDate);
        }
        document.addEventListener('DOMContentLoaded', function () {
            // Ensure the form exists before trying to validate it

            if (!formAuthentication) {
                console.error("Form not found!");
                return;
            }
            console.log("Form found:", formAuthentication);
            const CourseSelect = jQuery(formAuthentication.querySelector('[name="txtCourseId"]'));

            // Initialize the form validation
            formValidationInstance = FormValidation.formValidation(formAuthentication, {
                fields: {
                    txtName: {
                        validators: {
                            notEmpty: {
                                message: "Please enter Name"
                            },
                            stringLength: {
                                min: 3,
                                message: "Name must be more than 3 characters"
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
                    txtQualification: {
                        validators: {
                            notEmpty: {
                                message: "Please enter Qualification"
                            },
                            stringLength: {
                                min: 3,
                                message: "Name must be more than 3 characters"
                            }
                        }
                    },
                    txtCourseId: {
                        validators: {
                            notEmpty: {
                                message: "Please enter course"
                            }
                        }
                    },
                    txtFollowUpDate: {
                        validators: {
                            notEmpty: {
                                message: "Please select Follow Up"
                            }
                        }
                    },
                    txtAddress: {
                        validators: {
                            notEmpty: {
                                message: "Please enter address"
                            },
                            stringLength: {
                                min: 6,
                                message: "address must be more than 6 characters"
                            }

                        }
                    },
                    txtComment: {
                        validators: {
                            notEmpty: {
                                message: "Please enter comment"
                            },
                            stringLength: {
                                min: 10,
                                message: "comment must be more than 10 characters"
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
            if (CourseSelect.length) {
                select2Focus(CourseSelect);
                CourseSelect.wrap('<div class="position-relative"></div>');
                CourseSelect.select2({
                    placeholder: "Select Course",
                    dropdownParent: CourseSelect.parent()
                }).on("change", function () {
                    formValidationInstance.revalidateField("txtCourseId");
                });
            }

        });

    </script>
</asp:Content>

