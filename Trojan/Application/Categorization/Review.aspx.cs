using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Trojan.Application.Categorization.Application
{
    public partial class Review : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string virusName = PreviousPage.getSelectedVirus;
            label1.Text = virusName;
            displayVirus(virusName);
        }

        private void displayVirus(string virusName)
        {

        }
    }
}