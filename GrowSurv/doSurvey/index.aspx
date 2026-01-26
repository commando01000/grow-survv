<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="GrowSurv.doSurvey.index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700&subset=all" rel="stylesheet" type="text/css" />
        <link href="../assets/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
        <link href="../assets/global/plugins/simple-line-icons/simple-line-icons.min.css" rel="stylesheet" type="text/css" />        
        <link id="lnkCSS" runat="server" href = "../assets/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="../assets/surveyplugin/survey.css" rel="stylesheet" />
    <style type="text/css">
        .progress {
  overflow: hidden;
  background-color: gray;
  padding: 0;
  margin-bottom: 10px;
}
.bar-green {
  background-color: #1ab394;
  color: #fff;
  padding-left: 10px;
  float: left;
}
        .padding-tb-10 {
            padding-top :10px;
            padding-bottom:10px;
        }

        @font-face {
    font-family: 'JF-Flat';
    src: url('../fonts/glyphicons-halflings-regular.eot'); /* IE9 Compat Modes */
    src: url('../fonts/glyphicons-halflings-regular.eot#iefix') format('embedded-opentype'), /* IE6-IE8 */
    url('../fonts/JF-Flat-regular.woff') format('woff'), /* Pretty Modern Browsers */
    url('../fonts/JF-Flat-regular.ttf') format('truetype'), /* Safari, Android, iOS */
    url('../fonts/JF-Flat-regular.svg') format('svg'); /* Legacy iOS */
}

.font-JF {
    font-family: 'JF-Flat',sans-serif;
}

