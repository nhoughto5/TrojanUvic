using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Trojan.Models;

namespace Trojan.Application.Categorization.Application
{
    public partial class Review : System.Web.UI.Page
    {
        TrojanContext db = new TrojanContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            string virusName = PreviousPage.getSelectedVirus;
            label1.Text = virusName;
            displayVirus(virusName);
        }

        private void displayVirus(string virusName)
        {
            Virus virus = db.Virus.First(b => b.virusNickName == virusName);
            List<Virus_Item> Virus_Items = (from b in db.Virus_Item where (b.VirusId == virus.virusId) select b).ToList();
            List<Connection> Connections = (from b in db.Connections where (b.VirusId == virus.virusId) select b).ToList();
            Virus_Items = Virus_Items.OrderBy(c => c.AttributeId).ToList();
            Visualize(Virus_Items, Connections, virus.virusId);
        }

        protected void Visualize(List<Virus_Item> V_Items, List<Connection> Connections, string virusId)
        {
            jumboWrap.Visible = true;
            List<Node> Nodes = new List<Node>();
            Models.Attribute tempAttr = null;
            foreach (Virus_Item X in V_Items)
            {
                tempAttr = getAttribute(X.AttributeId);
                Nodes.Add(new Node(tempAttr.AttributeId, tempAttr.AttributeName, getCategoryFromAttr(X.AttributeId).CategoryName, tempAttr.F_in, tempAttr.F_out, tempAttr.Description));
            }
            string json;
            json = JsonConvert.SerializeObject(virusId);
            ClientScript.RegisterArrayDeclaration("virusId", json);
            foreach (Connection Con in Connections)
            {
                json = JsonConvert.SerializeObject(Con);
                ClientScript.RegisterArrayDeclaration("edges", json);
            }
            foreach (Node N in Nodes)
            {
                json = JsonConvert.SerializeObject(N);
                ClientScript.RegisterArrayDeclaration("nod", json);
            }
            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "id", "visualize('#visrep', " + Connections.Count + "," + Nodes.Count + ")", true);
        }
        //query the db for a single attribute
        private Trojan.Models.Attribute getAttribute(int ID)
        {
            return db.Attributes.Where(b => b.AttributeId == ID).FirstOrDefault();
        }
        private Trojan.Models.Category getCategoryFromAttr(int attr_ID)
        {
            int ID = getAttribute(attr_ID).CategoryId;
            return db.Categories.Where(b => b.CategoryId == ID).FirstOrDefault();
        }
    }
}