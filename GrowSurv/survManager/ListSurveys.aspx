<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="ListSurveys.aspx.cs" Inherits="GrowSurv.survManager.ListSurvies" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- BEGIN PAGE LEVEL PLUGINS -->
    <link href="../assets/global/plugins/bootstrap-daterangepicker/daterangepicker.min.css" rel="stylesheet" type="text/css" />
    <link href="../assets/global/plugins/bootstrap-datepicker/css/bootstrap-datepicker3.min.css" rel="stylesheet" type="text/css" />
    <link href="../assets/global/plugins/bootstrap-timepicker/css/bootstrap-timepicker.min.css" rel="stylesheet" type="text/css" />
    <link href="../assets/global/plugins/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css" />
    <link href="../assets/global/plugins/clockface/css/clockface.css" rel="stylesheet" type="text/css" />
    <link href="../assets/global/plugins/bootstrap-select/css/bootstrap-select.min.css" rel="stylesheet" type="text/css" />
    <!-- END PAGE LEVEL PLUGINS -->
</asp:Content>
<asp:Content runat="server" ID="Content3" ContentPlaceHolderID="CPHScripts">
    <script src="../scripts/angular.min.js"></script>
    <script src="../scripts/SurveyManager.js"></script>
    <script src="../scripts/sweetalert2.min.js"></script>

    <!-- BEGIN PAGE LEVEL PLUGINS -->
    <script src="../assets/global/plugins/moment.min.js" type="text/javascript"></script>
    <script src="../assets/global/plugins/bootstrap-daterangepicker/daterangepicker.min.js" type="text/javascript"></script>
    <script src="../assets/global/plugins/bootstrap-datepicker/js/bootstrap-datepicker.min.js" type="text/javascript"></script>
    <script src="../assets/global/plugins/bootstrap-timepicker/js/bootstrap-timepicker.min.js" type="text/javascript"></script>
    <script src="../assets/global/plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
    <script src="../assets/global/plugins/clockface/js/clockface.js" type="text/javascript"></script>

    <script src="../assets/global/plugins/bootstrap-select/js/bootstrap-select.min.js" type="text/javascript"></script>

    <!-- END PAGE LEVEL PLUGINS -->

    <!-- BEGIN PAGE LEVEL SCRIPTS -->
    <script src="../assets/pages/scripts/components-date-time-pickers.js" type="text/javascript"></script>
    <!-- END PAGE LEVEL SCRIPTS -->
