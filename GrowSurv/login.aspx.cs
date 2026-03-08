using System;
using System.Configuration;
using System.Web.Security;

namespace GrowSurv
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 1) Seed admin ONLY when flag is enabled (dev only)
            SeedAdminIfEnabled();

            // 2) Normal behavior
            if (Request.IsAuthenticated)
            {
                Response.Redirect("~/default.aspx");
            }
        }

        private void SeedAdminIfEnabled()
        {
            bool seedEnabled =
                (ConfigurationManager.AppSettings["SeedAdminOnStartup"] ?? "")
                .Equals("true", StringComparison.OrdinalIgnoreCase);

            if (!seedEnabled) return;

            string username = ConfigurationManager.AppSettings["SeedAdminUsername"] ?? "admin12";
            string password = ConfigurationManager.AppSettings["SeedAdminPassword"] ?? "Admin@12345";
            string email = ConfigurationManager.AppSettings["SeedAdminEmail"] ?? "admin@growsurv.local";

            // If user already exists, make sure it's usable and in the admin role.
            var existingUser = Membership.GetUser(username);
            if (existingUser != null)
            {
                if (!existingUser.IsApproved)
                {
                    existingUser.IsApproved = true;
                    Membership.UpdateUser(existingUser);
                }

                if (existingUser.IsLockedOut && !existingUser.UnlockUser())
                    throw new ApplicationException("Admin seed failed: unable to unlock existing admin user.");

                // Keep configured seed password as source of truth when seeding is enabled.
                if (!Membership.ValidateUser(username, password))
                {
                    try
                    {
                        string tempPassword = existingUser.ResetPassword();
                        bool changed = existingUser.ChangePassword(tempPassword, password);
                        if (!changed)
                            throw new ApplicationException("Admin seed failed: unable to reset existing admin password.");
                    }
                    catch (Exception ex)
                    {
                        throw new ApplicationException("Admin seed failed while resetting existing admin password.", ex);
                    }
                }

                EnsureRoleAndMembership(username, "admin");
                return;
            }

            // Create user
            MembershipCreateStatus status;
            var user = Membership.CreateUser(username, password, email, null, null, true, out status);

            if (status != MembershipCreateStatus.Success)
            {
                // Fail fast so you know what's wrong (invalid password policy, provider errors, etc.)
                throw new ApplicationException("Admin seed failed: " + status);
            }

            EnsureRoleAndMembership(user.UserName, "admin");
        }

        private void EnsureRoleAndMembership(string username, string roleName)
        {
            // Create role if missing
            if (!Roles.RoleExists(roleName))
                Roles.CreateRole(roleName);

            // Add user to role if not already
            if (!Roles.IsUserInRole(username, roleName))
                Roles.AddUserToRole(username, roleName);
        }
    }
}
