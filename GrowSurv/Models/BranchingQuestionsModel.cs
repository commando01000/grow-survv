using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GrowSurv.Models
{
    public class BranchingQuestionsModel
    {
        public int QuestionID { get; set; }
        public string QuestionText { get; set; }
        public int AnswerID { get; set; }
        public string AnswerText { get; set; }
        public int QuestionTypeID { get; set; }
        public int SkipToQuestionID { get; set; }
        public string SkipToQuestionText { get; set; }
        public int SkipToBranchID { get; set; }
        public string SkipToBranchText { get; set; }
    }
}