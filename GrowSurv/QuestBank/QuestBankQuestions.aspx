<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="QuestBankQuestions.aspx.cs" Inherits="GrowSurv.QuestBank.QuestBankQuestions" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row col-md-12" ng-app="globalApp" ng-cloak ng-controller="BankQuestionsController">
        <div class="portlet light">
            <div class="portlet-title">
                <div class="caption">
                    <span class="caption-subject bold uppercase">Questions Bank</span>
                </div>
            </div>
            <div class="portlet-body">
                <div class="container-fluid">
                    <div class="row col-md-12">
                        <div id="QuestionList">
                            <h3 class="font-dark">Questions</h3>
                            <hr />
                            <div class="col-md-12 margin-bottom-10">
                                <a class="btn blue btn-outline sbold" href="#" ng-click="AddNewQuestion()">Add Question </a>
                            </div>
                            <div class="col-md-12 margin-bottom-10">
                                <table class="table table-hover table-striped table-condensed table-bordered">
                                    <thead>
                                        <tr>
                                            <td>Title</td>
                                            <td>Type</td>
                                            <td>Actions</td>
                                        </tr>
                                    </thead>
                                    <tr ng-repeat="item in Questions">
                                        <td>{{item.EnTitle}}</td>
                                        <td>{{item.QuestionTypeName}}</td>
                                        <td>
                                            <a href="javascript:;" class="btn btn-xs blue" ng-click="editQuestion(item)"><i class="fa fa-edit"></i>Edit </a>
                                            <a href="javascript:;" class="btn btn-xs red"><i class="fa fa-trash"></i>Delete </a>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <div id="QuestionDetails" style="display: none">
                            <div class="form-body">
                                <div class="row">
                                    <div class="col-md-12">
                                        <h3 class="font-dark">Question Details
                                                                <button type="button" ng-click="CancelQuestion()" class="btn btn-sm dark btn-outline pull-right">Back to Questions</button>
                                        </h3>
                                        <hr />
                                        <div class="col-md-6 form-group form-md-line-input form-md-floating-label has-info">
                                            <select ng-class="{'form-control edited' : Question.QuestionTypeID != '', 'form-control' : Question.QuestionTypeID == ''}" ng-model="Question.BankQuestionTypeID">
                                                <option ng-repeat="item in QuestionTypes" ng-value="item.QuestionTypeID">{{item.EnName}}</option>
                                            </select>
                                            <label for="form_control_1">Question Type</label>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group form-md-line-input form-md-floating-label has-info">
                                                <input type="text" ng-class="{'form-control edited' : Question.Weight != '', 'form-control' : Question.Weight == ''}" ng-model="Question.Weight">
                                                <label for="form_control_2">Weight</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                        <div class="col-md-3 form-group form-md-line-input form-md-floating-label has-info">
                                            <select ng-class="{'form-control edited' : Question.BankCategoryID != '', 'form-control' : Question.BankCategoryID == ''}" ng-model="Question.BankCategoryID">
                                                <option ng-repeat="item in QuestionCategories" ng-value="item.BankCategoryID">{{item.EnName}}</option>
                                            </select>
                                            <label for="form_control_1">Question Category</label>
                                        </div>
                                        <%--<div class="col-md-1">&nbsp;</div>--%>
<%--                                        <div class="col-md-3 form-group form-md-line-input form-md-floating-label has-info">
                                            <select ng-class="{'form-control edited' : Question.BranchID != '', 'form-control' : Question.BranchID == ''}" ng-model="Question.BranchID">
                                                <option ng-value="0">Main Branch</option>
                                                <option ng-repeat="item in QuestionBranches" ng-value="item.QuestionBranchID">{{item.EnName}}</option>
                                            </select>
                                            <label for="form_control_1">Question Branch</label>
                                        </div>--%>
