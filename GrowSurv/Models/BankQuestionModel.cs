using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GrowSurv.Models
{
    public class BankQuestionModel
    {
        public int BankQuestionID { get; set; }
        public int BankQuestionTypeID { get; set; }
        public string ArTitle { get; set; }
        public string EnTitle { get; set; }
        public decimal Weight { get; set; }
        public int BankCategoryID { get; set; }
        public bool IsMandatory { get; set; }
        public string QuestionTypeName { get; set; }
    }
}