using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Trojan.Logic;
namespace Trojan.Application
{
    public partial class ApplicationHome : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            using (VirusDescriptionActions usersVirus = new VirusDescriptionActions())
            {
                //usersVirus.EmptyVirus();
                //usersVirus.setNewVirusId();
            }
        }
        protected void detectionBtn_Click(object sender, EventArgs e)
        {
            //using(VirusDescriptionActions usersVirus = new VirusDescriptionActions()){
            //    usersVirus.EmptyVirus();
            //}
            //Response.Redirect("~/Detection.aspx");
        }

        protected void attackBtn_Click(object sender, EventArgs e)
        {
             using(VirusDescriptionActions usersVirus = new VirusDescriptionActions()){
                usersVirus.EmptyVirus();
            }
            Response.Redirect("~/Attacks.aspx");
        }

    }
}