</asp:Content>
<asp:Content runat="server" ID="content4" ContentPlaceHolderID="CPHScriptsAfter">
    <script src="../assets/pages/scripts/components-bootstrap-select.min.js" type="text/javascript"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:HiddenField runat="server" ID="CurrentCompany" ClientIDMode="Static" Value="0" />
    <div class="row">
        <div class="col-md-12" ng-app="globalApp" ng-cloak ng-controller="SurveyController">
            <div id="Listsurveys">
                <div class="portlet light ">
                    <div class="portlet-title">
                        <div class="caption col-md-3">
                            <i class="icon-list font-green-sharp"></i>
                            <span class="caption-subject font-green-sharp sbold">My Surveys</span>
                        </div>
                        <div class="col-md-6" style="padding: 0">
                            <div class="col-md-6">
                                <input type="text" class="col-md-12 form-control" placeholder="Search surveys" ng-model="filterTxt" ng-keydown="$event.keyCode === 13 && getAllSurveys()" />
                            </div>
                            <div class="col-md-6">

                                <select class="bs-select form-control" data-live-search="true" id="filterCompany" data-size="8" ng-model="SelectedCompany">
                                    <%if(User.IsInRole("admin")) {%> <option value="0">All</option><%} %>
                                    <option ng-repeat="item in Companies" ng-value="item.CompanyID">{{item.EnName}}</option>
                                </select>
                            </div>
                        </div>
                        <div class="actions col-md-3" style="padding: 0">
                            <a class="btn blue btn-outline sbold" ng-click="getAllSurveys()" href="#">Search </a>
                            <a class="btn blue btn-outline sbold" href="#" ng-click="AddNew()">Add Survey </a>
                        </div>
                        <div class="portlet-body">
                            <table class="table table-hover table-striped table-bordered">
                                <thead>
                                    <tr>
                                        <td style="width: 30%">Title</td>
                                        <td style="width: 20%">Company</td>
                                        <td style="width: 10%">Expiry Date</td>
                                        <td>Actions</td>
                                    </tr>
                                </thead>
                                <tr ng-repeat="item in Surveys">
                                    <td>{{item.EnName}}</td>
                                    <td>{{item.CompanyEnName}}</td>
                                    <td>{{item.ExpiryDate | date : 'dd/MM/yyyy' }}</td>
                                    <td>
                                        <a href="javascript:;" class="btn blue" ng-click="EditSurvey(item.SurveyID)"><i class="fa fa-edit"></i> Edit </a>
                                        <a href="javascript:;" class="btn red" ng-click="deleteSurvey(item.SurveyID)"><i class="fa fa-trash"></i> Delete </a>
                                        <a href="javascript:;" ng-show="!item.IsPublic" class="btn green" ng-click="PublishSurvey(item.SurveyID)"><i class="fa fa-send"></i> Publish 
                                             <i class="fa fa-spinner fa-spin" ng-show="PublishStatus.PublishingToAll && PublishStatus.SurveyID == item.SurveyID"></i>
                                        </a>

                                        <div class="actions" style="display: inline-block">
                                            <div class="btn-group">
                                                <a class="btn btn-sm default dropdown-toggle" href="javascript:;" data-toggle="dropdown">More
                                                <i class="fa fa-angle-down"></i>
                                                </a>
                                                <ul class="dropdown-menu pull-right">
                                                    <li>
                                                        <a href="javascript:;" ng-click="ViewReports(item.SurveyID)"><i class="fa fa-dashboard"></i> Reports </a>
                                                    </li>
                                                    <li>
                                                        <a href="javascript:;" ng-click="DuplicateSurvey(item.SurveyID)">
                                                            <i class="fa fa-copy"></i> Duplicate Survey </a>
                                                    </li>
                                                    <%--                                                <li>
                                                    <a href="javascript:;">
                                                        <i class="fa fa-share-square-o"></i> Import questions </a>
                                                </li>--%>
                                                </ul>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div id="SurveyDetails" style="display: none">
                <div class="portlet light">
                    <div class="portlet-title">
                        <div class="caption">
                            <span class="caption-subject uppercase">Add/Edit Survey</span>
                        </div>
                        <div style="float:left;width:30%;text-align:right;padding:10px 0;font-size:18px;line-height:18px;">
                            Survey Name : 
                            {{Survey.EnName}}
                        </div>
                        <div class="actions">
                            <button type="button" ng-click="Cancel()" class="btn dark btn-outline">Back to Surveys</button>
                        </div>
                    </div>
                    <div class="portlet-body form">
                        <div class="row">
                            <div class="col-md-3 col-sm-3 col-xs-3">
                                <ul class="nav nav-tabs tabs-left">
                                    <li class="active">
                                        <a href="#tab_Main" data-toggle="tab">Main Data</a>
                                    </li>
                                    <li>
                                        <a href="#tab_QuestionCategories" ng-hide="!EditMode" data-toggle="tab">Question Categories</a>
                                    </li>
                                    <li>
                                        <a href="#tab_QuestionBranches" ng-hide="!EditMode" data-toggle="tab">Question Branches</a>
                                    </li>
                                    <li>
                                        <a href="#tab_Questions" ng-hide="!EditMode" data-toggle="tab">Questions </a>
                                    </li>
                                    <li style="display:none;">
                                        <a href="#tab_skipLogic" ng-hide="!EditMode" data-toggle="tab">skip logic rules </a>
                                    </li>
                                    <li>
                                        <a href="#tab_Branching" ng-hide="!EditMode" data-toggle="tab">Branching rules </a>
                                    </li>
                                    <li>
                                        <a href="#tab_PublishList" ng-hide="!EditMode" data-toggle="tab">Publish List </a>
                                    </li>
                                    <li>
                                        <a href="#tab_Weights" ng-hide="!EditMode" data-toggle="tab">Demographics weights </a>
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-9 col-sm-9 col-xs-9">
                                <div class="tab-content">
                                    <div class="tab-pane active" id="tab_Main">
                                        <h3 class="font-dark">Main Data</h3>
                                        <hr />

                                        <div class="form-body" ng-form name="mainsurveyData">
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <div class="form-group form-md-line-input form-md-floating-label has-info">
                                                        <select class="form-control edited" id="form_control_1" ng-model="SelectedCompany" required>
                                                            <option ng-repeat="item in Companies" ng-value="item.CompanyID">{{item.EnName}}</option>
                                                        </select>
                                                        <label for="form_control_1">Company</label>
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="form-group form-md-line-input form-md-floating-label has-info">
                                                       <label>
                                                        <input type="checkbox" ng-model="Survey.IsPublic">
                                                        Public Survey 
                                                    </label>
                                                    </div>
                                                </div>
                                            </div>
                                             <div class="row" ng-show="Survey.IsPublic">            
                                                 <div class="form-group form-md-line-input form-md-floating-label has-info">                                     
                                                 <input type="text" class="form-control edited" readonly ng-model="Survey.PublicURL" id="form_control_public" />
                                                 <label for="form_control_public">Public URL</label>
                                                     </div>
                                                 </div>
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group form-md-line-input form-md-floating-label has-info">
                                                        <input type="text" ng-class="{'form-control edited' : Survey.EnName != '', 'form-control' : Survey.EnName == ''}" id="form_control_2" ng-model="Survey.EnName" required>
                                                        <label for="form_control_2">English Title</label>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group form-md-line-input form-md-floating-label has-info">
                                                        <input type="text" ng-class="{'form-control edited' : Survey.ArName != '', 'form-control' : Survey.ArName == ''}" id="form_control_2_1" ng-model="Survey.ArName" required>
                                                        <label for="form_control_2">Arabic Title</label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group form-md-line-input form-md-floating-label has-info">
                                                        <textarea rows="3" ng-class="{'form-control edited' : Survey.EnDesc != '', 'form-control' : Survey.EnDesc == ''}" id="form_control_3" ng-model="Survey.EnDesc"></textarea>
                                                        <label for="form_control_2">English Invitation </label>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group form-md-line-input form-md-floating-label has-info">
                                                        <textarea rows="3" ng-class="{'form-control edited' : Survey.ArDesc != '', 'form-control' : Survey.ArDesc == ''}" id="form_control_3_1" ng-model="Survey.ArDesc"></textarea>
                                                        <label for="form_control_2">Arabic Invitation </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group form-md-line-input form-md-floating-label has-info">
                                                        <textarea rows="3" ng-class="{'form-control edited' : Survey.EnHeader != '', 'form-control' : Survey.EnHeader == ''}" id="form_control_4" ng-model="Survey.EnHeader"></textarea>
                                                        <label for="form_control_2">English Header</label>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group form-md-line-input form-md-floating-label has-info">
                                                        <textarea rows="3" ng-class="{'form-control edited' : Survey.ArHeader != '', 'form-control' : Survey.ArHeader == ''}" id="form_control_4_1" ng-model="Survey.ArHeader"></textarea>
                                                        <label for="form_control_2">Arabic Header</label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group form-md-line-input form-md-floating-label has-info">
                                                        <textarea rows="3" ng-class="{'form-control edited' : Survey.EnFooter != '', 'form-control' : Survey.EnFooter == ''}" ng-model="Survey.EnFooter"></textarea>
                                                        <label for="form_control_2">English Footer</label>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group form-md-line-input form-md-floating-label has-info">
                                                        <textarea rows="3" ng-class="{'form-control edited' : Survey.ArFooter != '', 'form-control' : Survey.ArFooter == ''}" ng-model="Survey.ArFooter"></textarea>
                                                        <label for="form_control_2">Arabic Footer</label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group form-md-line-input form-md-floating-label has-info">
                                                         <input type="text" ng-class="{'form-control edited' : Survey.EmailSubject != '', 'form-control' : Survey.EmailSubject == ''}" id="form_control_2" ng-model="Survey.EmailSubject" required>
                                                        <label for="form_control_2">Email subject</label>
                                                    </div>
                                                </div>
                                                
                                            </div>
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group form-md-line-input form-md-floating-label has-info">
                                                        <textarea rows="3" ng-class="{'form-control edited' : Survey.EmailBody != '', 'form-control' : Survey.EmailBody == ''}" ng-model="Survey.EmailBody"></textarea>
                                                        <label for="form_control_2">Email body</label>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group form-md-line-input form-md-floating-label has-info">
                                                        <textarea rows="3" ng-class="{'form-control edited' : Survey.ArEmailBody != '', 'form-control' : Survey.ArEmailBody == ''}" ng-model="Survey.ArEmailBody"></textarea>
                                                        <label for="form_control_2">Arabic Email body</label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <h4>Expiry Date</h4>
                                                    <div class="input-group input-medium date date-picker" data-date-format="mm/dd/yyyy" data-date-start-date="+0d">
                                                        <input type="text" ng-class="{'form-control edited' : Survey.ArName != '', 'form-control' : Survey.ArName == ''}" readonly ng-model="Survey.ExpiryDate" required>
                                                        <span class="input-group-btn">
                                                            <button class="btn default" type="button">
                                                                <i class="fa fa-calendar"></i>
                                                            </button>
                                                        </span>
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="form-group form-md-line-input form-md-floating-label has-info">
                                                        <select class="form-control edited" id="form_control_3" ng-model="Survey.SurveyTypeID" required>
                                                            <option ng-repeat="type in SurveyTypes" ng-value="type.SurveyTypeID">{{type.TypeNameEn}}</option>
                                                        </select>
                                                        <label for="form_control_3">Survey Type</label>
                                                    </div>
                                                </div>
                                                <div class="col-md-4" ng-show="Survey.SurveyTypeID == 2">
                                                    <h4>Duration</h4>
                                                    <div class="input-group">
                                                        <input type="text" class="form-control timepicker timepicker-24" ng-model="Survey.Duration" ng-required="Survey.SurveyTypeID == 2">
                                                        <span class="input-group-btn">
                                                            <button class="btn default" type="button">
                                                                <i class="fa fa-clock-o"></i>
                                                            </button>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
  													<label>
                                                        <input type="checkbox" ng-model="Survey.SkipDemographicPage">
                                                        Skip Demographic Page 
                                                    </label>
                                                <div class="col-md-12">
                                                    <h3>What are the mandatory fields to be filled ?
                                                    </h3>
                                                    <hr />
                                                    <label>
                                                        <input type="checkbox" ng-model="Survey.IsCountryMandatory">
                                                        Country 
                                                    </label>
                                                    <label>
                                                        <input type="checkbox" ng-model="Survey.IsGovernrateMandatory">
                                                        State 
                                                    </label>
                                                    <label>
                                                        <input type="checkbox" ng-model="Survey.IsAreaMandatory">
                                                        Area
                                                    </label>
                                                    <label>
                                                        <input type="checkbox" ng-model="Survey.IsBranchMandatory">
                                                        Branch
                                                    </label>
                                                    <label>
                                                        <input type="checkbox" ng-model="Survey.IsDepartmentMandatory">
                                                        Department
                                                    </label>
                                                    <label>
                                                        <input type="checkbox" ng-model="Survey.IsDivisionMandatory">
                                                        Division 
                                                    </label>
                                                    <label>
                                                        <input type="checkbox" ng-model="Survey.IsLevelMandatory">
                                                        Level
                                                    </label>
                                                    <label>
                                                        <input type="checkbox" ng-model="Survey.IsGradeMandatory">
                                                        Grade
                                                    </label>
                                                    <label>
                                                        <input type="checkbox" ng-model="Survey.IsJobTitleMandatory">
                                                        Job Title
                                                    </label>
                                                    <label>
                                                        <input type="checkbox" ng-model="Survey.IsGenderMandatory">
                                                        Gender
                                                    </label>
                                                    <label>
                                                        <input type="checkbox" ng-model="Survey.IsAgeMandatory">
                                                        Age
                                                    </label>
                                                    <label>
                                                        <input type="checkbox" ng-model="Survey.IsDurationMandatory">
                                                        Hiring Date
                                                    </label>
                                                    <label>
                                                        <input type="checkbox" ng-model="Survey.IsRecentPromotionDateMandatory">
                                                        Recent Promotion Date
                                                    </label>
                                                </div>
                                            </div>
                                            <div class="form-actions noborder pull-right" style="padding-right: 25px">
                                                <button type="button" class="btn default" ng-click="Cancel()">Cancel</button>
                                                <button type="button" class="btn green" ng-click="Save()" ng-disabled="mainsurveyData.$invalid">Save changes</button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tab-pane" id="tab_QuestionCategories">
                                        <h3 class="font-dark">Question Categories</h3>
                                        <hr />
                                        <div class="col-md-12 form-group form-md-line-input has-info">
                                            <div class="input-group input-group-sm">
                                                <div class="input-group-control col-md-5">
                                                    <input type="text" ng-class="{'form-control edited' : QuestionCategory.EnName != '', 'form-control' : QuestionCategory.EnName == ''}" ng-model="QuestionCategory.EnName">
                                                    <label for="form_control_2">Category (En)</label>
                                                </div>
                                                <div class="input-group-control col-md-5">
                                                    <input type="text" ng-class="{'form-control edited' : QuestionCategory.ArName != '', 'form-control' : QuestionCategory.ArName == ''}" ng-model="QuestionCategory.ArName">
                                                    <label for="form_control_2">Category (Ar)</label>
                                                </div>
                                                <span class="input-group-btn btn-right">
                                                    <a href="javascript:;" ng-disabled="!QuestionCategory.EnName" class="btn blue" ng-click="AddQuestionCategory()"><i class="fa fa-plus"></i>Add</a>
                                                    <a href="javascript:;" ng-disabled="!QuestionCategory.EnName" class="btn blue" ng-click="CancelQuestionCategory()"><i class="fa fa-ban"></i>Cancel</a>
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
                                            <tr ng-repeat="QuestionCategory in QuestionCategories">
                                                <td>{{QuestionCategory.EnName}}</td>
                                                <td>
                                                    <a href="javascript:;" ng-click="EditQuestionCategory(QuestionCategory.CategoryID)" class="btn btn-xs blue"><i class="fa fa-edit"></i>Edit </a>
                                                    <a href="javascript:;" ng-click="DeleteQuestionCategory(QuestionCategory.CategoryID)" class="btn btn-xs red"><i class="fa fa-trash"></i>Delete </a>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="tab-pane" id="tab_QuestionBranches">
                                        <h3 class="font-dark">Question Branches</h3>
                                        <hr />
                                        <div class="col-md-12 form-group form-md-line-input has-info">
                                            <div class="input-group input-group-sm">
                                                <div class="input-group-control col-md-5">
                                                    <input type="text" ng-class="{'form-control edited' : QuestionBranch.EnName != '', 'form-control' : QuestionBranch.EnName == ''}" ng-model="QuestionBranch.EnName">
                                                    <label for="form_control_2">Branch (En)</label>
                                                </div>
                                                <div class="input-group-control col-md-5">
                                                    <input type="text" ng-class="{'form-control edited' : QuestionBranch.ArName != '', 'form-control' : QuestionBranch.ArName == ''}" ng-model="QuestionBranch.ArName">
                                                    <label for="form_control_2">Branch (Ar)</label>
                                                </div>
                                                <span class="input-group-btn btn-right col-md-6">
                                                    <a href="javascript:;" ng-disabled="!QuestionBranch.EnName" class="btn blue" ng-click="AddQuestionBranch()"><i class="fa fa-plus"></i>Add</a>
                                                    <a href="javascript:;" ng-disabled="!QuestionBranch.EnName" class="btn blue" ng-click="CancelQuestionBranch()"><i class="fa fa-ban"></i>Cancel</a>

                                                </span>
                                            </div>
                                        </div>
                                        <table class="table table-hover table-striped table-condensed table-bordered">
                                            <thead>
                                                <tr>
                                                    <td>Branch Name</td>
                                                    <td>Actions</td>
                                                </tr>
                                            </thead>
                                            <tr ng-repeat="QuestionBranch in QuestionBranches">
                                                <td>{{QuestionBranch.EnName}}</td>
                                                <td>
                                                    <a href="javascript:;" ng-click="EditQuestionBranch(QuestionBranch.QuestionBranchID)" class="btn btn-xs blue"><i class="fa fa-edit"></i>Edit </a>
                                                    <a href="javascript:;" ng-click="DeleteQuestionBranch(QuestionBranch.QuestionBranchID)" class="btn btn-xs red"><i class="fa fa-trash"></i>Delete </a>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="tab-pane" id="tab_Questions">
                                        <div class="col-md-12">
                                            <div id="QuestionList">
                                                <h3 class="font-dark">Questions</h3>
                                                <hr />
                                                <div class="col-md-12 margin-bottom-10">
                                                    <a class="btn blue btn-outline sbold" href="#" ng-click="AddNewQuestion()">Add Question </a>
                                                    <a class="btn blue-hoki btn-outline sbold" href="#" ng-click="AddNewImportedQuestion()">Import Question From Survey</a>
                                                    <a class="btn blue-madison btn-outline sbold" href="#" ng-click="AddNewImportedQuestionFromBank()">Import Question From Questions Bank</a>
                                                </div>
                                                <div class="col-md-12 margin-bottom-10">
                                                    <table class="table table-hover table-striped table-condensed table-bordered">
                                                        <thead>
                                                            <tr>
                                                                <td style="width:40%">Title</td>
                                                                <td style="width:20%">Type</td>
                                                                <td style="width:10%">Order</td>
                                                                <td style="width:15%">Actions</td>                                                           
                                                            </tr>
                                                        </thead>
                                                        <tr ng-repeat="item in Questions">
                                                            <td>{{item.EnTitle}}</td>
                                                            <td>{{item.QuestionTypeName}}</td>
                                                             <td>
                                                                <div class="form-group form-md-line-input form-md-floating-label has-info">
                                                                    <input type="text" class="form-control edited" ng-model="item.QuestionOrder" />
                                                                </div>
                                                               </td>
                                                            <td style="min-width:250px">
                                                                <a href="javascript:;" class="btn btn-xs blue" ng-click="editQuestion(item)"><i class="fa fa-edit"></i>Edit </a>
                                                                <a href="javascript:;" class="btn btn-xs blue-ebonyclay" ng-click="duplicateQuestion(item)"><i class="fa fa-copy"></i>Duplicate </a>
                                                                <a href="javascript:;" class="btn btn-xs red" ng-click="deleteQuestion(item)"><i class="fa fa-trash"></i>Delete </a>
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
                                                                <select ng-class="{'form-control edited' : Question.QuestionTypeID != '', 'form-control' : Question.QuestionTypeID == ''}" ng-model="Question.QuestionTypeID">
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
                                                                <select ng-class="{'form-control edited' : Question.CategoryID != '', 'form-control' : Question.CategoryID == ''}" ng-model="Question.CategoryID">
                                                                    <option ng-repeat="item in QuestionCategories" ng-value="item.CategoryID">{{item.EnName}}</option>
                                                                </select>
                                                                <label for="form_control_1">Question Category</label>
                                                            </div>
                                                            <div class="col-md-1">&nbsp;</div>
                                                            <div class="col-md-3 form-group form-md-line-input form-md-floating-label has-info">
                                                                <select ng-class="{'form-control edited' : Question.BranchID != '', 'form-control' : Question.BranchID == ''}" ng-model="Question.BranchID">
                                                                    <option ng-value="0">Main Branch</option>
                                                                    <option ng-repeat="item in QuestionBranches" ng-value="item.QuestionBranchID">{{item.EnName}}</option>
                                                                </select>
                                                                <label for="form_control_1">Question Branch</label>
                                                            </div>
                                                            <div class="col-md-2">
                                                                <div class="form-group form-md-line-input form-md-floating-label has-info">
                                                                    <input type="text" ng-class="{'form-control edited' : Question.QuestionOrder != '', 'form-control' : Question.QuestionOrder == ''}" ng-model="Question.QuestionOrder">
                                                                    <label for="form_control_2">Order</label>
                                                                </div>
                                                            </div>
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
                                                        <div class="col-md-12" id="QuestionAnswers" ng-show="Question.QuestionTypeID !=1">
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
                                                            <button type="button" ng-disabled="!Question.EnTitle || !Question.QuestionTypeID || !Question.CategoryID " class="btn green" ng-click="SaveQuestion()">Save Question</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div id="SurveyListToImportQuestion" style="display: none">
                                                <div class="form-body">
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <h3 class="font-dark">Select the Survey having the question you want to import
                                                                <button type="button" ng-click="CancelImportQuestion()" class="btn btn-sm dark btn-outline pull-right">Back to Questions</button>
                                                            </h3>
                                                            <hr />
                                                            <div class="col-md-12" style="padding-bottom: 15px">
                                                                <div class="col-md-4" style="padding:0">
                                                                    <input type="text" class="form-control" placeholder="Search surveys" ng-model="filterTxt" ng-keydown="$event.keyCode === 13 && getAllSurveys()" />
                                                                </div>
                                                                <div class="col-md-4">
                                                                    <a class="btn blue btn-outline sbold" ng-click="getAllSurveys()" href="#">Search </a>
                                                                </div>

                                                            </div>
                                                            <div class="portlet-body">
                                                                <table class="table table-hover table-striped table-bordered">
                                                                    <thead>
                                                                        <tr>
                                                                            <td style="width: 30%">Title</td>
                                                                            <td style="width: 20%">Company</td>
                                                                            <td style="width: 10%">Expiry Date</td>
                                                                            <td>Actions</td>
                                                                        </tr>
                                                                    </thead>
                                                                    <tr ng-repeat="item in Surveys">
                                                                        <td>{{item.EnName}}</td>
                                                                        <td>{{item.CompanyEnName}}</td>
                                                                        <td>{{item.ExpiryDate | date : 'dd/MM/yyyy' }}</td>
                                                                        <td>
                                                                            <a href="javascript:;" class="btn blue" ng-click="showSurveyQuestionsToImport(item.SurveyID)"><i class="fa fa-list"></i>Show Questions </a>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div id="QuestionsListToImportQuestion" style="display: none">
                                                <div class="form-body">
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <h3 class="font-dark">Select the Question you want to import
                                                                <button type="button" ng-click="CancelImportQuestionInternal()" class="btn btn-sm dark btn-outline pull-right">Back to Surveys</button>
                                                            </h3>
                                                            <hr />
                                                            <div class="portlet-body">
                                                                <table class="table table-hover table-striped table-condensed table-bordered">
                                                                    <thead>
                                                                        <tr>
                                                                            <td>Check</td>
                                                                            <td>Title</td>
                                                                            <td>Type</td>
