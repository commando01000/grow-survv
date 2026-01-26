using GrowSurv.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GrowSurv.administration
{
    public partial class UserManagement : System.Web.UI.Page
    {
        #region Properties       

        public MembershipUser CurrentUser
        {
            get
            {
                if (Session["_CurrentUser"] != null)
                    return (MembershipUser)Session["_CurrentUser"];
                else
                    return null;
            }
            set
            {
                Session["_CurrentUser"] = value;
            }

        }
        public Company CurrentCompany
        {
            get
            {
                if (Session["_CurrentCompany"] != null)
                    return (Company)Session["_CurrentCompany"];
                else
                    return null;
            }
            set
            {
                Session["_CurrentCompany"] = value;
            }

        }
        public Department CurrentDepartment
        {
            get
            {
                if (Session["_CurrentDepartment"] != null)
                    return (Department)Session["_CurrentDepartment"];
                else
                    return null;
            }
            set
            {
                Session["_CurrentDepartment"] = value;
            }

        }
        public Governrate CurrentGov
        {
            get
            {
                if (Session["_CurrentGov"] != null)
                    return (Governrate)Session["_CurrentGov"];
                else
                    return null;
            }
            set
            {
                Session["_CurrentGov"] = value;
            }

        }

        public Country CurrentCountry
        {
            get
            {
                if (Session["_CurrentCountry"] != null)
                    return (Country)Session["_CurrentCountry"];
                else
                    return null;
            }
            set
            {
                Session["_CurrentCountry"] = value;
            }

        }

        public Area CurrentArea
        {
            get
            {
                if (Session["_CurrentArea"] != null)
                    return (Area)Session["_CurrentArea"];
                else
                    return null;
            }
            set
            {
                Session["_CurrentArea"] = value;
            }

        }
        public Branch CurrentBranch
        {
            get
            {
                if (Session["_CurrentBranch"] != null)
                    return (Branch)Session["_CurrentBranch"];
                else
                    return null;
            }
            set
            {
                Session["_CurrentBranch"] = value;
            }

        }
        public Division CurrentDivision
        {
            get
            {
                if (Session["_CurrentDivision"] != null)
                    return (Division)Session["_CurrentDivision"];
                else
                    return null;
            }
            set
            {
                Session["_CurrentDivision"] = value;
            }

        }
        public Level CurrentLevel
        {
            get
            {
                if (Session["_CurrentLevel"] != null)
                    return (Level)Session["_CurrentLevel"];
                else
                    return null;
            }
            set
            {
                Session["_CurrentLevel"] = value;
            }

        }
        public Grade CurrentGrade
        {
            get
            {
                if (Session["_CurrentGrade"] != null)
                    return (Grade)Session["_CurrentGrade"];
                else
                    return null;
            }
            set
            {
                Session["_CurrentGrade"] = value;
            }

        }
        public JobTitle CurrentJobTitle
        {
            get
            {
                if (Session["_CurrentJobTitle"] != null)
                    return (JobTitle)Session["_CurrentJobTitle"];
                else
                    return null;
            }
            set
            {
                Session["_CurrentJobTitle"] = value;
            }

        }
        public AgeGroup CurrentAgegroup
        {
            get
            {
                if (Session["_CurrentAgegroup"] != null)
                    return (AgeGroup)Session["_CurrentAgegroup"];
                else
                    return null;
            }
            set
            {
                Session["_CurrentAgegroup"] = value;
            }

        }
        #endregion

        #region Events

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadRoles();
                BindData();
                uiPanelAll.Visible = true;
                uiPanelEdit.Visible = false;
                Master.PageTitle = "User Management";
            }
        }


        protected void uiButtonSearch_Click(object sender, EventArgs e)
        {
            SearchByText();
        }

        
        protected void uiButtonUpdate_Click(object sender, EventArgs e)
        {
            if (CurrentUser != null)
            {
                //CurrentUser.Email = uiTextBoxMail.Text;
                List<string> stringListToAdd = new List<string>();
                List<string> stringListToRemove = new List<string>();

                if (!CurrentUser.IsLockedOut)
                {
                    if (CurrentUser.GetPassword() != uiTextBoxPass.Text && !string.IsNullOrEmpty(uiTextBoxPass.Text))
                    {
                        CurrentUser.ChangePassword(CurrentUser.GetPassword(), uiTextBoxPass.Text);
                    }
                }

                foreach (ListItem item in uiCheckBoxListRoles.Items)
                {
                    if (item.Selected)
                    {
                        if (!Roles.IsUserInRole(CurrentUser.UserName, item.Text))
                        {
                            stringListToAdd.Add(item.Text);
                        }
                    }
                    else
                    {
                        if (Roles.IsUserInRole(CurrentUser.UserName, item.Text))
                        {
                            stringListToRemove.Add(item.Text);
                        }
                    }
                }

                string[] stringArrayToAdd = stringListToAdd.ToArray();
                string[] stringArrayToRemove = stringListToRemove.ToArray();
                if (stringArrayToAdd.Length > 0)
                    Roles.AddUserToRoles(CurrentUser.UserName, stringArrayToAdd);
                if (stringArrayToRemove.Length > 0)
                    Roles.RemoveUserFromRoles(CurrentUser.UserName, stringArrayToRemove);

                // 
                if (Roles.IsUserInRole(CurrentUser.UserName, "Client"))
                {
                    Company usPr = new Company();
                    usPr.getCompanyByUsername(CurrentUser.UserName);

                    usPr.EnName = txtFullName.Text;
                    usPr.Email = txtEmail.Text;
                    usPr.Telephone = uiTextBoxTele.Text;
                    //usPr.GroupID = int.Parse(DropDownListGroups.SelectedValue);
                    usPr.AccountDueDate = DateTime.Parse(uiTextBoxAccountDueDate.Text);
                    usPr.Save();
                }
            }
            else
            {
                List<string> stringListToAdd = new List<string>();
                MembershipCreateStatus obj;
                string password = uiTextBoxPass.Text;
                MembershipUser objUser = Membership.CreateUser(uiTextBoxUserName.Text, password, "dummy@example.com", null, null, true, out obj);
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
                    foreach (ListItem item in uiCheckBoxListRoles.Items)
                    {
                        if (item.Selected)
                        {
                            if (!Roles.IsUserInRole(objUser.UserName, item.Text))
                            {
                                stringListToAdd.Add(item.Text);
                            }
                        }
                    }
                    string[] stringArrayToAdd = stringListToAdd.ToArray();
                    if (stringArrayToAdd.Length > 0)
                        Roles.AddUserToRoles(objUser.UserName, stringArrayToAdd);

                    // only incase of clients
                    if (stringListToAdd.Contains("client"))
                    {
                        Company usPr = new Company();
                        usPr.AddNew();
                        usPr.Username = objUser.UserName;
                        usPr.EnName = txtFullName.Text;
                        usPr.Email = txtEmail.Text;
                        usPr.Telephone = uiTextBoxTele.Text;
                        usPr.AccountDueDate = DateTime.Parse(uiTextBoxAccountDueDate.Text);
                        //usPr.GroupID = int.Parse(DropDownListGroups.SelectedValue);

                        usPr.Save();
                        uiPanelDepartments.Visible = true;
                    }
                }
            }
            
            //uiPanelAll.Visible = true;
            ClearFields();
            CurrentUser = null;
            BindData();

        }

        protected void uiButtonCancel_Click(object sender, EventArgs e)
        {
            ClearFields();
            uiPanelEdit.Visible = false;
            uiPanelDepartments.Visible = false;
            uiPanelAll.Visible = true;
            CurrentUser = null;
        }



        protected void uiLinkButtonAdd_Click(object sender, EventArgs e)
        {
            ClearFields();
            uiPanelAll.Visible = false;
            uiPanelEdit.Visible = true;
            uiPanelDepartments.Visible = false;

            //RequiredFieldValidator6.Enabled = false;
            RequiredFieldValidator2.Enabled = false;
            CompareValidator1.Enabled = false;
            //uiTextBoxPass.Enabled = false;
            CurrentUser = null;
        }
        
        protected void uiRadGridUsers_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            uiRadGridUsers.PageIndex = e.NewPageIndex;
            SearchByText();
        }

        protected void uiRadGridUsers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditUser")
            {                
                MembershipUser ObjData = Membership.GetUser(e.CommandArgument.ToString());
                uiTextBoxUserName.Text = ObjData.UserName;
                
                uiTextBoxUserName.Enabled = false;                
                //uiTextBoxPass.Enabled = false;
                // uiCheckBoxIsLocked.Checked = ObjData.IsLockedOut;
                RequiredFieldValidator2.Enabled = false;
                //RequiredFieldValidator6.Enabled = false;
                CompareValidator1.Enabled = false;
                uiTextBoxConfirm.Enabled = false;
                uiTextBoxPass.Enabled = true;
                //uiLinkButtonEditPassword.Enabled = true;
                //uiTextBoxMail.Text = ObjData.Email;
                foreach (string role in Roles.GetRolesForUser(ObjData.UserName))
                {
                    foreach (ListItem item in uiCheckBoxListRoles.Items)
                    {
                        if (role == item.Text)
                        {
                            item.Selected = true;
                            break;
                        }
                    }
                }
                uiPanelEdit.Visible = true;
                uiPanelDepartments.Visible = true;
                uiPanelAll.Visible = false;

                Company usPr = new Company();
                if (usPr.getCompanyByUsername(ObjData.UserName))
                {
                    txtFullName.Text = usPr.EnName;
                    txtEmail.Text = usPr.Email;
                    uiTextBoxTele.Text = usPr.Telephone;
                    CurrentUser = ObjData;
                    CurrentCompany = usPr;
                    if(!usPr.IsColumnNull("AccountDueDate"))
                        uiTextBoxAccountDueDate.Text = usPr.AccountDueDate.ToString("yyyy-MM-dd");                   

                    BindCountries();
                    BindGovs();
                    BindAreas();
                    BindBranches();
                    BindDepartments();
                    BindDivisions();
                    BindLevels();
                    BindGrades();
                    BindJobTitles();
                    BindAgeGroups();
                }
                if (!ObjData.IsLockedOut)
                    uiTextBoxPass.Text = ObjData.GetPassword();

            }
            else if (e.CommandName == "DeleteUser")
            {
                MembershipUser ObjData = Membership.GetUser(e.CommandArgument.ToString());
                if (ObjData != null)
                {
                    Company usPr = new Company();
                    if (usPr.getCompanyByUsername(ObjData.UserName))
                    {
                        usPr.IsDeleted = true;
                        usPr.Save();
                    }
                    //Membership.DeleteUser(ObjData.UserName, true);
                }
                BindData();
            }
            else if (e.CommandName == "UnlockUser")
            {
                MembershipUser ObjData = Membership.GetUser(e.CommandArgument.ToString());
                if (ObjData != null)
                {
                    ObjData.UnlockUser();
                    ObjData.IsApproved = true;
                    Membership.UpdateUser(ObjData);
                }
                BindData();
            }
            else if (e.CommandName == "lockUser")
            {
                MembershipUser ObjData = Membership.GetUser(e.CommandArgument.ToString());
                if (ObjData != null)
                {
                    ObjData.IsApproved = false;
                    Membership.UpdateUser(ObjData);
                }
                BindData();
            }
        }

        #region Country
        private void BindCountries()
        {
            Country departments = new Country();
            departments.GetListByCompanyID(CurrentCompany.CompanyID);
            uiGridViewCon.DataSource = departments.DefaultView;
            uiGridViewCon.DataBind();
        }


        protected void uiLinkButtonSaveCountry_Click(object sender, EventArgs e)
        {
            if (CurrentCountry != null)
            {
                CurrentCountry.EnName = uiTextBoxNameEn.Text;
                CurrentCountry.ArName = uiTextBoxNameAr.Text;
                CurrentCountry.IsActive = uiCheckBoxConActive.Checked;
                CurrentCountry.Save();


            }
            else
            {
                Country dep = new Country();
                dep.AddNew();
                dep.EnName = uiTextBoxNameEn.Text;
                dep.ArName = uiTextBoxNameAr.Text;
                dep.CompanyID = CurrentCompany.CompanyID;
                dep.IsActive = uiCheckBoxConActive.Checked;
                dep.Save();
            }
            uiTextBoxNameEn.Text = "";
            uiTextBoxNameAr.Text = "";
            uiCheckBoxConActive.Checked = false;
            BindCountries();
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "1", "$('.nav-tabs a[href=\"#tab_Conuntry\"]').tab('show');", true);
            CurrentCountry = null;
        }

        protected void uiGridViewCon_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            uiGridViewCon.PageIndex = e.NewPageIndex;
            BindCountries();
        }

        protected void uiGridViewCon_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditCon")
            {
                Country ObjData = new Country();
                ObjData.LoadByPrimaryKey(int.Parse(e.CommandArgument.ToString()));
                uiTextBoxNameEn.Text = ObjData.EnName;
                uiTextBoxNameAr.Text = ObjData.ArName;
                
                if (!ObjData.IsColumnNull("IsActive"))
                    uiCheckBoxConActive.Checked = ObjData.IsActive;
                CurrentCountry = ObjData;

            }
            else if (e.CommandName == "DeleteCon")
            {
                Country ObjData = new Country();
                ObjData.LoadByPrimaryKey(int.Parse(e.CommandArgument.ToString()));
                try
                {
                    ObjData.MarkAsDeleted();
                    ObjData.Save();
                }
                catch (Exception w)
                {

                }
                BindCountries();
            }
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "1", "$('.nav-tabs a[href=\"#tab_Conuntry\"]').tab('show');", true);
        }
        #endregion

        #region Govs
        private void BindGovs()
        {
            Governrate departments = new Governrate();
            departments.GetListByCompanyID(CurrentCompany.CompanyID);
            uiGridViewGovs.DataSource = departments.DefaultView;
            uiGridViewGovs.DataBind();
        }
        protected void uiLinkButtonSaveGov_Click(object sender, EventArgs e)
        {
            if (CurrentGov != null)
            {
                CurrentGov.EnName = uiTextBoxGovName.Text;
                CurrentGov.ArName = uiTextBoxGovNameAr.Text;
                CurrentGov.IsActive = uiCheckBoxGovActive.Checked;
                CurrentGov.Save();


            }
            else
            {
                Governrate dep = new Governrate();
                dep.AddNew();
                dep.EnName = uiTextBoxGovName.Text;
                dep.ArName = uiTextBoxGovNameAr.Text;
                dep.CompanyID = CurrentCompany.CompanyID;
                dep.IsActive = uiCheckBoxGovActive.Checked;
                dep.Save();
            }
            uiTextBoxGovName.Text = "";
            uiTextBoxGovNameAr.Text = "";
            uiCheckBoxGovActive.Checked = false;

            BindGovs();
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "1", "$('.nav-tabs a[href=\"#tab_Gov\"]').tab('show');", true);
            CurrentGov = null;

        }

        protected void uiGridViewGovs_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            uiGridViewGovs.PageIndex = e.NewPageIndex;
            BindGovs();
        }

        protected void uiGridViewGovs_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditGov")
            {
                Governrate ObjData = new Governrate();
                ObjData.LoadByPrimaryKey(int.Parse(e.CommandArgument.ToString()));
                uiTextBoxGovName.Text = ObjData.EnName;
                uiTextBoxGovNameAr.Text = ObjData.ArName;

                if (!ObjData.IsColumnNull("IsActive"))
                    uiCheckBoxGovActive.Checked = ObjData.IsActive;
                CurrentGov = ObjData;

            }
            else if (e.CommandName == "DeleteGov")
            {
                Governrate ObjData = new Governrate();
                ObjData.LoadByPrimaryKey(int.Parse(e.CommandArgument.ToString()));
                try
                {
                    ObjData.MarkAsDeleted();
                    ObjData.Save();
                }
                catch (Exception w)
                {

                }
                BindGovs();
            }
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "1", "$('.nav-tabs a[href=\"#tab_Gov\"]').tab('show');", true);
        }
        #endregion

        #region Departments
        private void BindDepartments()
        {
            Department departments = new Department();
            departments.GetListByCompanyID(CurrentCompany.CompanyID);
            uiGridViewDepartments.DataSource = departments.DefaultView;
            uiGridViewDepartments.DataBind();
        }
        protected void uiLinkButtonSaveDepartment_Click(object sender, EventArgs e)
        {
            if (CurrentDepartment != null)
            {
                CurrentDepartment.EnName = uiTextBoxDepartmentName.Text;
                CurrentDepartment.ArName = uiTextBoxDepartmentNameAr.Text;
                CurrentDepartment.IsActive = uiCheckBoxDepartmentActive.Checked;
                CurrentDepartment.Save();


            }
            else
            {
                Department dep = new Department();
                dep.AddNew();
                dep.EnName = uiTextBoxDepartmentName.Text;
                dep.ArName = uiTextBoxDepartmentNameAr.Text;
                dep.CompanyID = CurrentCompany.CompanyID;
                dep.IsActive = uiCheckBoxDepartmentActive.Checked;
                dep.Save();
            }
            uiTextBoxDepartmentName.Text = "";
            uiTextBoxDepartmentNameAr.Text = "";
            uiCheckBoxDepartmentActive.Checked = false;
            BindDepartments();
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "1", "$('.nav-tabs a[href=\"#tab_Departments\"]').tab('show');", true);
            CurrentDepartment = null;
        }

        protected void uiGridViewDepartments_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            uiGridViewDepartments.PageIndex = e.NewPageIndex;
            BindDepartments();
        }

        protected void uiGridViewDepartments_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditDepartment")
            {
                Department ObjData = new Department();
                ObjData.LoadByPrimaryKey(int.Parse(e.CommandArgument.ToString()));
                uiTextBoxDepartmentName.Text = ObjData.EnName;
                uiTextBoxDepartmentNameAr.Text = ObjData.ArName;

                if (!ObjData.IsColumnNull("IsActive"))
                    uiCheckBoxDepartmentActive.Checked = ObjData.IsActive;
                CurrentDepartment = ObjData;

            }
            else if (e.CommandName == "DeleteDepartment")
            {
                Department ObjData = new Department();
                ObjData.LoadByPrimaryKey(int.Parse(e.CommandArgument.ToString()));
                try
                {
                    ObjData.MarkAsDeleted();
                    ObjData.Save();
                }
                catch (Exception w)
                {
                    
                }
                BindDepartments();
            }
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "1", "$('.nav-tabs a[href=\"#tab_Departments\"]').tab('show');", true);
        }
        #endregion

        #region Areas
        private void BindAreas()
        {
            Area departments = new Area();
            departments.GetListByCompanyID(CurrentCompany.CompanyID);
            uiGridViewArea.DataSource = departments.DefaultView;
            uiGridViewArea.DataBind();
        }
        protected void uiLinkButtonSaveArea_Click(object sender, EventArgs e)
        {
            if (CurrentArea != null)
            {
                CurrentArea.NameEn = uiTextBoxAreaName.Text;
                CurrentArea.NameAr = uiTextBoxAreaNameAr.Text;
                CurrentArea.IsActive = uiCheckBoxAreaActive.Checked;
                CurrentArea.Save();


            }
            else
            {
                Area dep = new Area();
                dep.AddNew();
                dep.NameEn = uiTextBoxAreaName.Text;
                dep.NameAr = uiTextBoxAreaNameAr.Text;
                dep.CompanyID = CurrentCompany.CompanyID;
                dep.IsActive = uiCheckBoxAreaActive.Checked;
                dep.Save();
            }
            uiTextBoxAreaName.Text = "";
            uiTextBoxAreaNameAr.Text = "";
            uiCheckBoxAreaActive.Checked = false;

            BindAreas();
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "1", "$('.nav-tabs a[href=\"#tab_Area\"]').tab('show');", true);
            CurrentArea = null;
        }

        protected void uiGridViewArea_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            uiGridViewArea.PageIndex = e.NewPageIndex;
            BindAreas();
        }

        protected void uiGridViewArea_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditArea")
            {
                Area ObjData = new Area();
                ObjData.LoadByPrimaryKey(int.Parse(e.CommandArgument.ToString()));
                uiTextBoxAreaName.Text = ObjData.NameEn;
                uiTextBoxAreaNameAr.Text = ObjData.NameAr;

                if (!ObjData.IsColumnNull("IsActive"))
                    uiCheckBoxAreaActive.Checked = ObjData.IsActive;
                CurrentArea = ObjData;

            }
            else if (e.CommandName == "DeleteArea")
            {
                Area ObjData = new Area();
                ObjData.LoadByPrimaryKey(int.Parse(e.CommandArgument.ToString()));
                try
                {
                    ObjData.MarkAsDeleted();
                    ObjData.Save();
                }
                catch (Exception w)
                {

                }
                BindAreas();
            }
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "1", "$('.nav-tabs a[href=\"#tab_Area\"]').tab('show');", true);
        }
        #endregion

        #region Branches
        private void BindBranches()
        {
            Branch departments = new Branch();
            departments.GetListByCompanyID(CurrentCompany.CompanyID);
            uiGridViewBranch.DataSource = departments.DefaultView;
            uiGridViewBranch.DataBind();
        }
        protected void uiLinkButtonSaveBranch_Click(object sender, EventArgs e)
        {
            if (CurrentBranch != null)
            {
                CurrentBranch.NameEn = uiTextBoxBranchName.Text;
                CurrentBranch.NameAr = uiTextBoxBranchNameAr.Text;
                CurrentBranch.IsActive = uiCheckBoxBranchActive.Checked;
                CurrentBranch.Save();


            }
            else
            {
                Branch dep = new Branch();
                dep.AddNew();
                dep.NameEn = uiTextBoxBranchName.Text;
                dep.NameAr = uiTextBoxBranchNameAr.Text;
                dep.CompanyID = CurrentCompany.CompanyID;
                dep.IsActive = uiCheckBoxBranchActive.Checked;
                dep.Save();
            }
            uiTextBoxBranchName.Text = "";
            uiTextBoxBranchNameAr.Text = "";
            uiCheckBoxBranchActive.Checked = false;

            BindBranches();
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "1", "$('.nav-tabs a[href=\"#tab_Branches\"]').tab('show');", true);
            CurrentBranch = null;
        }

        protected void uiGridViewBranch_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            uiGridViewBranch.PageIndex = e.NewPageIndex;
            BindAreas();
        }

        protected void uiGridViewBranch_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditBranch")
            {
                Branch ObjData = new Branch();
                ObjData.LoadByPrimaryKey(int.Parse(e.CommandArgument.ToString()));
                uiTextBoxBranchName.Text = ObjData.NameEn;
                uiTextBoxBranchNameAr.Text = ObjData.NameAr;

                if (!ObjData.IsColumnNull("IsActive"))
                    uiCheckBoxBranchActive.Checked = ObjData.IsActive;
                CurrentBranch = ObjData;

            }
            else if (e.CommandName == "DeleteBranch")
            {
                Branch ObjData = new Branch();
                ObjData.LoadByPrimaryKey(int.Parse(e.CommandArgument.ToString()));
                try
                {
                    ObjData.MarkAsDeleted();
                    ObjData.Save();
                }
                catch (Exception w)
                {

                }
                BindAreas();
            }
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "1", "$('.nav-tabs a[href=\"#tab_Branches\"]').tab('show');", true);
        }
        #endregion

        #region Division
        private void BindDivisions()
        {
            Division departments = new Division();
            departments.GetListByCompanyID(CurrentCompany.CompanyID);
            uiGridViewDivision.DataSource = departments.DefaultView;
            uiGridViewDivision.DataBind();
        }
        protected void uiLinkButtonSaveDivision_Click(object sender, EventArgs e)
        {
            if (CurrentDivision != null)
            {
                CurrentDivision.NameEn = uiTextBoxDivisionName.Text;
                CurrentDivision.NameAr = uiTextBoxDivisionNameAr.Text;
                CurrentDivision.IsActive = uiCheckBoxDivisionActive.Checked;
                CurrentDivision.Save();


            }
            else
            {
                Division dep = new Division();
                dep.AddNew();
                dep.NameEn = uiTextBoxDivisionName.Text;
                dep.NameAr = uiTextBoxDivisionNameAr.Text;
                dep.CompanyID = CurrentCompany.CompanyID;
                dep.IsActive = uiCheckBoxDivisionActive.Checked;
                dep.Save();
            }
            uiTextBoxDivisionName.Text = "";
            uiTextBoxDivisionNameAr.Text = "";
            uiCheckBoxDivisionActive.Checked = false;

            BindDivisions();
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "1", "$('.nav-tabs a[href=\"#tab_Divisions\"]').tab('show');", true);
            CurrentDivision = null;
        }

        protected void uiGridViewDivision_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            uiGridViewDivision.PageIndex = e.NewPageIndex;
            BindDivisions();
        }

        protected void uiGridViewDivision_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditDivision")
            {
                Division ObjData = new Division();
                ObjData.LoadByPrimaryKey(int.Parse(e.CommandArgument.ToString()));
                uiTextBoxDivisionName.Text = ObjData.NameEn;
                uiTextBoxDivisionNameAr.Text = ObjData.NameAr;

                if (!ObjData.IsColumnNull("IsActive"))
                    uiCheckBoxDivisionActive.Checked = ObjData.IsActive;
                CurrentDivision = ObjData;

            }
            else if (e.CommandName == "DeleteDivision")
            {
                Division ObjData = new Division();
                ObjData.LoadByPrimaryKey(int.Parse(e.CommandArgument.ToString()));
                try
                {
                    ObjData.MarkAsDeleted();
                    ObjData.Save();
                }
                catch (Exception w)
                {

                }
                BindDivisions();
            }
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "1", "$('.nav-tabs a[href=\"#tab_Divisions\"]').tab('show');", true);
        }
        #endregion

        #region Level
        private void BindLevels()
        {
            Level departments = new Level();
            departments.GetListByCompanyID(CurrentCompany.CompanyID);
            uiGridViewLevel.DataSource = departments.DefaultView;
            uiGridViewLevel.DataBind();
        }
        protected void uiLinkButtonSaveLevel_Click(object sender, EventArgs e)
        {
            if (CurrentLevel != null)
            {
                CurrentLevel.EnName = uiTextBoxLevelName.Text;
                CurrentLevel.ArName = uiTextBoxLevelNameAr.Text;
                CurrentLevel.IsActive = uiCheckBoxLevelActive.Checked;
                CurrentLevel.Save();


            }
            else
            {
                Level dep = new Level();
                dep.AddNew();
                dep.EnName = uiTextBoxLevelName.Text;
                dep.ArName = uiTextBoxLevelNameAr.Text;
                dep.CompanyID = CurrentCompany.CompanyID;
                dep.IsActive = uiCheckBoxLevelActive.Checked;
                dep.Save();
            }
            uiTextBoxLevelName.Text = "";
            uiTextBoxLevelNameAr.Text = "";
            uiCheckBoxLevelActive.Checked = false;

            BindLevels();
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "1", "$('.nav-tabs a[href=\"#tab_Levels\"]').tab('show');", true);
            CurrentLevel = null;
        }

        protected void uiGridViewLevel_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            uiGridViewLevel.PageIndex = e.NewPageIndex;
            BindAreas();
        }

        protected void uiGridViewLevel_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditLevel")
            {
                Level ObjData = new Level();
                ObjData.LoadByPrimaryKey(int.Parse(e.CommandArgument.ToString()));
                uiTextBoxLevelName.Text = ObjData.EnName;
                uiTextBoxLevelNameAr.Text = ObjData.ArName;

                if (!ObjData.IsColumnNull("IsActive"))
                    uiCheckBoxLevelActive.Checked = ObjData.IsActive;
                CurrentLevel = ObjData;

            }
            else if (e.CommandName == "DeleteLevel")
            {
                Level ObjData = new Level();
                ObjData.LoadByPrimaryKey(int.Parse(e.CommandArgument.ToString()));
                try
                {
                    ObjData.MarkAsDeleted();
                    ObjData.Save();
                }
                catch (Exception w)
                {

                }
                BindLevels();
            }
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "1", "$('.nav-tabs a[href=\"#tab_Levels\"]').tab('show');", true);
        }
        #endregion

        #region Grade
        private void BindGrades()
        {
            Grade departments = new Grade();
            departments.GetListByCompanyID(CurrentCompany.CompanyID);
            uiGridViewGrade.DataSource = departments.DefaultView;
            uiGridViewGrade.DataBind();
        }
        protected void uiLinkButtonSaveGrade_Click(object sender, EventArgs e)
        {
            if (CurrentGrade != null)
            {
                CurrentGrade.EnName = uiTextBoxGradeName.Text;
                CurrentGrade.ArName = uiTextBoxGradeNameAr.Text;
                CurrentGrade.IsActive = uiCheckBoxGradeActive.Checked;
                CurrentGrade.Save();


            }
            else
            {
                Grade dep = new Grade();
                dep.AddNew();
                dep.EnName = uiTextBoxGradeName.Text;
                dep.ArName = uiTextBoxGradeNameAr.Text;
                dep.CompanyID = CurrentCompany.CompanyID;
                dep.IsActive = uiCheckBoxGradeActive.Checked;
                dep.Save();
            }
            uiTextBoxGradeName.Text = "";
            uiTextBoxGradeNameAr.Text = "";
            uiCheckBoxGradeActive.Checked = false;

            BindGrades();
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "1", "$('.nav-tabs a[href=\"#tab_Grades\"]').tab('show');", true);
            CurrentGrade = null;
        }

        protected void uiGridViewGrade_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            uiGridViewGrade.PageIndex = e.NewPageIndex;
            BindGrades();
        }

        protected void uiGridViewGrade_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditGrade")
            {
                Grade ObjData = new Grade();
                ObjData.LoadByPrimaryKey(int.Parse(e.CommandArgument.ToString()));
                uiTextBoxGradeName.Text = ObjData.EnName;
                uiTextBoxGradeNameAr.Text = ObjData.ArName;

                if (!ObjData.IsColumnNull("IsActive"))
                    uiCheckBoxGradeActive.Checked = ObjData.IsActive;
                CurrentGrade = ObjData;

            }
            else if (e.CommandName == "DeleteGrade")
            {
                Grade ObjData = new Grade();
                ObjData.LoadByPrimaryKey(int.Parse(e.CommandArgument.ToString()));
                try
                {
                    ObjData.MarkAsDeleted();
                    ObjData.Save();
                }
                catch (Exception w)
                {

                }
                BindGrades();
            }
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "1", "$('.nav-tabs a[href=\"#tab_Grades\"]').tab('show');", true);
        }
        #endregion

        #region JobTitle
        private void BindJobTitles()
        {
            JobTitle departments = new JobTitle();
            departments.GetListByCompanyID(CurrentCompany.CompanyID);
            uiGridViewJobTitle.DataSource = departments.DefaultView;
            uiGridViewJobTitle.DataBind();
        }
        protected void uiLinkButtonSaveJobTitle_Click(object sender, EventArgs e)
        {
            if (CurrentJobTitle != null)
            {
                CurrentJobTitle.EnName = uiTextBoxJobTitleName.Text;
                CurrentJobTitle.ArName = uiTextBoxJobTitleNameAr.Text;
                CurrentJobTitle.IsActive = uiCheckBoxJobTitleActive.Checked;
                CurrentJobTitle.Save();


            }
            else
            {
                JobTitle dep = new JobTitle();
                dep.AddNew();
                dep.EnName = uiTextBoxJobTitleName.Text;
                dep.ArName = uiTextBoxJobTitleNameAr.Text;
                dep.CompanyID = CurrentCompany.CompanyID;
                dep.IsActive = uiCheckBoxJobTitleActive.Checked;
                dep.Save();
            }
            uiTextBoxJobTitleName.Text = "";
            uiTextBoxJobTitleNameAr.Text = "";
            uiCheckBoxJobTitleActive.Checked = false;

            BindJobTitles();
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "1", "$('.nav-tabs a[href=\"#tab_JobTitles\"]').tab('show');", true);
            CurrentJobTitle = null;
        }

        protected void uiGridViewJobTitle_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            uiGridViewJobTitle.PageIndex = e.NewPageIndex;
            BindJobTitles();
        }

        protected void uiGridViewJobTitle_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditJobTitle")
            {
                JobTitle ObjData = new JobTitle();
                ObjData.LoadByPrimaryKey(int.Parse(e.CommandArgument.ToString()));
                uiTextBoxJobTitleName.Text = ObjData.EnName;
                uiTextBoxJobTitleNameAr.Text = ObjData.ArName;

                if (!ObjData.IsColumnNull("IsActive"))
                    uiCheckBoxJobTitleActive.Checked = ObjData.IsActive;
                CurrentJobTitle = ObjData;

            }
            else if (e.CommandName == "DeletejobTitle")
            {
                JobTitle ObjData = new JobTitle();
                ObjData.LoadByPrimaryKey(int.Parse(e.CommandArgument.ToString()));
                try
                {
                    ObjData.MarkAsDeleted();
                    ObjData.Save();
                }
                catch (Exception w)
                {

                }
                BindJobTitles();
            }
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "1", "$('.nav-tabs a[href=\"#tab_JobTitles\"]').tab('show');", true);
        }
        #endregion

        #region AgeGroup
        private void BindAgeGroups()
        {
            AgeGroup departments = new AgeGroup();
            departments.GetListByCompanyID(CurrentCompany.CompanyID);
            uiGridViewAgeGroup.DataSource = departments.DefaultView;
            uiGridViewAgeGroup.DataBind();
        }
        protected void uiLinkButtonSaveAgeGroup_Click(object sender, EventArgs e)
        {
            if (CurrentAgegroup != null)
            {
                CurrentAgegroup.EnDisplayName = uiTextBoxAgeGroupName.Text;
                CurrentAgegroup.ArDisplayName = uiTextBoxAgeGroupNameAr.Text;
                int start = 0;
                int end = 0;
                if (int.TryParse(uiTextBoxStart.Text, out start))
                    CurrentAgegroup.StartAge = start;
                else
                    CurrentAgegroup.SetColumnNull("StartAge");
                if (int.TryParse(uiTextBoxEnd.Text, out end))
                    CurrentAgegroup.EndAge = end;
                else
                    CurrentAgegroup.SetColumnNull("EndAge");
                
                CurrentAgegroup.IsActive = uiCheckBoxAgeGroupActive.Checked;
                CurrentAgegroup.Save();


            }
            else
            {
                AgeGroup dep = new AgeGroup();
                dep.AddNew();
                dep.EnDisplayName = uiTextBoxAgeGroupName.Text;
                dep.ArDisplayName = uiTextBoxAgeGroupNameAr.Text;
                dep.CompanyID = CurrentCompany.CompanyID;
                dep.IsActive = uiCheckBoxAgeGroupActive.Checked;
                int start = 0;
                int end = 0;
                if (int.TryParse(uiTextBoxStart.Text, out start))
                    dep.StartAge = start;
                else
                    dep.SetColumnNull("StartAge");
                if (int.TryParse(uiTextBoxEnd.Text, out end))
                    dep.EndAge = end;
                else
                    dep.SetColumnNull("EndAge");

                dep.Save();
            }
            uiTextBoxAgeGroupName.Text = "";
            uiTextBoxAgeGroupNameAr.Text = "";
            uiTextBoxStart.Text = "";
            uiTextBoxEnd.Text = "";
            uiCheckBoxAgeGroupActive.Checked = false;

            BindAgeGroups();
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "1", "$('.nav-tabs a[href=\"#tab_AgeGroups\"]').tab('show');", true);
            CurrentAgegroup = null;
        }

        protected void uiGridViewAgeGroup_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            uiGridViewAgeGroup.PageIndex = e.NewPageIndex;
            BindAgeGroups();
        }

        protected void uiGridViewAgeGroup_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditAgeGroup")
            {
                AgeGroup ObjData = new AgeGroup();
                ObjData.LoadByPrimaryKey(int.Parse(e.CommandArgument.ToString()));
                uiTextBoxAgeGroupName.Text = ObjData.EnDisplayName;
                uiTextBoxAgeGroupNameAr.Text = ObjData.ArDisplayName;
                if (!ObjData.IsColumnNull("StartAge"))
                    uiTextBoxStart.Text = ObjData.StartAge.ToString();
                if (!ObjData.IsColumnNull("EndAge"))
                    uiTextBoxEnd.Text = ObjData.EndAge.ToString();
                if (!ObjData.IsColumnNull("IsActive"))
                    uiCheckBoxAgeGroupActive.Checked = ObjData.IsActive;
                CurrentAgegroup = ObjData;

            }
            else if (e.CommandName == "DeleteAgeGroup")
            {
                AgeGroup ObjData = new AgeGroup();
                ObjData.LoadByPrimaryKey(int.Parse(e.CommandArgument.ToString()));
                try
                {
                    ObjData.MarkAsDeleted();
                    ObjData.Save();
                }
                catch (Exception w)
                {

                }
                BindAgeGroups();
            }
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "1", "$('.nav-tabs a[href=\"#tab_AgeGroups\"]').tab('show');", true);
        }
        #endregion

        #endregion

        #region Methods

        private void BindData()
        {
            SearchByText();
        }

        private void LoadRoles()
        {
            string[] allroles = Roles.GetAllRoles();
            if (!Roles.IsUserInRole("super admin"))
            {
                List<string> _roles = allroles.Where(r => r != "super admin").ToList<string>();
                uiCheckBoxListRoles.DataSource = _roles;
            }
            else
                uiCheckBoxListRoles.DataSource = allroles;

            uiCheckBoxListRoles.DataBind();

        }

       

        private void SearchByText()
        {
            Company up = new Company();
            up.searchCompanyForUsers(uiTextBoxSearch.Text);
            uiRadGridUsers.DataSource = up.DefaultView;
            uiRadGridUsers.DataBind();
        }

        private void ClearFields()
        {
            uiTextBoxUserName.Text = "";
            uiTextBoxPass.Text = "";
            uiTextBoxConfirm.Text = "";
            RequiredFieldValidator2.Enabled = true;
            CompareValidator1.Enabled = true;
            uiTextBoxUserName.Enabled = true;
            uiTextBoxPass.Enabled = true;
            uiTextBoxConfirm.Enabled = true;
            //uiLinkButtonEditPassword.Enabled = false;
            uiCheckBoxListRoles.ClearSelection();
            txtFullName.Text = "";
            txtEmail.Text = "";
            uiTextBoxAccountDueDate.Text = "";
            uiGridViewDepartments.DataSource = null;
            uiGridViewDepartments.DataBind();
            //txtTelephone.Text = "";
            //DropDownListGroups.SelectedIndex = 0;
            //uiCheckBoxListGroups.ClearSelection();
            //userImg.Src = "../img/noImg.gif";
            CurrentDepartment = null;
            CurrentAgegroup = null;
            CurrentArea = null;
            CurrentGov = null;
            CurrentBranch = null;
            CurrentDivision = null;
            CurrentLevel = null;
            CurrentJobTitle = null;
            CurrentGrade = null;
            CurrentCountry = null;
        }



        #endregion

    }
}