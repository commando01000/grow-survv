using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GrowSurv.Models
{
    public class SurveyMemberModel
    {
        public  int MemberID { get; set; }
        public  string MemberEmail { get; set; }
        public  int SurveyID { get; set; }
        public int DivionID { get; set; }
        public int DepartmentID { get; set; }
        public int AreaID { get; set; }
        public int BranchID { get; set; }
        public  string Grade { get; set; }
        public  string Level { get; set; }
        public  string JobTitle { get; set; }
        public int GenderID { get; set; }
        public decimal Age { get; set; }
        public DateTime Duration { get; set; }
        public  DateTime RecentPromotionDate { get; set; }
        public bool IsSurveySubmited { get; set; }

    }
}