<%--                                                                            <td>Actions</td>--%>
                                                                        </tr>
                                                                    </thead>
                                                                    <tr ng-repeat="item in QuestionsToImport">
                                                                        <td>
                                                                            <%--<input type="checkbox" class="" ng-model="item.IsChecked" />--%>
                                                                            <a class="btn btn-circle btn-sm font-lg grey" ng-click="item.IsChecked = true" ng-if="!item.IsChecked"><i class="fa fa-circle-o"></i></a>
                                                                            <a class="btn btn-circle btn-sm font-lg green-jungle" ng-click="item.IsChecked = false" ng-if="item.IsChecked"><i class="fa fa-check-circle-o"></i></a>
                                                                        </td>
                                                                        <td>{{item.EnTitle}}</td>
                                                                        <td>{{item.QuestionTypeName}}</td>
<%--                                                                        <td>
                                                                            <a href="javascript:;" class="btn btn-xs blue" ng-click="importQuestion(item)"><i class="fa fa-copy"></i>Import Question </a>
                                                                        </td>--%>
                                                                    </tr>
                                                                </table>
                                                                <div class="col-md-12 text-center">
                                                                    <a href="javascript:;" class="btn blue" ng-click="importQuestionBulk()"><i class="fa fa-copy"></i> Import Selected Questions </a>
                                                                </div>
                                                            </div>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div id="QuestionsBankToImportQuestion" style="display: none">
                                                <div class="form-body">
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <h3 class="font-dark">Select the Questions you want to import
                                                                <button type="button" ng-click="CancelImportBankQuestion()" class="btn btn-sm dark btn-outline pull-right">Back to Questions</button>
                                                            </h3>
                                                            <hr />
                                                            <div class="portlet-body">
                                                                <table class="table table-hover table-striped table-condensed table-bordered">
                                                                    <thead>
                                                                        <tr>
                                                                            <td>Check</td>
                                                                            <td>Title</td>
                                                                            <td>Type</td>
