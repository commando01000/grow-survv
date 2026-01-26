<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="UserManagement.aspx.cs" Inherits="GrowSurv.administration.UserManagement" %>
<%@ MasterType VirtualPath="~/MasterPages/Site.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="portlet light ">
        <div class="portlet-title">
            <div class="caption col-md-4">
                <i class="icon-list font-green-sharp"></i>
                <span class="caption-subject font-green-sharp sbold">User Management</span>
            </div>

        </div>
        <div class="portlet-body">
                <asp:Panel runat="server" ID="uiPanelAll">
                    <div class="col-md-12 clearfix margin-bottom-10" style="padding-left: 0px !important">
                         <asp:Panel ID="uiPanelSearch" runat="server" DefaultButton="uiButtonSearch" CssClass="col-md-10 clearfix margin-bottom-10">
                        <div class="col-md-12 clearfix" style="padding-left: 0px !important">
                            <div class="toolsBar">
                                <div class="products-filter-top">
                                    <div>
                                        <span>Search : </span>
                                        <asp:TextBox ID="uiTextBoxSearch" runat="server"></asp:TextBox>

                                        <asp:LinkButton ID="btnSearch" OnClick="uiButtonSearch_Click" CssClass="btn" runat="server" Style="height: 24px; line-height: normal; line-height: initial; padding-top: 5px;">Search <i class="fa fa-search"></i></asp:LinkButton>
                                        <asp:Button ID="uiButtonSearch" runat="server" Text="بحث" OnClick="uiButtonSearch_Click"
                                            Width="60px" Style="display: none;" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
                        <div class="col-md-2 pull-right">
                            <asp:LinkButton runat="server" ID="uiLinkButtonAdd" CssClass="btn btn-primary" OnClick="uiLinkButtonAdd_Click">Add new user</asp:LinkButton>
                        </div>
                    </div>
                    <div class="clearfix"></div>

                    <div class="col-md-12 clearfix margin-bottom-10">
                        <asp:GridView ID="uiRadGridUsers" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                            CellSpacing="0" HorizontalAlign="Center" Width="100%" CssClass="table table-hover table-striped table-bordered"
                            OnPageIndexChanging="uiRadGridUsers_PageIndexChanging" OnRowCommand="uiRadGridUsers_RowCommand">

                            <Columns>
                                <asp:BoundField DataField="MemUserName" HeaderText="User name"></asp:BoundField>
                                <asp:BoundField DataField="EnName" HeaderText="Company name"></asp:BoundField>
                                <asp:BoundField DataField="Email" HeaderText="Email"></asp:BoundField>
                                <asp:TemplateField HeaderText="Roles">
                                    <ItemTemplate>
                                        <%# string.Join("," ,Roles.GetRolesForUser(Eval("userName").ToString())) %>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Actions">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="uiLinkButtonEdit" runat="server" CommandArgument='<%# Eval("MemUserName") %>'
                                            CommandName="EditUser">Edit</asp:LinkButton>
                                        | 
                                        <asp:LinkButton ID="uiLinkButtonDelete" runat="server" CommandArgument='<%# Eval("MemUserName") %>'
                                            CommandName="DeleteUser" OnClientClick="return confirm('Are you want to delete this record?');">Delete</asp:LinkButton>
                                        <asp:LinkButton ID="uiLinkButtonLocked" runat="server" CommandArgument='<%# Eval("MemUserName") %>'
                                            CommandName="UnlockUser" Visible='<%# (Eval("IsLockedOut").ToString() == "True") ? true : false %>'><span style="color:#777;">|</span> Unlock</asp:LinkButton>
                                        <%--| 
                                    <asp:LinkButton ID="LinkButton1" CommandArgument='<%# Eval("UserName") %>' CommandName="LoginReport" runat="server">Report</asp:LinkButton>--%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>

                        </asp:GridView>
                        <div class="clearfix"></div>
                    </div>
                    <div class="clearfix"></div>
                </asp:Panel>
                <asp:Panel runat="server" ID="uiPanelEdit" CssClass="col-md-12 clearfix">
                    <div class="col-md-12 clearfix">
                        <asp:Label ID="uiLabelError" runat="server" Font-Bold="True" Text="An error occured. please try again later."
                            Visible="False" CssClass="Label alert-danger"></asp:Label>
                    </div>
                    <div class="col-md-12 clearfix">
                        <div class="col-md-2">
                            Username : 
                        </div>
                        <div class="col-md-4">
                            <asp:TextBox ID="uiTextBoxUserName" autocomplete="off" runat="server" Width="250px" ValidationGroup="EditUser"></asp:TextBox>
                            &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*"
                                ControlToValidate="uiTextBoxUserName" Display="Dynamic" ValidationGroup="EditUser"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-3"></div>
                        <div class="col-md-3">
                        </div>
                    </div>
                    <div style="clear: both; height: 5px;"></div>
                    <div class="col-md-12 clearfix ">
                        <div class="col-md-2">
                            Password : 
                        </div>
                        <div class="col-md-4">
                            <asp:TextBox ID="uiTextBoxPass" autocomplete="off" runat="server" Width="250px" ValidationGroup="EditUser" TextMode="Password"></asp:TextBox>
                            &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*"
                                ControlToValidate="uiTextBoxPass" Display="Dynamic" ValidationGroup="EditUser"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div style="clear: both; height: 5px;" class="hidden"></div>
                    <div class="col-md-12 clearfix hidden">
                        <div class="col-md-2">
                            Confirm password : 
                        </div>
                        <div class="col-md-4">
                            <asp:TextBox ID="uiTextBoxConfirm" autocomplete="off" runat="server" Width="250px" ValidationGroup="EditUser" TextMode="Password"></asp:TextBox>
                            <asp:CompareValidator runat="server" ErrorMessage="*" ID="CompareValidator1"
                                ControlToValidate="uiTextBoxConfirm" Display="Dynamic" ValidationGroup="EditUser" ControlToCompare="uiTextBoxPass"></asp:CompareValidator>

                        </div>
                    </div>
                    <div style="clear: both; height: 5px;"></div>
                    <div class="col-md-12 clearfix">
                        <div class="col-md-2">
                            English Name : 
                        </div>
                        <div class="col-md-4">
                            <asp:TextBox ID="txtFullName" autocomplete="off" runat="server" Width="250px" ValidationGroup="EditUser"></asp:TextBox>
                            &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*"
                                ControlToValidate="txtFullName" Display="Dynamic" ValidationGroup="EditUser"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div style="clear: both; height: 5px;"></div>
                    <div class="col-md-12 clearfix">
                        <div class="col-md-2">
                            Email : 
                        </div>
                        <div class="col-md-4">
                            <asp:TextBox ID="txtEmail" autocomplete="off" runat="server" Width="250px" ValidationGroup="EditUser"></asp:TextBox>
                            &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*"
                                ControlToValidate="txtEmail" Display="Dynamic" ValidationGroup="EditUser"></asp:RequiredFieldValidator>
                        </div>
                    </div>

                    <div style="clear: both; height: 5px;"></div>
                    <div class="col-md-12 clearfix">
                        <div class="col-md-2">
                            Telephone : 
                        </div>
                        <div class="col-md-4">
                            <asp:TextBox ID="uiTextBoxTele" autocomplete="off" runat="server" Width="250px" ValidationGroup="EditUser"></asp:TextBox>
                            &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator25" runat="server" ErrorMessage="*"
                                ControlToValidate="uiTextBoxTele" Display="Dynamic" ValidationGroup="EditUser"></asp:RequiredFieldValidator>
                        </div>
                    </div>


                    <div style="clear: both; height: 5px;"></div>
                    <div class="col-md-12 clearfix">
                        <div class="col-md-2">
                            Roles :
                        </div>
                        <div class="col-md-10">
                            <asp:CheckBoxList ID="uiCheckBoxListRoles" runat="server" CellPadding="5" CellSpacing="5"
                                RepeatColumns="2">
                            </asp:CheckBoxList>
                        </div>
                    </div>
                    <div class="col-md-12 clearfix">
                        <div class="col-md-2">
                            Account Expiry Date :
                            </div>
                        <div class="col-md-10">
                                <asp:TextBox ID="uiTextBoxAccountDueDate" TextMode="Date" runat="server" Width="250px" ValidationGroup="EditUser"></asp:TextBox>
                            
                        </div>
                    </div>
                    <div class="col-md-12 clearfix">
                        <div class="col-md-2">
                            &nbsp;
                        </div>
                        <div class="col-md-4">
                            <asp:LinkButton runat="server" ID="uiLinkButtonSave" CssClass="btn btn-primary" OnClick="uiButtonUpdate_Click" ValidationGroup="EditUser">Save</asp:LinkButton>
                            &nbsp;<asp:LinkButton runat="server" ID="uiLinkButtonCancel" CssClass="btn btn-primary" OnClick="uiButtonCancel_Click">Cancel</asp:LinkButton>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                    <div style="clear:both;height:5px;"></div>
                    <asp:Panel runat="server" ID="uiPanelDepartments" CssClass="col-md-12 clearfix" GroupingText="Demographic info">
                        <ul class="nav nav-tabs">
                            <li class="active">
                                <a href="#tab_Conuntry" data-toggle="tab">Countries</a>
                            </li>
                            <li>
                                <a href="#tab_Gov" data-toggle="tab">States</a>
                            </li>
                            <li>
                                <a href="#tab_Area" data-toggle="tab">Areas</a>
                            </li>
                            <li>
                                <a href="#tab_Branches" data-toggle="tab">Branches</a>
                            </li>
                            <li>
                                <a href="#tab_Departments" data-toggle="tab">Departments </a>
                            </li>
                            <li>
                                <a href="#tab_Divisions" data-toggle="tab">Divisions </a>
                            </li>
                            <li>
                                <a href="#tab_Levels" data-toggle="tab">Levels </a>
                            </li>
                            <li>
                                <a href="#tab_Grades" data-toggle="tab">Grades </a>
                            </li>
                            <li>
                                <a href="#tab_JobTitles" data-toggle="tab">Job Titles </a>
                            </li>
                            <li>
                                <a href="#tab_AgeGroups" data-toggle="tab">Age groups </a>
                            </li>
                        </ul>
                        <div class="tab-content">
                            <div class="tab-pane active" id="tab_Conuntry">
                                <div class="col-md-12 clearfix padding-tb-10">
                                    <div class="col-md-3 no-margin">
                                        Country Name (en) : 
                                    </div>
                                    <div class="col-md-3">
                                        <asp:TextBox ID="uiTextBoxNameEn" runat="server" Width="200px" ValidationGroup="EditCon"></asp:TextBox>
                                        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator26" runat="server" ErrorMessage="*"
                                            ControlToValidate="uiTextBoxNameEn" Display="Dynamic" ValidationGroup="EditCon"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="col-md-3">
                                        <asp:CheckBox ID="uiCheckBoxConActive" runat="server" />
                                        Active
                                    </div>

                                </div>
                                <div class="col-md-12 clearfix padding-tb-10">
                                    <div class="col-md-3 no-margin">
                                        Country Name (ar) : 
                                    </div>
                                    <div class="col-md-3">
                                        <asp:TextBox ID="uiTextBoxNameAr" runat="server" Width="200px" ValidationGroup="EditCon"></asp:TextBox>
                                        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator27" runat="server" ErrorMessage="*"
                                            ControlToValidate="uiTextBoxNameAr" Display="Dynamic" ValidationGroup="EditCon"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="col-md-3">
                                        <asp:LinkButton runat="server" ID="uiLinkButtonSaveCountry" CssClass="btn btn-primary" OnClick="uiLinkButtonSaveCountry_Click" ValidationGroup="EditCon">Add/ update Country</asp:LinkButton>
                                    </div>


                                </div>
                                <div class="col-md-12 clearfix margin-bottom-10">
                                    <asp:GridView ID="uiGridViewCon" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                        CellSpacing="0" HorizontalAlign="Center" Width="100%" CssClass="table table-hover table-striped table-bordered"
                                        OnPageIndexChanging="uiGridViewCon_PageIndexChanging" OnRowCommand="uiGridViewCon_RowCommand">

                                        <Columns>
                                            <asp:BoundField DataField="EnName" HeaderText="Name"></asp:BoundField>
                                            <asp:TemplateField HeaderText="Actions">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="uiLinkButtonEdit" runat="server" CommandArgument='<%# Eval("CountryID") %>'
                                                        CommandName="EditCon">Edit</asp:LinkButton>
                                                    | 
                                        <asp:LinkButton ID="uiLinkButtonDelete" runat="server" CommandArgument='<%# Eval("CountryID") %>'
                                            CommandName="DeleteCon" OnClientClick="return confirm('Are you want to delete this record?');">Delete</asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>

                                    </asp:GridView>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                            <div class="tab-pane" id="tab_Gov">
                                <div class="col-md-12 clearfix padding-tb-10">
                                    <div class="col-md-3 no-margin">
                                        State Name (en) : 
                                    </div>
                                    <div class="col-md-3">
                                        <asp:TextBox ID="uiTextBoxGovName" runat="server" Width="200px" ValidationGroup="EditGov"></asp:TextBox>
                                        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="*"
                                            ControlToValidate="uiTextBoxGovName" Display="Dynamic" ValidationGroup="EditGov"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="col-md-3">
                                        <asp:CheckBox ID="uiCheckBoxGovActive" runat="server" />
                                        Active
                                    </div>

                                </div>
                                <div class="col-md-12 clearfix padding-tb-10">
                                    <div class="col-md-3 no-margin">
                                        State Name (ar) : 
                                    </div>
                                    <div class="col-md-3">
                                        <asp:TextBox ID="uiTextBoxGovNameAr" runat="server" Width="200px" ValidationGroup="EditGov"></asp:TextBox>
                                        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="*"
                                            ControlToValidate="uiTextBoxGovNameAr" Display="Dynamic" ValidationGroup="EditGov"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="col-md-3">
                                        <asp:LinkButton runat="server" ID="uiLinkButtonSaveGov" CssClass="btn btn-primary" OnClick="uiLinkButtonSaveGov_Click" ValidationGroup="EditGov">Add/ update State</asp:LinkButton>
                                    </div>


                                </div>
                                <div class="col-md-12 clearfix margin-bottom-10">
                                    <asp:GridView ID="uiGridViewGovs" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                        CellSpacing="0" HorizontalAlign="Center" Width="100%" CssClass="table table-hover table-striped table-bordered"
                                        OnPageIndexChanging="uiGridViewGovs_PageIndexChanging" OnRowCommand="uiGridViewGovs_RowCommand">

                                        <Columns>
                                            <asp:BoundField DataField="EnName" HeaderText="Name"></asp:BoundField>
                                            <asp:TemplateField HeaderText="Actions">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="uiLinkButtonEdit" runat="server" CommandArgument='<%# Eval("GovernrateID") %>'
                                                        CommandName="EditGov">Edit</asp:LinkButton>
                                                    | 
                                        <asp:LinkButton ID="uiLinkButtonDelete" runat="server" CommandArgument='<%# Eval("GovernrateID") %>'
                                            CommandName="DeleteGov" OnClientClick="return confirm('Are you want to delete this record?');">Delete</asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>

                                    </asp:GridView>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                            <div class="tab-pane" id="tab_Area">
                                <div class="col-md-12 clearfix padding-tb-10">
                                    <div class="col-md-3 no-margin">
                                        Area Name (en) : 
                                    </div>
                                    <div class="col-md-3">
                                        <asp:TextBox ID="uiTextBoxAreaName" runat="server" Width="200px" ValidationGroup="EditArea"></asp:TextBox>
                                        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ErrorMessage="*"
                                            ControlToValidate="uiTextBoxAreaName" Display="Dynamic" ValidationGroup="EditArea"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="col-md-3">
                                        <asp:CheckBox ID="uiCheckBoxAreaActive" runat="server" />
                                        Active
                                    </div>

                                </div>
                                <div class="col-md-12 clearfix padding-tb-10">
                                    <div class="col-md-3 no-margin">
                                        Area Name (ar) : 
                                    </div>
                                    <div class="col-md-3">
                                        <asp:TextBox ID="uiTextBoxAreaNameAr" runat="server" Width="200px" ValidationGroup="EditArea"></asp:TextBox>
                                        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ErrorMessage="*"
                                            ControlToValidate="uiTextBoxAreaNameAr" Display="Dynamic" ValidationGroup="EditArea"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="col-md-3">
                                        <asp:LinkButton runat="server" ID="uiLinkButtonSaveArea" CssClass="btn btn-primary" OnClick="uiLinkButtonSaveArea_Click" ValidationGroup="EditArea">Add/ update area</asp:LinkButton>
                                    </div>


                                </div>
                                <div class="col-md-12 clearfix margin-bottom-10">
                                    <asp:GridView ID="uiGridViewArea" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                        CellSpacing="0" HorizontalAlign="Center" Width="100%" CssClass="table table-hover table-striped table-bordered"
                                        OnPageIndexChanging="uiGridViewArea_PageIndexChanging" OnRowCommand="uiGridViewArea_RowCommand">

                                        <Columns>
                                            <asp:BoundField DataField="NameEn" HeaderText="Name"></asp:BoundField>
                                            <asp:TemplateField HeaderText="Actions">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="uiLinkButtonEdit" runat="server" CommandArgument='<%# Eval("AreaID") %>'
                                                        CommandName="EditArea">Edit</asp:LinkButton>
                                                    | 
                                        <asp:LinkButton ID="uiLinkButtonDelete" runat="server" CommandArgument='<%# Eval("AreaID") %>'
                                            CommandName="DeleteArea" OnClientClick="return confirm('Are you want to delete this record?');">Delete</asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>

                                    </asp:GridView>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                            <div class="tab-pane" id="tab_Branches">
                                <div class="col-md-12 clearfix padding-tb-10">
                                    <div class="col-md-3 no-margin">
                                        Branch Name (en) : 
                                    </div>
                                    <div class="col-md-3">
                                        <asp:TextBox ID="uiTextBoxBranchName" runat="server" Width="200px" ValidationGroup="EditBranch"></asp:TextBox>
                                        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ErrorMessage="*"
                                            ControlToValidate="uiTextBoxBranchName" Display="Dynamic" ValidationGroup="EditBranch"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="col-md-3">
                                        <asp:CheckBox ID="uiCheckBoxBranchActive" runat="server" />
                                        Active
                                    </div>

                                </div>
                                <div class="col-md-12 clearfix padding-tb-10">
                                    <div class="col-md-3 no-margin">
                                        Branch Name (ar) : 
                                    </div>
                                    <div class="col-md-3">
                                        <asp:TextBox ID="uiTextBoxBranchNameAr" runat="server" Width="200px" ValidationGroup="EditBranch"></asp:TextBox>
                                        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ErrorMessage="*"
                                            ControlToValidate="uiTextBoxBranchNameAr" Display="Dynamic" ValidationGroup="EditBranch"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="col-md-3">
                                        <asp:LinkButton runat="server" ID="uiLinkButtonSaveBranch" CssClass="btn btn-primary" OnClick="uiLinkButtonSaveBranch_Click" ValidationGroup="EditBranch">Add/ update branch</asp:LinkButton>
                                    </div>


                                </div>
                                <div class="col-md-12 clearfix margin-bottom-10">
                                    <asp:GridView ID="uiGridViewBranch" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                        CellSpacing="0" HorizontalAlign="Center" Width="100%" CssClass="table table-hover table-striped table-bordered"
                                        OnPageIndexChanging="uiGridViewBranch_PageIndexChanging" OnRowCommand="uiGridViewBranch_RowCommand">

                                        <Columns>
                                            <asp:BoundField DataField="NameEn" HeaderText="Name"></asp:BoundField>
                                            <asp:TemplateField HeaderText="Actions">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="uiLinkButtonEdit" runat="server" CommandArgument='<%# Eval("BranchID") %>'
                                                        CommandName="EditBranch">Edit</asp:LinkButton>
                                                    | 
                                        <asp:LinkButton ID="uiLinkButtonDelete" runat="server" CommandArgument='<%# Eval("BranchID") %>'
                                            CommandName="DeleteBranch" OnClientClick="return confirm('Are you want to delete this record?');">Delete</asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>

                                    </asp:GridView>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                            <div class="tab-pane" id="tab_Departments">
                                <div class="col-md-12 clearfix padding-tb-10">
                                    <div class="col-md-3 no-margin">
                                        Department Name (en) : 
                                    </div>
                                    <div class="col-md-3">
                                        <asp:TextBox ID="uiTextBoxDepartmentName" runat="server" Width="200px" ValidationGroup="EditDepartment"></asp:TextBox>
                                        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="*"
                                            ControlToValidate="uiTextBoxDepartmentName" Display="Dynamic" ValidationGroup="EditDepartment" ></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="col-md-3">
                                        <asp:CheckBox ID="uiCheckBoxDepartmentActive" runat="server" /> Active
                                    </div>
                                    
                                </div>
                                <div class="col-md-12 clearfix padding-tb-10">
                                    <div class="col-md-3 no-margin">
                                        Department Name (ar) : 
                                    </div>
                                    <div class="col-md-3">
                                        <asp:TextBox ID="uiTextBoxDepartmentNameAr" runat="server" Width="200px" ValidationGroup="EditDepartment"></asp:TextBox>
                                        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="*"
                                            ControlToValidate="uiTextBoxDepartmentNameAr" Display="Dynamic" ValidationGroup="EditDepartment" ></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="col-md-3">
                                        <asp:LinkButton runat="server" ID="uiLinkButtonSaveDepartment" CssClass="btn btn-primary" OnClick="uiLinkButtonSaveDepartment_Click" ValidationGroup="EditDepartment">Add/ update department</asp:LinkButton>
                                    </div>
                                    
                                    
                                </div>
                                <div class="col-md-12 clearfix margin-bottom-10">
                                    <asp:GridView ID="uiGridViewDepartments" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                        CellSpacing="0" HorizontalAlign="Center" Width="100%" CssClass="table table-hover table-striped table-bordered"
                                        OnPageIndexChanging="uiGridViewDepartments_PageIndexChanging" OnRowCommand="uiGridViewDepartments_RowCommand">

                                        <Columns>
                                            <asp:BoundField DataField="EnName" HeaderText="Name"></asp:BoundField>
                                            <asp:TemplateField HeaderText="Actions">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="uiLinkButtonEdit" runat="server" CommandArgument='<%# Eval("DepartmentID") %>'
                                                        CommandName="EditDepartment">Edit</asp:LinkButton>
                                                    | 
                                        <asp:LinkButton ID="uiLinkButtonDelete" runat="server" CommandArgument='<%# Eval("DepartmentID") %>'
                                            CommandName="DeleteDepartment" OnClientClick="return confirm('Are you want to delete this record?');">Delete</asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>

                                    </asp:GridView>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                            <div class="tab-pane " id="tab_Divisions">
                                <div class="col-md-12 clearfix padding-tb-10">
                                    <div class="col-md-3 no-margin">
                                        Division Name (en) : 
                                    </div>
                                    <div class="col-md-3">
                                        <asp:TextBox ID="uiTextBoxDivisionName" runat="server" Width="200px" ValidationGroup="EditDivision"></asp:TextBox>
                                        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ErrorMessage="*"
                                            ControlToValidate="uiTextBoxDivisionName" Display="Dynamic" ValidationGroup="EditDivision"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="col-md-3">
                                        <asp:CheckBox ID="uiCheckBoxDivisionActive" runat="server" />
                                        Active
                                    </div>

                                </div>
                                <div class="col-md-12 clearfix padding-tb-10">
                                    <div class="col-md-3 no-margin">
                                        Division Name (ar) : 
                                    </div>
                                    <div class="col-md-3">
                                        <asp:TextBox ID="uiTextBoxDivisionNameAr" runat="server" Width="200px" ValidationGroup="EditDivision"></asp:TextBox>
                                        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" ErrorMessage="*"
                                            ControlToValidate="uiTextBoxDivisionNameAr" Display="Dynamic" ValidationGroup="EditDivision"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="col-md-3">
                                        <asp:LinkButton runat="server" ID="uiLinkButtonSaveDivision" CssClass="btn btn-primary" OnClick="uiLinkButtonSaveDivision_Click" ValidationGroup="EditDivision">Add/ update division</asp:LinkButton>
                                    </div>


                                </div>
                                <div class="col-md-12 clearfix margin-bottom-10">
                                    <asp:GridView ID="uiGridViewDivision" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                        CellSpacing="0" HorizontalAlign="Center" Width="100%" CssClass="table table-hover table-striped table-bordered"
                                        OnPageIndexChanging="uiGridViewDivision_PageIndexChanging" OnRowCommand="uiGridViewDivision_RowCommand">

                                        <Columns>
                                            <asp:BoundField DataField="NameEn" HeaderText="Name"></asp:BoundField>
                                            <asp:TemplateField HeaderText="Actions">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="uiLinkButtonEdit" runat="server" CommandArgument='<%# Eval("DivisionID") %>'
                                                        CommandName="EditDivision">Edit</asp:LinkButton>
                                                    | 
                                        <asp:LinkButton ID="uiLinkButtonDelete" runat="server" CommandArgument='<%# Eval("DivisionID") %>'
                                            CommandName="DeleteDivision" OnClientClick="return confirm('Are you want to delete this record?');">Delete</asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>

                                    </asp:GridView>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                            <div class="tab-pane " id="tab_Levels">
                                <div class="col-md-12 clearfix padding-tb-10">
                                    <div class="col-md-3 no-margin">
                                        Level Name (en) : 
                                    </div>
                                    <div class="col-md-3">
                                        <asp:TextBox ID="uiTextBoxLevelName" runat="server" Width="200px" ValidationGroup="EditLevel"></asp:TextBox>
                                        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server" ErrorMessage="*"
                                            ControlToValidate="uiTextBoxLevelName" Display="Dynamic" ValidationGroup="EditLevel"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="col-md-3">
                                        <asp:CheckBox ID="uiCheckBoxLevelActive" runat="server" />
                                        Active
                                    </div>

                                </div>
                                <div class="col-md-12 clearfix padding-tb-10">
                                    <div class="col-md-3 no-margin">
                                        Level Name (ar) : 
                                    </div>
                                    <div class="col-md-3">
                                        <asp:TextBox ID="uiTextBoxLevelNameAr" runat="server" Width="200px" ValidationGroup="EditLevel"></asp:TextBox>
                                        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator16" runat="server" ErrorMessage="*"
                                            ControlToValidate="uiTextBoxLevelNameAr" Display="Dynamic" ValidationGroup="EditLevel"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="col-md-3">
                                        <asp:LinkButton runat="server" ID="uiLinkButtonSaveLevel" CssClass="btn btn-primary" OnClick="uiLinkButtonSaveLevel_Click" ValidationGroup="EditLevel">Add/ update level</asp:LinkButton>
                                    </div>


                                </div>
                                <div class="col-md-12 clearfix margin-bottom-10">
                                    <asp:GridView ID="uiGridViewLevel" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                        CellSpacing="0" HorizontalAlign="Center" Width="100%" CssClass="table table-hover table-striped table-bordered"
                                        OnPageIndexChanging="uiGridViewLevel_PageIndexChanging" OnRowCommand="uiGridViewLevel_RowCommand">

                                        <Columns>
                                            <asp:BoundField DataField="EnName" HeaderText="Name"></asp:BoundField>
                                            <asp:TemplateField HeaderText="Actions">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="uiLinkButtonEdit" runat="server" CommandArgument='<%# Eval("LevelID") %>'
                                                        CommandName="EditLevel">Edit</asp:LinkButton>
                                                    | 
                                        <asp:LinkButton ID="uiLinkButtonDelete" runat="server" CommandArgument='<%# Eval("LevelID") %>'
                                            CommandName="DeleteLevel" OnClientClick="return confirm('Are you want to delete this record?');">Delete</asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>

                                    </asp:GridView>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                            <div class="tab-pane " id="tab_Grades">
                                <div class="col-md-12 clearfix padding-tb-10">
                                    <div class="col-md-3 no-margin">
                                        Grade Name (en) : 
                                    </div>
                                    <div class="col-md-3">
                                        <asp:TextBox ID="uiTextBoxGradeName" runat="server" Width="200px" ValidationGroup="EditGrade"></asp:TextBox>
                                        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator17" runat="server" ErrorMessage="*"
                                            ControlToValidate="uiTextBoxGradeName" Display="Dynamic" ValidationGroup="EditGrade"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="col-md-3">
                                        <asp:CheckBox ID="uiCheckBoxGradeActive" runat="server" />
                                        Active
                                    </div>

                                </div>
                                <div class="col-md-12 clearfix padding-tb-10">
                                    <div class="col-md-3 no-margin">
                                        Grade Name (ar) : 
                                    </div>
                                    <div class="col-md-3">
                                        <asp:TextBox ID="uiTextBoxGradeNameAr" runat="server" Width="200px" ValidationGroup="EditGrade"></asp:TextBox>
                                        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator18" runat="server" ErrorMessage="*"
                                            ControlToValidate="uiTextBoxGradeNameAr" Display="Dynamic" ValidationGroup="EditGrade"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="col-md-3">
                                        <asp:LinkButton runat="server" ID="uiLinkButtonSaveGrade" CssClass="btn btn-primary" OnClick="uiLinkButtonSaveGrade_Click" ValidationGroup="EditGrade">Add/ update grade</asp:LinkButton>
                                    </div>


                                </div>
                                <div class="col-md-12 clearfix margin-bottom-10">
                                    <asp:GridView ID="uiGridViewGrade" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                        CellSpacing="0" HorizontalAlign="Center" Width="100%" CssClass="table table-hover table-striped table-bordered"
                                        OnPageIndexChanging="uiGridViewGrade_PageIndexChanging" OnRowCommand="uiGridViewGrade_RowCommand">

                                        <Columns>
                                            <asp:BoundField DataField="EnName" HeaderText="Name"></asp:BoundField>
                                            <asp:TemplateField HeaderText="Actions">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="uiLinkButtonEdit" runat="server" CommandArgument='<%# Eval("GradeID") %>'
                                                        CommandName="EditGrade">Edit</asp:LinkButton>
                                                    | 
                                        <asp:LinkButton ID="uiLinkButtonDelete" runat="server" CommandArgument='<%# Eval("GradeID") %>'
                                            CommandName="DeleteGrade" OnClientClick="return confirm('Are you want to delete this record?');">Delete</asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>

                                    </asp:GridView>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                            <div class="tab-pane " id="tab_JobTitles">
                                <div class="col-md-12 clearfix padding-tb-10">
                                    <div class="col-md-3 no-margin">
                                        Job Title Name (en) : 
                                    </div>
                                    <div class="col-md-3">
                                        <asp:TextBox ID="uiTextBoxJobTitleName" runat="server" Width="200px" ValidationGroup="EditJobTitle"></asp:TextBox>
                                        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator19" runat="server" ErrorMessage="*"
                                            ControlToValidate="uiTextBoxJobTitleName" Display="Dynamic" ValidationGroup="EditJobTitle"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="col-md-3">
                                        <asp:CheckBox ID="uiCheckBoxJobTitleActive" runat="server" />
                                        Active
                                    </div>

                                </div>
                                <div class="col-md-12 clearfix padding-tb-10">
                                    <div class="col-md-3 no-margin">
                                        Job Title Name (ar) : 
                                    </div>
                                    <div class="col-md-3">
                                        <asp:TextBox ID="uiTextBoxJobTitleNameAr" runat="server" Width="200px" ValidationGroup="EditJobTitle"></asp:TextBox>
                                        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator20" runat="server" ErrorMessage="*"
                                            ControlToValidate="uiTextBoxJobTitleNameAr" Display="Dynamic" ValidationGroup="EditJobTitle"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="col-md-3">
                                        <asp:LinkButton runat="server" ID="uiLinkButtonSaveJobTitle" CssClass="btn btn-primary" OnClick="uiLinkButtonSaveJobTitle_Click" ValidationGroup="EditJobTitle">Add/ update job title</asp:LinkButton>
                                    </div>


                                </div>
                                <div class="col-md-12 clearfix margin-bottom-10">
                                    <asp:GridView ID="uiGridViewJobTitle" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                        CellSpacing="0" HorizontalAlign="Center" Width="100%" CssClass="table table-hover table-striped table-bordered"
                                        OnPageIndexChanging="uiGridViewJobTitle_PageIndexChanging" OnRowCommand="uiGridViewJobTitle_RowCommand">

                                        <Columns>
                                            <asp:BoundField DataField="EnName" HeaderText="Name"></asp:BoundField>
                                            <asp:TemplateField HeaderText="Actions">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="uiLinkButtonEdit" runat="server" CommandArgument='<%# Eval("JobTitleID") %>'
                                                        CommandName="EditJobTitle">Edit</asp:LinkButton>
                                                    | 
                                        <asp:LinkButton ID="uiLinkButtonDelete" runat="server" CommandArgument='<%# Eval("JobTitleID") %>'
                                            CommandName="DeletejobTitle" OnClientClick="return confirm('Are you want to delete this record?');">Delete</asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>

                                    </asp:GridView>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                            <div class="tab-pane " id="tab_AgeGroups">
                                <div class="col-md-12 clearfix ">
                                    <div class="col-md-3 no-margin">
                                        Age Group Name (en) : 
                                    </div>
                                    <div class="col-md-3">
                                        <asp:TextBox ID="uiTextBoxAgeGroupName" runat="server" Width="200px" ValidationGroup="EditAG"></asp:TextBox>
                                        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator21" runat="server" ErrorMessage="*"
                                            ControlToValidate="uiTextBoxAgeGroupName" Display="Dynamic" ValidationGroup="EditAG"></asp:RequiredFieldValidator>
                                    </div>
                                    
                                    <div class="col-md-2 no-margin">
                                        Start Age : 
                                    </div>
                                    <div class="col-md-1">
                                        <asp:TextBox ID="uiTextBoxStart" runat="server" Width="50px" ValidationGroup="EditAG" TextMode="Number"></asp:TextBox>
                                        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator23" runat="server" ErrorMessage="*"
                                            ControlToValidate="uiTextBoxStart" Display="Dynamic" ValidationGroup="EditAG"></asp:RequiredFieldValidator>
                                    </div>
                                     <div class="col-md-2 no-margin">
                                        End Age : 
                                    </div>
                                    <div class="col-md-1">
                                        <asp:TextBox ID="uiTextBoxEnd" runat="server" Width="50px" ValidationGroup="EditAG" TextMode="Number"></asp:TextBox>
                                        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator24" runat="server" ErrorMessage="*"
                                            ControlToValidate="uiTextBoxEnd" Display="Dynamic" ValidationGroup="EditAG"></asp:RequiredFieldValidator>
                                    </div>

                                </div>
                                <div class="col-md-12 clearfix ">
                                     <div class="col-md-3 no-margin">
                                        Age Group Name (ar) : 
                                    </div>
                                    <div class="col-md-3">
                                        <asp:TextBox ID="uiTextBoxAgeGroupNameAr" runat="server" Width="200px" ValidationGroup="EditAG"></asp:TextBox>
                                        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator22" runat="server" ErrorMessage="*"
                                            ControlToValidate="uiTextBoxAgeGroupNameAr" Display="Dynamic" ValidationGroup="EditAG"></asp:RequiredFieldValidator>
                                    </div>
                                   
                                    <div class="col-md-2">
                                        <asp:CheckBox ID="uiCheckBoxAgeGroupActive" runat="server" />
                                        Active
                                    </div>
                                    <div class="col-md-2">
                                        <asp:LinkButton runat="server" ID="uiLinkButtonSaveAgeGroup" CssClass="btn btn-primary" OnClick="uiLinkButtonSaveAgeGroup_Click" ValidationGroup="EditAG">Add/ update age group</asp:LinkButton>
                                    </div>


                                </div>
                                <div class="col-md-12 clearfix margin-bottom-10">
                                    <asp:GridView ID="uiGridViewAgeGroup" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                        CellSpacing="0" HorizontalAlign="Center" Width="100%" CssClass="table table-hover table-striped table-bordered"
                                        OnPageIndexChanging="uiGridViewAgeGroup_PageIndexChanging" OnRowCommand="uiGridViewAgeGroup_RowCommand">

                                        <Columns>
                                            <asp:BoundField DataField="EnDisplayName" HeaderText="Name"></asp:BoundField>
                                            <asp:TemplateField HeaderText="Actions">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="uiLinkButtonEdit" runat="server" CommandArgument='<%# Eval("AgeGroupID") %>'
                                                        CommandName="EditAgeGroup">Edit</asp:LinkButton>
                                                    | 
                                        <asp:LinkButton ID="uiLinkButtonDelete" runat="server" CommandArgument='<%# Eval("AgeGroupID") %>'
                                            CommandName="DeleteAgeGroup" OnClientClick="return confirm('Are you want to delete this record?');">Delete</asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>

                                    </asp:GridView>
                                    <div class="clearfix"></div>
                                </div>
                            </div>

                        </div>

                    </asp:Panel>

                    <div style="clear: both; height: 5px;"></div>
                    
                </asp:Panel>
                <div class="clearfix"></div>
        </div>
    </div>
</asp:Content>
