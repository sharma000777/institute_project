<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true" CodeFile="Add_Batch.aspx.cs" Inherits="Admin_Add_Batch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Add Batch | Institute Management Software</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row g-6 mb-6">
        <div class="col-md">
            <div class="card">
                <div class="card-header row" style="justify-content: space-between;">
                    <div class="col-md-4">
                        <h5><span class="text-muted fw-light">Master /</span><a href="Batch.aspx"> <span class=" fw-light">Batch /</span></a> Create Batch</h5>
                    </div>
                    <div id="top-right-date" class="col-md-8" style="display: flex; justify-content: end;">
                        <div class="">
                            <a href="Batch.aspx" class="btn btn-primary waves-effect waves-light" style="margin-right: 10px"><i class="menu-icon ri-arrow-left-line"></i>Back</a>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <h4 class="text-center">Batch Info</h4>
                    <div class="row">
                        <div class="card col-lg-8 mx-auto" id="formAuthentication">
                            <!-- 1. Delivery Address -->
                            <div class="row g-6 mb-6">
                                <div class="col-12 col-md-8 offset-md-2">
                                    <div class="form-floating form-floating-outline validation">
                                        <div class="select2-primary">
                                            <select id="txtSession" name="txtSession" class="select2 form-select">
                                            </select>
                                        </div>
                                        <label for="txtSession">Session *</label>
                                    </div>
                                </div>
                                <div class="col-12 col-md-8 offset-md-2">
                                    <div class="form-floating form-floating-outline validation">
                                        <div class="select2-primary">
                                            <select id="txtCourse" name="txtCourse" class="select2 form-select">
                                            </select>
                                        </div>
                                        <label for="txtCourse">Course *</label>
                                    </div>
                                </div>
                                <div class="col-12 col-md-8 offset-md-2">
                                    <div class="form-floating form-floating-outline validation">
                                        <input type="text" id="txtBatchName" name="txtBatchName" class="form-control" placeholder="Enter Batchname" />
                                        <label for="txtBatchName">Batch Name *</label>
                                    </div>
                                </div>
                                <div class="col-12 col-md-4 offset-md-2">
                                    <div class="form-floating form-floating-outline">
                                        <input type="text" id="txtBatchStartTime" class="form-control time-mask" placeholder="hh:mm" />
                                        <label for="txtBatchStartTime">Batch Start Time</label>
                                    </div>
                                    
                                </div>
                                <div class="col-12 col-md-4">
                                    <div class="form-floating form-floating-outline">
                                        <input type="text" id="txtBatchEndTime" class="form-control time-mask" placeholder="hh:mm" />
                                        <label for="txtBatchEndTime">Batch End Time</label>
                                    </div>
                                    
                                </div>
                                 <div class="col-12 col-md-8 offset-md-2">
                                    <div class="form-floating form-floating-outline validation">
                                        <input class="form-control" type="date" id="txtStartDate" name="txtStartDate">
                                        <label for="txtStartDate">Start Date</label>
                                    </div>
                                </div>

                            </div>
                            <div class="row g-6">
                                <div class="col-12 text-center col-md-4 offset-md-4">
                                    <button id="BtnAdd" type="button" class="btn btn-primary me-3" style="width:100%">Create</button>
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

        var Session, Course, BatchName, BatchStartTime, BatchEndTime, StartDate;
        var BtnAdd, dataToSend;



        var formAuthentication = document.querySelector("#formAuthentication");
        var formValidationInstance;

        const defaultRun = async () => {
            try {
                await renderSession();
                await renderCourse();
                time();
            } catch (err) {
                console.log(err);
            }
        }

        $(document).ready(function () {

            Session = $("#txtSession");
            Course = $('#txtCourse');
            BatchName = $('#txtBatchName');
            BatchStartTime = $('#txtBatchStartTime');
            BatchEndTime = $('#txtBatchEndTime');
            StartDate = $('#txtStartDate');

            BtnAdd = $("#BtnAdd");

            (async function () {
                await Show_Spinner();
                await defaultRun().finally(async () => {
                    await Hide_Spinner();
                });
            })();

            $(document).on("click", "#BtnAdd", OnClick_BtnAdd);

            OnKeyPressValidation(Batch_Name, validateAlphabeticOrSpace);

        })
        async function renderSession() {
            try {
                const response = await Ajax_GetResult_WithoutParameter("Add_Batch.aspx", "Get_Session");
                const data = JSON.parse(response.d);
                if (data.length > 0) {
                    Session.html('<option value="" Selected>Select Session</option>');
                    $.each(data, function (index, item) {
                        Session.append($('<option>', {
                            value: item.Id,
                            text: item.SessionStart + " - " + item.SessionEnd
                        }));
                    });
                }

            } catch (err) {
                console.log(err);
            }
        }
        async function renderCourse() {
            try {
                const response = await Ajax_GetResult_WithoutParameter("Add_Batch.aspx", "Get_Course");
                const data = JSON.parse(response.d);
                if (data.length > 0) {
                    Course.html('<option value="" Selected>Select Course</option>');
                    $.each(data, function (index, item) {
                        Course.append($('<option>', {
                            value: item.Id,
                            text: item.Course_Name
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
                                    SessionId: Session.val(),
                                    CourseId: Course.val(),
                                    BatchName: BatchName.val(),
                                    BatchStartTime: BatchStartTime.val(),
                                    BatchEndTime: BatchEndTime.val(),
                                    StartDate: StartDate.val()
                                }

                                const response1 = await Ajax_GetResult("Add_Batch.aspx", "IsExist", dataToSend);
                                if (response1.d > 0) {
                                    Warning("Batch already exist!");
                                }
                                else {
                                    const response = await Ajax_GetResult("Add_Batch.aspx", "Add_Batch", dataToSend);
                                    if (response.d > 0)
                                        Success_Redirect("Created", "Batch Created Successfully", "Batch.aspx");
                                    else
                                        Failed("Batch Created Failed !")
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
        function time() {
            "use strict";

            (function () {
                var n = $("#txtBatchStartTime");
                var o = $("#txtBatchEndTime");
                    
                n && new Cleave(n, {
                    time: true,
                    timePattern: ["h", "m"]
                });
                o && new Cleave(o, {
                    time: true,
                    timePattern: ["h", "m"]
                });


            })();

        }
        document.addEventListener('DOMContentLoaded', function () {
            // Ensure the form exists before trying to validate it

            if (!formAuthentication) {
                console.error("Form not found!");
                return;
            }
            console.log("Form found:", formAuthentication);
            const SessionSelect = jQuery(formAuthentication.querySelector('[name="txtSession"]'));
            const CourseSelect = jQuery(formAuthentication.querySelector('[name="txtCourse"]'));

            // Initialize the form validation
            formValidationInstance = FormValidation.formValidation(formAuthentication, {
                fields: {
                    txtSession: {
                        validators: {
                            notEmpty: {
                                message: "Please select Session"
                            }
                        }
                    },
                    txtCourse: {
                        validators: {
                            notEmpty: {
                                message: "Please select Course"
                            }
                        }
                    },
                    txtBatchName: {
                        validators: {
                            notEmpty: {
                                message: "Please enter Batch Name"
                            },
                            stringLength: {
                                min: 3,
                                message: "Batch Name must be more than 3 characters"
                            }
                        }
                    },
                    txtBatchStartTime: {
                        validators: {
                            notEmpty: {
                                message: "Please select Batch Start Time"
                            }
                        }
                    },
                    txtBatchEndTime: {
                        validators: {
                            notEmpty: {
                                message: "Please select Batch End Time"
                            }
                        }
                    },
                    txtStartDate: {
                        validators: {
                            notEmpty: {
                                message: "Please select Start Date"
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
            if (SessionSelect.length) {
                select2Focus(SessionSelect);
                SessionSelect.wrap('<div class="position-relative"></div>');
                SessionSelect.select2({
                    placeholder: "Select Session",
                    dropdownParent: SessionSelect.parent()
                }).on("change", function () {
                    formValidationInstance.revalidateField("txtSession");
                });
            }
            if (CourseSelect.length) {
                select2Focus(CourseSelect);
                CourseSelect.wrap('<div class="position-relative"></div>');
                CourseSelect.select2({
                    placeholder: "Select Course",
                    dropdownParent: CourseSelect.parent()
                }).on("change", function () {
                    formValidationInstance.revalidateField("txtCourse");
                });
            }

        });

    </script>
</asp:Content>

