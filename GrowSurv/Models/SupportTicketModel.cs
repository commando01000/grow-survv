using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GrowSurv.Models
{
    public class SupportTicketModel
    {
        public int SupportTicketID { get; set; }
        public Guid UserID { get; set; }
        public string UserName { get; set; }
        public string TicketTitle { get; set; }
        public DateTime TicketDate { get; set; }
        public bool IsClosed { get; set; }
        public int UnreadMessages { get; set; }
        public DateTime? LastMessageDate { get; set; }
    }
}