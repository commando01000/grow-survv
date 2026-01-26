<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="reports.aspx.cs" Inherits="GrowSurv.survManager.reports" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="col-lg-12">
        <div class="col-lg-3">
            <b>Survey :</b> <asp:Label ID="uiLabelSurveyTitle" runat="server"></asp:Label>
        </div>
        <div class="col-lg-3">
             <b>Company :</b> <asp:Label ID="uiLabelCompany" runat="server" ></asp:Label>
        </div>
        <div class="col-lg-3">
             <b>Expiry Date :</b> <asp:Label ID="uiLabelExpDate" runat="server" ></asp:Label>
        </div>
        <div class="col-lg-3">
            <a href="ListSurveys.aspx" class="btn btn-info"><i class="fa fa-backward"></i> Back to survey list</a>
        </div>
    </div>
    <div class="col-lg-12">
        <h4>
            Please select report from list below:
        </h4>
    </div>
    <div class="col-lg-12">
        <div class="col-lg-1">
             <b>Report : </b>
        </div>
        <div class="col-lg-4">
            <asp:DropDownList ID="uiDropDownListReports" runat="server" CssClass="form-control">
                <asp:ListItem Text="Survey Engagement" value="1"/>
                <asp:ListItem Text="Survey Statistics - bar chart" value="2"/>
                <asp:ListItem Text="Survey Statistics - pie chart" value="7"/>
                <asp:ListItem Text="Survey Statistics by demographics" value="3"/>   
                <asp:ListItem Text="Survey Questions Evaluation" value="4"/>   
                 <asp:ListItem Text="Print Survey" value="5"/>                           
                <%-- added from code based on role 
                    <asp:ListItem Text="Survey Detailed Answers" value="6"/>        --%>
                
            </asp:DropDownList>
        </div>
        <div class="col-lg-1">
             <b>Lang: </b>
        </div>  
        <div class="col-lg-1">
              <asp:DropDownList ID="uiDropDownListLang" runat="server" CssClass="form-control">
                <asp:ListItem Text="English" value="en"/>
                <asp:ListItem Text="Arabic" value="ar"/>
            </asp:DropDownList>
        </div>  
        <div class="col-lg-1">
             <b>Demographics: </b>
        </div>  
        <div class="col-lg-1">
             
        </div>   
        <div class="col-lg-2">
            <asp:DropDownList ID="uiDropDownListDemographics" runat="server" CssClass="form-control">
                <asp:ListItem Text="Select demographic" value=""/>
                <asp:ListItem Text="Country" value="CountryEnName"/>
                <asp:ListItem Text="Governrate" value="GovEnName"/>
                <asp:ListItem Text="Areas" value="AreaEnName"/>
                <asp:ListItem Text="Branches" value="BranchEnName"/>
                <asp:ListItem Text="Departments" value="DepEnName"/>
                <asp:ListItem Text="Divisions" value="DivEnName"/>
                <asp:ListItem Text="Age groups" value="AgeEnName"/>
                <asp:ListItem Text="Levels" value="LevelEnName"/>
                <asp:ListItem Text="Grades" value="GradeEnName"/>
                <asp:ListItem Text="Job Titles" value="jobEnName"/>
                <asp:ListItem Text="Gender" value="GenderEnName"/>
            </asp:DropDownList>
        </div>     
        <div class="col-lg-1">
            <asp:LinkButton Text="View Report" ID="uiLinkButtonViewReport" OnClick="uiLinkButtonViewReport_Click" runat="server" CssClass="btn btn-default"/>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CPHScripts" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="CPHScriptsAfter" runat="server">
</asp:Content>
