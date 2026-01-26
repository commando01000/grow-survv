using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GrowSurv.Models
{
    public class TicketMessageModel
    {
        public int TicketMessageID { get; set; }
        public int SupportTicketID { get; set; }
        public bool FromAdmin { get; set; }
        public string MessageContent { get; set; }
        public DateTime MessageDate { get; set; }
    }
}