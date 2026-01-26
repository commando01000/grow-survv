using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GrowSurv.Models
{
    public class QuestionBranchModel
    {
        public int QuestionBranchID { get; set; }
        public string ArName { get; set; }
        public string EnName { get; set; }
        public int SureveyID { get; set; }
    }
}