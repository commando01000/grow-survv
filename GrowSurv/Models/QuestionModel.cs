using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GrowSurv.Models
{
    public class QuestionModel
    {
        public int QuestionID { get; set; }
        public string ArTitle { get; set; }
        public string EnTitle { get; set; }
        public decimal Weight { get; set; }
        public int CategoryID { get; set; }
        public int BranchID { get; set; }
        public int QuestionOrder { get; set; }
        public int SurveyID { get; set; }
        public int ParentQuestionID { get; set; }
        public int QuestionTypeID { get; set; }
        public bool IsMandatory { get; set; }
        public string QuestionTypeName { get; set; }
    }
}