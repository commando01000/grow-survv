using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GrowSurv.Models
{
    public class SurveyJson
    {
        public string title { get; set; }
        public string showTimerPanelMode { get; set; }
        public double maxTimeToFinish { get; set; }
        public string showTimerPanel { get; set; }
        public List<PageJson> pages { get; set; }
        public int SurveyTypeID { get; set; }
        public bool IsPublic { get; set; }

    }

    public class PageJson
    {
        public bool showQuestionNumbers { get; set; }
        public string name { get; set; }
        //public string visibleIf { get; set; }
        public string visibleIf { get; set; }
        public List<QuestionJson> questions { get; set; }
        public string navigationButtonsVisibility { get; set; }
        public string title { get; set; }
    }

    public class QuestionJson
    {
        public string type { get; set; }
        public List<item> choices { get; set; }
        public string name { get; set; }
        public bool isRequired { get; set; }
        public bool isAllRowRequired { get; set; }
        public string title { get; set; }
        //public string visibleIf { get; set; }
        public string visibleIf { get; set; }
        public List<item> rows { get; set; }
        public List<item> columns { get; set; }
    }

    public class item
    {
        public string text { get; set; }
        public string value { get; set; }
    }

    public class SurveyData
    {
        public int text { get; set; }
        public object answers { get; set; }
    }
}