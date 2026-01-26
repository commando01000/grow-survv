using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GrowSurv.Models
{
    public class QuestionTypeModel
    {
        public int QuestionTypeID { get; set; }
        public string ArName { get; set; }
        public string EnName { get; set; }
        public bool IsGrid { get; set; }
    }
}