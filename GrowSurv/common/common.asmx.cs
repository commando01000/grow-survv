using GrowSurv.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using GrowSurv.Models;
using System.Security.Cryptography;
using System.Text;
using System.IO;
using System.Net.Mail;
using System.Web.Security;

namespace GrowSurv.common
{
    /// <summary>
    /// Summary description for common
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class common : System.Web.Services.WebService
    {
        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";
        }

        #region Survey Functions
        [WebMethod]
        public void SearchSurveies(string filtertxt, int CompanyID)
        {
            List<SurveyModel> survies = new List<SurveyModel>();
            Survey survs = new Survey();
            survs.searchSurvies(filtertxt, CompanyID);
            for (int i = 0; i < survs.RowCount; i++)
            {
                survies.Add(new SurveyModel
                {
                    SurveyID = survs.SurveyID,
                    ArDesc = survs.ArDesc,
                    ArName = survs.ArName,
                    CompanyID = survs.CompanyID,
                    EnDesc = survs.EnDesc,
                    EnName = survs.EnName,
                    ExpiryDate = survs.ExpiryDate,
                    CompanyEnName = survs.GetColumn("CompanyEnName").ToString(),
                    IsAgeMandatory = survs.IsColumnNull("IsAgeMandatory") ? false : survs.IsAgeMandatory,
                    IsAreaMandatory = survs.IsColumnNull("IsAreaMandatory") ? false : survs.IsAreaMandatory,
                    IsBranchMandatory = survs.IsColumnNull("IsBranchMandatory") ? false : survs.IsBranchMandatory,
                    IsDepartmentMandatory = survs.IsColumnNull("IsDepartmentMandatory") ? false : survs.IsDepartmentMandatory,
                    IsDivisionMandatory = survs.IsColumnNull("IsDivisionMandatory") ? false : survs.IsDivisionMandatory,
                    IsDurationMandatory = survs.IsColumnNull("IsDurationMandatory") ? false : survs.IsDurationMandatory,
                    IsGenderMandatory = survs.IsColumnNull("IsGenderMandatory") ? false : survs.IsGenderMandatory,
                    IsGradeMandatory = survs.IsColumnNull("IsGenderMandatory") ? false : survs.IsGenderMandatory,
                    IsJobTitleMandatory = survs.IsColumnNull("IsJobTitleMandatory") ? false : survs.IsJobTitleMandatory,
                    IsLevelMandatory = survs.IsColumnNull("IsLevelMandatory") ? false : survs.IsLevelMandatory,
                    IsRecentPromotionDateMandatory = survs.IsColumnNull("IsRecentPromotionDateMandatory") ? false : survs.IsRecentPromotionDateMandatory,
                    IsGovernrateMandatory = survs.IsColumnNull("IsGovernrateMandatory") ? false : survs.IsGovernrateMandatory,
                    IsCountryMandatory = survs.IsColumnNull("IsCountryMandatory") ? false : survs.IsCountryMandatory,
                    IsPublic= survs.IsColumnNull("IsPublic") ? false : survs.IsPublic,
                    EnHeader = survs.EnHeader,
                    ArHeader = survs.ArHeader,
                    EnFooter = survs.EnFooter,
                    ArFooter = survs.ArFooter,
					EmailSubject = survs.EmailSubject,
                    EmailBody = survs.EmailBody,
                    ArEmailBody = survs.ArEmailBody,
                    SkipDemographicPage = survs.IsColumnNull("SkipDemographicPage") ? false : survs.SkipDemographicPage,
                    PublicURL = survs.IsColumnNull("IsPublic") ? "" : survs.IsPublic ? "http://growsurv.com/doSurvey/index.aspx?sid=" + HttpUtility.UrlEncode(Encrypt(survs.SurveyID.ToString())) + "&mail=" : ""
                });
                survs.MoveNext();
            }

            SetContentResult(survies);
        }
        [WebMethod]
        public void getSurvey(int SurveyID)
        {
            SurveyModel survies = new SurveyModel();
            Survey survs = new Survey();
            survs.LoadByPrimaryKey(SurveyID);

            survies = (new SurveyModel
            {
                SurveyID = survs.SurveyID,
                ArDesc = survs.ArDesc,
                ArName = survs.ArName,
                CompanyID = survs.CompanyID,
                EnDesc = survs.EnDesc,
                EnName = survs.EnName,
                ExpiryDate = survs.ExpiryDate,
                // CompanyEnName = survs.GetColumn("CompanyEnName").ToString()
                IsAgeMandatory = survs.IsColumnNull("IsAgeMandatory") ? false : survs.IsAgeMandatory,
                IsAreaMandatory = survs.IsColumnNull("IsAreaMandatory") ? false : survs.IsAreaMandatory,
                IsBranchMandatory = survs.IsColumnNull("IsBranchMandatory") ? false : survs.IsBranchMandatory,
                IsDepartmentMandatory = survs.IsColumnNull("IsDepartmentMandatory") ? false : survs.IsDepartmentMandatory,
                IsDivisionMandatory = survs.IsColumnNull("IsDivisionMandatory") ? false : survs.IsDivisionMandatory,
                IsDurationMandatory = survs.IsColumnNull("IsDurationMandatory") ? false : survs.IsDurationMandatory,
                IsGenderMandatory = survs.IsColumnNull("IsGenderMandatory") ? false : survs.IsGenderMandatory,
                IsGradeMandatory = survs.IsColumnNull("IsGenderMandatory") ? false : survs.IsGenderMandatory,
                IsJobTitleMandatory = survs.IsColumnNull("IsJobTitleMandatory") ? false : survs.IsJobTitleMandatory,
                IsLevelMandatory = survs.IsColumnNull("IsLevelMandatory") ? false : survs.IsLevelMandatory,
                IsRecentPromotionDateMandatory = survs.IsColumnNull("IsRecentPromotionDateMandatory") ? false : survs.IsRecentPromotionDateMandatory,
                SurveyTypeID = survs.IsColumnNull("SurveyTypeID") ? 1 : survs.SurveyTypeID,
                Duration = survs.IsColumnNull("Duration") ? DateTime.MinValue : survs.Duration,
                IsGovernrateMandatory= survs.IsColumnNull("IsGovernrateMandatory") ? false : survs.IsGovernrateMandatory,
                IsCountryMandatory = survs.IsColumnNull("IsCountryMandatory") ? false : survs.IsCountryMandatory,
                IsPublic = survs.IsColumnNull("IsPublic") ? false : survs.IsPublic,
                EnHeader = survs.EnHeader,
                ArHeader = survs.ArHeader,
                EnFooter= survs.EnFooter,
                ArFooter = survs.ArFooter,
				EmailSubject = survs.EmailSubject,
                EmailBody = survs.EmailBody,
                ArEmailBody = survs.ArEmailBody,
                SkipDemographicPage = survs.IsColumnNull("SkipDemographicPage") ? false : survs.SkipDemographicPage,
                PublicURL = survs.IsColumnNull("IsPublic") ? "" : survs.IsPublic ? "http://growsurv.com/doSurvey/index.aspx?sid=" + HttpUtility.UrlEncode(Encrypt(survs.SurveyID.ToString())) + "&mail=" : ""
            });


            SetContentResult(survies);
        }
        [WebMethod]
        public void SaveSurvey(SurveyModel model)
        {
            Survey survs = new Survey();
            if (model.SurveyID == 0)
                survs.AddNew();
            else
                survs.LoadByPrimaryKey(model.SurveyID);

            survs.ArDesc = model.ArDesc == null ? "" : model.ArDesc;
            survs.EnDesc = model.EnDesc == null ? "" : model.EnDesc;
            survs.EnName = model.EnName == null ? "" : model.EnName;
            survs.ArName = model.ArName == null ? "" : model.ArName;
            survs.EnHeader = model.EnHeader == null ? "" : model.EnHeader;
            survs.ArHeader = model.ArHeader == null ? "" : model.ArHeader;
            survs.EnFooter = model.EnFooter == null ? "" : model.EnFooter;
            survs.ArFooter = model.ArFooter == null ? "" : model.ArFooter;
            survs.IsAgeMandatory = model.IsAgeMandatory;
            survs.IsAreaMandatory = model.IsAreaMandatory;
            survs.IsBranchMandatory = model.IsBranchMandatory;
            survs.IsDepartmentMandatory = model.IsDepartmentMandatory;
            survs.IsDivisionMandatory = model.IsDivisionMandatory;
            survs.IsDurationMandatory = model.IsDurationMandatory;
            survs.IsGenderMandatory = model.IsGenderMandatory;
            survs.IsGradeMandatory = model.IsGradeMandatory;
            survs.IsCountryMandatory = model.IsCountryMandatory;
            survs.IsPublic = model.IsPublic;
            survs.IsJobTitleMandatory = model.IsJobTitleMandatory;
            survs.IsLevelMandatory = model.IsLevelMandatory;
            survs.IsRecentPromotionDateMandatory = model.IsRecentPromotionDateMandatory;
            survs.IsGovernrateMandatory = model.IsGovernrateMandatory;
            survs.SkipDemographicPage = model.SkipDemographicPage;

            survs.EmailSubject = model.EmailSubject;
            survs.EmailBody = model.EmailBody;
            survs.ArEmailBody = model.ArEmailBody;
            if (model.ExpiryDate != DateTime.MinValue)
                survs.ExpiryDate = model.ExpiryDate;
            else
                survs.SetColumnNull("ExpiryDate");

            if (model.CompanyID == 0)
                survs.SetColumnNull("CompanyID");
            else
                survs.CompanyID = model.CompanyID;
            survs.SurveyTypeID = model.SurveyTypeID;
            if (model.Duration != DateTime.MinValue)
                survs.Duration = model.Duration;
            else
                survs.Duration = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day, 1, 0, 0);


