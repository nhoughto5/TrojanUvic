using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Trojan.Models;

namespace Trojan.Application.Categorization
{
    public partial class CategorizationMain : System.Web.UI.Page
    {
        TrojanContext db = new TrojanContext();
        public string selectedVirusName;
        public string getSelectedVirus
        {
            get
            {
                return trojanDrpDown.SelectedValue;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                loadDropdown();
                trojanDrpDown.Items.Insert(0, new ListItem("-- Select a Trojan --", "0"));
            }
        }
        private void loadDropdown()
        {
            trojanDrpDown.DataSource = (from b in db.Virus where (b.userName == HttpContext.Current.User.Identity.Name) select b).ToList();
            trojanDrpDown.DataValueField = "virusNickName";
            trojanDrpDown.DataBind();
        }

        protected void trojanDrpDown_SelectedIndexChanged(object sender, EventArgs e)
        {
            trojanDrpDown.Items.Insert(0, new ListItem("-- Select a Trojan --", "0"));
            int selectd = trojanDrpDown.SelectedIndex;
            if (trojanDrpDown.SelectedIndex != 0)
            {
                selectedVirusName = trojanDrpDown.SelectedValue;
                //Response.Redirect("~/Application/Categorization/Review.aspx");
                Server.Transfer("~/Application/Categorization/Review.aspx", true);
            }
        }
    }
}