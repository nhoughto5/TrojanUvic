using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin.Security;
using Owin;
using Trojan.Models;
using System.Web.UI.WebControls;

namespace Trojan.Account
{
    public partial class Manage : System.Web.UI.Page
    {
        TrojanContext db = new TrojanContext();
        protected string SuccessMessage
        {
            get;
            private set;
        }

        private bool HasPassword(ApplicationUserManager manager)
        {
            return manager.HasPassword(User.Identity.GetUserId());
        }

        public bool HasPhoneNumber { get; private set; }

        public bool TwoFactorEnabled { get; private set; }

        public bool TwoFactorBrowserRemembered { get; private set; }

        public int LoginsCount { get; set; }

        protected void Page_Load()
        {
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();

            HasPhoneNumber = String.IsNullOrEmpty(manager.GetPhoneNumber(User.Identity.GetUserId()));

            // Enable this after setting up two-factor authentientication
            //PhoneNumber.Text = manager.GetPhoneNumber(User.Identity.GetUserId()) ?? String.Empty;

            TwoFactorEnabled = manager.GetTwoFactorEnabled(User.Identity.GetUserId());

            LoginsCount = manager.GetLogins(User.Identity.GetUserId()).Count;

            var authenticationManager = HttpContext.Current.GetOwinContext().Authentication;

            if (!IsPostBack)
            {
                // Determine the sections to render
                if (HasPassword(manager))
                {
                    ChangePassword.Visible = true;
                }
                else
                {
                    CreatePassword.Visible = true;
                    ChangePassword.Visible = false;
                }
                populate();
                // Render success message
                var message = Request.QueryString["m"];
                if (message != null)
                {
                    // Strip the query string from action
                    Form.Action = ResolveUrl("~/Account/Manage");

                    SuccessMessage =
                        message == "ChangePwdSuccess" ? "Your password has been changed."
                        : message == "SetPwdSuccess" ? "Your password has been set."
                        : message == "RemoveLoginSuccess" ? "The account was removed."
                        : message == "AddPhoneNumberSuccess" ? "Phone number has been added"
                        : message == "RemovePhoneNumberSuccess" ? "Phone number was removed"
                        : String.Empty;
                    successMessage.Visible = !String.IsNullOrEmpty(SuccessMessage);
                }
            }
        }


        private void AddErrors(IdentityResult result)
        {
            foreach (var error in result.Errors)
            {
                ModelState.AddModelError("", error);
            }
        }

        // Remove phonenumber from user
        protected void RemovePhone_Click(object sender, EventArgs e)
        {
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            var signInManager = Context.GetOwinContext().Get<ApplicationSignInManager>();
            var result = manager.SetPhoneNumber(User.Identity.GetUserId(), null);
            if (!result.Succeeded)
            {
                return;
            }
            var user = manager.FindById(User.Identity.GetUserId());
            if (user != null)
            {
                signInManager.SignIn(user, isPersistent: false, rememberBrowser: false);
                Response.Redirect("/Account/Manage?m=RemovePhoneNumberSuccess");
            }
        }

        // DisableTwoFactorAuthentication
        protected void TwoFactorDisable_Click(object sender, EventArgs e)
        {
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            manager.SetTwoFactorEnabled(User.Identity.GetUserId(), false);

            Response.Redirect("/Account/Manage");
        }

        //EnableTwoFactorAuthentication 
        protected void TwoFactorEnable_Click(object sender, EventArgs e)
        {
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            manager.SetTwoFactorEnabled(User.Identity.GetUserId(), true);

            Response.Redirect("/Account/Manage");
        }

        private void populate()
        {
            
            trojanDrpDown.DataSource = (from b in db.severityRating where ((b.userName == HttpContext.Current.User.Identity.Name) && (b.coverage == false)) select b).ToList();
            trojanDrpDown.DataValueField = "nickName";
            trojanDrpDown.DataBind();
            trojanDrpDown.Items.Insert(0, new ListItem("-- Select a Trojan --", "0"));

            detectDrpDwn.DataSource = (from b in db.severityRating where ((b.userName == HttpContext.Current.User.Identity.Name) && (b.coverage == true)) select b).ToList();
            detectDrpDwn.DataValueField = "nickName";
            detectDrpDwn.DataBind();
            detectDrpDwn.Items.Insert(0, new ListItem("-- Select a Method --", "0"));
        }

        protected void deleteTrojanBtn_Click(object sender, EventArgs e)
        {
            var virus = db.Virus.Where(c => (c.virusNickName == trojanDrpDown.SelectedValue)).FirstOrDefault();
            string virusId = virus.virusId;

            db.Virus.Remove(virus);
            var items = db.Virus_Item.Where(c => c.VirusId == virusId).ToList();
            foreach(var I in items)
            {
                db.Virus_Item.Remove(I);
            }

            var rating = db.severityRating.Where(c => (c.VirusId == virusId)).ToList();
            foreach(var R in rating)
            {
                db.severityRating.Remove(R);
            }
            db.SaveChanges();
            populate();
        }

        protected void dtcnDeleteBtn_Click(object sender, EventArgs e)
        {
            
            var rating = db.severityRating.Where(c => (c.nickName == detectDrpDwn.SelectedValue) && (c.userName == HttpContext.Current.User.Identity.Name)).FirstOrDefault();
            db.severityRating.Remove(rating);
            db.SaveChanges();
            populate();
        }
    }
}