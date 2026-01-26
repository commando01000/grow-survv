using GrowSurv.BLL;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Script.Services;
using System.Web.Security;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GrowSurv.survManager
{
    public partial class ListSurvies : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            if (Request.IsAuthenticated)
            {
                    if (Roles.IsUserInRole("client"))
                    {
                        Company current = new Company();
                        current.getCompanyByUsername(Membership.GetUser().UserName);
                        CurrentCompany.Value = current.CompanyID.ToString();
                    }
            }
        }

        [WebMethod]
        public static List<SurveyModel> SearchSurveies(string filtertxt, int CompanyID)
        {

            List<SurveyModel> survies = new List<survManager.SurveyModel>();
            Survey survs = new Survey();
            survs.searchSurvies(filtertxt, CompanyID);
            for (int i = 0; i < survs.RowCount; i++)
            {
                survies.Add(new SurveyModel { SurveyID = survs.SurveyID, ArDesc = survs.ArDesc, ArName = survs.ArName, CompanyID = survs.CompanyID, EnDesc = survs.EnDesc, EnName = survs.EnName });
                survs.MoveNext();
            }

            return survies;
        }

        [WebMethod]
        public static string HelloWorld()
        {
            return "Hello world";
        }

        private string Encrypt(string clearText)
        {
            string EncryptionKey = "MAKV2SPBNI99212";
            byte[] clearBytes = Encoding.Unicode.GetBytes(clearText);
            using (Aes encryptor = Aes.Create())
            {
                Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
                encryptor.Key = pdb.GetBytes(32);
                encryptor.IV = pdb.GetBytes(16);
                using (MemoryStream ms = new MemoryStream())
                {
                    using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateEncryptor(), CryptoStreamMode.Write))
                    {
                        cs.Write(clearBytes, 0, clearBytes.Length);
                        cs.Close();
                    }
                    clearText = Convert.ToBase64String(ms.ToArray());
                }
            }
            return clearText;
        }
    }

    public class SurveyModel
    {
        public int SurveyID { get; set; }
        public string ArName { get; set; }
        public string EnName { get; set; }
        public string EnDesc { get; set; }
        public string ArDesc { get; set; }
        public int CompanyID { get; set; }

    }
}