<%--                                        <div class="col-md-2">
                                            <div class="form-group form-md-line-input form-md-floating-label has-info">
                                                <input type="text" ng-class="{'form-control edited' : Question.QuestionOrder != '', 'form-control' : Question.QuestionOrder == ''}" ng-model="Question.QuestionOrder">
                                                <label for="form_control_2">Order</label>
                                            </div>
                                        </div>--%>
                                        <div class="col-md-3" style="padding-top: 20px;">
                                            <label>
                                                <input type="checkbox" ng-model="Question.IsMandatory">
                                                Is Mandatory
                                            </label>
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                        <div class="form-group form-md-line-input form-md-floating-label has-info col-md-12">
                                            <textarea type="text" ng-class="{'form-control edited' : Question.EnTitle != '', 'form-control' : Question.EnTitle == ''}" ng-model="Question.EnTitle"></textarea>
                                            <label for="form_control_2">Question (En)</label>
                                        </div>

                                    </div>
                                    <div class="col-md-12">
                                        <div class="form-group form-md-line-input form-md-floating-label has-info col-md-12">
                                            <textarea type="text" ng-class="{'form-control edited' : Question.ArTitle != '', 'form-control' : Question.ArTitle == ''}" ng-model="Question.ArTitle"></textarea>
                                            <label for="form_control_2">Question (Ar)</label>
                                        </div>
                                    </div>
                                    <div class="col-md-12" id="QuestionAnswers" ng-show="Question.BankQuestionTypeID !=1">
                                        <hr />
                                        <h3 class="font-dark">Answers</h3>
                                        <hr />
                                        <div class="col-md-12">

                                            <div class="form-group form-md-line-input form-md-floating-label has-info col-md-6">
                                                <input type="text" ng-class="{'form-control edited' : QuestionAnswer.EnName != '', 'form-control' : QuestionAnswer.EnName == ''}" ng-model="QuestionAnswer.EnName">
                                                <label for="form_control_2">Answer (En)</label>
                                            </div>
                                            <div class="form-group form-md-line-input form-md-floating-label has-info col-md-6">
                                                <input type="text" ng-class="{'form-control edited' : QuestionAnswer.ArName != '', 'form-control' : QuestionAnswer.ArName == ''}" ng-model="QuestionAnswer.ArName">
                                                <label for="form_control_2">Answer (Ar)</label>
                                            </div>
                                        </div>

                                        <div class="col-md-12 ">
                                            <div class="form-group form-md-line-input form-md-floating-label has-info col-md-3">
                                                <input type="text" ng-class="{'form-control edited' : QuestionAnswer.Weight != '', 'form-control' : QuestionAnswer.Weight == ''}" ng-model="QuestionAnswer.Weight">
                                                <label for="form_control_2">Answer Weight</label>
                                            </div>
                                            <span class="btn-right col-md-6">
                                                <a href="javascript:;" ng-disabled="!QuestionAnswer.EnName" class="btn blue" ng-click="AddAnswer()"><i class="fa fa-plus"></i>Add</a>
                                                <a href="javascript:;" ng-disabled="!QuestionAnswer.EnName" class="btn blue" ng-click="CancelAnswer()"><i class="fa fa-ban"></i>Cancel</a>
                                            </span>
                                        </div>



                                        <table class="table table-hover table-striped table-condensed table-bordered">
                                            <thead>
                                                <tr>
                                                    <td>Answer Text</td>
                                                    <td>Answer Weight</td>
                                                    <td>Actions</td>
                                                </tr>
                                            </thead>
                                            <tr ng-repeat="QuestionAnswer in QuestionAnswers">
                                                <td>{{QuestionAnswer.EnName}}</td>
                                                <td>{{QuestionAnswer.Weight}}</td>
                                                <td>
                                                    <a href="javascript:;" ng-click="editAnswer(QuestionAnswer)" class="btn btn-xs blue"><i class="fa fa-edit"></i>Edit </a>
                                                    <a href="javascript:;" ng-click="DeleteAnswer(QuestionAnswer)" class="btn btn-xs red"><i class="fa fa-trash"></i>Delete </a>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="cok-md-12" id="GridSubQuestions" ng-show="Question.QuestionTypeID ==5 || Question.QuestionTypeID ==6">
                                        <div id="GridSubQuestionsMaster">
                                            <h3 class="font-dark">Sub-Questions</h3>
                                            <hr />
                                            <div class="col-md-12 form-group form-md-line-input has-info">
                                                <span class="pull-right">
                                                    <a href="javascript:;" class="btn blue" ng-click="AddSubQuestion()"><i class="fa fa-plus"></i>Add Sub-Question</a>
                                                </span>
                                                <table class="table table-hover table-striped table-condensed table-bordered">
                                                    <thead>
                                                        <tr>
                                                            <td>Sub-Question Text</td>
                                                            <td>Actions</td>
                                                        </tr>
                                                    </thead>
                                                    <tr ng-repeat="SubQuestion in SubQuestions">
                                                        <td>{{SubQuestion.EnTitle}}</td>
                                                        <td>
                                                            <a href="javascript:;" ng-click="editSubQuestion(SubQuestion)" class="btn btn-xs blue"><i class="fa fa-edit"></i>Edit </a>
                                                            <a href="javascript:;" ng-click="DeleteSubQuestion(SubQuestion)" class="btn btn-xs red"><i class="fa fa-trash"></i>Delete </a>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </div>
                                        <div id="GridSubQuestionsDetail" style="display: none">
                                            <h3 class="font-dark">Sub-Question Details
                                                                    <button type="button" ng-click="CancelSubQuestion()" class="btn btn-sm dark btn-outline pull-right">Back to Sub-Questions</button>
                                            </h3>
                                            <hr />
                                            <div class="col-md-12 form-group form-md-line-input has-info">
                                                <div class="col-md-12 form-group form-md-line-input form-md-floating-label has-info">
                                                    <div class="input-group input-group-sm disable-target">
                                                        <div class="input-group-control col-md-4">
                                                            <textarea type="text" ng-class="{'form-control edited' : SubQuestion.EnTitle != '', 'form-control' : SubQuestion.EnTitle == ''}" ng-model="SubQuestion.EnTitle"></textarea>
                                                            <label for="form_control_2">Sub-Question (En)</label>
                                                        </div>
                                                        <div class="input-group-control col-md-4">
                                                            <textarea type="text" ng-class="{'form-control edited' : SubQuestion.ArTitle != '', 'form-control' : SubQuestion.ArTitle == ''}" ng-model="SubQuestion.ArTitle"></textarea>
                                                            <label for="form_control_2">Sub-Question (Ar)</label>
                                                        </div>
                                                        <span class="input-group-btn btn-right">
                                                            <a href="javascript:;" ng-disabled="!SubQuestion.EnTitle" class="btn blue" ng-click="SaveSubQuestion()"><i class="fa fa-plus"></i>Add</a>
                                                            <a href="javascript:;" ng-disabled="!SubQuestion.EnTitle" class="btn blue" ng-click="CancelSubQuestion()"><i class="fa fa-ban"></i>Cancel</a>
                                                        </span>
                                                    </div>
                                                </div>
                                                <%-- <hr />
                                                                    <h3 class="font-dark">Answers</h3>
                                                                    <hr />
                                                                    <div class="col-md-12 form-group form-md-line-input has-info">
                                                                        <div class="input-group input-group-sm">
                                                                            <div class="input-group-control">
                                                                                <input type="text" ng-class="{'form-control edited' : Survey.ArName != '', 'form-control' : Survey.ArName == ''}" ng-model="SubQuestionAnswer.EnName">
                                                                                <label for="form_control_2">Answer</label>
                                                                            </div>
                                                                            <span class="input-group-btn btn-right">
                                                                                <a href="javascript:;" ng-disabled="!SubQuestionAnswer.EnName" class="btn blue" ng-click="AddSubQuestionAnswer()"><i class="fa fa-plus"></i>Add</a>
                                                                            </span>
                                                                        </div>
                                                                    </div>
                                                                    <table class="table table-hover table-striped table-condensed table-bordered">
                                                                        <thead>
                                                                            <tr>
                                                                                <td>Answer Text</td>
                                                                                <td>Actions</td>
                                                                            </tr>
                                                                        </thead>
                                                                        <tr ng-repeat="SubQuestionAnswer in SubQuestionAnswers">
                                                                            <td>{{SubQuestionAnswer.EnName}}</td>
                                                                            <td>
                                                                                <a href="javascript:;" class="btn btn-xs blue"><i class="fa fa-edit"></i>Edit </a>
                                                                                <a href="javascript:;" class="btn btn-xs red"><i class="fa fa-trash"></i>Delete </a>
                                                                            </td>
                                                                        </tr>
                                                                    </table>--%>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row pull-right" style="padding-right: 15px">
                                        <button type="button" class="btn default" ng-click="CancelQuestion()">Cancel</button>
                                        <button type="button" class="btn green" ng-click="SaveQuestion()">Save Question</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CPHScripts" runat="server">
    <script src="../scripts/angular.min.js"></script>
    <script src="../scripts/sweetalert2.min.js"></script>
    <script src="../scripts/BankQuestionsController.js"></script>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="CPHScriptsAfter" runat="server">
</asp:Content>
