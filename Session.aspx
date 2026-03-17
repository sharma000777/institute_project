<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true" CodeFile="Session.aspx.cs" Inherits="Admin_Session" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Session | Institute Management Software</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row g-6 mb-6">
        <div class="col-md">
            <div class="card">
                <div class="card-header row" style="justify-content: space-between;">
                    <div class="col-md-4">
                        <h5><span class="text-muted fw-light">Master /</span> Add Session</h5>
                    </div>
                    <div id="top-right-date" class="col-md-8" style="display: flex; justify-content: end;">
                        <div class="">
                            <a href="Add_Session.aspx" class="btn btn-primary waves-effect waves-light" style="margin-right: 10px"><i class="menu-icon ri-function-add-fill"></i>Add New</a>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <div class="table-responsive text-nowrap">
                        <table class="table nowrap" id="tblSession">
                            <caption class="ms-4">
                                List of Session
                            </caption>
                            <thead>
                                <tr>
                                    <th>SlNo</th>
                                    <th>Action</th>
                                    <th>Session</th>
                                </tr>
                            </thead>
                        </table>

                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Edit User Modal -->
    <div class="modal fade" id="AddUpdateModal" tabindex="-1" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
        <div class="modal-dialog modal-dialog-centered modal-lg modal-simple modal-edit-user">
            <div class="modal-content">
                <div class="modal-body p-0">
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    <div class="text-center mb-6">
                        <h4 class="mb-2">Edit / Update Session</h4>
                    </div>
                    <div class="row g-5" id="formAuthentication">
                        <div class="col-12 col-md-5">
                            <div class="form-floating form-floating-outline mb-6">
                                <input type="text" id="txtSessionStart" name="txtSessionStart" class="form-control date-mask" placeholder="YYYY" />
                                <label for="txtSessionStart">Session Start *</label>
                            </div>
                        </div>
                        <div class="col-12 col-md-2 d-flex justify-content-center align-items-center">
                            <h6>To</h6>
                        </div>
                        <div class="col-12 col-md-5">
                            <div class="form-floating form-floating-outline mb-6">
                                <input type="text" id="txtSessionEnd" name="txtSessionEnd" class="form-control date-mask" placeholder="YYYY" />
                                <label for="txtSessionEnd">Session End *</label>
                            </div>
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

        let Id, SessionStart, SessionEnd;
        let table, url, BtnAdd, BtnUpdate, dataToSend;

        let formAuthentication = document.querySelector("#formAuthentication");
        let formValidationInstance;

        const defaultRun = async () => {
            try {
                var url = "Session.aspx/Get_Session_Master";
                await GetSession(url);
                date();
            } catch (err) {
                console.log(err);
            }
        }

        $(document).ready(function () {

            SessionStart = $('#txtSessionStart');
            SessionEnd = $('#txtSessionEnd');

            BtnUpdate = $("#BtnUpdate");

            (async function () {
                await Show_Spinner();
                await defaultRun().finally(async () => {
                    await Hide_Spinner();
                })
            })();


            $(document).on("click", "a.delete-link", OnClick_BtnDelete);
            $(document).on("click", "a.update-link", OnClick_update_link);
            $(document).on("click", "#BtnUpdate", OnClick_BtnUpdate);


        });
        async function GetSession(url) {

            try {
                return new Promise((resolve, reject) => {
                    table = $('#tblSession').DataTable();

                    if ($.fn.DataTable.isDataTable('#tblSession')) {
                        table.destroy();

                    }
                    table = $('#tblSession').DataTable(
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
                                    "data": "Id",
                                    "render": function (data, type, row, meta) { // Added parameters
                                        var row = "";
                                        row += '<div class="dropdown">';
                                        row += '<button type="button" class="btn p-0 dropdown-toggle hide-arrow" data-bs-toggle="dropdown"><i class="ri-more-2-line"></i></button>';
                                        row += '<div class="dropdown-menu">';
                                        row += '<a class="dropdown-item update-link" name="' + data + '" href="javascript:void(0);" data-bs-toggle="modal" data-bs-target="#AddUpdateModal"><i class="menu-icon ri-pencil-line me-1"></i>Edit/Update</a>'; // Changed here
                                        row += '<a class="dropdown-item delete-link" name="' + data + '" href="javascript:void(0);"><i class="menu-icon ri-delete-bin-6-line me-1"></i>Delete</a>';
                                        row += '</div>';
                                        row += '</div>';
                                        return row;
                                    },
                                    "orderable": false,
                                    "width": "0rem"
                                },
                                {
                                    "data": "SessionStart",
                                    "render": function (data, type, row, meta) { // Added parameters
                                        var rowHtml = "";
                                        rowHtml = data + " - " + row.SessionEnd;
                                        return rowHtml;
                                    },
                                    "orderable": false,
                                    "autoWidth": true
                                },
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
                        Id: this.name
                    };
                    const response = await Ajax_GetResult("Session.aspx", "Delete_Session_Master", dataToSend);

                    $('#tblSession').DataTable().ajax.reload();
                    if (response.d > 0)
                        Success("Deleted", "You have deleted this Session successfully");
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

        async function OnClick_update_link() {
            try {
                await Show_Spinner();

                $('#AddUpdateModal').on('shown.bs.modal', function () {
                    $('#AddUpdateModal').modal('show');

                });


                Id = this.name;
                dataToSend = {
                    Id: this.name
                };
                const response = await Ajax_GetResult("Session.aspx", "Get_UpdateDetail", dataToSend);
                const data = JSON.parse(response.d);
                console.log(data)
                SessionStart.val(data[0].SessionStart);
                SessionEnd.val(data[0].SessionEnd);


            } catch (err) {
                console.log(err);
            }
            finally {
                await Hide_Spinner();
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
                                    Id: Id,
                                    SessionStart: SessionStart.val(),
                                    SessionEnd: SessionEnd.val()
                                }

                                const response = await Ajax_GetResult("Session.aspx", "Update_Session_Master", dataToSend);
                                if (response.d > 0) {
                                    $('#tblSession').DataTable().ajax.reload();
                                    $('#AddUpdateModal').modal('toggle');
                                    Success("Updated", "Session Updated Successfully",);
                                }
                                else {
                                    Failed("Updated Failed !")
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
        function date() {
            "use strict";

            (function () {
                var a = $("#txtSessionStart");
                var b = $("#txtSessionEnd");

                a && new Cleave(a, {
                    date: true,
                    delimiter: "-",
                    datePattern: ["Y"]
                });
                b && new Cleave(b, {
                    date: true,
                    delimiter: "-",
                    datePattern: ["Y"]
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

            // Initialize the form validation
            formValidationInstance = FormValidation.formValidation(formAuthentication, {
                fields: {
                    txtSessionStart: {
                        validators: {
                            notEmpty: {
                                message: "Please select Session Start"
                            }
                        }
                    },
                    txtSessionEnd: {
                        validators: {
                            notEmpty: {
                                message: "Please select Session End"
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

