<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="QuestBankCategories.aspx.cs" Inherits="GrowSurv.QuestBank.QuestBankCategories" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row col-md-12" ng-app="globalApp" ng-cloak ng-controller="BankCategoriesController">
        <div class="portlet light">
            <div class="portlet-title">
                <div class="caption">
                    <span class="caption-subject bold uppercase">Questions Bank Categories Management</span>
                </div>
            </div>
            <div class="portlet-body">
                <div class="container-fluid">
                    <div class="row col-md-12">
                        <h4 class="font-dark">Question Categories</h4>
                        <hr />
                        <div class="col-md-12 form-group form-md-line-input has-info">
                            <div class="input-group input-group-sm">
                                <div class="input-group-control col-md-5">
                                    <input type="text" ng-class="{'form-control edited' : QuestionCategory.EnName != '', 'form-control' : QuestionCategory.EnName == ''}" ng-model="Category.EnName">
                                    <label for="form_control_2">Category (En)</label>
                                </div>
                                <div class="input-group-control col-md-5" style="margin-left:15px;">
                                    <input type="text" ng-class="{'form-control edited' : QuestionCategory.ArName != '', 'form-control' : QuestionCategory.ArName == ''}" ng-model="Category.ArName">
                                    <label for="form_control_2">Category (Ar)</label>
                                </div>
                                <span class="input-group-btn btn-right">
                                    <a href="javascript:;" ng-disabled="!Category.EnName" class="btn blue" ng-click="SaveQuestionCategory()"><i class="fa fa-plus"></i>Save</a>
                                    <a href="javascript:;" ng-disabled="!Category.EnName" class="btn blue" ng-click="CancelCategory()"><i class="fa fa-ban"></i>Cancel</a>
                                </span>
                            </div>
                        </div>
                        <table class="table table-hover table-striped table-condensed table-bordered">
                            <thead>
                                <tr>
                                    <td>Category Name</td>
                                    <td>Actions</td>
                                </tr>
                            </thead>
                            <tr ng-repeat="QuestionCategory in Categories">
                                <td>{{QuestionCategory.EnName}}</td>
                                <td>
                                    <a href="javascript:;" ng-click="EditBankCategory(QuestionCategory)" class="btn btn-xs blue"><i class="fa fa-edit"></i>Edit </a>
                                    <a href="javascript:;" ng-click="DeleteQuestionCategory(QuestionCategory.CategoryID)" class="btn btn-xs red"><i class="fa fa-trash"></i>Delete </a>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CPHScripts" runat="server">
    <script src="../scripts/angular.min.js"></script>
    <script src="../scripts/sweetalert2.min.js"></script>
    <script src="../scripts/BankCategoriesController.js"></script>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="CPHScriptsAfter" runat="server">
</asp:Content>
