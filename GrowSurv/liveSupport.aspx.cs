using GrowSurv.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GrowSurv
{
    public partial class liveSupport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            hdCurrentUserRole.Value = Roles.GetRolesForUser(User.Identity.Name).Contains("admin") ? "admin" : "client";
            //SupportMessage obj = new SupportMessage();
        }
    }
}