using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GrowSurv.Models
{
    public class AnswerModel
    {
        public int AnswerID { get; set; }
        public string ArName { get; set; }
        public string EnName { get; set; }
        public int QuestionID { get; set; }
        public decimal Weight { get; set; }
        public int NextQuestionID { get; set; }
        public int NextBranchID { get; set; }

    }
}