            survs.Save();
            SurveyModel tempSurvey = new SurveyModel
            {
                SurveyTypeID = survs.SurveyTypeID,
                SurveyID = survs.SurveyID,
                CompanyID = survs.CompanyID,
                EnName = survs.EnName,
                ExpiryDate = survs.ExpiryDate,
                Duration = survs.Duration,
                EnDesc = survs.EnDesc,
                ArDesc = survs.ArDesc,
                ArName = survs.ArName,
                IsAgeMandatory = survs.IsAgeMandatory,
                IsAreaMandatory = survs.IsAreaMandatory,
                IsRecentPromotionDateMandatory = survs.IsRecentPromotionDateMandatory,
                IsLevelMandatory = survs.IsLevelMandatory,
                IsJobTitleMandatory = survs.IsJobTitleMandatory,
                IsGradeMandatory = survs.IsGradeMandatory,
                IsGenderMandatory = survs.IsGenderMandatory,
                IsBranchMandatory = survs.IsBranchMandatory,
                IsDepartmentMandatory = survs.IsDepartmentMandatory,
                IsDivisionMandatory = survs.IsDivisionMandatory,
                IsDurationMandatory = survs.IsDurationMandatory,
                IsCountryMandatory = survs.IsCountryMandatory,
                IsPublic = survs.IsPublic,
                ArHeader = survs.ArHeader,
                EnHeader = survs.EnHeader,
                ArFooter = survs.ArFooter,
                EnFooter = survs.EnFooter,
                IsGovernrateMandatory = survs.IsGovernrateMandatory,
                EmailSubject = survs.EmailSubject,
                EmailBody = survs.EmailBody,
                ArEmailBody = survs.ArEmailBody,
                SkipDemographicPage = survs.IsColumnNull("SkipDemographicPage") ? false : survs.SkipDemographicPage,
                PublicURL = survs.IsColumnNull("IsPublic") ? "" : survs.IsPublic ? "http://growsurv.com/doSurvey/index.aspx?sid=" + HttpUtility.UrlEncode(Encrypt(survs.SurveyID.ToString())) + "&mail=" : ""
            };
            SetContentResult(tempSurvey);
        }

        [WebMethod]
        public void PublishSurvey(int SurveyID)
        {            
            SurveyMember members = new SurveyMember();
            members.GetListBySurveyID(SurveyID);
            string surveyId = HttpUtility.UrlEncode(Encrypt(SurveyID.ToString()));
            string email = "";
			Survey mainSurvey = new Survey();
            mainSurvey.LoadByPrimaryKey(SurveyID);
            for (int i = 0; i < members.RowCount; i++)
            {
                if (IsValidEmail(members.MemberEmail))
                {
                    email = HttpUtility.UrlEncode(Encrypt(members.MemberEmail));
                    MailMessage msg = new MailMessage();
                    msg.From = new MailAddress("publish@growsurv.com");
                    msg.Subject = mainSurvey.EmailSubject;
                    msg.IsBodyHtml = true;
                    msg.BodyEncoding = System.Text.Encoding.UTF8;

                    SmtpClient client = new SmtpClient("mail.growsurv.com", 25);                    
                    client.EnableSsl = false;
                    client.UseDefaultCredentials = false;
                    client.Credentials = new System.Net.NetworkCredential("publish@growsurv.com", "Jco1d#44");
                    msg.To.Clear();
                    msg.To.Add(members.MemberEmail);
                    //msg.Body = "http://localhost:21455/doSurvey/index.aspx?sid=" + surveyId + "&mail=" + email;
                    msg.Body = string.Format(HttpContext.GetGlobalResourceObject("General", "EmailTemplate").ToString(), mainSurvey.EmailBody, mainSurvey.ArEmailBody, "http://growsurv.com/doSurvey/index.aspx?sid=" + surveyId + "&mail=" + email);
                    
                    client.Send(msg);

                }
                members.MoveNext();
            }
            SetContentResult(true);
        }

        [WebMethod]
        public void SendEmailForAMember(int memberID, int surveyID)
        {
            SurveyMember members = new SurveyMember();
            members.LoadByPrimaryKey(memberID);
            string surveyId = HttpUtility.UrlEncode(Encrypt(surveyID.ToString()));
            Survey mainSurvey = new Survey();
            mainSurvey.LoadByPrimaryKey(surveyID);
            string email = "";
            if (IsValidEmail(members.MemberEmail))
            {
                email = HttpUtility.UrlEncode(Encrypt(members.MemberEmail));
                MailMessage msg = new MailMessage();
                msg.From = new MailAddress("publish@growsurv.com");
                msg.Subject = mainSurvey.EmailSubject;
                msg.IsBodyHtml = true;
                msg.BodyEncoding = System.Text.Encoding.UTF8;

                SmtpClient client = new SmtpClient("mail.growsurv.com", 25);
                client.EnableSsl = false;
                client.UseDefaultCredentials = false;
                client.Credentials = new System.Net.NetworkCredential("publish@growsurv.com", "Jco1d#44");
                msg.To.Clear();
                msg.To.Add(members.MemberEmail);                
                //msg.Body = "http://localhost:21455/doSurvey/index.aspx?sid=" + surveyId + "&mail=" + email;
                msg.Body = string.Format(HttpContext.GetGlobalResourceObject("General", "EmailTemplate").ToString(), mainSurvey.EmailBody, mainSurvey.ArEmailBody, "http://growsurv.com/doSurvey/index.aspx?sid=" + surveyId + "&mail=" + email);
                client.Send(msg);

            }
        }

        [WebMethod]
        public void DuplicateSurvey(int SurveyID) {
            // Duplicating Survey :: NewSurvey
            #region Duplicating Survey

            Survey OldSurvey = new Survey();
            OldSurvey.LoadByPrimaryKey(SurveyID);

            Survey NewSurvey = new Survey();
            NewSurvey.AddNew();

            NewSurvey.ArName = OldSurvey.ArName + " (مكرر)";
            NewSurvey.EnName = OldSurvey.EnName + " (Duplicated)";
            NewSurvey.ArDesc = OldSurvey.IsColumnNull("ArDesc") ? "" : OldSurvey.ArDesc;
            NewSurvey.EnDesc = OldSurvey.IsColumnNull("EnDesc") ? "" : OldSurvey.EnDesc;
            NewSurvey.CompanyID = OldSurvey.CompanyID;
            NewSurvey.ExpiryDate = OldSurvey.ExpiryDate;
            NewSurvey.IsDivisionMandatory = OldSurvey.IsColumnNull("IsDivisionMandatory") ? false : OldSurvey.IsDivisionMandatory;
            NewSurvey.IsDepartmentMandatory = OldSurvey.IsColumnNull("IsDepartmentMandatory") ? false : OldSurvey.IsDepartmentMandatory;
            NewSurvey.IsAreaMandatory = OldSurvey.IsColumnNull("IsAreaMandatory") ? false : OldSurvey.IsAreaMandatory;
            NewSurvey.IsBranchMandatory = OldSurvey.IsColumnNull("IsBranchMandatory") ? false : OldSurvey.IsBranchMandatory;
            NewSurvey.IsGradeMandatory = OldSurvey.IsColumnNull("IsGradeMandatory") ? false : OldSurvey.IsGradeMandatory;
            NewSurvey.IsLevelMandatory = OldSurvey.IsColumnNull("IsLevelMandatory") ? false : OldSurvey.IsLevelMandatory;
            NewSurvey.IsJobTitleMandatory = OldSurvey.IsColumnNull("IsJobTitleMandatory") ? false : OldSurvey.IsJobTitleMandatory;
            NewSurvey.IsGenderMandatory = OldSurvey.IsColumnNull("IsGenderMandatory") ? false : OldSurvey.IsGenderMandatory;
            NewSurvey.IsAgeMandatory = OldSurvey.IsColumnNull("IsAgeMandatory") ? false : OldSurvey.IsAgeMandatory;
            NewSurvey.IsDurationMandatory = OldSurvey.IsColumnNull("IsDurationMandatory") ? false : OldSurvey.IsDurationMandatory;
            NewSurvey.IsCountryMandatory = OldSurvey.IsColumnNull("IsCountryMandatory") ? false : OldSurvey.IsCountryMandatory;
            NewSurvey.IsPublic = OldSurvey.IsColumnNull("IsPublic") ? false : OldSurvey.IsPublic;
            NewSurvey.IsRecentPromotionDateMandatory = OldSurvey.IsColumnNull("IsRecentPromotionDateMandatory") ? false : OldSurvey.IsRecentPromotionDateMandatory;
            NewSurvey.SurveyTypeID = OldSurvey.SurveyTypeID;
            if (OldSurvey.IsColumnNull("Duration"))
                NewSurvey.SetColumnNull("Duration");
            else
                NewSurvey.Duration = OldSurvey.Duration;
            NewSurvey.IsGovernrateMandatory = OldSurvey.IsColumnNull("IsGovernrateMandatory") ? false : OldSurvey.IsGovernrateMandatory;
            NewSurvey.ArHeader = OldSurvey.IsColumnNull("ArDesc") ? "" : OldSurvey.ArHeader;
            NewSurvey.EnHeader = OldSurvey.IsColumnNull("ArDesc") ? "" : OldSurvey.EnHeader;
            NewSurvey.ArFooter = OldSurvey.IsColumnNull("ArDesc") ? "" : OldSurvey.ArFooter;
            NewSurvey.EnFooter = OldSurvey.IsColumnNull("ArDesc") ? "" : OldSurvey.EnFooter;

            NewSurvey.Save();
            #endregion

            // Duplicating SurveyDepartment :: NewSurveyDepartment
            #region Duplicating SurveyDepartment
            SurveyDepartment OldSurveyDepartment = new SurveyDepartment();
            OldSurveyDepartment.Where.SurveyID.Value = OldSurvey.SurveyID;
            OldSurveyDepartment.Where.SurveyID.Operator = MyGeneration.dOOdads.WhereParameter.Operand.Equal;
            OldSurveyDepartment.Query.Load();

            if (OldSurveyDepartment.RowCount > 0)
            {
                OldSurveyDepartment.Rewind();
                for (int i = 0; i < OldSurveyDepartment.RowCount; i++)
                {
                    SurveyDepartment NewSurveyDepartment = new SurveyDepartment();
                    NewSurveyDepartment.AddNew();

                    NewSurveyDepartment.SurveyID = NewSurvey.SurveyID;
                    NewSurveyDepartment.DepartmentID = OldSurveyDepartment.DepartmentID;
                    NewSurveyDepartment.Weight = OldSurveyDepartment.IsColumnNull("Weight") ? 0 : OldSurveyDepartment.Weight;

                    NewSurvey.Save();
                    OldSurveyDepartment.MoveNext();
                }
            }
            #endregion

            // Duplicating Questions :: NewQuestion
            #region Duplicating Questions
            Question OldQuestion = new Question();
            OldQuestion.Where.SurveyID.Value = OldSurvey.SurveyID;
            OldQuestion.Where.SurveyID.Operator = MyGeneration.dOOdads.WhereParameter.Operand.Equal;
            OldQuestion.Query.Load();

            if (OldQuestion.RowCount > 0)
            {
                OldQuestion.Rewind();
                for (int i = 0; i < OldQuestion.RowCount; i++)
                {
                    Question NewQuestion = new Question();
                    NewQuestion.AddNew();

                    NewQuestion.SurveyID = NewSurvey.SurveyID;
                    NewQuestion.QuestionTypeID = OldQuestion.QuestionTypeID;
                    NewQuestion.ArTitle = OldQuestion.IsColumnNull("ArTitle") ? "" : OldQuestion.ArTitle;
                    NewQuestion.EnTitle = OldQuestion.IsColumnNull("EnTitle") ? "" : OldQuestion.EnTitle;
                    //ParentQuestionID ! TODO: Issue with Parent Question Field
                    NewQuestion.IsMandatory = OldQuestion.IsColumnNull("IsMandatory") ? false : OldQuestion.IsMandatory;
                    NewQuestion.Weight = OldQuestion.IsColumnNull("Weight") ? 0 : OldQuestion.Weight;
                    //QuestionCatergoryID !TODO: Issue with Question Category Field
                    NewQuestion.QuestionOrder = OldQuestion.IsColumnNull("QuestionOrder") ? 0 : OldQuestion.QuestionOrder;
                    //QuestionBranchID ! TODO: Issue with Question Branch Field
                    NewQuestion.Save();


                    // Duplicating Current Question Answers
                    Answer OldAnswer = new Answer();
                    OldAnswer.Where.QuestionID.Value = OldQuestion.QuestionID;
                    OldAnswer.Where.QuestionID.Operator = MyGeneration.dOOdads.WhereParameter.Operand.Equal;
                    OldAnswer.Query.Load();
                    OldQuestion.MoveNext();
                    if (OldAnswer.RowCount > 0)
                    {
                        OldAnswer.Rewind();
                        for (int j = 0; j < OldAnswer.RowCount; j++)
                        {
                            Answer NewAnswer = new Answer();
                            NewAnswer.AddNew();
                            NewAnswer.ArName = OldAnswer.IsColumnNull("ArName") ? "" : OldAnswer.ArName;
                            NewAnswer.EnName = OldAnswer.IsColumnNull("EnName") ? "" : OldAnswer.EnName;
                            NewAnswer.QuestionID = NewQuestion.QuestionID;
                            NewAnswer.Weight = OldAnswer.IsColumnNull("Weight") ? 0 : OldAnswer.Weight;
                            NewAnswer.Save();
                            OldAnswer.MoveNext();
                        }
                    }
                }
            }
            #endregion

            // Duplicating Question Categories :: NewQuestionCategory
            #region Duplicating Question Categories
            QuestionCategory OldQuestionCategory = new QuestionCategory();
            OldQuestionCategory.Where.SureveyID.Value = SurveyID;
            OldQuestionCategory.Where.SureveyID.Operator = MyGeneration.dOOdads.WhereParameter.Operand.Equal;
            OldQuestionCategory.Query.Load();

            if (OldQuestionCategory.RowCount > 0)
            {
                OldQuestionCategory.Rewind();
                for (int i = 0; i < OldQuestionCategory.RowCount; i++)
                {
                    QuestionCategory NewQuestionCategory = new QuestionCategory();
                    NewQuestionCategory.AddNew();
                    NewQuestionCategory.ArName = OldQuestionCategory.IsColumnNull("ArName") ? "" : OldQuestionCategory.ArName;
                    NewQuestionCategory.EnName = OldQuestionCategory.IsColumnNull("EnName") ? "" : OldQuestionCategory.EnName;
                    NewQuestionCategory.SureveyID = NewSurvey.SurveyID;
                    NewQuestionCategory.Save();
                    OldQuestionCategory.MoveNext();
                }
            }
            #endregion

            // Duplicating Question Branches :: NewQuestionBranch
            #region Duplicating Question Branches
            QuestionBranch OldQuestionBranch = new QuestionBranch();
            OldQuestionBranch.Where.SurveyID.Value = SurveyID;
            OldQuestionBranch.Where.SurveyID.Operator = MyGeneration.dOOdads.WhereParameter.Operand.Equal;
            OldQuestionBranch.Query.Load();

            if (OldQuestionBranch.RowCount > 0)
            {
                OldQuestionBranch.Rewind();
                for (int i = 0; i < OldQuestionBranch.RowCount; i++)
                {
                    QuestionBranch NewQuestionBranch = new QuestionBranch();
                    NewQuestionBranch.AddNew();
                    NewQuestionBranch.ArName = OldQuestionCategory.IsColumnNull("ArName") ? "" : OldQuestionCategory.ArName;
                    NewQuestionBranch.EnName = OldQuestionCategory.IsColumnNull("EnName") ? "" : OldQuestionCategory.EnName;
                    NewQuestionBranch.SurveyID = NewSurvey.SurveyID;
                    NewQuestionBranch.Save();
                    OldQuestionBranch.MoveNext();
                }
            }
            #endregion
        }

        [WebMethod]
        public void DeleteSurvey(int SurveyID)
        {
            Survey survey = new Survey();
            survey.LoadByPrimaryKey(SurveyID);

            SurveyMember members = new SurveyMember();
            members.GetListBySurveyID(SurveyID);

            QuestionCategory cats = new QuestionCategory();
            cats.GetSurveyCategoriesBySurveyID(SurveyID);

            QuestionBranch branchs = new QuestionBranch();
            branchs.GetBranchesBySurveyID(SurveyID);

            Question question = new Question();
            question.searchQuestions("", SurveyID);

            for (int i = 0; i < question.RowCount; i++)
            {

                SurveyMemberAnswer sma = new SurveyMemberAnswer();
                sma.getSurveyMemberAnswerByQuestionID(question.QuestionID);
                sma.DeleteAll();

                if (question.QuestionTypeID == 5)
                {
                    Question subs = new Question();
                    subs.GetSubQuestionsByQuestionID(question.QuestionID);
                    subs.DeleteAll();
                    subs.Save();
                }


                Answer answers = new Answer();
                answers.getAnswersByQuestionID(question.QuestionID);

                
                answers.DeleteAll();
                question.MarkAsDeleted();
                try
                {
                    sma.Save();
                    answers.Save();
                    //question.Save();
                    //SetContentResult(true);
                }
                catch (Exception ex)
                {
                    //SetContentResult(false);
                }
                question.MoveNext();
            }
            question.Save();
            branchs.DeleteAll();
            branchs.Save();
            cats.DeleteAll();
            cats.Save();
            members.DeleteAll();
            members.Save();
            survey.MarkAsDeleted();
            survey.Save();
            SetContentResult(false);
        }
        #endregion

        #region Survey Question
        [WebMethod]
        public void getAllQuestionTypes()
        {
            List<QuestionTypeModel> survies = new List<QuestionTypeModel>();
            QuestionType survs = new QuestionType();
            survs.LoadAll();
            for (int i = 0; i < survs.RowCount; i++)
            {
                survies.Add(new QuestionTypeModel { QuestionTypeID = survs.QuestionTypeID, IsGrid = survs.IsColumnNull("IsGrid") ? false : survs.IsGrid, ArName = survs.ArName, EnName = survs.EnName });
                survs.MoveNext();
            }

            SetContentResult(survies);
        }
        [WebMethod]
        public void getQuestionAnswersByQuestionID(int QuestionID)
        {
            List<AnswerModel> Answers = new List<AnswerModel>();
            Answer answers = new Answer();
            answers.Where.QuestionID.Value = QuestionID;
            answers.Where.QuestionID.Operator = MyGeneration.dOOdads.WhereParameter.Operand.Equal;
            answers.Query.Load();
            for (int i = 0; i < answers.RowCount; i++)
            {
                Answers.Add(new AnswerModel { AnswerID = answers.AnswerID, EnName = answers.EnName, ArName = answers.ArName, QuestionID = answers.QuestionID, Weight = answers.IsColumnNull("Weight") ? 0 : answers.Weight, NextBranchID = answers.IsColumnNull("NextBranchID") ? 0 : answers.NextBranchID, NextQuestionID = answers.IsColumnNull("NextQuestionID") ? 0 : answers.NextQuestionID });
                answers.MoveNext();
            }

            SetContentResult(Answers);
        }
        [WebMethod]
        public void getQuestions(int SurveyID)
        {
            List<QuestionModel> survies = new List<QuestionModel>();
            Question survs = new Question();
            survs.searchQuestions("", SurveyID);
            for (int i = 0; i < survs.RowCount; i++)
            {
                survies.Add(new QuestionModel
                {
                    QuestionTypeName = survs.GetColumn("QuestionTypeName").ToString(),
                    QuestionID = survs.QuestionID,
                    SurveyID = survs.SurveyID,
                    ArTitle = survs.ArTitle,
                    EnTitle = survs.EnTitle,
                    CategoryID = survs.IsColumnNull("QuestionCatergoryID") ? 0 : survs.QuestionCatergoryID,
                    BranchID = survs.IsColumnNull("QuestionBranchID") ? 0 : survs.QuestionBranchID,
                    QuestionOrder = survs.IsColumnNull("QuestionOrder") ? 0 : survs.QuestionOrder,
                    Weight = survs.IsColumnNull("Weight") ? 0 : survs.Weight,
                    IsMandatory = survs.IsColumnNull("IsMandatory") ? false : survs.IsMandatory,
                    ParentQuestionID = survs.IsColumnNull("ParentQuestionID") ? 0 : survs.ParentQuestionID,
                    QuestionTypeID = survs.QuestionTypeID
                });
                survs.MoveNext();
            }

            SetContentResult(survies);
        }
        [WebMethod]
        public void getSkipLogicQuestions(int SurveyID)
        {
            List<BranchingQuestionsModel> Branchs = new List<BranchingQuestionsModel>();
            Question ques = new Question();
            ques.Where.SurveyID.Value = SurveyID;
            ques.Where.SurveyID.Operator = MyGeneration.dOOdads.WhereParameter.Operand.Equal;
            ques.Query.Load();
            for (int i = 0; i < ques.RowCount; i++)
            {
                Answer answ = new Answer();
                answ.Where.QuestionID.Value = ques.QuestionID;
                answ.Where.QuestionID.Operator = MyGeneration.dOOdads.WhereParameter.Operand.Equal;
                answ.Where.QuestionID.Conjuction = MyGeneration.dOOdads.WhereParameter.Conj.And;
                answ.Where.NextQuestionID.Value = 0;
                answ.Where.NextQuestionID.Operator = MyGeneration.dOOdads.WhereParameter.Operand.NotEqual;
                answ.Where.NextQuestionID.Conjuction = MyGeneration.dOOdads.WhereParameter.Conj.And;
                answ.Where.NextQuestionID.Value = null;
                answ.Where.NextQuestionID.Operator = MyGeneration.dOOdads.WhereParameter.Operand.IsNotNull;
                answ.Query.Load();

                if (answ.RowCount > 0)
                {
                    for (int j = 0; j < answ.RowCount; j++)
                    {
                        Question tempNextQuestion = new Question();
                        tempNextQuestion.LoadByPrimaryKey(answ.NextQuestionID);
                        Branchs.Add(new BranchingQuestionsModel
                        {
                            AnswerID = answ.AnswerID,
                            AnswerText = answ.EnName,
                            QuestionID = ques.QuestionID,
                            QuestionText = ques.EnTitle,
                            QuestionTypeID = ques.QuestionTypeID,
                            SkipToQuestionID = answ.NextQuestionID,
                            SkipToQuestionText = (tempNextQuestion.EnTitle)
                        });
                        answ.MoveNext();
                    }
                }
                ques.MoveNext();
            }

            SetContentResult(Branchs);
        }
        [WebMethod]
        public void getBranchingQuestions(int SurveyID)
        {
            List<BranchingQuestionsModel> Branchs = new List<BranchingQuestionsModel>();
            Question ques = new Question();
            ques.Where.SurveyID.Value = SurveyID;
            ques.Where.SurveyID.Operator = MyGeneration.dOOdads.WhereParameter.Operand.Equal;
            ques.Query.Load();
            for (int i = 0; i < ques.RowCount; i++)
            {
                Answer answ = new Answer();
                answ.Where.QuestionID.Value = ques.QuestionID;
                answ.Where.QuestionID.Operator = MyGeneration.dOOdads.WhereParameter.Operand.Equal;
                answ.Where.QuestionID.Conjuction = MyGeneration.dOOdads.WhereParameter.Conj.And;
                answ.Where.NextBranchID.Value = 0;
                answ.Where.NextBranchID.Operator = MyGeneration.dOOdads.WhereParameter.Operand.NotEqual;
                answ.Where.NextBranchID.Conjuction = MyGeneration.dOOdads.WhereParameter.Conj.And;
                answ.Where.NextBranchID.Value = null;
                answ.Where.NextBranchID.Operator = MyGeneration.dOOdads.WhereParameter.Operand.IsNotNull;
                answ.Query.Load();

                if (answ.RowCount > 0)
                {
                    for (int j = 0; j < answ.RowCount; j++)
                    {
                        QuestionBranch tempNextBranch = new QuestionBranch();
                        tempNextBranch.LoadByPrimaryKey(answ.NextBranchID);
                        Branchs.Add(new BranchingQuestionsModel
                        {
                            AnswerID = answ.AnswerID,
                            AnswerText = answ.EnName,
                            QuestionID = ques.QuestionID,
                            QuestionText = ques.EnTitle,
                            QuestionTypeID = ques.QuestionTypeID,
                            SkipToBranchID = answ.NextBranchID,
                            SkipToBranchText = (tempNextBranch.EnName)
                        });
                        answ.MoveNext();
                    }
                }
                ques.MoveNext();
            }

            SetContentResult(Branchs);
        }
        [WebMethod]
        public void saveBranchingQuestion(BranchingQuestionsModel model, bool toBranch)
        {
            Answer answ = new Answer();
            answ.LoadByPrimaryKey(model.AnswerID);
            if (toBranch)
            {
                answ.NextBranchID = model.SkipToBranchID;
                answ.SetColumnNull("NextQuestionID");
            }
            else
            {
                answ.NextQuestionID = model.SkipToQuestionID;
                answ.SetColumnNull("NextBranchID");
            }
            answ.Save();
            SetContentResult(true);
        }
        [WebMethod]
        public void deleteBranchingOrSkipLogic(int AnswerID)
        {
            Answer answ = new Answer();
            answ.LoadByPrimaryKey(AnswerID);
            answ.SetColumnNull("NextQuestionID");
            answ.SetColumnNull("NextBranchID");
            answ.Save();            
            SetContentResult(true);
        }
        [WebMethod]
        public void SaveQuestion(QuestionModel model)
        {
            Question survs = new Question();
            if (model.QuestionID == 0)
                survs.AddNew();
            else
                survs.LoadByPrimaryKey(model.QuestionID);

            survs.ArTitle = model.ArTitle == null ? "" : model.ArTitle;
            survs.EnTitle = model.EnTitle == null ? "" : model.EnTitle;
            if (model.QuestionTypeID != 0)
                survs.QuestionTypeID = model.QuestionTypeID;
            else
                survs.SetColumnNull("QuestionTypeID");

            survs.IsMandatory = model.IsMandatory;

            survs.Weight = model.Weight;
            if (model.CategoryID != 0)
                survs.QuestionCatergoryID = model.CategoryID;
            else
                survs.SetColumnNull("QuestionCatergoryID");
            if (model.BranchID != 0)
                survs.QuestionBranchID = model.BranchID;
            else
                survs.SetColumnNull("QuestionBranchID");            
            survs.QuestionOrder = model.QuestionOrder;
            if (model.ParentQuestionID != 0)
                survs.ParentQuestionID = model.ParentQuestionID;
            else
                survs.SetColumnNull("ParentQuestionID");
            
            survs.SurveyID = model.SurveyID;
            survs.Save();

            QuestionModel tempQuestion = new QuestionModel
            {
                ArTitle = survs.ArTitle,
                EnTitle = survs.EnTitle,
                QuestionID = survs.QuestionID,
                QuestionTypeID = survs.IsColumnNull("QuestionTypeID") ? 0 : survs.QuestionTypeID,
                QuestionOrder = survs.QuestionOrder,
                Weight = survs.Weight,
                CategoryID = survs.IsColumnNull("QuestionCatergoryID") ? 0 : survs.QuestionCatergoryID,
                BranchID = survs.IsColumnNull("QuestionBranchID") ? 0: survs.QuestionBranchID,
                SurveyID = survs.SurveyID
            };
            SetContentResult(tempQuestion);
        }

        [WebMethod]
        public void UpdateQuestionsOrders(List<QuestionModel> model)
        {
            foreach (QuestionModel item in model)
            {
                Question survs = new Question();
                survs.LoadByPrimaryKey(item.QuestionID);
                survs.QuestionOrder = item.QuestionOrder;
                survs.Save();
            }
            
        }
        
        [WebMethod]
        public void deleteQuestion(int QuestionID)
        {
            Question question = new Question();
            question.LoadByPrimaryKey(QuestionID);
            
            Answer answers = new Answer();
            answers.getAnswersByQuestionID(QuestionID);

            SurveyMemberAnswer sma = new SurveyMemberAnswer();
            sma.getSurveyMemberAnswerByQuestionID(QuestionID);

            sma.DeleteAll();
            answers.DeleteAll();
            question.MarkAsDeleted();
            try
            {
                sma.Save();
                answers.Save();
                question.Save();
                SetContentResult(true);
            }
            catch (Exception ex)
            {
                SetContentResult(false);
            }

        }
        [WebMethod]
        public void SaveAnswers(AnswerModel model)
        {
            Answer survs = new Answer();
            if (model.AnswerID == 0)
                survs.AddNew();
            else
                survs.LoadByPrimaryKey(model.AnswerID);

            survs.EnName = model.EnName == null ? "" : model.EnName;
            survs.ArName = model.ArName == null ? "" : model.ArName;
            survs.Weight = model.Weight;
            survs.QuestionID = model.QuestionID;
            survs.Save();
            SetContentResult(true);
        }
        [WebMethod]
        public void deleteAnswer(int AnswerID)
        {
            Answer answer = new Answer();
            answer.LoadByPrimaryKey(AnswerID);
            answer.MarkAsDeleted();
            try
            {
                answer.Save();
                SetContentResult(true);
            }
            catch (Exception ex)
            {
                SetContentResult(false);
            }

        }
        [WebMethod]
        public void getSurveyAsJson(int SurveyID, string lang, string memberMail)
        {
            Survey survey = new Survey();
            survey.LoadByPrimaryKey(SurveyID);
            SurveyJson surveyJson = new Models.SurveyJson();
            surveyJson.title = lang == "en" ? survey.EnName : survey.ArName;
            surveyJson.pages = new List<Models.PageJson>();
            double timeToFinish = 0;
            if (!survey.IsColumnNull("SurveyTypeID") && !survey.IsColumnNull("Duration"))
                if (survey.SurveyTypeID == 2)
                {
                    timeToFinish = survey.Duration.TimeOfDay.TotalSeconds;
                    surveyJson.showTimerPanel = "top";
                    surveyJson.showTimerPanelMode = "survey";
                }
            surveyJson.maxTimeToFinish = timeToFinish;
            if (!survey.IsColumnNull("SurveyTypeID"))
                surveyJson.SurveyTypeID = survey.SurveyTypeID;
            else
                surveyJson.SurveyTypeID = 1;

            if (!survey.IsColumnNull("IsPublic"))
                surveyJson.IsPublic = survey.IsPublic;
            else
                surveyJson.IsPublic = false;

            QuestionCategory Categories = new QuestionCategory();
            Categories.GetSurveyCategoriesBySurveyID(SurveyID);
            int pageCount = -1;
            for (int j = 0; j < Categories.RowCount; j++)
            {
                surveyJson.pages.Add(new PageJson() { name = lang == "en" ? Categories.EnName : Categories.ArName, title = lang == "en" ? Categories.EnName : Categories.ArName, questions = new List<QuestionJson>(), visibleIf = "", navigationButtonsVisibility = "show" });
                pageCount++;
                Question questionsMain = new Question();
                questionsMain.GetSurveyQuestionsBySurveyIDAndCategoryID(SurveyID, Categories.CategoryID);
                for (int i = 0; i < questionsMain.RowCount; i++)
                {
                    string qtype = "";
                    List<item> answersJson = new List<item>();
                    List<item> rows = new List<item>();
                    List<item> columns = new List<item>();
                    Answer answers = new Answer();
                    answers.getAnswersByQuestionID(questionsMain.QuestionID);
                    for (int k = 0; k < answers.RowCount; k++)
                    {
                        answersJson.Add(new item { text = lang == "en" ? answers.EnName : answers.ArName, value = answers.AnswerID.ToString() });
                        columns.Add(new item() { text = lang == "en" ? answers.EnName : answers.ArName, value = answers.AnswerID.ToString() });
                        answers.MoveNext();
                    }

                    switch (questionsMain.QuestionTypeID)
                    {
                        case 1:
                        case 2:
                        case 3:
                        case 4:
                            if (questionsMain.QuestionTypeID == 1) qtype = "text";
                            if (questionsMain.QuestionTypeID == 2) qtype = "radiogroup";
                            if (questionsMain.QuestionTypeID == 3) qtype = "checkbox";
                            if (questionsMain.QuestionTypeID == 4) qtype = "dropdown";
                            surveyJson.pages[pageCount].questions.Add(
                            new QuestionJson()
                            {
                                name = questionsMain.QuestionID.ToString(),
                                type = qtype,
                                isRequired = questionsMain.IsColumnNull("IsMandatory") ? false : questionsMain.IsMandatory,
                                title = lang == "en" ? questionsMain.EnTitle : questionsMain.ArTitle,
                                choices = answersJson,
                                visibleIf = questionsMain.IsColumnNull("PQuestionID") ? "" : "{" + questionsMain.GetColumn("PQuestionID").ToString() + "} = '" + questionsMain.GetColumn("AnswerID") + "'"
                            });
                            break;
                        case 5:
                            qtype = "matrix";
                            Question subquestions = new Question();
                            subquestions.GetSubQuestionsByQuestionID(questionsMain.QuestionID);
                            for (int m = 0; m < subquestions.RowCount; m++)
                            {
                                rows.Add(new item() { text = lang == "en" ? subquestions.EnTitle : subquestions.ArTitle, value = subquestions.QuestionID.ToString() });
                                subquestions.MoveNext();
                            }
                            surveyJson.pages[pageCount].questions.Add(
                            new QuestionJson()
                            {
                                name = questionsMain.QuestionID.ToString(),
                                type = qtype,
                                isRequired = questionsMain.IsColumnNull("IsMandatory") ? false : questionsMain.IsMandatory,
                                isAllRowRequired = questionsMain.IsColumnNull("IsMandatory") ? false : questionsMain.IsMandatory,
                                title = lang == "en" ? questionsMain.EnTitle : questionsMain.ArTitle,
                                rows = rows,
                                columns = columns,
                                visibleIf = questionsMain.IsColumnNull("PQuestionID") ? "" : "{" + questionsMain.GetColumn("PQuestionID").ToString() + "} = '" + questionsMain.GetColumn("AnswerID") + "'"

                            });
                            break;
                        default:
                            break;
                    }

                    questionsMain.MoveNext();
                }
                Categories.MoveNext();

            }
            

            SurveyMember mem = new SurveyMember();
            mem.GetMemberBySurveyIDAndMemberEmail(SurveyID, memberMail);

            Survey surveyData = new Survey();
            surveyData.GetSurveyDataBySurveyIDAndMemberID(SurveyID, mem.MemberID);
            List<object> sdata = new List<object>();
            string dataObject = "{";
            for (int i = 0; i < surveyData.RowCount; i++)
            {
                if (dataObject.Length > 1)
                    dataObject += ",";
                switch (surveyData.GetColumn("QuestionTypeID").ToString())
                {                    
                    case "1":                        
                        dataObject += "\""+surveyData.GetColumn("QuestionID").ToString() + "\""  + ":" + "\""+ surveyData.GetColumn("AnswerText").ToString() + "\"";
                        break;
                    case "2":
                    case "4":
                        dataObject += "\"" + surveyData.GetColumn("QuestionID").ToString() + "\":\"" + surveyData.GetColumn("AnswerID").ToString() + "\"";
                        break;
                    case "5":
                        dataObject += "\"" + surveyData.GetColumn("QuestionID").ToString() + "\":{";
                        Survey subsurveyData = new Survey();
                        subsurveyData.GetSurveyDataSubQuestionBySurveyIDAndMemberIDAndParentQuestionID(SurveyID, mem.MemberID, int.Parse(surveyData.GetColumn("QuestionID").ToString()));

                        for (int k = 0; k < subsurveyData.RowCount; k++)
                        {
                            if (k > 0)
                                dataObject += ",";
                            dataObject += "\"" + subsurveyData.GetColumn("QuestionID").ToString() + "\":\"" + subsurveyData.GetColumn("AnswerID").ToString() + "\"";
                            subsurveyData.MoveNext();
                        }
                        dataObject += "}";
                        break;
                    case "3":
                        dataObject += "\"" + surveyData.GetColumn("QuestionID").ToString() + "\":[";
                        Survey checksurveyData = new Survey();
                        checksurveyData.GetSurveyDataAnswersBySurveyIDAndMemberIDAndQuestionID(SurveyID, mem.MemberID, int.Parse(surveyData.GetColumn("QuestionID").ToString()));

                        for (int k = 0; k < checksurveyData.RowCount; k++)
                        {
                            if (k > 0)
                                dataObject += ",";
                            dataObject += "\"" + checksurveyData.GetColumn("AnswerID").ToString() + "\"";
                            checksurveyData.MoveNext();
                        }
                        dataObject += "]";
                        break;
                    default:
                        break;
                }
                surveyData.MoveNext();
            }
            dataObject += "}";
            dynamic x = new { survey = surveyJson, surveydata= dataObject };
            SetContentResult(x);
        }
        
        [WebMethod]
        public void submitSurveyAsJson(int SurveyID, string member, object surveydata, bool IsSubmitted)
        {
            dynamic obj = surveydata;
            List<object> myvaluelist = new List<object>();
            myvaluelist.AddRange((dynamic)obj.Values);
            List<object> mykeylist = new List<object>();
            mykeylist.AddRange((dynamic)obj.Keys);
            SurveyMember mem = new SurveyMember();
            mem.GetMemberBySurveyIDAndMemberEmail(SurveyID, member);
			mem.IsSurveySubmited = IsSubmitted;
            if (IsSubmitted)
                mem.SubmitDate = DateTime.Now;
            else
                mem.SetColumnNull("SubmitDate");
            mem.Save();
            for (int i = 0; i < mykeylist.Count; i++)
            {
                Question q = new Question();
                q.LoadByPrimaryKey(int.Parse(mykeylist[i].ToString()));                
                SurveyMemberAnswer answer = new SurveyMemberAnswer();
                if (!answer.getAnswerByMemberIDAndQuestionID(mem.MemberID, q.QuestionID))
                    answer.AddNew();
                answer.SurveyMemberID = mem.MemberID;
                answer.QuestionID = q.QuestionID;

                if (q.QuestionTypeID == 1 || q.QuestionTypeID == 2 || q.QuestionTypeID == 4)
                {
                    if (q.QuestionTypeID == 1)
                    {
                        answer.AnswerText = myvaluelist[i].ToString();
                        answer.SetColumnNull("AnswerID");
                    }
                    else
                    {
                        try
                        {
                            answer.AnswerID = int.Parse(myvaluelist[i].ToString());
                            answer.SetColumnNull("AnswerText");
                        }
                        catch (Exception ex)
                        {
                            // question in case of dropdown / radio is not answered due to branching or not madatory 
                            answer.SetColumnNull("AnswerID");
                            answer.SetColumnNull("AnswerText");
                        }
                    }
                }
                else if (q.QuestionTypeID == 5)
                {
                    dynamic subObj = myvaluelist[i];
                    List<object> mysubvaluelist = new List<object>();
                    mysubvaluelist.AddRange((dynamic)subObj.Values);
                    List<object> mysubkeylist = new List<object>();
                    mysubkeylist.AddRange((dynamic)subObj.Keys);
                    for (int j = 0; j < mysubkeylist.Count; j++)
                    {
                        SurveyMemberAnswer subanswer = new SurveyMemberAnswer();
                        if (!subanswer.getAnswerByMemberIDAndQuestionID(mem.MemberID, int.Parse(mysubkeylist[j].ToString())))
                            subanswer.AddNew();
                        subanswer.SurveyMemberID = mem.MemberID;
                        subanswer.QuestionID = int.Parse(mysubkeylist[j].ToString());
                        try
                        {
                            subanswer.AnswerID = int.Parse(mysubvaluelist[j].ToString());
                        }
                        catch (Exception ex)
                        {
                            // question in case of radio is not answered in matrix
                            subanswer.SetColumnNull("AnswerID");
                            subanswer.SetColumnNull("AnswerText");
                        }
                        subanswer.Save();
                    }
					continue;
                }
                else if (q.QuestionTypeID == 3)
                {
                    List<object> mysubvaluelist = new List<object>();
                    mysubvaluelist.AddRange((dynamic)myvaluelist[i]);
					SurveyMemberAnswer subanswer = new SurveyMemberAnswer();
                    if (subanswer.getAnswerByMemberIDAndQuestionID(mem.MemberID, q.QuestionID))
                    {
                        subanswer.DeleteAll();
                        subanswer.Save();
                    }

                    for (int k = 0; k < mysubvaluelist.Count; k++)
                    {
                        if (!string.IsNullOrEmpty(mysubvaluelist[k].ToString()))
                        {
                            subanswer.AddNew();
                            subanswer.SurveyMemberID = mem.MemberID;
                            subanswer.QuestionID = q.QuestionID;
                            subanswer.AnswerID = int.Parse(mysubvaluelist[k].ToString());
                            subanswer.Save();
                        }
                    }
					continue;
                }
                else
                {
                    continue;
                }

                answer.Save();

            }
            SetContentResult(true);
        }
        [WebMethod]
        public void submitDemographicData(int SurveyID, string member,int conId,  int govId, int areaID, int branchID, int departmentID,
                        int divisionID, int level, int grade, int jobTitle, int ageGroup, int gender, int durationInSeconds)
        {
            SurveyMember _member = new SurveyMember();
            if (_member.GetMemberBySurveyIDAndMemberEmail(SurveyID, member))
            {
                if (conId != 0)
                    _member.CountryID = conId;
                if (govId != 0)
                    _member.GovernrateID = govId;
                if (areaID != 0)
                    _member.AreaID = areaID;
                if (branchID != 0)
                    _member.BranchID = branchID;
                if (departmentID != 0)
                    _member.DepartmentID = departmentID;
                if (divisionID != 0)
                    _member.DivionID = divisionID;
                if (level != 0)
                    _member.LevelID = level;
                if (grade != 0)
                    _member.GradeID = grade;
                if (jobTitle != 0)
                    _member.JobTitleID = jobTitle;
                if (ageGroup != 0)
                    _member.AgeGroupID = ageGroup;
                if (gender != 0)
                    _member.GenderID = gender;
                if (_member.IsColumnNull(SurveyMember.ColumnNames.Duration))
                {
                    _member.Duration = new DateTime(1900, 1, 1).AddSeconds(durationInSeconds);
                }
                else
                    _member.Duration = _member.Duration.AddSeconds(durationInSeconds);
                _member.Save();
            }
        }
        [WebMethod]
        public void importQuestion(int QuestionID, int NewSurveyID)
        {
            Question originalQuestion = new Question();
            originalQuestion.LoadByPrimaryKey(QuestionID);

            Question newQuestion = new Question();
            newQuestion.AddNew();
            newQuestion.SurveyID = NewSurveyID;
            newQuestion.QuestionTypeID = originalQuestion.QuestionTypeID;
            newQuestion.ArTitle = originalQuestion.ArTitle;
            newQuestion.EnTitle = originalQuestion.EnTitle;
            newQuestion.IsMandatory = originalQuestion.IsColumnNull("IsMandatory") ? false : originalQuestion.IsMandatory;
            newQuestion.Weight = originalQuestion.IsColumnNull("Weight") ? 0 : originalQuestion.Weight;
            //order won't be imported
            //newQuestion.QuestionOrder = originalQuestion.IsColumnNull("QuestionOrder") ? 0 : originalQuestion.QuestionOrder;            
            newQuestion.Save();

            // Importing Question Answers
            Answer originalAnswer = new Answer();
            originalAnswer.Where.QuestionID.Value = QuestionID;
            originalAnswer.Where.QuestionID.Operator = MyGeneration.dOOdads.WhereParameter.Operand.Equal;
            originalAnswer.Query.Load();

            if (originalAnswer.RowCount > 0)
            {
                originalAnswer.Rewind();
                for (int i = 0; i < originalAnswer.RowCount; i++)
                {
                    Answer newAnswer = new Answer();
                    newAnswer.AddNew();
                    newAnswer.ArName = originalAnswer.ArName;
                    newAnswer.EnName = originalAnswer.EnName;
                    newAnswer.QuestionID = newQuestion.QuestionID;
                    newAnswer.Weight = originalAnswer.IsColumnNull("Weight") ? 0 : originalAnswer.Weight;
                    newAnswer.Save();
                    originalAnswer.MoveNext();
                }
            }

            // Importing Sub-Questions
            Question originalSubQuestion = new Question();
            originalSubQuestion.Where.ParentQuestionID.Value = QuestionID;
            originalSubQuestion.Where.ParentQuestionID.Operator = MyGeneration.dOOdads.WhereParameter.Operand.Equal;
            originalSubQuestion.Query.Load();

            if (originalSubQuestion.RowCount > 0)
            {
                originalSubQuestion.Rewind();
                for (int i = 0; i < originalSubQuestion.RowCount; i++)
                {
                    Question newSubQuestion = new Question();
                    newSubQuestion.AddNew();
                    newSubQuestion.SurveyID = NewSurveyID;
                    // sub question has no type :) 
                    //newSubQuestion.QuestionTypeID = originalSubQuestion.QuestionTypeID;
                    newSubQuestion.ParentQuestionID = newQuestion.QuestionID;
                    newSubQuestion.ArTitle = originalSubQuestion.ArTitle;
                    newSubQuestion.EnTitle = originalSubQuestion.EnTitle;
                    newSubQuestion.IsMandatory = originalSubQuestion.IsColumnNull("IsMandatory") ? false : originalSubQuestion.IsMandatory;
                    newSubQuestion.Weight = originalSubQuestion.IsColumnNull("Weight") ? 0 : originalSubQuestion.Weight;
                    //newSubQuestion.QuestionOrder = originalSubQuestion.IsColumnNull("QuestionOrder") ? 0 : originalSubQuestion.QuestionOrder;
                    newSubQuestion.Save();
                    originalSubQuestion.MoveNext();
                }
            }
        }
        [WebMethod]
        public void importQuestionBulk(int NewSurveyID , List<int> QuestionsIDList)
        {
            foreach (int item in QuestionsIDList)
            {
                importQuestion(item, NewSurveyID);
            }
        }

        [WebMethod]
        public void importBankQuestion(int QuestionID, int NewSurveyID)
        {
            BankQuestion originalQuestion = new BankQuestion();
            originalQuestion.LoadByPrimaryKey(QuestionID);

            Question newQuestion = new Question();
            newQuestion.AddNew();
            newQuestion.SurveyID = NewSurveyID;
            newQuestion.QuestionTypeID = originalQuestion.BankQuestionTypeID;
            newQuestion.ArTitle = originalQuestion.ArTitle;
            newQuestion.EnTitle = originalQuestion.EnTitle;
            newQuestion.IsMandatory = originalQuestion.IsColumnNull("IsMandatory") ? false : originalQuestion.IsMandatory;
            newQuestion.Weight = originalQuestion.IsColumnNull("Weight") ? 0 : originalQuestion.Weight;
            newQuestion.Save();

            // Importing Bank Question Answers
            BankQuestionAnswer originalAnswer = new BankQuestionAnswer();
            originalAnswer.Where.BankQuestionID.Value = QuestionID;
            originalAnswer.Where.BankQuestionID.Operator = MyGeneration.dOOdads.WhereParameter.Operand.Equal;
            originalAnswer.Query.Load();

            if (originalAnswer.RowCount > 0)
            {
                originalAnswer.Rewind();
                for (int i = 0; i < originalAnswer.RowCount; i++)
                {
                    Answer newAnswer = new Answer();
                    newAnswer.AddNew();
                    newAnswer.ArName = originalAnswer.ArName;
                    newAnswer.EnName = originalAnswer.EnName;
                    newAnswer.QuestionID = newQuestion.QuestionID;
                    newAnswer.Weight = originalAnswer.IsColumnNull("Weight") ? 0 : originalAnswer.Weight;
                    newAnswer.Save();
                    originalAnswer.MoveNext();
                }
            }
        }
        [WebMethod]
        public void importBankQuestionBulk(int NewSurveyID, List<int> QuestionsIDList)
        {
            foreach (int item in QuestionsIDList)
            {
                importBankQuestion(item, NewSurveyID);
            }
        }


		[WebMethod]
        public void getBranchingRules(int SurveyID)
        {
            List<BranchingQuestionsModel> Branchs = new List<BranchingQuestionsModel>();
            QuestionBranch ques = new QuestionBranch();
            ques.GetSurveyQuestionsBySurveyIDWithBranching(SurveyID);
            for (int i = 0; i < ques.RowCount; i++)
            {
                
                Branchs.Add(new BranchingQuestionsModel
                {
                    AnswerID = int.Parse(ques.GetColumn("AnswerID").ToString()),
                    AnswerText = ques.GetColumn("AnswerText").ToString(),
                    QuestionID = int.Parse(ques.GetColumn("QuestionID").ToString()),
                    QuestionText = ques.GetColumn("QuestionText").ToString(),
                    QuestionTypeID = int.Parse(ques.GetColumn("QuestionTypeID").ToString()),
                    SkipToBranchID = int.Parse(ques.GetColumn("SkipToBranchID").ToString()),
                    SkipToBranchText = ques.GetColumn("SkipToBranchText").ToString()
                });
                    
                ques.MoveNext();
            }

            SetContentResult(Branchs);
        }
		
        [WebMethod]
        public void duplicateQuestion(int QuestionID)
        {
            Question originalQuestion = new Question();
            originalQuestion.LoadByPrimaryKey(QuestionID);

            Question newQuestion = new Question();
            newQuestion.AddNew();
            newQuestion.SurveyID = originalQuestion.SurveyID;
            newQuestion.QuestionTypeID = originalQuestion.QuestionTypeID;
            newQuestion.ArTitle = originalQuestion.ArTitle + " (مكرر)";
            newQuestion.EnTitle = originalQuestion.EnTitle + " (Duplicated)";
            newQuestion.IsMandatory = originalQuestion.IsColumnNull("IsMandatory") ? false : originalQuestion.IsMandatory;
            newQuestion.Weight = originalQuestion.IsColumnNull("Weight") ? 0 : originalQuestion.Weight;
            newQuestion.QuestionOrder = originalQuestion.IsColumnNull("QuestionOrder") ? 0 : originalQuestion.QuestionOrder;
            newQuestion.Save();

            // Importing Question Answers
            Answer originalAnswer = new Answer();
            originalAnswer.Where.QuestionID.Value = QuestionID;
            originalAnswer.Where.QuestionID.Operator = MyGeneration.dOOdads.WhereParameter.Operand.Equal;
            originalAnswer.Query.Load();

            if (originalAnswer.RowCount > 0)
            {
                originalAnswer.Rewind();
                for (int i = 0; i < originalAnswer.RowCount; i++)
                {
                    Answer newAnswer = new Answer();
                    newAnswer.AddNew();
                    newAnswer.ArName = originalAnswer.ArName;
                    newAnswer.EnName = originalAnswer.EnName;
                    newAnswer.QuestionID = newQuestion.QuestionID;
                    newAnswer.Weight = originalAnswer.IsColumnNull("Weight") ? 0 : originalAnswer.Weight;
                    newAnswer.Save();
                    originalAnswer.MoveNext();
                }
            }
        }

		

        #endregion

        #region Question Categories
        [WebMethod]
        public void getAllQuestionCategoriesBySurveyID(int SurveyID)
        {
            List<CategoryModel> Cats = new List<CategoryModel>();
            QuestionCategory cats = new QuestionCategory();
            cats.Where.SureveyID.Value = SurveyID;
            cats.Where.SureveyID.Operator = MyGeneration.dOOdads.WhereParameter.Operand.Equal;
            cats.Query.Load();
            for (int i = 0; i < cats.RowCount; i++)
            {
                Cats.Add(new CategoryModel { CategoryID = cats.CategoryID, EnName = cats.EnName, SureveyID = cats.SureveyID });
                cats.MoveNext();
            }

            SetContentResult(Cats);
        }
        [WebMethod]
        public void SaveCategory(CategoryModel model)
        {
            QuestionCategory cats = new QuestionCategory();
            if (model.CategoryID == 0)
                cats.AddNew();
            else
                cats.LoadByPrimaryKey(model.CategoryID);

            cats.EnName = model.EnName == null ? "" : model.EnName;
            cats.ArName = model.ArName == null ? "" : model.ArName;
            cats.SureveyID = model.SureveyID;
            cats.Save();
            SetContentResult(true);
        }
        [WebMethod]
        public void getQuestionCategory(int CategoryID)
        {
            CategoryModel cats = new CategoryModel();
            QuestionCategory category = new QuestionCategory();
            category.LoadByPrimaryKey(CategoryID);

            cats = new CategoryModel
            {
                SureveyID = category.SureveyID,
                CategoryID = category.CategoryID,
                ArName = category.ArName,                
                EnName = category.EnName
            };


            SetContentResult(cats);
        }
        [WebMethod]
        public void deleteQuestionCategory(int CategoryID)
        {            
            QuestionCategory category = new QuestionCategory();
            category.LoadByPrimaryKey(CategoryID);
            category.MarkAsDeleted();
            try
            {
                category.Save();
                SetContentResult(true);
            }
            catch (Exception ex)
            {
                SetContentResult(false);
            }
            
        }
        #endregion

        #region Question Branches
        [WebMethod]
        public void getAllQuestionBranchesBySurveyID(int SurveyID)
        {
            List<QuestionBranchModel> branches = new List<QuestionBranchModel>();
            QuestionBranch cats = new QuestionBranch();
            cats.Where.SurveyID.Value = SurveyID;
            cats.Where.SurveyID.Operator = MyGeneration.dOOdads.WhereParameter.Operand.Equal;
            cats.Query.Load();
            for (int i = 0; i < cats.RowCount; i++)
            {
                branches.Add(new QuestionBranchModel { QuestionBranchID = cats.QuestionBranchID, EnName = cats.EnName, SureveyID = cats.SurveyID });
                cats.MoveNext();
            }

            SetContentResult(branches);
        }
        [WebMethod]
        public void SaveBranch(QuestionBranchModel model)
        {
            QuestionBranch cats = new QuestionBranch();
            if (model.QuestionBranchID == 0)
                cats.AddNew();
            else
                cats.LoadByPrimaryKey(model.QuestionBranchID);

            cats.EnName = model.EnName == null ? "" : model.EnName;
            cats.ArName = model.ArName == null ? "" : model.ArName;
            cats.SurveyID = model.SureveyID;
            cats.Save();
            SetContentResult(true);
        }
        [WebMethod]
        public void getQuestionBranch(int BranchID)
        {
            QuestionBranchModel branchs = new QuestionBranchModel();
            QuestionBranch branch = new QuestionBranch();
            branch.LoadByPrimaryKey(BranchID);

            branchs = new QuestionBranchModel
            {
                SureveyID = branch.SurveyID,
                QuestionBranchID = branch.QuestionBranchID,
                ArName = branch.ArName,
                EnName = branch.EnName
            };


            SetContentResult(branchs);
        }
        [WebMethod]
        public void deleteQuestionBranch(int BranchID)
        {
            QuestionBranch branch = new QuestionBranch();
            branch.LoadByPrimaryKey(BranchID);
            branch.MarkAsDeleted();
            try
            {
                branch.Save();
                SetContentResult(true);
            }
            catch (Exception ex)
            {
                SetContentResult(false);
            }

        }
        #endregion

        #region Sub-Questions
        [WebMethod]
        public void getSubQuestionByQuestionID(int QuestionID)
        {
            List<QuestionModel> Questions = new List<QuestionModel>();
            Question question = new Question();
            question.Where.ParentQuestionID.Value = QuestionID;
            question.Where.ParentQuestionID.Operator = MyGeneration.dOOdads.WhereParameter.Operand.Equal;
            question.Query.Load();
            for (int i = 0; i < question.RowCount; i++)
            {
                Questions.Add(new QuestionModel { QuestionID = question.QuestionID, EnTitle = question.EnTitle,ArTitle = question.ArTitle,ParentQuestionID = question.ParentQuestionID });
                question.MoveNext();
            }

            SetContentResult(Questions);
        }
        #endregion

        #region PublishList
        [WebMethod]
        public void getAllListBySurveyID(int SurveyID)
        {
            List<SurveyMemberModel> Cats = new List<SurveyMemberModel>();
            SurveyMember cats = new SurveyMember();
            cats.GetListBySurveyID(SurveyID);
            for (int i = 0; i < cats.RowCount; i++)
            {
                Cats.Add(new SurveyMemberModel { MemberID = cats.MemberID, MemberEmail = cats.MemberEmail, SurveyID = cats.SurveyID, IsSurveySubmited = cats.IsColumnNull("IsSurveySubmited") ? false : cats.IsSurveySubmited });
                cats.MoveNext();
            }

            SetContentResult(Cats);
        }
        [WebMethod]
        public void SaveMail(SurveyMemberModel model)
        {
            SurveyMember cats = new SurveyMember();
            if (model.MemberID == 0)
                cats.AddNew();
            else
                cats.LoadByPrimaryKey(model.MemberID);

            cats.MemberEmail = model.MemberEmail == null ? "" : model.MemberEmail;            
            cats.SurveyID = model.SurveyID;
            cats.Save();
            SetContentResult(true);
        }
        [WebMethod]
        public void getSurveyMember(int MemberID)
        {
            SurveyMemberModel cats = new SurveyMemberModel();
            SurveyMember category = new SurveyMember();
            category.LoadByPrimaryKey(MemberID);

            cats = new SurveyMemberModel
            {
                SurveyID = category.SurveyID,
                MemberEmail = category.MemberEmail
            };


            SetContentResult(cats);
        }
        [WebMethod]
        public void deleteSurveyMember(int MemberID)
        {
            SurveyMember category = new SurveyMember();
            category.LoadByPrimaryKey(MemberID);
            category.MarkAsDeleted();
            try
            {
                category.Save();
                SetContentResult(true);
            }
            catch (Exception ex)
            {
                SetContentResult(false);
            }

        }
        #endregion

        #region Live Support

        [WebMethod]
        public void getSupportTickets() {
            SupportTicket supportTickets = new SupportTicket();
            List<SupportTicketModel> supportTicketModels = new List<SupportTicketModel>();

            if (Roles.IsUserInRole("admin"))
            {
                supportTickets.getSupportTicketsForAdmin();

                if (supportTickets.RowCount > 0)
                {
                    supportTickets.Rewind();
                    for (int i = 0; i < supportTickets.RowCount; i++)
                    {
                        TicketMessage obj = new TicketMessage();
                        obj.getUnreadMessages(supportTickets.UserID, supportTickets.SupportTicketID, 1);

                        TicketMessage obj2 = new TicketMessage();
                        obj2.getLastMessageDate(supportTickets.SupportTicketID);
                        DateTime? lastdate = null;
                        if(obj2.RowCount > 0)
                            if(!obj2.IsColumnNull("LastMessageDate"))
                                lastdate = DateTime.Parse(obj2.GetColumn("LastMessageDate").ToString());
                        supportTicketModels.Add(new SupportTicketModel
                        {
                            UserName = supportTickets.GetColumn("UserName").ToString(),
                            TicketTitle = supportTickets.TicketTitle.Length > 50 ? supportTickets.TicketTitle.Substring(0,50) + "...": supportTickets.TicketTitle,
                            TicketDate = supportTickets.TicketDate,
                            SupportTicketID = supportTickets.SupportTicketID,
                            IsClosed = supportTickets.IsClosed,
                            UnreadMessages = obj.RowCount,
                            LastMessageDate = lastdate
                        });
                        supportTickets.MoveNext();
                    }
                }
            }
            else
            {
                supportTickets.getSupportTicketsForClient(Membership.GetUser(true).ProviderUserKey.ToString());
                if (supportTickets.RowCount > 0)
                {
                    supportTickets.Rewind();
                    for (int i = 0; i < supportTickets.RowCount; i++)
                    {
                        TicketMessage obj = new TicketMessage();
                        obj.getUnreadMessages(supportTickets.UserID, supportTickets.SupportTicketID, 0);

                        TicketMessage obj2 = new TicketMessage();
                        obj2.getLastMessageDate(supportTickets.SupportTicketID);
                        supportTicketModels.Add(new SupportTicketModel
                        {
                            TicketTitle = supportTickets.TicketTitle.Length > 50 ? supportTickets.TicketTitle.Substring(0, 50) + "..." : supportTickets.TicketTitle,
                            TicketDate = supportTickets.TicketDate,
                            SupportTicketID = supportTickets.SupportTicketID,
                            IsClosed = supportTickets.IsClosed,
                            UnreadMessages = obj.RowCount,
                            LastMessageDate = DateTime.Parse(obj2.GetColumn("LastMessageDate").ToString())
                        });
                        supportTickets.MoveNext();
                    }
                }
            }
            SetContentResult(supportTicketModels.OrderByDescending(i=>i.LastMessageDate));
        }

        [WebMethod]
        public void getSupportMessages(int supportTicketID,bool isAdmin)
        {
            setMessagesAsRead(supportTicketID, isAdmin);
            TicketMessage ticketMessage = new TicketMessage();
            ticketMessage.getTicketMessages(supportTicketID);

            List<TicketMessageModel> messages = new List<TicketMessageModel>();
            if (ticketMessage.RowCount > 0)
            {
                ticketMessage.Rewind();
                for (int i = 0; i < ticketMessage.RowCount; i++)
                {
                    messages.Add(new TicketMessageModel
                    {
                        TicketMessageID = ticketMessage.TicketMessageID,
                        SupportTicketID = ticketMessage.SupportTicketID,
                        MessageDate = ticketMessage.MessageDate,
                        MessageContent = ticketMessage.MessageContent,
                        FromAdmin = ticketMessage.FromAdmin
                    });
                    ticketMessage.MoveNext();
                }
            }
            SetContentResult(messages);
        }

        public void setMessagesAsRead(int supportTicketID,bool IsAdmin)
        {
            TicketMessage obj = new TicketMessage();
            obj.setMessagesAsRead(supportTicketID, IsAdmin ? 1 : 0);
        }

        [WebMethod]
        public void sendMessage(int supportTicketID,bool isAdmin, string messageContent)
        {
            TicketMessage obj = new TicketMessage();
            obj.AddNew();
            obj.SupportTicketID = supportTicketID;
            obj.FromAdmin = isAdmin;
            obj.MessageContent = messageContent;
            obj.MessageDate = DateTime.Now;
            obj.IsRead = false;
            obj.Save();
        }

        [WebMethod]
        public void createNewTicket(string TicketTitle)
        {
            SupportTicket obj = new SupportTicket();
            obj.AddNew();
            obj.TicketTitle = TicketTitle;
            obj.UserID = new Guid(Membership.GetUser(true).ProviderUserKey.ToString());
            obj.TicketDate = DateTime.Now;
            obj.IsClosed = false;
            obj.Save();

            TicketMessage obj2 = new TicketMessage();
            obj2.AddNew();
            obj2.SupportTicketID = obj.SupportTicketID;
            obj2.FromAdmin = false;
            obj2.MessageContent = TicketTitle;
            obj2.MessageDate = DateTime.Now;
            obj2.IsRead = false;
            obj2.Save();
        }

        [WebMethod]
        public void closeTicket(int supportTicketID)
        {
            SupportTicket obj = new SupportTicket();
            obj.LoadByPrimaryKey(supportTicketID);
            obj.IsClosed = true;
            obj.Save();
        }

        #endregion

        #region Question Bank Categories

        [WebMethod]
        public void getAllBankCategories()
        {
            BankCategory cats = new BankCategory();
            cats.LoadAll();

            SetContentResult(cats.DefaultView.ToTable());
        }

        [WebMethod]
        public void SaveBankCategory(BankCategoryModel model)
        {
            BankCategory cats = new BankCategory();
            if (model.BankCategoryID == 0)
                cats.AddNew();
            else
                cats.LoadByPrimaryKey(model.BankCategoryID);

            cats.EnName = model.EnName == null ? "" : model.EnName;
            cats.ArName = model.ArName == null ? "" : model.ArName;
            cats.Save();
            SetContentResult(true);
        }

        [WebMethod]
        public void deleteBankCategory(int CategoryID)
        {
            BankCategory category = new BankCategory();
            category.LoadByPrimaryKey(CategoryID);
            category.MarkAsDeleted();
            try
            {
                category.Save();
                SetContentResult(true);
            }
            catch (Exception ex)
            {
                SetContentResult(false);
            }

        }

        #endregion

        #region Question Bank Questions

        [WebMethod]
        public void getBankQuestions(string searchQuery)
        {
            List<BankQuestionModel> questionList = new List<BankQuestionModel>();
            BankQuestion question = new BankQuestion();
            question.searchQuestions(searchQuery);

            //QuestionTypeName = survs.GetColumn("QuestionTypeName").ToString();
            //question.Query.Load();
            for (int i = 0; i < question.RowCount; i++)
            {
                questionList.Add(new BankQuestionModel
                {
                    BankQuestionID = question.BankQuestionID,
                    ArTitle = question.ArTitle,
                    EnTitle = question.EnTitle,
                    BankCategoryID = question.IsColumnNull("BankCategoryID") ? 0 : question.BankCategoryID,
                    Weight = question.IsColumnNull("Weight") ? 0 : question.Weight,
                    IsMandatory = question.IsColumnNull("IsMandatory") ? false : question.IsMandatory,
                    BankQuestionTypeID = question.BankQuestionTypeID
                });
                question.MoveNext();
            }

            SetContentResult(questionList);
        }

        [WebMethod]
        public void SaveBankQuestion(BankQuestionModel model)
        {
            BankQuestion question = new BankQuestion();
            if (model.BankQuestionID == 0)
                question.AddNew();
            else
                question.LoadByPrimaryKey(model.BankQuestionID);

            question.ArTitle = model.ArTitle == null ? "" : model.ArTitle;
            question.EnTitle = model.EnTitle == null ? "" : model.EnTitle;
            if (model.BankQuestionTypeID != 0)
                question.BankQuestionTypeID = model.BankQuestionTypeID;
            else
                question.SetColumnNull("BankQuestionTypeID");

            question.Weight = model.Weight;
            if (model.BankCategoryID != 0)
                question.BankCategoryID = model.BankCategoryID;
            else
                question.SetColumnNull("BankCategoryID");

            question.Save();
            //SetContentResult(question.DefaultView);
        }

        [WebMethod]
        public void deleteBankQuestion(int QuestionID)
        {
            BankQuestion question = new BankQuestion();
            question.LoadByPrimaryKey(QuestionID);
            question.MarkAsDeleted();
            try
            {
                question.Save();
                SetContentResult(true);
            }
            catch (Exception ex)
            {
                SetContentResult(false);
            }
        }

        #endregion

        #region Question Bank Answers

        [WebMethod]
        public void getBankAnswersByBankQuestionID(int QuestionID)
        {
            List<BankQuestionAnswerModel> Answers = new List<BankQuestionAnswerModel>();
            BankQuestionAnswer answers = new BankQuestionAnswer();
            answers.Where.BankQuestionID.Value = QuestionID;
            answers.Where.BankQuestionID.Operator = MyGeneration.dOOdads.WhereParameter.Operand.Equal;
            answers.Query.Load();
            for (int i = 0; i < answers.RowCount; i++)
            {
                Answers.Add(new BankQuestionAnswerModel { BankQuestionAnswerID = answers.BankQuestionAnswerID, EnName = answers.EnName, BankQuestionID = answers.BankQuestionID, Weight = answers.IsColumnNull("Weight") ? 0 : answers.Weight });
                answers.MoveNext();
            }

            SetContentResult(Answers);
        }

        [WebMethod]
        public void SaveBankAnswer(BankQuestionAnswerModel model)
        {
            BankQuestionAnswer survs = new BankQuestionAnswer();
            if (model.BankQuestionAnswerID == 0)
                survs.AddNew();
            else
                survs.LoadByPrimaryKey(model.BankQuestionAnswerID);

            survs.EnName = model.EnName == null ? "" : model.EnName;
            survs.ArName = model.ArName == null ? "" : model.ArName;
            survs.Weight = model.Weight;
            survs.BankQuestionID = model.BankQuestionID;
            survs.Save();
            SetContentResult(true);
        }

        [WebMethod]
        public void deleteBankAnswer(int AnswerID)
        {
            BankQuestionAnswer answer = new BankQuestionAnswer();
            answer.LoadByPrimaryKey(AnswerID);
            answer.MarkAsDeleted();
            try
            {
                answer.Save();
                SetContentResult(true);
            }
            catch (Exception ex)
            {
                SetContentResult(false);
            }
        }

        #endregion

        [WebMethod]
        public void getAllCompanies(int companyID)
        {
            List<CompanyModel> survies = new List<CompanyModel>();
            Company survs = new Company();
            if(companyID == 0)
                survs.searchCompany("");
            else
                survs.LoadByPrimaryKey(companyID);
            for (int i = 0; i < survs.RowCount; i++)
            {
                survies.Add(new CompanyModel { Email = survs.Email, LogoPath = survs.LogoPath, ArName = survs.ArName, CompanyID = survs.CompanyID, username = survs.Username, EnName = survs.EnName });
                survs.MoveNext();
            }

            SetContentResult(survies);
        }

        [WebMethod]
        public void getAllSurveyTypes()
        {
            
            SurveyType survs = new SurveyType();
            survs.LoadAll();
            
            SetContentResult(survs.DefaultView.Table);
        }

        private void SetContentResult(dynamic data)
        {
            string result = Newtonsoft.Json.JsonConvert.SerializeObject(data, Formatting.None, new IsoDateTimeConverter() { DateTimeFormat = "yyyy-MM-ddTHH:mm:ss" });
            HttpContext.Current.Response.ContentType = "application/json; charset=utf-8";
            HttpContext.Current.Response.Write(result);
            HttpContext.Current.Response.Flush(); // Sends all currently buffered output to the client.
            HttpContext.Current.Response.SuppressContent = true;  // Gets or sets a value indicating whether to send HTTP content to the client.
            HttpContext.Current.ApplicationInstance.CompleteRequest(); // Causes ASP.NET to bypass all events and filtering in the HTTP pipeline chain of execution and directly execute the EndRequest event.
        }

        private string Encrypt(string clearText)
        {
            string EncryptionKey = "MAKV2SPBNI99212";
            byte[] clearBytes = Encoding.Unicode.GetBytes(clearText);
            using (Aes encryptor = Aes.Create())
            {
                Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
                encryptor.Key = pdb.GetBytes(32);
                encryptor.IV = pdb.GetBytes(16);
                using (MemoryStream ms = new MemoryStream())
                {
                    using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateEncryptor(), CryptoStreamMode.Write))
                    {
                        cs.Write(clearBytes, 0, clearBytes.Length);
                        cs.Close();
                    }
                    clearText = Convert.ToBase64String(ms.ToArray());
                }
            }
            return clearText;
        }

        private bool IsValidEmail(string email)
        {
            try
            {
                var addr = new System.Net.Mail.MailAddress(email);
                return addr.Address == email;
            }
            catch
            {
                return false;
            }
        }

        [WebMethod]
        public void getAllDemographicWeightsBySurveyID(int surveyId, int companyID)
        {
            CountryWeight conList = new CountryWeight();
            conList.ConBySurveyID(surveyId, companyID);

            GovernrateWeight govList = new GovernrateWeight();
            govList.GovBySurveyID(surveyId, companyID);

            DivisionWeight divList = new DivisionWeight();
            divList.DivisionBySurveyID(surveyId, companyID);

            BranchWeight branchList = new BranchWeight();
            branchList.BranchBySurveyID(surveyId, companyID);

            DepartmentWeight deptList = new DepartmentWeight();
            deptList.DepartmentBySurveyID(surveyId, companyID);

            AreaWeight areaList = new AreaWeight();
            areaList.AreaBySurveyID(surveyId, companyID);

            AgeGroupWeight ageList = new AgeGroupWeight();
            ageList.AgeGroupBySurveyID(surveyId, companyID);

            LevelWeight levelList = new LevelWeight();
            levelList.LevelBySurveyID(surveyId, companyID);

            JobTitleWeight jtList = new JobTitleWeight();
            jtList.JobTitleBySurveyID(surveyId, companyID);

            GradeWeight gradeList = new GradeWeight();
            gradeList.GradeBySurveyID(surveyId, companyID);

            GenderWeight genderList = new GenderWeight();
            genderList.GenderBySurveyID(surveyId, companyID);

            dynamic result = new { ConList = conList.DefaultView.ToTable(), GovList = govList.DefaultView.ToTable(), BranchList = branchList.DefaultView.ToTable(), DeptList = deptList.DefaultView.ToTable()
                , DivList = divList.DefaultView.ToTable(), AreaList = areaList.DefaultView.ToTable(), AgeList = ageList.DefaultView.ToTable(),
                LevelList = levelList.DefaultView.ToTable(), JobTitleList = jtList.DefaultView.ToTable(), GradeList = gradeList.DefaultView.ToTable(), 
                GenderList = genderList.DefaultView.ToTable()
            };

            SetContentResult(result);
        }


        [WebMethod]
        public void saveAllDemographicWeightsBySurveyID(int surveyId, int companyID, object weights)
        {
            var AllWeights = JsonConvert.DeserializeObject<Dictionary<string, List<object>>>(JsonConvert.SerializeObject(weights));

            CountryWeight conList = new CountryWeight();
            conList.ConBySurveyID(surveyId, companyID);
            if (conList.RowCount > 0)
            {
                int rows = conList.RowCount;
                try
                {
                    for (int i = 0; i < rows; i++)
                    {
                        if (!conList.IsColumnNull("WeightID"))
                            conList.MarkAsDeleted();
                        conList.MoveNext();
                    }
                    conList.Save();
                }
                catch (Exception ex)
                {

                }
            }

            GovernrateWeight govList = new GovernrateWeight();
            govList.GovBySurveyID(surveyId, companyID);
            if (govList.RowCount > 0)
            {
                int rows = govList.RowCount;
                try
                {
                    for (int i = 0; i < rows; i++)
                    {
                        if(!govList.IsColumnNull("WeightID"))
                            govList.MarkAsDeleted();
                        govList.MoveNext();
                    }
                    govList.Save();
                }
                catch (Exception ex)
                {
                    
                }
            }

            DivisionWeight divList = new DivisionWeight();
            divList.DivisionBySurveyID(surveyId, companyID);
            if (divList.RowCount > 0)
            {
                int rows = divList.RowCount;

                try
                {
                    for (int i = 0; i < rows; i++)
                    {
                        if (!divList.IsColumnNull("WeightID"))
                            divList.MarkAsDeleted();
                        divList.MoveNext();
                    }
                    divList.Save();
                }
                catch (Exception ex)
                {
                    
                }
            }

            BranchWeight branchList = new BranchWeight();
            branchList.BranchBySurveyID(surveyId, companyID);
            if (branchList.RowCount > 0)
            {
                int rows = branchList.RowCount;

                try
                {
                    for (int i = 0; i < rows; i++)
                    {
                        if (!branchList.IsColumnNull("WeightID"))
                            branchList.MarkAsDeleted();
                        branchList.MoveNext();
                    }
                    branchList.Save();
                }
                catch (Exception ex)
                {
                    
                }
            }

            DepartmentWeight deptList = new DepartmentWeight();
            deptList.DepartmentBySurveyID(surveyId, companyID);
            if(deptList.RowCount > 0)
            {
                int rows = deptList.RowCount;

                try
                {
                    for (int i = 0; i < rows; i++)
                    {
                        if (!deptList.IsColumnNull("WeightID"))
                            deptList.MarkAsDeleted();
                        deptList.MoveNext();
                    }
                    deptList.Save();
                }
                catch (Exception ex)
                {

                }
            }

            AreaWeight areaList = new AreaWeight();
            areaList.AreaBySurveyID(surveyId, companyID);
            if(areaList.RowCount > 0)
            {
                int rows = areaList.RowCount;

                try
                {
                    for (int i = 0; i < rows; i++)
                    {
                        if (!areaList.IsColumnNull("WeightID"))
                            areaList.MarkAsDeleted();
                        areaList.MoveNext();
                    }
                    areaList.Save();
                }
                catch (Exception ex)
                {

                }
            }

            AgeGroupWeight ageList = new AgeGroupWeight();
            ageList.AgeGroupBySurveyID(surveyId, companyID);
            if(ageList.RowCount > 0)
            {
                int rows = ageList.RowCount;

                try
                {
                    for (int i = 0; i < rows; i++)
                    {
                        if (!ageList.IsColumnNull("WeightID"))
                            ageList.MarkAsDeleted();
                        ageList.MoveNext();
                    }
                    ageList.Save();
                }
                catch (Exception ex)
                {
                    
                }
            }

            LevelWeight levelList = new LevelWeight();
            levelList.LevelBySurveyID(surveyId, companyID);
            if (levelList.RowCount > 0)
            {
                int rows = levelList.RowCount;

                try
                {
                    for (int i = 0; i < rows; i++)
                    {
                        if (!levelList.IsColumnNull("WeightID"))
                            levelList.MarkAsDeleted();
                        levelList.MoveNext();
                    }
                    levelList.Save();
                }
                catch (Exception ex)
                {

                }
            }
            JobTitleWeight jtList = new JobTitleWeight();
            jtList.JobTitleBySurveyID(surveyId, companyID);
            if (jtList.RowCount > 0)
            {
                int rows = jtList.RowCount;

                try
                {
                    for (int i = 0; i < rows; i++)
                    {
                        if (!jtList.IsColumnNull("WeightID"))
                            jtList.MarkAsDeleted();
                        jtList.MoveNext();
                    }
                    jtList.Save();
                }
                catch (Exception ex)
                {

                }
            }
            GradeWeight gradeList = new GradeWeight();
            gradeList.GradeBySurveyID(surveyId, companyID);
            if (gradeList.RowCount > 0)
            {
                int rows = gradeList.RowCount;

                try
                {
                    for (int i = 0; i < rows; i++)
                    {
                        if (!gradeList.IsColumnNull("WeightID"))
                            gradeList.MarkAsDeleted();
                        gradeList.MoveNext();
                    }
                    gradeList.Save();
                }
                catch (Exception ex)
                {

                }
            }
            GenderWeight genderList = new GenderWeight();
            genderList.GenderBySurveyID(surveyId, companyID);
            if (genderList.RowCount > 0)
            {
                int rows = genderList.RowCount;

                try
                {
                    for (int i = 0; i < rows; i++)
                    {
                        if (!genderList.IsColumnNull("WeightID"))
                            genderList.MarkAsDeleted();
                        genderList.MoveNext();
                    }
                    genderList.Save();
                }
                catch (Exception ex)
                {

                }
            }

            conList = new CountryWeight();
            foreach (dynamic item in AllWeights["ConList"])
            {
                double weight = 0;
                if (double.TryParse(item.Weight.ToString(), out weight))
                {
                    conList.AddNew();
                    conList.SurveyID = surveyId;
                    conList.CountryID = int.Parse(item.CountryID.ToString());
                    conList.Weight = weight;
                }

            }
            conList.Save();

            govList = new GovernrateWeight();
            foreach (dynamic item in AllWeights["GovList"])
            {                
                double weight = 0;
                if (double.TryParse(item.Weight.ToString(), out weight))
                {
                    govList.AddNew();
                    govList.SurveyID = surveyId;
                    govList.GovernrateID = int.Parse(item.GovernrateID.ToString());
                    govList.Weight = weight;
                }
                
            }
            govList.Save();

            branchList = new BranchWeight();
            foreach (dynamic item in AllWeights["BranchList"])
            {
                double weight = 0;
                if (double.TryParse(item.Weight.ToString(), out weight))
                {
                    branchList.AddNew();
                    branchList.SurveyID = surveyId;
                    branchList.BranchID = int.Parse(item.BranchID.ToString());
                    branchList.Weight = weight;
                }

            }
            branchList.Save();

            deptList = new DepartmentWeight();
            foreach (dynamic item in AllWeights["DeptList"])
            {
                double weight = 0;
                if (double.TryParse(item.Weight.ToString(), out weight))
                {
                    deptList.AddNew();
                    deptList.SurveyID = surveyId;
                    deptList.DepartmentID = int.Parse(item.DepartmentID.ToString());
                    deptList.Weight = weight;
                }

            }
            deptList.Save();

            divList = new DivisionWeight();
            foreach (dynamic item in AllWeights["DivList"])
            {
                double weight = 0;
                if (double.TryParse(item.Weight.ToString(), out weight))
                {
                    divList.AddNew();
                    divList.SurveyID = surveyId;
                    divList.DivisionID = int.Parse(item.DivisionID.ToString());
                    divList.Weight = weight;
                }

            }
            divList.Save();

            areaList = new AreaWeight();
            foreach (dynamic item in AllWeights["AreaList"])
            {
                double weight = 0;
                if (double.TryParse(item.Weight.ToString(), out weight))
                {
                    areaList.AddNew();
                    areaList.SurveyID = surveyId;
                    areaList.AreaID = int.Parse(item.AreaID.ToString());
                    areaList.Weight = weight;
                }

            }
            areaList.Save();

            ageList = new AgeGroupWeight();
            foreach (dynamic item in AllWeights["AgeList"])
            {
                double weight = 0;
                if (double.TryParse(item.Weight.ToString(), out weight))
                {
                    ageList.AddNew();
                    ageList.SurveyID = surveyId;
                    ageList.AgeGroupID = int.Parse(item.AgeGroupID.ToString());
                    ageList.Weight = weight;
                }

            }
            ageList.Save();

            levelList = new LevelWeight();
            foreach (dynamic item in AllWeights["LevelList"])
            {
                double weight = 0;
                if (double.TryParse(item.Weight.ToString(), out weight))
                {
                    levelList.AddNew();
                    levelList.SurveyID = surveyId;
                    levelList.LevelID = int.Parse(item.LevelID.ToString());
                    levelList.Weight = weight;
                }

            }
            levelList.Save();

            jtList = new JobTitleWeight();
            foreach (dynamic item in AllWeights["JobTitleList"])
            {
                double weight = 0;
                if (double.TryParse(item.Weight.ToString(), out weight))
                {
                    jtList.AddNew();
                    jtList.SurveyID = surveyId;
                    jtList.JobTitleID = int.Parse(item.JobTitleID.ToString());
                    jtList.Weight = weight;
                }

            }
            jtList.Save();

            gradeList = new GradeWeight();
            foreach (dynamic item in AllWeights["GradeList"])
            {
                double weight = 0;
                if (double.TryParse(item.Weight.ToString(), out weight))
                {
                    gradeList.AddNew();
                    gradeList.SurveyID = surveyId;
                    gradeList.GradeID = int.Parse(item.GradeID.ToString());
                    gradeList.Weight = weight;
                }

            }
            gradeList.Save();

            genderList = new GenderWeight();
            foreach (dynamic item in AllWeights["GenderList"])
            {
                double weight = 0;
                if (double.TryParse(item.Weight.ToString(), out weight))
                {
                    genderList.AddNew();
                    genderList.SurveyID = surveyId;
                    genderList.GenderID = int.Parse(item.GenderID.ToString());
                    genderList.Weight = weight;
                }

            }
            genderList.Save();

            SetContentResult(true);
        }
    }
}