<%--                                                                            <td>Actions</td>--%>
                                                                        </tr>
                                                                    </thead>
                                                                    <tr ng-repeat="item in BankQuestionsToImport">
                                                                        <td>
                                                                            <%--<input type="checkbox" class="" ng-model="item.IsChecked" />--%>
                                                                            <a class="btn btn-circle btn-sm font-lg grey" ng-click="item.IsChecked = true" ng-if="!item.IsChecked"><i class="fa fa-circle-o"></i></a>
                                                                            <a class="btn btn-circle btn-sm font-lg green-jungle" ng-click="item.IsChecked = false" ng-if="item.IsChecked"><i class="fa fa-check-circle-o"></i></a>
                                                                        </td>
                                                                        <td>{{item.EnTitle}}</td>
                                                                        <td>{{item.QuestionTypeName}}</td>
<%--                                                                        <td>
                                                                            <a href="javascript:;" class="btn btn-xs blue" ng-click="importQuestion(item)"><i class="fa fa-copy"></i>Import Question </a>
                                                                        </td>--%>
                                                                    </tr>
                                                                </table>
                                                                <div class="col-md-12 text-center">
                                                                    <a href="javascript:;" class="btn blue" ng-click="importBankQuestionBulk()"><i class="fa fa-copy"></i> Import Selected Questions </a>
                                                                </div>
                                                            </div>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="tab-pane" id="tab_skipLogic">
                                        <h3 class="font-dark">Skip Logic</h3>
                                        <hr />
                                        <div class="col-md-12 form-group form-md-line-input has-info">
                                            <div class="col-md-6">
                                                <div class="form-group form-md-line-input form-md-floating-label has-info">
                                                    <select class="form-control edited" ng-change="loadBranchingQuestionAnswers()" ng-model="BranchingQuestion.QuestionID" id="form_control_1">
                                                        <option ng-repeat="item in McQuestions" ng-value="item.QuestionID">{{item.EnTitle}}</option>
                                                    </select>
                                                    <label for="form_control_1">Question</label>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group form-md-line-input form-md-floating-label has-info">
                                                    <select class="form-control edited" id="form_control_1" ng-model="BranchingQuestion.AnswerID">
                                                        <option ng-repeat="item in BranchingQuestionAnswers" ng-value="item.AnswerID">{{item.EnName}}</option>
                                                    </select>
                                                    <label for="form_control_1">Answer</label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-12 form-group form-md-line-input has-info">
                                            <div class="col-md-3">
                                                Skip to Question :
                                            </div>
                                            <div class="col-md-5">
                                                <div class="form-group form-md-line-input form-md-floating-label has-info">
                                                    <select class="form-control edited" id="form_control_1" ng-model="BranchingQuestion.SkipToQuestionID">
                                                        <option ng-repeat="item in Questions" ng-value="item.QuestionID">{{item.EnTitle}}</option>
                                                    </select>
                                                    <label for="form_control_1">Next Question</label>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <a href="javascript:;" class="btn btn-xs green" ng-click="AddSkipLogic()">
                                                    <i class="fa fa-plus"></i>Add Rule</a>
                                                <a href="javascript:;" class="btn btn-xs green" ng-click="CancelSkipLogic()">
                                                    <i class="fa fa-ban"></i>Cancel</a>
                                            </div>
                                        </div>
                                        <table class="table table-hover table-striped table-condensed table-bordered">
                                            <thead>
                                                <tr>
                                                    <td>Question</td>
                                                    <td>Answer</td>
                                                    <td>Skip to Question</td>
                                                    <td>Actions</td>
                                                </tr>
                                            </thead>
                                            <tr ng-repeat="BranchingQuestion in SkipLogicQuestions">
                                                <td>{{BranchingQuestion.QuestionText}}</td>
                                                <td>{{BranchingQuestion.AnswerText}}</td>
                                                <td>{{BranchingQuestion.SkipToQuestionText}}</td>
                                                <td>
                                                    <a href="javascript:;" ng-click="EditSkipLogic(BranchingQuestion)" class="btn btn-xs blue"><i class="fa fa-edit"></i>Edit </a>
                                                    <a href="javascript:;" ng-click="DeleteSkipLogic(BranchingQuestion)" class="btn btn-xs red"><i class="fa fa-trash"></i>Delete </a>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="tab-pane" id="tab_Branching">
                                        <h3 class="font-dark">Branching</h3>
                                        <hr />
                                        <div class="col-md-12 form-group form-md-line-input has-info">
                                            <div class="col-md-6">
                                                <div class="form-group form-md-line-input form-md-floating-label has-info">
                                                    <select class="form-control edited" ng-change="loadBranchingQuestionAnswers()" ng-model="BranchingQuestion.QuestionID" id="form_control_1">
                                                        <option ng-repeat="item in McQuestions" ng-value="item.QuestionID">{{item.EnTitle}}</option>
                                                    </select>
                                                    <label for="form_control_1">Question</label>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group form-md-line-input form-md-floating-label has-info">
                                                    <select class="form-control edited" id="form_control_1" ng-model="BranchingQuestion.AnswerID">
                                                        <option ng-repeat="item in BranchingQuestionAnswers" ng-value="item.AnswerID">{{item.EnName}}</option>
                                                    </select>
                                                    <label for="form_control_1">Answer</label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-12 form-group form-md-line-input has-info">
                                            <div class="col-md-3">
                                                Skip to Branch :
                                            </div>
                                            <div class="col-md-5">
                                                <div class="form-group form-md-line-input form-md-floating-label has-info">
                                                    <select class="form-control edited" id="form_control_1" ng-model="BranchingQuestion.SkipToBranchID">
                                                        <option ng-repeat="item in QuestionBranches" ng-value="item.QuestionBranchID">{{item.EnName}}</option>
                                                    </select>
                                                    <label for="form_control_1">Next Branch</label>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <a href="javascript:;" class="btn btn-xs green" ng-click="AddBranchToSurvey()">
                                                    <i class="fa fa-plus"></i>Add Rule</a>
                                                <a href="javascript:;" class="btn btn-xs green" ng-click="CancelBranchSurvey()">
                                                    <i class="fa fa-ban"></i>Cancel</a>
                                            </div>
                                        </div>
                                        <table class="table table-hover table-striped table-condensed table-bordered">
                                            <thead>
                                                <tr>
                                                    <td>Question</td>
                                                    <td>Answer</td>
                                                    <td>Go to Branch</td>
                                                    <td>Actions</td>
                                                </tr>
                                            </thead>
                                            <tr ng-repeat="BranchingQuestion in BranchingQuestions">
                                                <td>{{BranchingQuestion.QuestionText}}</td>
                                                <td>{{BranchingQuestion.AnswerText}}</td>
                                                <td>{{BranchingQuestion.SkipToBranchText}}</td>
                                                <td>
                                                    <a href="javascript:;" ng-click="EditBranchSurvey(BranchingQuestion)" class="btn btn-xs blue"><i class="fa fa-edit"></i>Edit </a>
                                                    <a href="javascript:;" ng-click="DeleteBranchSurvey(BranchingQuestion)" class="btn btn-xs red"><i class="fa fa-trash"></i>Delete </a>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="tab-pane" id="tab_PublishList">
                                        <h3 class="font-dark">Publish List</h3>
                                        <hr />
                                        <div class="col-md-12 form-group form-md-line-input has-info" ng-hide="Survey.IsPublic">
                                            <div class="input-group input-group-sm" >
                                                <div class="input-group-control">
                                                    <input type="text" ng-class="{'form-control edited' : Mail.MemberEmail != '', 'form-control' : Mail.MemberEmail == ''}" ng-model="Mail.MemberEmail">
                                                    <label for="form_control_2">Mail</label>
                                                </div>
                                                <span class="input-group-btn btn-right">
                                                    <a href="javascript:;" ng-disabled="!Mail.MemberEmail" class="btn blue" ng-click="AddMail()"><i class="fa fa-plus"></i>Add</a>
                                                    <a href="javascript:;" ng-disabled="!Mail.MemberEmail" class="btn blue" ng-click="CancelEmail()"><i class="fa fa-ban"></i>Cancel</a>

                                                </span>
                                            </div>
                                        </div>
                                        <table class="table table-hover table-striped table-condensed table-bordered">
                                            <thead>
                                                <tr>
                                                    <td>Mail</td>
                                                    <td>Actions</td>
                                                </tr>
                                            </thead>
                                            <tr ng-repeat="PMail in PublishList">
                                                <td>{{PMail.MemberEmail}}</td>
                                                <td>
                                                    <a ng-hide="Survey.IsPublic" href="javascript:;" ng-click="EditEmail(PMail.MemberID)" class="btn btn-xs blue"><i class="fa fa-edit"></i>Edit </a>
                                                    <a ng-hide="Survey.IsPublic" href="javascript:;" ng-click="DeleteEMail(PMail.MemberID)" class="btn btn-xs red"><i class="fa fa-trash"></i>Delete </a>
                                                    <a ng-hide="Survey.IsPublic" href="javascript:;" ng-click="SendEMail(PMail.MemberID, PMail.SurveyID)" class="btn btn-xs green"><i class="fa fa-send"></i>Publish Survey 
                                                        <i class="fa fa-spinner fa-spin" ng-show="PublishStatus.PublishingToMember && PublishStatus.MemberID == PMail.MemberID"></i>
                                                    </a>                                        
                                                    <%if (User.IsInRole("admin"))
                                                        {%>                                                               
                                                     <a href="doreport.aspx?r=6&sid={{PMail.SurveyID}}&g=GovEnName&gd=&lang=en&mid={{PMail.MemberID}}" target="_blank" class="btn btn-xs green"><i class="fa fa-file"></i>Survey Answers                                                       
                                                    </a>
                                                    <%} %>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="tab-pane" id="tab_Weights">
                                        <h3 class="font-dark">Demographic weights</h3>
                                        <hr />
                                        <ul class="nav nav-tabs">
                                            <li class="active">
                                                <a href="#tab_Con" data-toggle="tab">Country</a>
                                            </li>
                                            <li>
                                                <a href="#tab_Gov" data-toggle="tab">State</a>
                                            </li>
                                            <li >
                                                <a href="#tab_Branch" data-toggle="tab">Branch</a>
                                            </li>
                                            <li >
                                                <a href="#tab_Department" data-toggle="tab">Department</a>
                                            </li>
                                            <li >
                                                <a href="#tab_Div" data-toggle="tab">Division</a>
                                            </li>
                                            <li >
                                                <a href="#tab_Area" data-toggle="tab">Area</a>
                                            </li>
                                            <li >
                                                <a href="#tab_Age" data-toggle="tab">Age</a>
                                            </li>
                                            <li >
                                                <a href="#tab_Level" data-toggle="tab">Level</a>
                                            </li>
                                            <li >
                                                <a href="#tab_Jt" data-toggle="tab">Job title</a>
                                            </li>
                                            <li >
                                                <a href="#tab_Grade" data-toggle="tab">Grade</a>
                                            </li>
                                            <li >
                                                <a href="#tab_Gender" data-toggle="tab">Gender</a>
                                            </li>
                                        </ul>
                                        <div class="tab-content">
                                            <div class="tab-pane" id="tab_Con">
                                                <table class="table table-hover table-striped table-condensed table-bordered">
                                                    <thead>
                                                        <tr>
                                                            <td>Country</td>
                                                            <td>Weight</td>
                                                        </tr>
                                                    </thead>
                                                    <tr ng-repeat="con in ConList">
                                                        <td>{{con.EnName}}</td>
                                                        <td>
                                                            <div class="form-group form-md-line-input form-md-floating-label has-info">
                                                                <input type="text" class="form-control edited" ng-model="con.Weight" />
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div class="tab-pane" id="tab_Gov">
                                                <table class="table table-hover table-striped table-condensed table-bordered">
                                                    <thead>
                                                        <tr>
                                                            <td>Governrate</td>
                                                            <td>Weight</td>
                                                        </tr>
                                                    </thead>
                                                    <tr ng-repeat="gov in GovList">
                                                        <td>{{gov.EnName}}</td>
                                                        <td>
                                                            <div class="form-group form-md-line-input form-md-floating-label has-info">
                                                                <input type="text" class="form-control edited" ng-model="gov.Weight" />
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div class="tab-pane" id="tab_Branch">
                                                <table class="table table-hover table-striped table-condensed table-bordered">
                                                    <thead>
                                                        <tr>
                                                            <td>Branch</td>
                                                            <td>Weight</td>
                                                        </tr>
                                                    </thead>
                                                    <tr ng-repeat="branch in BranchList">
                                                        <td>{{branch.NameEn}}</td>
                                                        <td>
                                                            <div class="form-group form-md-line-input form-md-floating-label has-info">
                                                                <input type="text" class="form-control edited" ng-model="branch.Weight" />
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div class="tab-pane" id="tab_Department">
                                                <table class="table table-hover table-striped table-condensed table-bordered">
                                                    <thead>
                                                        <tr>
                                                            <td>Department</td>
                                                            <td>Weight</td>
                                                        </tr>
                                                    </thead>
                                                    <tr ng-repeat="dept in DeptList">
                                                        <td>{{dept.EnName}}</td>
                                                        <td>
                                                            <div class="form-group form-md-line-input form-md-floating-label has-info">
                                                                <input type="text" class="form-control edited" ng-model="dept.Weight" />
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div class="tab-pane" id="tab_Div">
                                                <table class="table table-hover table-striped table-condensed table-bordered">
                                                    <thead>
                                                        <tr>
                                                            <td>Division</td>
                                                            <td>Weight</td>
                                                        </tr>
                                                    </thead>
                                                    <tr ng-repeat="div in DivList">
                                                        <td>{{div.NameEn}}</td>
                                                        <td>
                                                            <div class="form-group form-md-line-input form-md-floating-label has-info">
                                                                <input type="text" class="form-control edited" ng-model="div.Weight" />
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div class="tab-pane" id="tab_Area">
                                                <table class="table table-hover table-striped table-condensed table-bordered">
                                                    <thead>
                                                        <tr>
                                                            <td>Area</td>
                                                            <td>Weight</td>
                                                        </tr>
                                                    </thead>
                                                    <tr ng-repeat="area in AreaList">
                                                        <td>{{area.NameEn}}</td>
                                                        <td>
                                                            <div class="form-group form-md-line-input form-md-floating-label has-info">
                                                                <input type="text" class="form-control edited" ng-model="area.Weight" />
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div class="tab-pane" id="tab_Age">
                                                <table class="table table-hover table-striped table-condensed table-bordered">
                                                    <thead>
                                                        <tr>
                                                            <td>Age group</td>
                                                            <td>Weight</td>
                                                        </tr>
                                                    </thead>
                                                    <tr ng-repeat="age in AgeList">
                                                        <td>{{age.EnDisplayName}}</td>
                                                        <td>
                                                            <div class="form-group form-md-line-input form-md-floating-label has-info">
                                                                <input type="text" class="form-control edited" ng-model="age.Weight" />
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div class="tab-pane" id="tab_Level">
                                                <table class="table table-hover table-striped table-condensed table-bordered">
                                                    <thead>
                                                        <tr>
                                                            <td>Level</td>
                                                            <td>Weight</td>
                                                        </tr>
                                                    </thead>
                                                    <tr ng-repeat="level in LevelList">
                                                        <td>{{level.EnName}}</td>
                                                        <td>
                                                            <div class="form-group form-md-line-input form-md-floating-label has-info">
                                                                <input type="text" class="form-control edited" ng-model="level.Weight" />
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div class="tab-pane" id="tab_Jt">
                                                <table class="table table-hover table-striped table-condensed table-bordered">
                                                    <thead>
                                                        <tr>
                                                            <td>Job title</td>
                                                            <td>Weight</td>
                                                        </tr>
                                                    </thead>
                                                    <tr ng-repeat="jt in JobTitleList">
                                                        <td>{{jt.EnName}}</td>
                                                        <td>
                                                            <div class="form-group form-md-line-input form-md-floating-label has-info">
                                                                <input type="text" class="form-control edited" ng-model="jt.Weight" />
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div class="tab-pane" id="tab_Grade">
                                                <table class="table table-hover table-striped table-condensed table-bordered">
                                                    <thead>
                                                        <tr>
                                                            <td>Grade</td>
                                                            <td>Weight</td>
                                                        </tr>
                                                    </thead>
                                                    <tr ng-repeat="grade in GradeList">
                                                        <td>{{grade.EnName}}</td>
                                                        <td>
                                                            <div class="form-group form-md-line-input form-md-floating-label has-info">
                                                                <input type="text" class="form-control edited" ng-model="grade.Weight" />
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div class="tab-pane" id="tab_Gender">
                                                <table class="table table-hover table-striped table-condensed table-bordered">
                                                    <thead>
                                                        <tr>
                                                            <td>Gender</td>
                                                            <td>Weight</td>
                                                        </tr>
                                                    </thead>
                                                    <tr ng-repeat="gender in GenderList">
                                                        <td>{{gender.NameEn}}</td>
                                                        <td>
                                                            <div class="form-group form-md-line-input form-md-floating-label has-info">
                                                                <input type="text" class="form-control edited" ng-model="gender.Weight" />
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div class="form-actions noborder pull-right" style="padding-right: 25px">
                                                <button type="button" class="btn green" ng-click="SaveDemographic()">Save changes</button>
                                            </div>
                                        </div>
                                        
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--                <div class="row">
                </div>--%>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
