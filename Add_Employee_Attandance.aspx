<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true" CodeFile="Add_Employee_Attandance.aspx.cs" Inherits="Admin_Add_Employee_Attandance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
       
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <style>
        .attendance-box {
            display: inline-block;
            width: 40px;
            height: 40px;
            line-height: 40px;
            text-align: center;
            border: 2px solid #ccc;
            cursor: pointer;
            user-select: none;
            margin-right: 10px;
            border-radius: 6px;
            transition: background-color 0.3s, border-color 0.3s;
        }
        .selected {
            border-color: #3b82f6;
            background-color: #3b82f6;
            color: white;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

            <div class="container mx-auto p-4 bg-white rounded-md shadow-xl border-2 border-[#15a3b2]">
            <div class="flex justify-between">
               <span class="text-xl">Employee Section / <b>Employee Attendance</b></span>
                <h2 class="text-xl font-bold text-white bg-[#15a3b2] rounded p-2 text-center mb-4 shadow-xl">
                    <i class="fas fa-check-circle"></i> Mark Employee Attendance
                </h2>
            </div>

            <!-- 🔍 Search Box -->
            <div class="mb-4 flex space-x-4 p-2">
                <!--
                <label class="text-sm font-semibold">Search :</label>
                <div class="lg:w-1/4 w-1/2">
                   <asp:TextBox runat="server" ID="txtname" OnTextChanged="txtname_TextChanged" placeholder=" Name, Employee ID, Mobile" class="border-2 border-[#15a3b2] p-2 rounded w-full"></asp:TextBox>
                   
                </div>
                -->
                   <div>
                       <label class="text-sm font-semibold">Department :</label>
                <asp:DropDownList ID="ddlDepartment" runat="server" AutoPostBack="true"  OnSelectedIndexChanged="ddlCourse_SelectedIndexChanged"
                    CssClass="text-white  rounded bg-[#15a3b7] border-2 border-[#15a3b2] p-2">
                
                </asp:DropDownList>
                   </div>
                <div>
                    <label class="text-sm font-semibold">Designation :</label>
                <asp:DropDownList ID="ddlDesignation" runat="server" AutoPostBack="true"  OnSelectedIndexChanged="ddlDesignation_SelectedIndexChanged"
                    CssClass="text-white  rounded bg-[#15a3b7] border-2 border-[#15a3b2] p-2">
                
                </asp:DropDownList>
                </div>
            </div>

                      <div class="bg-gray-50 p-4 rounded-lg shadow-sm border-2 border-gray-400 mb-6">
    <h3 class="text-lg font-medium text-gray-800 mb-3">Attendance Status Legend</h3>
    <div class="flex flex-wrap gap-4">
        <!-- Present -->
        <div class="flex items-center">
            <div class="w-5 h-5 rounded-full border-2 border-green-500 bg-green-100 mr-2"></div>
            <span class="text-sm font-medium text-gray-700">P - Present</span>
        </div>
        
        <!-- Absent -->
        <div class="flex items-center">
            <div class="w-5 h-5 rounded-full border-2 border-red-500 bg-red-100 mr-2"></div>
            <span class="text-sm font-medium text-gray-700">A - Absent</span>
        </div>
        
        <!-- Unexcused Leave -->
        <div class="flex items-center">
            <div class="w-5 h-5 rounded-full border-2 border-blue-500 bg-blue-100 mr-2"></div>
            <span class="text-sm font-medium text-gray-700">U - Unexcused Leave</span>
        </div>
        
        <!-- Excused Leave -->
        <div class="flex items-center">
            <div class="w-5 h-5 rounded-full border-2 border-yellow-500 bg-yellow-100 mr-2"></div>
            <span class="text-sm font-medium text-gray-700">E - Excused Leave</span>
        </div>
    </div>
</div>

            <!-- 📋 Attendance Table -->
            <div class="w-full overflow-auto min-h-[50vh] relative">
                <asp:Repeater ID="rptAttendance" runat="server">
                    <HeaderTemplate>
                        <table id="attendanceTable" class="w-full border border-[#15a3b2] table-auto border-collapse">
                            <thead class="bg-[#15a3b2] text-white sticky top-0">
                                <tr class="text-center">
                                    <th class="p-2 border">S.N.</th>
                                    <th class="p-2 border">IMG</th>
                                    <th class="p-2 border">Emp. ID</th>
                                    <th class="p-2 border">Name</th>
                                    <th class="p-2 border">Gender</th>
                                    <th class="p-2 border">Mobile</th>
                                
                                    <th class="p-2 border">Department</th>
                                    <th class="p-2 border">Designation</th>
                                    <th class="p-2 border">Mark</th>
                                </tr>
                            </thead>
                            <tbody>
                    </HeaderTemplate>

                    <ItemTemplate>
                        <tr class="text-center border">
                            <td class="p-2 border"><%# Container.ItemIndex + 1 %></td>
                                <td class="p-2 border"><img alt="Img" width="50" src='../UserLogin_Content/upload/<%# Eval("Photo") %>'/></td>
                            <td class="p-2 border"><%# Eval("EmployeeId") %></td>
                          
                            <td class="p-2 border"><%# Eval("EmployeeName") %></td>
                            <td class="p-2 border"><%# Eval("Gender") %></td>
                            <td class="p-2 border"><%# Eval("Mobile") %></td>
                      
                            <td class="p-2 border"><%# Eval("Department") %></td>
                            <td class="p-2 border"><%# Eval("Designation") %></td>
                            <td class="p-2 border">
                                <div class="flex space-x-2 mt-1 justify-center">
                                    <div class="attendance-box" data-id='<%# Eval("EmployeeId") %>' data-status="P">P</div>
                                    <div class="attendance-box" data-id='<%# Eval("EmployeeId") %>' data-status="A">A</div>
                                     <div class="attendance-box" data-id='<%# Eval("EmployeeId") %>' data-status="U">U</div>
                                    <div class="attendance-box" data-id='<%# Eval("EmployeeId") %>' data-status="E">E</div>
                                    <input type="hidden" name="attend_<%# Eval("EmployeeId") %>" id="attend_<%# Eval("EmployeeId") %>" value="" />
                                    <asp:HiddenField ID="HiddenField" runat="server" Value='<%# Eval("EmployeeId") %>' />
                                </div>
                            </td>
                        </tr>
                    </ItemTemplate>

                    <FooterTemplate>
                            </tbody>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
            </div>

            <!-- 🔘 Submit & Controls -->
            <div class="mt-4 flex items-center space-x-4">
                <asp:Button ID="btnSubmit" runat="server" Text="✅ Submit Attendance" CssClass="cursor-pointer bg-[#15a3b7] text-lg font-bold text-white px-4 py-2 rounded" OnClick="btnSubmit_Click" />
                <asp:Label ID="lblSelectedCount" runat="server" CssClass="text-gray-700 font-medium"></asp:Label>
            </div>

            <div class="mt-4 p-2 bg-gray-200 rounded flex flex-wrap items-center justify-between space-y-2">
                <span class="font-medium text-gray-700">Total Rows: <%= rptAttendance.Items.Count %></span>
                <div class="flex space-x-2">
                    <button type="button" id="btnMarkAllPresent" class="bg-[#15a3b2] text-white px-3 py-1 rounded">Mark All Present</button>
                    <button type="button" id="btnMarkAllAbsent" class="bg-yellow-500 text-white px-3 py-1 rounded">Mark All Absent</button>
                    <button type="button" id="btnReset" class="bg-red-500 text-white px-3 py-1 rounded">Reset</button>
                </div>
            </div>
        </div>

        <!-- ✅ JS Script -->
        <script>
            $(document).ready(function () {
                $(".attendance-box").click(function () {
                    var $this = $(this);
                    var parent = $this.closest("td");
                    var id = $this.data("id");
                    var status = $this.data("status");
                    var hiddenInput = $("#attend_" + id);

                    if ($this.hasClass("selected")) {
                        $this.removeClass("selected");
                        hiddenInput.val("");
                    } else {
                        parent.find(".attendance-box").removeClass("selected");
                        $this.addClass("selected");
                        hiddenInput.val(status);
                    }

                    updateSelectedCount();
                });

                $("#btnReset").click(function () {
                    $(".attendance-box").removeClass("selected");
                    $("input[id^='attend_']").val("");
                    updateSelectedCount();
                });

                $("#btnMarkAllPresent").click(function () {
                    $(".attendance-box[data-status='P']").each(function () {
                        var $this = $(this);
                        var id = $this.data("id");
                        $("#attend_" + id).val("P");
                        var parent = $this.closest("td");
                        parent.find(".attendance-box").removeClass("selected");
                        $this.addClass("selected");
                    });
                    updateSelectedCount();
                });

                $("#btnMarkAllAbsent").click(function () {
                    $(".attendance-box[data-status='A']").each(function () {
                        var $this = $(this);
                        var id = $this.data("id");
                        $("#attend_" + id).val("A");
                        var parent = $this.closest("td");
                        parent.find(".attendance-box").removeClass("selected");
                        $this.addClass("selected");
                    });
                    updateSelectedCount();
                });

                function updateSelectedCount() {
                    var count = $("input[id^='attend_']").filter(function () {
                        return $(this).val() !== "";
                    }).length;
                    $("#<%= lblSelectedCount.ClientID %>").text("Total Selected: " + count);
                }

                updateSelectedCount();

                // 🔍 Search Filter
                $("#searchBox").on("keyup", function () {
                    var value = $(this).val().toLowerCase();
                    $("#attendanceTable tbody tr").filter(function () {
                        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                    });
                });
            });
        </script>

</asp:Content>