.font-JF-force {
    font-family: 'JF-Flat',sans-serif !important;
}

        .lang_label {
            text-decoration:none;
            color:black;
            font-weight:bold;
            font-size:20px;
        }

        .rtl {
            direction:rtl !important;
        }
        .invitation {
            padding:10px;
            background-color:rgba(255, 255, 255, 0.5);
            font-size:16px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:HiddenField id="uiHiddenFieldsurveyID" value="0" runat="server" />
        <asp:HiddenField id="uiHiddenFieldMemberID" value="0" runat="server" />
        <asp:HiddenField ID="uiHiddenFieldCurrentLang" runat="server" Value="en" />
    
        <div class="col-lg-12 padding-tb-10">
            <div class="col-lg-2">
                <img src="../assets/global/img/final_logo.png" alt="logo" class="logo-default" style="max-height: 35px; -webkit-filter: drop-shadow(1px 1px 1px rgba(0, 0, 0, 0.70)); filter: drop-shadow(1px 1px 1px rgba(0, 0, 0, 0.70));" />
            </div>
            <div class="col-lg-8">
                <div id="langSelector" runat="server" visible="true" style="padding-top: 10px; text-align: center; margin: 0 auto; border: 1px solid #1ab394; background-image: url('../assets/global/img/wm.png'); background-size: contain; height: 500px; margin: 0 auto; background-repeat: no-repeat;" class="clearfix">
                    <p class="invitation text-left text-justify">
                        <asp:Literal ID="uiLiteralEnInvitation" runat="server"></asp:Literal>
                    </p>
                    <p class="invitation rtl text-right text-justify">
                        <asp:Literal ID="uiLiteralArInvitation" runat="server"></asp:Literal>

                    </p>
                    <h3>Please select your language:
                    </h3>
                    <div class="col-lg-1">&nbsp;</div>
                    <div class="col-lg-5">
                        <asp:LinkButton runat="server" CssClass="font-JF lang_label" ID="ArabicLink" OnClick="ArabicLink_Click">
                    <img src="../assets/global/img/flags/Egypt.png" /><br />
                    العربية
                        </asp:LinkButton>
                    </div>

                    <div class="col-lg-5">
                        <asp:LinkButton runat="server" CssClass="lang_label" ID="EnglishLink" OnClick="EnglishLink_Click">
                    <img src="../assets/global/img/flags/United-Kingdom.png" /><br />
                    English
                        </asp:LinkButton>
                    </div>
                </div>
                <div style="margin: 0 auto; border: 1px solid #1ab394;" class="clearfix" id="PreSurvey" runat="server" visible="false">
                    <div class="col-md-12">                        
                        <p>
                            <asp:Literal ID="uiLiteralDemographicHeader" runat="server" />
                        </p>
                    </div>
                    <div class="col-md-12 clearfix padding-tb-10" runat="server" id="conDiv">
                        <div class="col-md-3">
                            <asp:Label ID="uiLabelCon" runat="server"></asp:Label>
                        </div>
                        <div class="col-md-3">
                            <asp:DropDownList CssClass="form-control" ID="uiDropDownListCon" runat="server"></asp:DropDownList>
                            <asp:HiddenField ID="uiHiddenFieldCon" Value="0" runat="server" />
                        </div>
                       
                    </div>
                    <div class="col-md-12 clearfix padding-tb-10">
                        <div class="col-md-3" runat="server" id="govLabelDiv">
                            <asp:Label ID="uiLabelGov" runat="server"></asp:Label>
                        </div>
                        <div class="col-md-3" runat="server" id="govDDLDiv">
                            <asp:DropDownList CssClass="form-control" ID="uiDropDownListGov" runat="server"></asp:DropDownList>
                            <asp:HiddenField ID="uiHiddenFieldGov" Value="0" runat="server" />
                        </div>
                        <div class="col-md-3" runat="server" id="areaLabelDiv">
                            <asp:Label ID="uiLabelArea" runat="server"></asp:Label>
                        </div>
                        <div class="col-md-3" runat="server" id="areaDDLDiv">
                            <asp:DropDownList CssClass="form-control" ID="uiDropDownListArea" runat="server"></asp:DropDownList>
                            <asp:HiddenField ID="uiHiddenFieldArea" Value="0" runat="server" />
                        </div>
                    </div>
                    <div class="col-md-12 clearfix padding-tb-10">
                        <div class="col-md-3" runat="server" id="branchLabelDiv">
                            <asp:Label ID="uiLabelBranch" runat="server"></asp:Label>
                        </div>
                        <div class="col-md-3" runat="server" id="branchDDLDiv">
                            <asp:DropDownList CssClass="form-control" ID="uiDropDownListBranch" runat="server"></asp:DropDownList>
                            <asp:HiddenField ID="uiHiddenFieldBranch" Value="0" runat="server" />

                        </div>
                        <div class="col-md-3" runat="server" id="deptLabelDiv">
                            <asp:Label ID="uiLabelDepartment" runat="server"></asp:Label>
                        </div>
                        <div class="col-md-3" runat="server" id="deptDDLDiv">
                            <asp:DropDownList CssClass="form-control" ID="uiDropDownListDeparment" runat="server"></asp:DropDownList>
                            <asp:HiddenField ID="uiHiddenFieldDepartment" Value="0" runat="server" />

                        </div>
                    </div>
                    <div class="col-md-12 clearfix padding-tb-10">
                        <div class="col-md-3" runat="server" id="divLabelDiv">
                            <asp:Label ID="uiLabelDivision" runat="server"></asp:Label>
                        </div>
                        <div class="col-md-3" runat="server" id="divDDLDiv">
                            <asp:DropDownList CssClass="form-control" ID="uiDropDownListDivision" runat="server"></asp:DropDownList>
                            <asp:HiddenField ID="uiHiddenFieldDivision" Value="0" runat="server" />

                        </div>
                        <div class="col-md-3" runat="server" id="lvlLabelDiv">
                            <asp:Label ID="uiLabellevel" runat="server"></asp:Label>
                        </div>
                        <div class="col-md-3" runat="server" id="lvlDDLDiv">
                            <asp:DropDownList CssClass="form-control" ID="uiDropDownListlevel" runat="server"></asp:DropDownList>
                            <asp:HiddenField ID="uiHiddenFieldLevel" Value="0" runat="server" />

                        </div>
                    </div>
                    <div class="col-md-12 clearfix padding-tb-10">
                        <div class="col-md-3" runat="server" id="gradeLabelDiv">
                            <asp:Label ID="uiLabelGrade" runat="server"></asp:Label>
                        </div>
                        <div class="col-md-3" runat="server" id="gradeDDLDiv">
                            <asp:DropDownList CssClass="form-control" ID="uiDropDownListGrade" runat="server"></asp:DropDownList>
                            <asp:HiddenField ID="uiHiddenFieldGrade" Value="0" runat="server" />

                        </div>
                        <div class="col-md-3" runat="server" id="jtLabelDiv">
                            <asp:Label ID="uiLabelJobTitle" runat="server"></asp:Label>

                        </div>
                        <div class="col-md-3" runat="server" id="jtDDLDiv">
                            <asp:DropDownList CssClass="form-control" ID="uiDropDownListJobTitle" runat="server"></asp:DropDownList>
                            <asp:HiddenField ID="uiHiddenFieldJobTitle" Value="0" runat="server" />
                        </div>
                    </div>
                    <div class="col-md-12 clearfix padding-tb-10">
                        <div class="col-md-3" runat="server" id="agLabelDiv">
                            <asp:Label ID="uiLabelAgeGroup" runat="server"></asp:Label>

                        </div>
                        <div class="col-md-3" runat="server" id="agDDLDiv">
                            <asp:DropDownList CssClass="form-control" ID="uiDropDownListAgeGroup" runat="server"></asp:DropDownList>
                            <asp:HiddenField ID="uiHiddenFieldAgeGroup" Value="0" runat="server" />
                        </div>
                        <div class="col-md-3" runat="server" id="genLabelDiv">
                            <asp:Label ID="uiLabelGender" runat="server"></asp:Label>

                        </div>
                        <div class="col-md-3" runat="server" id="genDDLDiv">
                            <asp:DropDownList CssClass="form-control" ID="uiDropDownListGender" runat="server"></asp:DropDownList>
                            <asp:HiddenField ID="uiHiddenFieldGender" Value="0" runat="server" />
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="col-md-3"></div>
                        <div class="col-md-3">
                            <asp:LinkButton ID="uiLinkButtonMoveNextServer" class="btn btn-success" runat="server" OnClientClick="return MoveNext();" OnClick="uiLinkButtonMoveNextServer_Click"></asp:LinkButton>
                            <%--<a href="#" onclick="MoveNext();" class="btn btn-success" runat="server" id="uiLinkButtonMoveNext"></a>--%>
                        </div>
                        <div class="col-md-3"></div>
                        <div class="col-md-3"></div>
                    </div>

                </div>

                <div style="margin: 0 auto; border: 1px solid #1ab394;" id="MainSurvey" runat="server" visible="false">
                    <p style="padding:5px;text-align:center">
                        <asp:Literal ID="uiLiteralHeader" runat="server"></asp:Literal>
                    </p>
                    <div id="surveyContainer"></div>

                    <div style="float: right" id="SaveAndContinue">
                        <input type="button" id="SaveAndContinueBtn" class="sv_complete_btn" value="Save and continue later" style="margin-left: 5px; margin-right: 5px;" />
                    </div>
                    <p style="padding:5px;text-align:center">
                        <asp:Literal ID="uiLiteralFooter" runat="server"></asp:Literal>

                    </p>
                </div>


            </div>
            <div class="col-lg-2">

            </div>
        </div>

       <div class="col-lg-12 padding-tb-10">
            <div class="col-lg-2">
                Powered by 
                <a href="http://q-bitware.com" target="_blank">
                    <img src="../assets/pages/img/q-bitware.png" style="max-height: 50px; margin-left: -15px; -webkit-filter: drop-shadow(1px 1px 1px black); filter: drop-shadow(1px 1px 1px black);" />
                </a>
            </div>
           <div class="col-lg-8" style="text-align:center">
               2018 &copy; <img src="../assets/pages/img/tcg.png" style="max-height: 50px;" />
               </div>
           </div>

        <div class="modal fade" id="myModal" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title" id="modalTitle">

                        </h4>
                    </div>
                    <div class="modal-body">
                        <p id="modalText">

                        </p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>

            </div>
        </div>
        <script src="../assets/global/plugins/jquery.min.js" type="text/javascript"></script>
        <script src="../assets/global/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="../assets/surveyplugin/survey.jquery.min.js"></script>

        <script type="text/javascript">
            function getParameterByName(name, url) {
                if (!url) url = window.location.href;
                name = name.replace(/[\[\]]/g, "\\$&");
                var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
                    results = regex.exec(url);
                if (!results) return null;
                if (!results[2]) return '';
                return decodeURIComponent(results[2].replace(/\+/g, " "));
            }
            $(document).ready(function () {
                //var showb = getParameterByName('sid');
                var showb = $('#<%= uiHiddenFieldsurveyID.ClientID %>').val();
                var lang = $('#<%= uiHiddenFieldCurrentLang.ClientID %>').val();
                var membermail = $('#<%= uiHiddenFieldMemberID.ClientID %>').val();

                var surveyJSON;
                $.get("../common/common.asmx/getSurveyAsJson?SurveyID=" + showb + "&lang=" + lang + "&memberMail=" + membermail, function (data) {
                    var surveyJSON = data.survey;
                    Survey.defaultStandardCss.progressBar = "bar-green";
                    Survey.defaultStandardCss.progress = "progress";

                    var survey = new Survey.Model(surveyJSON);
                    survey.showProgressBar = "top";
                    var olddata = JSON.parse(data.surveydata);
                    survey.startTimer();
                    $("#surveyContainer").Survey({
                        model: survey,
                        data: olddata,
                        onComplete: sendDataToServer
                    });
                    $("#SaveAndContinue").css('display', 'none');
                    if (surveyJSON.SurveyTypeID == 1 && !surveyJSON.IsPublic) {
                        $("#SaveAndContinue").css('display', 'block');
                        $("#SaveAndContinue").click(function () {
                            sendDataToServer(survey, false);
                            survey.setCookie();
                            window.location.href = "http://" + window.location.hostname + "/default.aspx";
                        });
                        setTimeout(function () { $('.sv_container .sv_nav').append($("#SaveAndContinue")); }, 300);
                    }
                });
               
                
          //      var surveyJSON = {
          //          title: "Tell us, what technologies do you use?", pages: [
          //{
          //    showQuestionNumbers: true,
          //    name: "page1", questions: [
          //      { type: "radiogroup", choices: ["Yes", "No"], isRequired: true, name: "frameworkUsing1", title: "Do you use any front-end framework like Bootstrap?" },
          //      { type: "checkbox", choices: ["Bootstrap", "Foundation"], hasOther: true, isRequired: true, name: "framework", title: "What front-end framework do you use?", visibleIf: "{frameworkUsing} = 'Yes'" }
          //    ]
          //},
          //{
          //    showQuestionNumbers: true,
          //    name: "page2", questions: [
          //      { type: "radiogroup", choices: ["Yes", "No"], isRequired: true, name: "frameworkUsing2", title: "Do you use any front-end framework like Bootstrap?" },
          //      { type: "checkbox", choices: ["Bootstrap", "Foundation"], hasOther: true, isRequired: true, name: "framework", title: "What front-end framework do you use?", visibleIf: "{frameworkUsing} = 'Yes'" }
          //    ]
          //},
          //{
          //    showQuestionNumbers: true,
          //    name: "page3", questions: [
          //      { type: "radiogroup", choices: ["Yes", "No"], isRequired: true, name: "frameworkUsing", title: "Do you use any front-end framework like Bootstrap?" },
          //      { type: "checkbox", choices: ["Bootstrap", "Foundation"], hasOther: true, isRequired: true, name: "framework", title: "What front-end framework do you use?", visibleIf: "{frameworkUsing} = 'Yes'" }
          //    ]
          //},
          //{
          //    name: "page4", questions: [
          //    { type: "radiogroup", choices: ["Yes", "No"], isRequired: true, name: "mvvmUsing", title: "Do you use any MVVM framework?" },
          //    { type: "checkbox", choices: ["AngularJS", "KnockoutJS", "React"], hasOther: true, isRequired: true, name: "mvvm", title: "What MVVM framework do you use?", visibleIf: "{mvvmUsing} = 'Yes'" }]
          //},
          //{
          //    name: "page5", questions: [
          //    { type: "text", name: "about", title: "Please tell us about your main requirements for Survey library" }]
          //}
          //          ]
          //      };
                //Survey.Survey.cssType = "bootstrap";

                
            });
            
            function sendDataToServer(survey, IsSubmitted) {
                survey.stopTimer();
                var resultAsString = JSON.stringify(survey.data);
                var surveyid = $('#<%= uiHiddenFieldsurveyID.ClientID %>').val();
                var membermail = $('#<%= uiHiddenFieldMemberID.ClientID %>').val();
                var NotSubmitted = (IsSubmitted == false);
                $.ajax({
                    type: 'POST',
                    url: '../common/common.asmx/submitSurveyAsJson',
                    data: JSON.stringify({ SurveyID: surveyid, member: membermail, surveydata: survey.data, IsSubmitted: !NotSubmitted }),
                    contentType: 'application/json',
                    dataType: 'application/json'
                }).done(function () {

                });

                var conID = 0, govID = 0, areaID = 0, branchID = 0, departmentID = 0, divisionID = 0, level = 0, grade = 0, jobTitle = 0, ageGroup = 0, gender = 0;
                 if ($('#<%= uiDropDownListCon.ClientID%>').val() != "")
                     conID = $('#<%= uiDropDownListCon.ClientID %>').val();
                if ( $('#<%= uiDropDownListGov.ClientID%>').val() != "")
                    govID = $('#<%= uiDropDownListGov.ClientID %>').val();
                if( $('#<%= uiDropDownListArea.ClientID%>').val() != "")
                    areaID = $('#<%= uiDropDownListArea.ClientID %>').val();
                if( $('#<%= uiDropDownListBranch.ClientID%>').val() != "")
                    branchID = $('#<%= uiDropDownListBranch.ClientID %>').val();
                if( $('#<%= uiDropDownListDeparment.ClientID%>').val() != "")
                    departmentID = $('#<%= uiDropDownListDeparment.ClientID %>').val();
                if( $('#<%= uiDropDownListDivision.ClientID%>').val() != "")
                    divisionID = $('#<%= uiDropDownListDivision.ClientID %>').val();
                if( $('#<%= uiDropDownListlevel.ClientID%>').val() != "")
                    level = $('#<%= uiDropDownListlevel.ClientID %>').val();
                if( $('#<%= uiDropDownListGrade.ClientID%>').val() != "")
                    grade = $('#<%= uiDropDownListGrade.ClientID %>').val();
                if( $('#<%= uiDropDownListJobTitle.ClientID%>').val() != "")
                    jobTitle = $('#<%= uiDropDownListJobTitle.ClientID %>').val();
                if( $('#<%= uiDropDownListAgeGroup.ClientID%>').val() != "")
                    ageGroup = $('#<%= uiDropDownListAgeGroup.ClientID %>').val();
                if ( $('#<%= uiDropDownListGender.ClientID%>').val() != "")
                    gender = $('#<%= uiDropDownListGender.ClientID %>').val();

                $.ajax({
                    type: 'POST',
                    url: '../common/common.asmx/submitDemographicData',
                    data: JSON.stringify({
                        SurveyID: surveyid, member: membermail, conId : conID, govId: govID, areaID: areaID, branchID: branchID, departmentID: departmentID,
                        divisionID: divisionID, level: level, grade: grade, jobTitle: jobTitle, ageGroup: ageGroup, gender: gender, durationInSeconds: survey.timeSpent
                        }),
                    contentType: 'application/json',
                    dataType: 'application/json'
                }).done(function () {

                });

                //$.post("../common/common.asmx/submitSurveyAsJson", { SurveyID: surveyid, member: membermail, surveydata: resultAsString }).done(function () {

                //});
            }


            function MoveNext()
            {
                var errors = "";
                if ($('#<%= uiHiddenFieldCurrentLang.ClientID %>').val() == "en")
                {
                    $('#modalTitle').html("Error");
                    if($('#<%= uiHiddenFieldCon.ClientID %>').val() != "0" && $('#<%= uiDropDownListCon.ClientID%>').val() == "")
                        errors += "Please select country" + "<br />";
                    if ($('#<%= uiHiddenFieldGov.ClientID %>').val() != "0" && $('#<%= uiDropDownListGov.ClientID%>').val() == "")
                        errors += "Please select state" + "<br />";
                    if($('#<%= uiHiddenFieldArea.ClientID %>').val() != "0" && $('#<%= uiDropDownListArea.ClientID%>').val() == "")
                        errors += "Please select area" + "<br />";
                    if($('#<%= uiHiddenFieldBranch.ClientID %>').val() != "0" && $('#<%= uiDropDownListBranch.ClientID%>').val() == "")
                        errors += "Please select branch" + "<br />";
                    if($('#<%= uiHiddenFieldDepartment.ClientID %>').val() != "0" && $('#<%= uiDropDownListDeparment.ClientID%>').val() == "")
                        errors += "Please select department" + "<br />";
                    if($('#<%= uiHiddenFieldDivision.ClientID %>').val() != "0" && $('#<%= uiDropDownListDivision.ClientID%>').val() == "")
                        errors += "Please select division" + "<br />";
                    if($('#<%= uiHiddenFieldLevel.ClientID %>').val() != "0" && $('#<%= uiDropDownListlevel.ClientID%>').val() == "")
                        errors += "Please select level" + "<br />";
                    if($('#<%= uiHiddenFieldGrade.ClientID %>').val() != "0" && $('#<%= uiDropDownListGrade.ClientID%>').val() == "")
                        errors += "Please select grade" + "<br />";
                    if($('#<%= uiHiddenFieldJobTitle.ClientID %>').val() != "0" && $('#<%= uiDropDownListJobTitle.ClientID%>').val() == "")
                        errors += "Please select job title" + "<br />";
                    if($('#<%= uiHiddenFieldAgeGroup.ClientID %>').val() != "0" && $('#<%= uiDropDownListAgeGroup.ClientID%>').val() == "")
                        errors += "Please select age group" + "<br />";
                    if($('#<%= uiHiddenFieldGender.ClientID %>').val() != "0" && $('#<%= uiDropDownListGender.ClientID%>').val() == "")
                        errors += "Please select gender" + "<br />";
                }
                else
                {
                    $('#modalTitle').html("خطأ");
                    if($('#<%= uiHiddenFieldCon.ClientID %>').val() != "0" && $('#<%= uiDropDownListCon.ClientID%>').val() == "")
                        errors += "من فضلك إختر البلد" + "<br />";
                    if ($('#<%= uiHiddenFieldGov.ClientID %>').val() != "0" && $('#<%= uiDropDownListGov.ClientID%>').val() == "")
                        errors += "من فضلك إختر المحافظة" + "<br />";
                    if($('#<%= uiHiddenFieldArea.ClientID %>').val() != "0" && $('#<%= uiDropDownListArea.ClientID%>').val() == "")
                        errors += "من فضلك إختر المنطقة" + "<br />";
                    if($('#<%= uiHiddenFieldBranch.ClientID %>').val() != "0" && $('#<%= uiDropDownListBranch.ClientID%>').val() == "")
                        errors += "من فضلك إختر الفرع" + "<br />";
                    if($('#<%= uiHiddenFieldDepartment.ClientID %>').val() != "0" && $('#<%= uiDropDownListDeparment.ClientID%>').val() == "")
                        errors += "من فضلك إختر القسم" + "<br />";
                    if($('#<%= uiHiddenFieldDivision.ClientID %>').val() != "0" && $('#<%= uiDropDownListDivision.ClientID%>').val() == "")
                        errors += "من فضلك إختر القطاع" + "<br />";
                    if($('#<%= uiHiddenFieldLevel.ClientID %>').val() != "0" && $('#<%= uiDropDownListlevel.ClientID%>').val() == "")
                        errors += "من فضلك إختر المستوى" + "<br />";
                    if($('#<%= uiHiddenFieldGrade.ClientID %>').val() != "0" && $('#<%= uiDropDownListGrade.ClientID%>').val() == "")
                        errors += "من فضلك إختر الدرجة" + "<br />";
                    if($('#<%= uiHiddenFieldJobTitle.ClientID %>').val() != "0" && $('#<%= uiDropDownListJobTitle.ClientID%>').val() == "")
                        errors += "من فضلك إختر الوظيفة" + "<br />";
                    if($('#<%= uiHiddenFieldAgeGroup.ClientID %>').val() != "0" && $('#<%= uiDropDownListAgeGroup.ClientID%>').val() == "")
                        errors += "من فضلك إختر الفئة العمرية" + "<br />";
                    if($('#<%= uiHiddenFieldGender.ClientID %>').val() != "0" && $('#<%= uiDropDownListGender.ClientID%>').val() == "")
                        errors += "من فضلك إختر النوع" + "<br />";
                    
                }
                $('#modalText').html(errors);
                if (errors != "")
                {
                    $("#myModal").modal();
                    return false;
                }

                else
                {
                    $('#PreSurvey').css('display', 'none');
                    $('#MainSurvey').css('display', 'none');
                    return true;
                }

            }
        </script>
    </form>
</body>
</html>
