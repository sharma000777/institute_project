<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true" CodeFile="Add_Expense.aspx.cs" Inherits="Admin_Add_Expense" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Add Expense | Institute Management Software</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row g-6 mb-6">
        <div class="col-md">
            <div class="card">
                <div class="card-header row" style="justify-content: space-between;">
                    <div class="col-md-4">
                        <h5><span class="text-muted fw-light">Master /</span><a href="Expense.aspx"> <span class=" fw-light">Expense /</span></a> Add Expense</h5>
                    </div>
                    <div id="top-right-date" class="col-md-8" style="display: flex; justify-content: end;">
                        <div class="">
                            <a href="Expense.aspx" class="btn btn-primary waves-effect waves-light" style="margin-right: 10px"><i class="menu-icon ri-arrow-left-line"></i>Back</a>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <div class="row g-5 mb-5">
                        <div class="col-lg-8 mx-auto">
                            <div class="row g-6" id="formAuthentication">
                                <div class="col-12 col-md-6">
                                    <div class="form-floating form-floating-outline validation">
                                        <select name="txtExpenseBy" id="txtExpenseBy" class="select2 form-select" data-allow-clear="true">
                                        </select>
                                        <label for="txtExpenseBy">Expense By *</label>
                                    </div>
                                </div>
                                <div class="col-12 col-md-6">
                                    <div class="form-floating form-floating-outline validation">
                                        <select name="txtPurpose" id="txtPurpose" class="select2 form-select" data-allow-clear="true">
                                        </select>
                                        <label for="txtPurpose">Purpose *</label>
                                    </div>
                                </div>
                                <div class="col-12 col-md-6">
                                    <div class="form-floating form-floating-outline validation">
                                        <input type="text" id="txtAmount" name="txtAmount" class="form-control" placeholder="Enter Amount" />
                                        <label for="txtAmount">Amount *</label>
                                    </div>
                                </div>
                                <div class="col-12 col-md-6">
                                    <div class="form-floating form-floating-outline validation">
                                        <input type="text" id="txtRecieverName" name="txtRecieverName" class="form-control" placeholder="Enter Reciever Name" />
                                        <label for="txtRecieverName">Reciever Name *</label>
                                    </div>
                                </div>
                                <div class="col-12 col-md-6">
                                    <div class="form-floating form-floating-outline validation">
                                        <select name="txtPaymentMethod" id="txtPaymentMethod" class="select2 form-select" data-allow-clear="true">
                                            <option value="">Select Mode</option>
                                            <option value="Cash">Cash</option>
                                            <option value="UPI">UPI</option>
                                            <option value="Bank transfers">Bank transfers</option>
                                            <option value="Nifty">Nifty</option>
                                            <option value="Cheque">Cheque</option>
                                        </select>
                                        <label for="txtPaymentMethod">Payment Method *</label>
                                    </div>
                                </div>
                                <div class="col-12 col-md-6">
                                    <div class="form-floating form-floating-outline validation">
                                        <input type="text" id="txtTransactionNo" name="txtTransactionNo" class="form-control" placeholder="Enter Transaction No" />
                                        <label for="txtTransactionNo">Transaction No *</label>
                                    </div>
                                </div>
                                <div class="col-12 col-md-6">
                                    <div class="form-floating form-floating-outline validation">
                                        <input type="text" id="txtBankName" name="txtBankName" class="form-control" placeholder="Enter Bank Name" />
                                        <label for="txtBankName">Bank Name *</label>
                                    </div>
                                </div>
                                <div class="col-12 col-md-6">
                                    <div class="form-floating form-floating-outline validation">
                                        <input type="date" id="txtDate" name="txtDate" class="form-control" />
                                        <label for="txtDate">Date *</label>
                                    </div>
                                </div>
                                <div class="col-12 col-md-12">
                                    <div class="form-floating form-floating-outline validation">
                                        <textarea id="txtRemarks" name="txtRemarks" class="form-control" placeholder="Enter Remarks" style="height: 8rem"></textarea>
                                        <label for="txtRemarks">Remarks (optional)</label>
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

        let ExpenseBy, Purpose, Amount, RecieverName, PaymentMethod, TransactionNo, BankName, txtDate, Remarks;
        var BtnAdd, dataToSend;



        var formAuthentication = document.querySelector("#formAuthentication");
        var formValidationInstance;

        const defaultRun = async () => {
            try {
                await renderExpenseBy();
                await renderPurpose();
                restrictAfterDate();
            } catch (err) {
                console.log(err);
            }
        }

        $(document).ready(function () {

            ExpenseBy = $("#txtExpenseBy");
            Purpose = $("#txtPurpose");
            Amount = $("#txtAmount");
            RecieverName = $("#txtRecieverName");
            PaymentMethod = $("#txtPaymentMethod");
            TransactionNo = $("#txtTransactionNo");
            BankName = $("#txtBankName");
            txtDate = $("#txtDate");
            Remarks = $("#txtRemarks");

            BtnAdd = $("#BtnAdd");

            (async function () {
                await Show_Spinner();
                await defaultRun().finally(async () => {
                    await Hide_Spinner();
                });
            })();


            $(document).on("click", "#BtnAdd", OnClick_BtnAdd);

            OnKeyPressValidation(ExpenseBy, validateAlphabeticOrSpace);
            OnKeyPressValidation(Purpose, validateAlphabeticOrSpace);
            OnKeyPressValidation(RecieverName, validateAlphabeticOrSpace);
            OnKeyPressValidation(BankName, validateAlphabeticOrSpace);
            OnKeyPressValidation(Amount, validatePrice);

            PaymentMethod.change(OnChange_PaymentMethod);

        })
        async function renderExpenseBy() {
            try {
                const response = await Ajax_GetResult_WithoutParameter("Add_Expense.aspx", "Get_ExpenseBy");
                const data = JSON.parse(response.d);
                if (data.length > 0) {
                    ExpenseBy.html('<option value="" Selected>Select Expense By</option>');
                    $.each(data, function (index, item) {
                        ExpenseBy.append($('<option>', {
                            value: item.EmployeeId,
                            text: item.EmployeeName + "( " + item.Mobile + " )"
                        }));
                    });
                }

            } catch (err) {
                console.log(err);
            }
        }
        async function renderPurpose() {
            try {
                const response = await Ajax_GetResult_WithoutParameter("Add_Expense.aspx", "Get_Purpose");
                const data = JSON.parse(response.d);
                if (data.length > 0) {
                    Purpose.html('<option value="" Selected>Select Purpose</option>');
                    $.each(data, function (index, item) {
                        Purpose.append($('<option>', {
                            value: item.Expense_Head,
                            text: item.Expense_Head
                        }));
                    });
                }

            } catch (err) {
                console.log(err);
            }
        }
        async function OnChange_PaymentMethod() {
            if (PaymentMethod.val() == "Cash") {
                TransactionNo.val("Null");
                BankName.val("Null");
                TransactionNo.attr("readOnly", true);
                BankName.attr("readOnly", true);

                formValidationInstance.resetField("txtTransactionNo")
                formValidationInstance.resetField("txtBankName")
            }
            else {
                TransactionNo.attr("readOnly", false);
                BankName.attr("readOnly", false);
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
                                    ExpenseBy: ExpenseBy.val(),
                                    Purpose: Purpose.val(),
                                    Amount: Amount.val(),
                                    RecieverName: RecieverName.val(),
                                    PaymentMethod: PaymentMethod.val(),
                                    TransactionNo: TransactionNo.val(),
                                    BankName: BankName.val(),
                                    txtDate: txtDate.val(),
                                    Remarks: Remarks.val()
                                }

                                const response = await Ajax_GetResult("Add_Expense.aspx", "Add_Expense", dataToSend);
                                if (response.d > 0)
                                    Success_Redirect("Added", "Expense Added Successfully", "Expense.aspx");
                                else
                                    Failed("Expense Added Failed !")


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
        function restrictAfterDate() {
            var currentDate = new Date();
            var tomorrowDate = new Date(currentDate);
            tomorrowDate.setDate(currentDate.getDate());

            var maxDate = tomorrowDate.getFullYear() + '-' + ('0' + (tomorrowDate.getMonth() + 1)).slice(-2) + '-' + ('0' + tomorrowDate.getDate()).slice(-2);

            txtDate.attr('max', maxDate);
        }
        document.addEventListener('DOMContentLoaded', function () {
            // Ensure the form exists before trying to validate it

            if (!formAuthentication) {
                console.error("Form not found!");
                return;
            }
            console.log("Form found:", formAuthentication);
            const PaymentMethodSelect = jQuery(formAuthentication.querySelector('[name="txtPaymentMethod"]'));

            // Initialize the form validation
            formValidationInstance = FormValidation.formValidation(formAuthentication, {
                fields: {
                    txtExpenseBy: {
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
                    txtPurpose: {
                        validators: {
                            notEmpty: {
                                message: "Please enter Purpose"
                            },
                            stringLength: {
                                min: 3,
                                message: "Purpose must be more than 3 characters"
                            }
                        }
                    },
                    txtAmount: {
                        validators: {
                            notEmpty: {
                                message: "Please enter Amount"
                            },
                            numeric: {
                                message: "Please enter a valid number"
                            }
                        }
                    },
                    txtRecieverName: {
                        validators: {
                            notEmpty: {
                                message: "Please enter Reciever Name"
                            },
                            stringLength: {
                                min: 3,
                                message: "Reciever Name must be more than 3 characters"
                            }
                        }
                    },
                    txtPaymentMethod: {
                        validators: {
                            notEmpty: {
                                message: "Please select Payment Method"
                            }
                        }
                    },
                    txtTransactionNo: {
                        validators: {
                            notEmpty: {
                                message: "Please enter Transaction No"
                            },
                            stringLength: {
                                min: 3,
                                message: "Transaction No must be more than 3 characters"
                            }
                        }
                    },
                    txtBankName: {
                        validators: {
                            notEmpty: {
                                message: "Please enter Bank Name"
                            },
                            stringLength: {
                                min: 3,
                                message: "Bank Name must be more than 3 characters"
                            }
                        }
                    },
                    txtDate: {
                        validators: {
                            notEmpty: {
                                message: "Please select Date"
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
            if (PaymentMethodSelect.length) {
                select2Focus(PaymentMethodSelect);
                PaymentMethodSelect.wrap('<div class="position-relative"></div>');
                PaymentMethodSelect.select2({
                    placeholder: "Select Payment Method",
                    dropdownParent: PaymentMethodSelect.parent()
                }).on("change", function () {
                    formValidationInstance.revalidateField("txtPaymentMethod");
                });
            }

        });

    </script>
</asp:Content>

