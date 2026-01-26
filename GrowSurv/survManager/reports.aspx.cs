using GrowSurv.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GrowSurv.survManager
{
    public partial class reports : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (User.IsInRole("admin"))
                {
                    uiDropDownListReports.Items.Add(new ListItem("Survey Detailed Answers", "6"));
                }

                int sid = 0;
                if (Request.QueryString["sid"] != null)
                {
                    if (int.TryParse(Request.QueryString["sid"].ToString(), out sid))
                    {
                        Survey survey = new Survey();
                        survey.LoadByPrimaryKey(sid);
                        Company company = new Company();
                        company.LoadByPrimaryKey(survey.CompanyID);
                        uiLabelSurveyTitle.Text = survey.EnName;
                        uiLabelCompany.Text = company.EnName;
                        if(!survey.IsColumnNull("ExpiryDate"))
                            uiLabelExpDate.Text = survey.ExpiryDate.ToString("dd/MM/yyyy");
                        
                    }
                    else
                    {
                        Response.Redirect("~/survManager/ListSurveys.aspx");
                    }
                }
                else
                {
                    Response.Redirect("~/survManager/ListSurveys.aspx");
                }

            }
        }

        protected void uiLinkButtonViewReport_Click(object sender, EventArgs e)
        {
            string displayname = "";
            if (uiDropDownListReports.SelectedValue == "3" || uiDropDownListReports.SelectedValue == "4")
            {
                switch (uiDropDownListDemographics.SelectedValue)
                {
                    case "CountryEnName":
                        displayname = "Country";
                        break;
                    case "GovEnName":
                        displayname = "State";
                        break;
                    case "AreaEnName":
                        displayname = "Area";
                        break;
                    case "BranchEnName":
                        displayname = "Branch";
                        break;
                    case "DepEnName":
                        displayname = "Department";
                        break;
                    case "DivEnName":
                        displayname = "Division";
                        break;
                    case "LevelEnName":
                        displayname = "Level";
                        break;
                    case "GradeEnName":
                        displayname = "Grade";
                        break;
                    case "jobEnName":
                        displayname = "Job Title";
                        break;
                    case "AgeEnName":
                        displayname = "Age Group";
                        break;
                    case "GenderEnName":
                        displayname = "Gender";
                        break;
                    default:
                        displayname = "General";
                        break;
                }
            }
            Response.Redirect("~/survManager/doreport.aspx?r=" + uiDropDownListReports.SelectedValue + "&sid=" + Request.QueryString["sid"].ToString() + "&g=" + uiDropDownListDemographics.SelectedValue + "&gd=" + displayname + "&mid=0&lang=" + uiDropDownListLang.SelectedValue);

        }
    }
}