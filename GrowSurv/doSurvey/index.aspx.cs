using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GrowSurv.BLL;
namespace GrowSurv.doSurvey
{
    public partial class index : System.Web.UI.Page
    {
        public string Lang {
            get
            {
                if (Session["_CurrentLang"] != null)
                    return Session["_CurrentLang"].ToString();
                else
                    return "en";
            }
            set
            {
                Session["_CurrentLang"] = value;
            }
        }

        public int SurveyID
        {
            get
            {
                if (Session["_SurveyID"] != null)
                    return int.Parse(Session["_SurveyID"].ToString());
                else
                    return 0;
            }
            set
            {
                Session["_SurveyID"] = value;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            string surveyID = "";
            string member = "";

            //uiHiddenFieldsurveyID.Value = surveyID;

            if (!IsPostBack)
            {
                try
                {
                    surveyID = Decrypt(HttpUtility.UrlDecode(Request.QueryString["sid"]));
                    int sid = 0;
                    if (int.TryParse(surveyID, out sid))
                        SurveyID = sid;
                    member = Decrypt(HttpUtility.UrlDecode(Request.QueryString["mail"]));
                    Survey currentSurvey = new Survey();

                    if (SurveyID != 0)
                    {
                        if (currentSurvey.LoadByPrimaryKey(SurveyID))
                        {
                            uiLiteralEnInvitation.Text = currentSurvey.EnDesc;
                            uiLiteralArInvitation.Text = currentSurvey.ArDesc;
                        }
                    }
                    bool isPublicSurvey = false;
                    if (currentSurvey != null)
                        if (!currentSurvey.IsColumnNull("IsPublic"))
                            isPublicSurvey = currentSurvey.IsPublic;

                    if (!isPublicSurvey)
                    {

                        SurveyMember mem = new SurveyMember();
                        if (mem.GetMemberBySurveyIDAndMemberEmail(SurveyID, member))
                        {
                            if (!mem.IsColumnNull(SurveyMember.ColumnNames.IsSurveySubmited))
                            {
                                if (mem.IsSurveySubmited)
                                {
                                    // html error
                                    Response.Redirect("unauthorized.aspx", false);
                                }
                            }
                        }
                        else
                        {
                            // html error
                            Response.Redirect("unauthorized.aspx", false);
                        }
                    }
                    else // public survey
                    {
                        SurveyMember mem = new SurveyMember();
                        mem.AddNew();
                        mem.MemberEmail = "p_" + Guid.NewGuid() + "_" + surveyID + "@growsurv.com";
                        mem.SurveyID = SurveyID;
                        mem.Save();
                        member = mem.MemberEmail;
                    }
                    //BindSurveyInfo(surveyID);

                }
                catch (Exception x)
                {
                    Response.Redirect("~/index.html");
                }
                uiHiddenFieldsurveyID.Value = surveyID;
                uiHiddenFieldMemberID.Value = member;

            }
        }

        private void BindSurveyInfo(int surveyID)
        {
            string member = "";
            member = Decrypt(HttpUtility.UrlDecode(Request.QueryString["mail"]));
            SurveyMember mem = new SurveyMember();
            mem.GetMemberBySurveyIDAndMemberEmail(SurveyID, member);
            
            Survey survey = new Survey();
            survey.LoadByPrimaryKey(surveyID);
            uiLabelCon.Text = (Lang == "en" ? "Country" : "البلد") + (survey.IsCountryMandatory ? "*" : "");
            uiHiddenFieldCon.Value = survey.IsCountryMandatory ? "1" : "0";
            conDiv.Attributes.CssStyle.Add("display", survey.IsCountryMandatory ? "block" : "none");
            

            uiLabelGov.Text = (Lang == "en" ?  "State" : "المحافظة") + (survey.IsGovernrateMandatory ? "*" : "");
            uiHiddenFieldGov.Value = survey.IsGovernrateMandatory ? "1" : "0";
            govLabelDiv.Attributes.CssStyle.Add("display", survey.IsGovernrateMandatory ? "block" : "none");
            govDDLDiv.Attributes.CssStyle.Add("display", survey.IsGovernrateMandatory ? "block" : "none");

            uiLabelArea.Text = (Lang == "en" ? "Area" : "المنطقة") + (survey.IsAreaMandatory ? "*" : "");
            uiHiddenFieldArea.Value = survey.IsAreaMandatory ? "1" : "0";
            areaLabelDiv.Attributes.CssStyle.Add("display", survey.IsAreaMandatory ? "block" : "none");
            areaDDLDiv.Attributes.CssStyle.Add("display", survey.IsAreaMandatory ? "block" : "none");

            uiLabelBranch.Text = (Lang == "en" ? "Branch" : "الفرع") + (survey.IsBranchMandatory ? "*" : "");
            uiHiddenFieldBranch.Value = survey.IsBranchMandatory ? "1" : "0";
            branchLabelDiv.Attributes.CssStyle.Add("display", survey.IsBranchMandatory ? "block" : "none");
            branchDDLDiv.Attributes.CssStyle.Add("display", survey.IsBranchMandatory ? "block" : "none");

            uiLabelDepartment.Text = (Lang == "en" ? "Department" : "القسم") + (survey.IsDepartmentMandatory ? "*" : "");
            uiHiddenFieldDepartment.Value = survey.IsDepartmentMandatory ? "1" : "0";
            deptLabelDiv.Attributes.CssStyle.Add("display", survey.IsDepartmentMandatory ? "block" : "none");
            deptDDLDiv.Attributes.CssStyle.Add("display", survey.IsDepartmentMandatory ? "block" : "none");

            uiLabelDivision.Text = (Lang == "en" ? "Division" : "القطاع") + (survey.IsDivisionMandatory ? "*" : "");
            uiHiddenFieldDivision.Value = survey.IsDivisionMandatory ? "1" : "0";
            divLabelDiv.Attributes.CssStyle.Add("display", survey.IsDivisionMandatory ? "block" : "none");
            divDDLDiv.Attributes.CssStyle.Add("display", survey.IsDivisionMandatory ? "block" : "none");

            uiLabellevel.Text = (Lang == "en" ? "Level" : "المستوى") + (survey.IsLevelMandatory ? "*" : "");
            uiHiddenFieldLevel.Value = survey.IsLevelMandatory ? "1" : "0";
            lvlLabelDiv.Attributes.CssStyle.Add("display", survey.IsLevelMandatory ? "block" : "none");
            lvlDDLDiv.Attributes.CssStyle.Add("display", survey.IsLevelMandatory ? "block" : "none");

            uiLabelGrade.Text = (Lang == "en" ? "Grade" : "الدرجة") + (survey.IsGradeMandatory ? "*" : "");
            uiHiddenFieldGrade.Value = survey.IsGradeMandatory ? "1" : "0";
            gradeLabelDiv.Attributes.CssStyle.Add("display", survey.IsGradeMandatory ? "block" : "none");
            gradeDDLDiv.Attributes.CssStyle.Add("display", survey.IsGradeMandatory ? "block" : "none");

            uiLabelJobTitle.Text = (Lang == "en" ? "Job Title" : "الوظيفة") + (survey.IsJobTitleMandatory ? "*" : "");
            uiHiddenFieldJobTitle.Value = survey.IsJobTitleMandatory ? "1" : "0";
            jtLabelDiv.Attributes.CssStyle.Add("display", survey.IsJobTitleMandatory ? "block" : "none");
            jtDDLDiv.Attributes.CssStyle.Add("display", survey.IsJobTitleMandatory ? "block" : "none");

            uiLabelAgeGroup.Text = (Lang == "en" ? "Age Group" : "الفئة العمرية") + (survey.IsAgeMandatory ? "*" : "");
            uiHiddenFieldAgeGroup.Value = survey.IsAgeMandatory ? "1" : "0";
            agLabelDiv.Attributes.CssStyle.Add("display", survey.IsAgeMandatory ? "block" : "none");
            agDDLDiv.Attributes.CssStyle.Add("display", survey.IsAgeMandatory ? "block" : "none");

            uiLabelGender.Text = (Lang == "en" ? "Gender" : "النوع") + (survey.IsGenderMandatory ? "*" : "");
            uiHiddenFieldGender.Value = survey.IsGenderMandatory ? "1" : "0";
            genLabelDiv.Attributes.CssStyle.Add("display", survey.IsGenderMandatory ? "block" : "none");
            genDDLDiv.Attributes.CssStyle.Add("display", survey.IsGenderMandatory ? "block" : "none");

            uiLiteralDemographicHeader.Text = Lang == "en" ?  survey.EnHeader : survey.ArHeader;
            uiLiteralHeader.Text = Lang == "en" ? survey.EnHeader : survey.ArHeader;
            uiLiteralFooter.Text = Lang == "en" ? survey.EnFooter : survey.ArFooter;


            Country cons = new Country();
            cons.GetActiveListByCompanyID(survey.CompanyID);
            uiDropDownListCon.DataSource = cons.DefaultView;

            uiDropDownListCon.DataTextField = (Lang == "en" ? Country.ColumnNames.EnName : Country.ColumnNames.ArName);
            uiDropDownListCon.DataValueField = Country.ColumnNames.CountryID;
            uiDropDownListCon.DataBind();
            if (Lang == "en")
                uiDropDownListCon.Items.Insert(0, new ListItem("Select Country", ""));
            else
                uiDropDownListCon.Items.Insert(0, new ListItem("إختر البلد", ""));


            Governrate govs = new Governrate();
            govs.GetActiveListByCompanyID(survey.CompanyID);
            uiDropDownListGov.DataSource = govs.DefaultView;

            uiDropDownListGov.DataTextField = (Lang == "en" ? Governrate.ColumnNames.EnName : Governrate.ColumnNames.ArName);
            uiDropDownListGov.DataValueField = Governrate.ColumnNames.GovernrateID;
            uiDropDownListGov.DataBind();
            if(Lang == "en")
                uiDropDownListGov.Items.Insert(0, new ListItem("Select State", ""));
            else
                uiDropDownListGov.Items.Insert(0, new ListItem("إختر المحافظة", ""));


            Area areas = new Area();
            areas.GetActiveListByCompanyID(survey.CompanyID);
            uiDropDownListArea.DataSource = areas.DefaultView;
            uiDropDownListArea.DataTextField = (Lang == "en" ? Area.ColumnNames.NameEn : Area.ColumnNames.NameAr);
            uiDropDownListArea.DataValueField = Area.ColumnNames.AreaID;
            uiDropDownListArea.DataBind();
            if (Lang == "en")
                uiDropDownListArea.Items.Insert(0, new ListItem("Select Area", ""));
            else
                uiDropDownListArea.Items.Insert(0, new ListItem("إختر المنطقة", ""));

            Branch branches = new Branch();
            branches.GetActiveListByCompanyID(survey.CompanyID);
            uiDropDownListBranch.DataSource = branches.DefaultView;
            uiDropDownListBranch.DataTextField = (Lang == "en" ? Branch.ColumnNames.NameEn  : Branch.ColumnNames.NameAr);
            uiDropDownListBranch.DataValueField = Branch.ColumnNames.BranchID;
            uiDropDownListBranch.DataBind();
            if (Lang == "en")
                uiDropDownListBranch.Items.Insert(0, new ListItem("Select Branch", ""));
            else
                uiDropDownListBranch.Items.Insert(0, new ListItem("إختر الفرع", ""));

            Department depts = new Department();
            depts.GetActiveListByCompanyID(survey.CompanyID);
            uiDropDownListDeparment.DataSource = depts.DefaultView;
            uiDropDownListDeparment.DataTextField = (Lang == "en" ? Department.ColumnNames.EnName : Department.ColumnNames.ArName);
            uiDropDownListDeparment.DataValueField = Department.ColumnNames.DepartmentID;
            uiDropDownListDeparment.DataBind();
            if (Lang == "en")
                uiDropDownListDeparment.Items.Insert(0, new ListItem("Select Department", ""));
            else
                uiDropDownListDeparment.Items.Insert(0, new ListItem("إختر القسم", ""));

            Division divs = new Division();
            divs.GetActiveListByCompanyID(survey.CompanyID);
            uiDropDownListDivision.DataSource = divs.DefaultView;
            uiDropDownListDivision.DataTextField = (Lang == "en" ? Division.ColumnNames.NameEn : Division.ColumnNames.NameAr);
            uiDropDownListDivision.DataValueField = Division.ColumnNames.DivisionID;
            uiDropDownListDivision.DataBind();
            if (Lang == "en")
                uiDropDownListDivision.Items.Insert(0, new ListItem("Select Division", ""));
            else
                uiDropDownListDivision.Items.Insert(0, new ListItem("إختر القطاع", ""));

            Level lvl = new Level();
            lvl.GetActiveListByCompanyID(survey.CompanyID);
            uiDropDownListlevel.DataSource = lvl.DefaultView;
            uiDropDownListlevel.DataTextField = (Lang == "en" ? Level.ColumnNames.EnName : Level.ColumnNames.ArName);
            uiDropDownListlevel.DataValueField = Level.ColumnNames.LevelID;
            uiDropDownListlevel.DataBind();
            if (Lang == "en")
                uiDropDownListlevel.Items.Insert(0, new ListItem("Level Level", ""));
            else
                uiDropDownListlevel.Items.Insert(0, new ListItem("إختر المستوى", ""));

            Grade grads = new Grade();
            grads.GetActiveListByCompanyID(survey.CompanyID);
            uiDropDownListGrade.DataSource = grads.DefaultView;
            uiDropDownListGrade.DataTextField = (Lang == "en" ? Grade.ColumnNames.EnName : Grade.ColumnNames.ArName);
            uiDropDownListGrade.DataValueField = Grade.ColumnNames.GradeID;
            uiDropDownListGrade.DataBind();
            if (Lang == "en")
                uiDropDownListGrade.Items.Insert(0, new ListItem("Select Grade", ""));
            else
                uiDropDownListGrade.Items.Insert(0, new ListItem("إختر الدرجة", ""));

            JobTitle jobtitle = new JobTitle();
            jobtitle.GetActiveListByCompanyID(survey.CompanyID);
            uiDropDownListJobTitle.DataSource = jobtitle.DefaultView;
            uiDropDownListJobTitle.DataTextField = (Lang == "en" ? JobTitle.ColumnNames.EnName : JobTitle.ColumnNames.ArName);
            uiDropDownListJobTitle.DataValueField = JobTitle.ColumnNames.JobTitleID;
            uiDropDownListJobTitle.DataBind();
            if (Lang == "en")
                uiDropDownListJobTitle.Items.Insert(0, new ListItem("Select JobTitle", ""));
            else
                uiDropDownListJobTitle.Items.Insert(0, new ListItem("إختر الوظيفة", ""));

            AgeGroup ags = new AgeGroup();
            ags.GetActiveListByCompanyID(survey.CompanyID);
            uiDropDownListAgeGroup.DataSource = ags.DefaultView;
            uiDropDownListAgeGroup.DataTextField = (Lang == "en" ? AgeGroup.ColumnNames.EnDisplayName : AgeGroup.ColumnNames.ArDisplayName);
            uiDropDownListAgeGroup.DataValueField = AgeGroup.ColumnNames.AgeGroupID;
            uiDropDownListAgeGroup.DataBind();
            if (Lang == "en")
                uiDropDownListAgeGroup.Items.Insert(0, new ListItem("Select Age Group", ""));
            else
                uiDropDownListAgeGroup.Items.Insert(0, new ListItem("إختر الفئة العمرية", ""));

            Gender genders = new Gender();
            genders.LoadAll();
            uiDropDownListGender.DataSource = genders.DefaultView;
            uiDropDownListGender.DataTextField = (Lang == "en" ? Gender.ColumnNames.NameEn : Gender.ColumnNames.NameAr);
            uiDropDownListGender.DataValueField = Gender.ColumnNames.GenderID;
            uiDropDownListGender.DataBind();
            if (Lang == "en")
                uiDropDownListGender.Items.Insert(0, new ListItem("Select Gender", ""));
            else
                uiDropDownListGender.Items.Insert(0, new ListItem("إختر النوع", ""));

            if (mem.RowCount > 0)
            {
                if (!mem.IsColumnNull(SurveyMember.ColumnNames.CountryID))
                    uiDropDownListCon.SelectedValue = mem.CountryID.ToString();
                if (!mem.IsColumnNull(SurveyMember.ColumnNames.GovernrateID))
                    uiDropDownListGov.SelectedValue = mem.GovernrateID.ToString();
                if (!mem.IsColumnNull(SurveyMember.ColumnNames.BranchID))
                    uiDropDownListBranch.SelectedValue = mem.BranchID.ToString();
                if (!mem.IsColumnNull(SurveyMember.ColumnNames.DepartmentID))
                    uiDropDownListDeparment.SelectedValue = mem.DepartmentID.ToString();
                if (!mem.IsColumnNull(SurveyMember.ColumnNames.DivionID))
                    uiDropDownListDivision.SelectedValue = mem.DivionID.ToString();
                if (!mem.IsColumnNull(SurveyMember.ColumnNames.AreaID))
                    uiDropDownListArea.SelectedValue = mem.AreaID.ToString();
                if (!mem.IsColumnNull(SurveyMember.ColumnNames.GradeID))
                    uiDropDownListGrade.SelectedValue = mem.GradeID.ToString();
                if (!mem.IsColumnNull(SurveyMember.ColumnNames.GenderID))
                    uiDropDownListGender.SelectedValue = mem.GenderID.ToString();
                if (!mem.IsColumnNull(SurveyMember.ColumnNames.LevelID))
                    uiDropDownListlevel.SelectedValue = mem.LevelID.ToString();
                if (!mem.IsColumnNull(SurveyMember.ColumnNames.JobTitleID))
                    uiDropDownListJobTitle.SelectedValue = mem.JobTitleID.ToString();
                if (!mem.IsColumnNull(SurveyMember.ColumnNames.AgeGroupID))
                    uiDropDownListAgeGroup.SelectedValue = mem.AgeGroupID.ToString();
            }
        }

        private string Decrypt(string cipherText)
        {
            string EncryptionKey = "MAKV2SPBNI99212";
            cipherText = cipherText.Replace(" ", "+");
            byte[] cipherBytes = Convert.FromBase64String(cipherText);
            using (Aes encryptor = Aes.Create())
            {
                Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
                encryptor.Key = pdb.GetBytes(32);
                encryptor.IV = pdb.GetBytes(16);
                using (MemoryStream ms = new MemoryStream())
                {
                    using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateDecryptor(), CryptoStreamMode.Write))
                    {
                        cs.Write(cipherBytes, 0, cipherBytes.Length);
                        cs.Close();
                    }
                    cipherText = Encoding.Unicode.GetString(ms.ToArray());
                }
            }
            return cipherText;
        }

