using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GrowSurv.Models
{
    public class SurveyModel
    {
        public int SurveyID { get; set; }
        public string ArName { get; set; }
        public string EnName { get; set; }
        public string EnDesc { get; set; }
        public string ArDesc { get; set; }
        public int CompanyID { get; set; }
        public DateTime ExpiryDate{ get; set; }
        public string CompanyEnName { get; set; }
        public bool IsDivisionMandatory { get; set; }
        public bool IsDepartmentMandatory { get; set; }
        public bool IsAreaMandatory { get; set; }
        public bool IsBranchMandatory { get; set; }
        public bool IsGradeMandatory { get; set; }
        public bool IsLevelMandatory { get; set; }
        public bool IsJobTitleMandatory { get; set; }
        public bool IsGenderMandatory { get; set; }
        public bool IsAgeMandatory { get; set; }
        public bool IsDurationMandatory { get; set; }
        public bool IsRecentPromotionDateMandatory { get; set; }
        public int SurveyTypeID { get; set; }
        public DateTime Duration { get; set; }
        public string EnHeader { get; set; }
        public string ArHeader { get; set; }
        public string EnFooter { get; set; }
        public string ArFooter { get; set; }
        public bool IsGovernrateMandatory { get; set; }
        public string EmailSubject { get; set; }
        public string EmailBody { get; set; }
        public bool SkipDemographicPage { get; set; }
        public string ArEmailBody { get; set; }
        public bool IsPublic { get; set; }

        public bool IsCountryMandatory { get; set; }
        public string PublicURL { get; set; }


    }
}