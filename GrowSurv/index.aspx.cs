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
    public partial class index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void uiButtonRegister_Click(object sender, EventArgs e)
        {
            List<string> stringListToAdd = new List<string>();
            MembershipCreateStatus obj;
            string password = uiTextBoxPassword.Text;
            MembershipUser objUser = Membership.CreateUser(uiTextBoxUsername.Text, password, uiTextBoxemail.Text, null, null, true, out obj);
            bool success = true;
            switch (obj)
            {
                case MembershipCreateStatus.DuplicateUserName:
                    uiLabelError.Text = "duplicate username";
                    uiLabelError.Visible = true;
                    success = false;
                    break;
                case MembershipCreateStatus.InvalidPassword:
                    uiLabelError.Text = "invalid password. password must be (6) characters or more.";
                    uiLabelError.Visible = true;
                    success = false;
                    break;
                case MembershipCreateStatus.ProviderError:
                case MembershipCreateStatus.UserRejected:
                    uiLabelError.Text = "an error occurred. please try again.";
                    uiLabelError.Visible = true;
                    success = false;
                    break;
                default:
                    break;
            }
            if (success)
            {                               
                Roles.AddUserToRole(objUser.UserName, "client");
                
                Company usPr = new Company();
                usPr.AddNew();
                usPr.Username = objUser.UserName;
                usPr.EnName = uiTextBoxtname.Text;
                usPr.Email = uiTextBoxemail.Text;
                usPr.AccountDueDate = DateTime.Now.AddDays(7);
                //usPr.GroupID = int.Parse(DropDownListGroups.SelectedValue);

                usPr.Save();
                FormsAuthentication.SetAuthCookie(objUser.UserName, true);
                Response.Redirect("~/default.aspx");
            }
        }
    }
}