        protected void ArabicLink_Click(object sender, EventArgs e)
        {
            Lang = "ar";
            uiHiddenFieldCurrentLang.Value = Lang;
            Survey surv = new Survey();
            surv.LoadByPrimaryKey(SurveyID);
            if (!surv.IsColumnNull("SkipDemographicPage"))
            {
                PreSurvey.Visible = !surv.SkipDemographicPage;
                MainSurvey.Visible = surv.SkipDemographicPage;
            }
            else
            {
                PreSurvey.Visible = true;
                MainSurvey.Visible = false;
            }
            langSelector.Visible = false;
            
            uiLinkButtonMoveNextServer.Text = "إستمرار";
            //uiLinkButtonMoveNext.InnerText = "إستمرار";
            lnkCSS.Href = "../assets/global/plugins/bootstrap/css/bootstrap-rtl.min.css";
            PreSurvey.Attributes["class"]= "rtl font-JF clearfix";
            MainSurvey.Attributes["class"] = "rtl font-JF clearfix";
            BindSurveyInfo(SurveyID);
        }

        protected void EnglishLink_Click(object sender, EventArgs e)
        {
            Lang = "en";
            uiHiddenFieldCurrentLang.Value = Lang;
            Survey surv = new Survey();
            surv.LoadByPrimaryKey(SurveyID);
            if (!surv.IsColumnNull("SkipDemographicPage"))
            {
                PreSurvey.Visible = !surv.SkipDemographicPage;
                MainSurvey.Visible = surv.SkipDemographicPage;
            }
            else
            {
                PreSurvey.Visible = true;
                MainSurvey.Visible = false;
            }
            
            langSelector.Visible = false;
            
            //uiLinkButtonMoveNext.InnerText = "Continue";
            uiLinkButtonMoveNextServer.Text = "Continue";

            lnkCSS.Href = "../assets/global/plugins/bootstrap/css/bootstrap.min.css";
            PreSurvey.Attributes["class"] = "clearfix";
            MainSurvey.Attributes["class"] = "clearfix";
            BindSurveyInfo(SurveyID);
        }

        protected void uiLinkButtonMoveNextServer_Click(object sender, EventArgs e)
        {
            PreSurvey.Visible = true;
            PreSurvey.Attributes.Add("style", "display:none");
            langSelector.Visible = false;
            MainSurvey.Visible = true;
        }
    }

}