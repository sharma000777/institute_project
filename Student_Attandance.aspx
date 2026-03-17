<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true" CodeFile="Student_Attandance.aspx.cs" Inherits="Admin_Student_Attandance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
           <script src="https://cdn.tailwindcss.com"></script>
    <style>
        .box {
            width: 28px;
            height: 28px;
            line-height: 28px;
            border-radius: 0.25rem;
            font-weight: bold;
            display: inline-block;
            text-align: center;
        }
        .present { border: 2px solid green; color: green; }
        .absent { border: 2px solid red; color: red; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="max-w-7xl mx-auto bg-white p-6 rounded-lg shadow-md border-2 border-[#15a3b2]">

            <h2 class="text-2xl font-bold mb-6 text-center lg:w-1/4 bg-[#15a3b2] rounded shadow-xl p-2 text-white">View Attendance</h2>

            <!-- Filters -->
            <div class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-5 gap-4 mb-6">
          

                <div>
                    <label class="block text-sm font-medium text-gray-700">Course</label>
                    <asp:DropDownList ID="ddlCourse" AutoPostBack="true" OnSelectedIndexChanged="ddlCourse_SelectedIndexChanged" runat="server" CssClass="p-2 border-2 mt-1 block w-full border-blue-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 text-sm" />
                </div>
                <!--
                <div>
                    <label class="block text-sm font-medium text-gray-700">Session</label>
                    <asp:DropDownList ID="ddlSession" runat="server" CssClass="p-2 border-2 mt-1 block w-full border-blue-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 text-sm" />
                </div>
            -->
                <div>
                      <label class="block text-sm font-medium text-gray-700">Year</label>
                    <asp:TextBox ID="txtYear" runat="server" TextMode="Number" 
                 min="2000" max="2100" step="1" value="2025" AutoPostBack="true" OnTextChanged="txtYear_TextChanged" CssClass="p-2 border-2 mt-1 block w-full border-blue-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 text-sm" />
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700">Month</label>
                    <asp:DropDownList ID="ddlMonth" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlMonth_SelectedIndexChanged" CssClass="p-2 border-2 mt-1 block w-full border-blue-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 text-sm">
                        <asp:ListItem Text="January" Value="1" />
                        <asp:ListItem Text="February" Value="2" />
                        <asp:ListItem Text="March" Value="3" />
                        <asp:ListItem Text="April" Value="4" />
                        <asp:ListItem Text="May" Value="5" />
                        <asp:ListItem Text="June" Value="6" />
                        <asp:ListItem Text="July" Value="7" />
                        <asp:ListItem Text="August" Value="8" />
                        <asp:ListItem Text="September" Value="9" />
                        <asp:ListItem Text="October" Value="10" />
                        <asp:ListItem Text="November" Value="11" />
                        <asp:ListItem Text="December" Value="12" />
                    </asp:DropDownList>
                </div>
                <div>
                     <label class="block text-sm font-medium text-gray-700">Name / Roll No</label>
                    <asp:TextBox runat="server" AutoPostBack="true"  OnTextChanged="txtSearch_TextChanged" ID="txtSearch" CssClass="p-2 border-2 mt-1 block w-full border-blue-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 text-sm"></asp:TextBox>
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
            <!-- Attendance Table -->
            <div class="overflow-auto  p-4 rounded border border-gray-200 text-gray-900">
                <asp:Literal ID="litAttendanceTable" runat="server"></asp:Literal>
            </div>

             <div class="my-2">
            <asp:Button Text="Export" runat="server" ID="btnExport" OnClick="btnExport_Click" CssClass="bg-[#15a3b2] p-2 px-4 rounded shadow text-gray-800 font-bold" />
        </div>

            <!-- Success Message -->
            <asp:Label ID="lblMessage" runat="server" CssClass="mt-4 text-green-600 font-medium block" />
        </div>
</asp:Content>

