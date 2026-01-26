using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GrowSurv.Models
{
    public class BankQuestionAnswerModel
    {
        public int BankQuestionAnswerID { get; set; }
        public string ArName { get; set; }
        public string EnName { get; set; }
        public int BankQuestionID { get; set; }
        public decimal Weight { get; set; }
    }
}