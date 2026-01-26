using GrowSurv.BLL;
using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GrowSurv.survManager
{
    public partial class doreport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["r"] != null)
                {
                    string lang = Request.QueryString["lang"].ToString() == "ar" ? "ar\\" : "";
                    ReportDataSource rds = new ReportDataSource();

                    switch (Request.QueryString["r"].ToString())
                    {
                        case "1":
                            ReportDataSource rds13 = new ReportDataSource();
                            rds13.Name = "ConDataSet";
                            GSDataSetTableAdapters.GetEngagementRateBySurveyIDForCountryTableAdapter conds = new GSDataSetTableAdapters.GetEngagementRateBySurveyIDForCountryTableAdapter();
                            conds.ClearBeforeFill = true;

                            rds.Name = "GovDataSet";
                            GSDataSetTableAdapters.GetEngagementRateBySurveyIDForGovernrateTableAdapter govds = new GSDataSetTableAdapters.GetEngagementRateBySurveyIDForGovernrateTableAdapter();
                            govds.ClearBeforeFill = true;

                            ReportDataSource rds2 = new ReportDataSource();
                            rds2.Name = "AreaDataSet";
                            GSDataSetTableAdapters.GetEngagementRateBySurveyIDForAreaTableAdapter Areads = new GSDataSetTableAdapters.GetEngagementRateBySurveyIDForAreaTableAdapter();
                            Areads.ClearBeforeFill = true;

                            ReportDataSource rds3 = new ReportDataSource();
                            rds3.Name = "BranchDataSet";
                            GSDataSetTableAdapters.GetEngagementRateBySurveyIDForBranchTableAdapter Branchds = new GSDataSetTableAdapters.GetEngagementRateBySurveyIDForBranchTableAdapter();
                            Branchds.ClearBeforeFill = true;

                            ReportDataSource rds4 = new ReportDataSource();
                            rds4.Name = "DeptDataSet";
                            GSDataSetTableAdapters.GetEngagementRateBySurveyIDForDepartmentTableAdapter Deptds = new GSDataSetTableAdapters.GetEngagementRateBySurveyIDForDepartmentTableAdapter();
                            Deptds.ClearBeforeFill = true;

                            ReportDataSource rds5 = new ReportDataSource();
                            rds5.Name = "DivDataSet";
                            GSDataSetTableAdapters.GetEngagementRateBySurveyIDForDivisionTableAdapter Divds = new GSDataSetTableAdapters.GetEngagementRateBySurveyIDForDivisionTableAdapter();
                            Divds.ClearBeforeFill = true;

                            ReportDataSource rds6 = new ReportDataSource();
                            rds6.Name = "AgeDataSet";
                            GSDataSetTableAdapters.GetEngagementRateBySurveyIDForAgeGroupTableAdapter Ageds = new GSDataSetTableAdapters.GetEngagementRateBySurveyIDForAgeGroupTableAdapter();
                            Ageds.ClearBeforeFill = true;

                            ReportDataSource rds7 = new ReportDataSource();
                            rds7.Name = "GenderDataSet";
                            GSDataSetTableAdapters.GetEngagementRateBySurveyIDForGenderTableAdapter Genderds = new GSDataSetTableAdapters.GetEngagementRateBySurveyIDForGenderTableAdapter();
                            Genderds.ClearBeforeFill = true;

                            ReportDataSource rds8 = new ReportDataSource();
                            rds8.Name = "GradeDataSet";
                            GSDataSetTableAdapters.GetEngagementRateBySurveyIDForGradeTableAdapter Gradeds = new GSDataSetTableAdapters.GetEngagementRateBySurveyIDForGradeTableAdapter();
                            Gradeds.ClearBeforeFill = true;

                            ReportDataSource rds9 = new ReportDataSource();
                            rds9.Name = "LevelDataSet";
                            GSDataSetTableAdapters.GetEngagementRateBySurveyIDForAreaTableAdapter Levelds = new GSDataSetTableAdapters.GetEngagementRateBySurveyIDForAreaTableAdapter();
                            Levelds.ClearBeforeFill = true;

                            ReportDataSource rds10 = new ReportDataSource();
                            rds10.Name = "JTDataSet";
                            GSDataSetTableAdapters.GetEngagementRateBySurveyIDForJobTitleTableAdapter Jtds = new GSDataSetTableAdapters.GetEngagementRateBySurveyIDForJobTitleTableAdapter();
                            Jtds.ClearBeforeFill = true;

                            ReportDataSource rds11 = new ReportDataSource();
                            rds11.Name = "MembersDataSet";
                            GSDataSetTableAdapters.GetMembersCountBySurveyIDTableAdapter Membersds = new GSDataSetTableAdapters.GetMembersCountBySurveyIDTableAdapter();
                            Membersds.ClearBeforeFill = true;

                            int surveyID_1 = 0;
                            if (int.TryParse(Request.QueryString["sid"].ToString(), out surveyID_1))
                            {
                                rds.Value = govds.GetData(surveyID_1);
                                rds13.Value = conds.GetData(surveyID_1);
                                rds2.Value = Areads.GetData(surveyID_1);
                                rds3.Value = Branchds.GetData(surveyID_1);
                                rds4.Value = Deptds.GetData(surveyID_1);
                                rds5.Value = Divds.GetData(surveyID_1);
                                rds6.Value = Ageds.GetData(surveyID_1);
                                rds7.Value = Genderds.GetData(surveyID_1);
                                rds8.Value = Gradeds.GetData(surveyID_1);
                                rds9.Value = Levelds.GetData(surveyID_1);
                                rds10.Value = Jtds.GetData(surveyID_1);
                                rds11.Value = Membersds.GetData(surveyID_1);
                                ReportViewer1.LocalReport.ReportPath = "Reports\\"+lang+"SurveyEngagment.rdlc";
                                ReportViewer1.LocalReport.DataSources.Clear();
                                ReportViewer1.LocalReport.DataSources.Add(rds);
                                ReportViewer1.LocalReport.DataSources.Add(rds2);
                                ReportViewer1.LocalReport.DataSources.Add(rds3);
                                ReportViewer1.LocalReport.DataSources.Add(rds4);
                                ReportViewer1.LocalReport.DataSources.Add(rds5);
                                ReportViewer1.LocalReport.DataSources.Add(rds6);
                                ReportViewer1.LocalReport.DataSources.Add(rds7);
                                ReportViewer1.LocalReport.DataSources.Add(rds8);
                                ReportViewer1.LocalReport.DataSources.Add(rds9);
                                ReportViewer1.LocalReport.DataSources.Add(rds10);
                                ReportViewer1.LocalReport.DataSources.Add(rds11);
                                ReportViewer1.LocalReport.DataSources.Add(rds13);
                                ReportViewer1.LocalReport.Refresh();
                                return;
                            }
                            else
                                return;
                            
                            break;
                        case "2":
                        case "7":
                            rds.Name = "GSDataSet";
                            GSDataSetTableAdapters.GetStatisticsBySurveyIDTableAdapter gsbysurveyID = new GSDataSetTableAdapters.GetStatisticsBySurveyIDTableAdapter();
                            gsbysurveyID.ClearBeforeFill = true;
                            int surveyID = 0;
                            if (int.TryParse(Request.QueryString["sid"].ToString(), out surveyID))
                                rds.Value = gsbysurveyID.GetData(surveyID);
                            else
                                return;
                            if(Request.QueryString["r"].ToString() == "2")
                                ReportViewer1.LocalReport.ReportPath = "Reports\\" + lang + "statisticsreport.rdlc";
                            else if(Request.QueryString["r"].ToString() == "7")                            
                                ReportViewer1.LocalReport.ReportPath = "Reports\\" + lang + "statisticsreport_pie.rdlc";
                            ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(LocalReport_SubreportProcessing_Statistics);
                            break;
                        case "3":
                            rds.Name = "GSDataSet";
                            GSDataSetTableAdapters.GetStatisticsBySurveyIDWithGroupingTableAdapter gsbysurveyIDByGroup = new GSDataSetTableAdapters.GetStatisticsBySurveyIDWithGroupingTableAdapter();
                            gsbysurveyIDByGroup.ClearBeforeFill = true;
                            int surveyIDByGroup = 0;
                            if (int.TryParse(Request.QueryString["sid"].ToString(), out surveyIDByGroup))
                                rds.Value = gsbysurveyIDByGroup.GetData(surveyIDByGroup);
                            else
                                return;
                            ReportViewer1.LocalReport.ReportPath = "Reports\\" + lang + "StatisticsReportWithGrouping.rdlc";
                            ReportParameter[] rep_params = new ReportParameter[2];
                            rep_params[0] = new ReportParameter("GroupBy", Request.QueryString["g"].ToString());
                            rep_params[1] = new ReportParameter("GroupByDisplayName", Request.QueryString["gd"].ToString());                            
                            ReportViewer1.LocalReport.SetParameters(rep_params);

                            break;
                        case "4":
                            Survey S = new Survey();                         
                            int surveyIDEval = 0;
                            if (!int.TryParse(Request.QueryString["sid"].ToString(), out surveyIDEval))
                                return;
                            switch (Request.QueryString["gd"].ToString())
                            {
                                case "Country":
                                    S.GetEvaluationByCon(surveyIDEval);
                                    break;
                                case "State":
                                    S.GetEvaluationByGov(surveyIDEval);
                                    break;
                                case "Branch":
                                    S.GetEvaluationByBranch(surveyIDEval);
                                    break;
                                case "Area":
                                    S.GetEvaluationByArea(surveyIDEval);
                                    break;
                                case "Department":
                                    S.GetEvaluationByDepartment(surveyIDEval);
                                    break;
                                case "Division":
                                    S.GetEvaluationByDivision(surveyIDEval);
                                    break;
                                case "Age Group":
                                    S.GetEvaluationByAgegroup(surveyIDEval);
                                    break;
                                case "Grade":
                                    S.GetEvaluationByGrade(surveyIDEval);
                                    break;
                                case "Job Title":
                                    S.GetEvaluationByJobTitle(surveyIDEval);
                                    break;
                                case "Level":
                                    S.GetEvaluationByLevel(surveyIDEval);
                                    break;
                                case "Gender":
                                    S.GetEvaluationByGender(surveyIDEval);
                                    break;
                                default:
                                    S.GetEvaluation_General(surveyIDEval);
                                    break;
                            }
                            ReportViewer1.LocalReport.ReportPath = "Reports\\" + lang + "Evaluation.rdlc";
                            rds.Name = "DemoDataSet";
                            rds.Value = S.DefaultView;
                            ReportParameter[] rep_paramsEval = new ReportParameter[1];
                            rep_paramsEval[0] = new ReportParameter("Demographic", Request.QueryString["gd"].ToString());                            
                            ReportViewer1.LocalReport.SetParameters(rep_paramsEval);
                            
                            break;
                        case "5":
                            ReportViewer1.LocalReport.ReportPath = "Reports\\" + lang + "Survey.rdlc";
                            ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(LocalReport_SubreportProcessing);
                            rds.Name = "SurveyDataSet";
                            GSDataSetTableAdapters.GetAllQuestionsAndAnswersBySurveyIDTableAdapter getall= new GSDataSetTableAdapters.GetAllQuestionsAndAnswersBySurveyIDTableAdapter();
                            GSDataSetTableAdapters.GetSubQuestionsAndAnswersBySurveyIDTableAdapter getsub = new GSDataSetTableAdapters.GetSubQuestionsAndAnswersBySurveyIDTableAdapter();
                            getall.ClearBeforeFill = true;
                            int surveyIDGetAll = 0;
                            ReportDataSource rds12 = new ReportDataSource();
                            if (int.TryParse(Request.QueryString["sid"].ToString(), out surveyIDGetAll))
                            {
                                rds.Value = getall.GetData(surveyIDGetAll);
                                
                                rds12.Name = "QuestionDataSet";
                                rds12.Value = getsub.GetData(surveyIDGetAll);
                                ReportViewer1.LocalReport.DataSources.Clear();
                                ReportViewer1.LocalReport.DataSources.Add(rds);
                                ReportViewer1.LocalReport.DataSources.Add(rds12);

                                ReportViewer1.LocalReport.Refresh();
                                return;
                            }
                            else
                                return;
                            break;
                        case "6":
                            rds.Name = "DetailsDataSet";
                            GSDataSetTableAdapters.GetSurveyAnswerDetailsBySurveyIDAndMemberIDTableAdapter gsabysurveyID = new GSDataSetTableAdapters.GetSurveyAnswerDetailsBySurveyIDAndMemberIDTableAdapter();
                            gsabysurveyID.ClearBeforeFill = true;
                            int surveyID_ans = 0;
                            if (int.TryParse(Request.QueryString["sid"].ToString(), out surveyID_ans))
                            {
                                int memberid = 0;
                                int.TryParse(Request.QueryString["mid"].ToString(), out memberid);
                                rds.Value = gsabysurveyID.GetData(surveyID_ans, memberid);
                                ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(LocalReport_SubreportProcessing_subQuestion);
                            }
                            else
                                return;
                            ReportViewer1.LocalReport.ReportPath = "Reports\\" + lang + "DetailedSurveyAnswers.rdlc";
                            break;
                        default:
                            break;
                    }
                    ReportViewer1.LocalReport.DataSources.Clear();
                    ReportViewer1.LocalReport.DataSources.Add(rds);
                    ReportViewer1.LocalReport.Refresh();
                }

                
            }
        }
        private void LocalReport_SubreportProcessing_subQuestion(object sender, SubreportProcessingEventArgs e)
        {
            GSDataSetTableAdapters.GetSurveyAnswerDetailsBySurveyIDAndMemberID_SubQuestionsTableAdapter getsub = new GSDataSetTableAdapters.GetSurveyAnswerDetailsBySurveyIDAndMemberID_SubQuestionsTableAdapter();
            ReportDataSource rds12 = new ReportDataSource();
            rds12.Name = "DetailedDataSet";
            rds12.Value = getsub.GetData(int.Parse(Request.QueryString["sid"].ToString()), int.Parse(e.Parameters["MemberID"].Values[0].ToString()));
            e.DataSources.Add(rds12);
        }

        private void LocalReport_SubreportProcessing_Statistics(object sender, SubreportProcessingEventArgs e)
        {
            GSDataSetTableAdapters.GetSubQuestionsAnswersBySurveyIDTableAdapter getsub = new GSDataSetTableAdapters.GetSubQuestionsAnswersBySurveyIDTableAdapter();
            ReportDataSource rds12 = new ReportDataSource();
            rds12.Name = "QuestionDataSet";
            rds12.Value = getsub.GetData(int.Parse(Request.QueryString["sid"].ToString()));
            e.DataSources.Add(rds12);
        }

        private void LocalReport_SubreportProcessing(object sender, SubreportProcessingEventArgs e)
        {
            GSDataSetTableAdapters.GetSubQuestionsAndAnswersBySurveyIDTableAdapter getsub = new GSDataSetTableAdapters.GetSubQuestionsAndAnswersBySurveyIDTableAdapter();            
            ReportDataSource rds12 = new ReportDataSource();
            rds12.Name = "QuestionDataSet";
            rds12.Value = getsub.GetData(int.Parse(Request.QueryString["sid"].ToString()));
            e.DataSources.Add(rds12);

        }
    }
}