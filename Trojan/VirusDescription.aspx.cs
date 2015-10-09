using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Trojan.Models;
using Trojan.Logic;
using System.Collections.Specialized;
using System.Collections;
using System.Web.ModelBinding;
using Newtonsoft.Json;

namespace Trojan
{
    public partial class VirusDescription : System.Web.UI.Page
    {
        bool isBuilt;
        TrojanContext db = new TrojanContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            using (VirusDescriptionActions usersVirus = new VirusDescriptionActions())
            {
                int totalNumberofAttributes = 0;
                int totalF_in = 0;
                int totalF_out = 0;
                //Built = false;
                //Built = getBuiltStatus();
                totalNumberofAttributes = usersVirus.GetCount();
                totalF_in = usersVirus.getTotalF_in();
                totalF_out = usersVirus.getTotalF_out();
                if (!getBuiltStatus())
                {
                    abstractionNone.Visible = abstractionGrid.Visible = abstractionResults.Visible = false;
                    directNone.Visible = direct.Visible = directGrid.Visible = false;
                    indirectNone.Visible = indirectGrid.Visible = indirect.Visible = false;
                    ColumnGrid.Visible = ColumnResults.Visible = false;
                    RowGrid.Visible = RowResults.Visible = false;
                    notes.Visible = false;
                    ConnectionsResults.Visible = false;
                    ConnectionsGrid.Visible = false;
                    LocationGrid.Visible = Locationlbl.Visible = false;
                    //visJumboContainer.Visible = false;
                    notBuilt.Visible = false;
                    abstractionEmpty.Visible = false;
                }
                if (totalNumberofAttributes > 0)
                {
                    // Display Total.
                    VirusDescriptionTitle.Visible = true;
                    NoSelected.Visible = false;
                    UpdateBtn.Visible = true;
                    BuildCombo.Visible = true;
                    BuildRow.Visible = true;
                    BuildCol.Visible = true;
                    ClearBtn.Visible = true;
                    notes.Visible = false;
                    canNot.Visible = false;
                    buttonTable.Visible = true;
                    abstractionEmpty.Visible = false;
                    lblTotal.Text = String.Format("{0:d}", totalNumberofAttributes);
                    VirusDescriptionTitle.InnerText = "Current Virus Total";
                    if (totalF_in > 0)
                    {
                        lblTotalF_in.Text = String.Format("{0:d}", totalF_in);
                    }
                    else
                    {
                        lblTotalF_in.Text = "0";
                    }
                    if (totalF_out > 0)
                    {
                        lblTotalF_out.Text = String.Format("{0:d}", totalF_out);
                    }
                    else
                    {
                        lblTotalF_out.Text = "0";
                    }
                }
                else
                {
                    VirusDescriptionTitle.Visible = false;
                    NoSelected.Visible = true;
                    LabelTotalText.Text = "";
                    lblTotal.Text = "";
                    LabelTotalF_in.Text = "";
                    lblTotalF_in.Text = "";
                    LabelTotalF_out.Text = "";
                    lblTotalF_out.Text = "";
                    buttonTable.Visible = false;
                    UpdateBtn.Visible = false;
                    BuildCombo.Visible = false;
                    BuildRow.Visible = false;
                    BuildCol.Visible = false;
                    ClearBtn.Visible = false;
                    canNot.Visible = false;
                    notes.Visible = false;
                    abstractionNone.Visible = abstractionResults.Visible = abstractionGrid.Visible = false;
                    directNone.Visible = direct.Visible = directGrid.Visible = false;
                    indirectNone.Visible = indirectGrid.Visible = indirect.Visible = false;
                    RowResults.Visible = RowGrid.Visible = false;
                    ColumnResults.Visible = ColumnGrid.Visible = false;
                    ConnectionsResults.Visible = false;
                    ConnectionsGrid.Visible = false;
                    LocationGrid.Visible = Locationlbl.Visible = false;
                }
            }
        }
        private bool getBuiltStatus()
        {
            return isBuilt;
        }
        private void setBuilt(bool V)
        {
            isBuilt = V;
        }
        public List<Virus_Item> GetVirusDescription()
        {
            VirusDescriptionActions actions = new VirusDescriptionActions();
            return actions.GetDescriptionItems();
        }

        public List<Virus_Item> UpdateCartItems()
        {
            //using (VirusDescriptionActions usersShoppingCart = new VirusDescriptionActions())
            //{
            using (VirusDescriptionActions usersVirus = new VirusDescriptionActions())
            {
                String virusId = usersVirus.GetVirusId();
                int total = usersVirus.GetCount();
                if (total > 0)
                {
                    VirusDescriptionActions.VirusDescriptionUpdates[] cartUpdates = new VirusDescriptionActions.VirusDescriptionUpdates[DescriptionList.Rows.Count];
                    for (int i = 0; i < DescriptionList.Rows.Count; i++)
                    {
                        IOrderedDictionary rowValues = new OrderedDictionary();
                        rowValues = GetValues(DescriptionList.Rows[i]);
                        cartUpdates[i].AttributeId = Convert.ToInt32(rowValues["AttributeId"]);

                        CheckBox cbRemove = new CheckBox();
                        cbRemove = (CheckBox)DescriptionList.Rows[i].FindControl("Remove");
                        cartUpdates[i].RemoveItem = cbRemove.Checked;

                        CheckBox cbOnOff = new CheckBox();
                        cbOnOff = (CheckBox)DescriptionList.Rows[i].FindControl("On_Off_CheckBox");
                        if (cbOnOff.Checked == true) //Check to see if On/off is checked
                        {
                            if (usersVirus.Get_OnOff(virusId, cartUpdates[i].AttributeId) == true) //If checked and currently on, turn off
                            {
                                cartUpdates[i].OnOff = false;
                            }
                            else //If checked and currently off, turn on
                            {
                                cartUpdates[i].OnOff = true;
                            }
                            //cartUpdates[i].OnOff = cbOnOff.Checked;
                        }
                        else //if not checked, query DB for previous state
                        {
                            cartUpdates[i].OnOff = usersVirus.Get_OnOff(virusId, cartUpdates[i].AttributeId);
                        }
                        
                        
                    }
                    usersVirus.UpdateVirusDescriptionDatabase(virusId, cartUpdates);
                    DescriptionList.DataBind();
                    total = usersVirus.GetCount();
                    if (total == 0)
                    {
                        //noneSelected();
                        return usersVirus.GetDescriptionItems();
                    }
                    else
                    {
                        lblTotal.Text = String.Format("{0:d}", usersVirus.GetCount());
                        lblTotalF_in.Text = String.Format("{0:d}", usersVirus.getTotalF_in());
                        lblTotalF_out.Text = String.Format("{0:d}", usersVirus.getTotalF_out());
                        return usersVirus.GetDescriptionItems();
                    }
                }
                else
                {
                    noneSelected();
                    return usersVirus.GetDescriptionItems();
                }
            }
        }

        public static IOrderedDictionary GetValues(GridViewRow row)
        {
            IOrderedDictionary values = new OrderedDictionary();
            foreach (DataControlFieldCell cell in row.Cells)
            {
                if (cell.Visible)
                {
                    // Extract values from the cell.
                    cell.ContainingField.ExtractValuesFromCell(values, cell, row.RowState, true);
                }
            }
            return values;
        }

        //query the db for a single attribute
        private Trojan.Models.Attribute getAttribute(int ID)
        {
            return db.Attributes.Where(b => b.AttributeId == ID).FirstOrDefault();
        }
        private Trojan.Models.Matrix_Cell getCell(int row, int col)
        {
            return db.Matrix_Cell.Where(b => (b.RowId == row) && (b.ColumnId == col)).FirstOrDefault();
        }

        private Trojan.Models.Category getCategory(int ID)
        {
            return db.Categories.Where(b => b.CategoryId == ID).FirstOrDefault();
        }
        private Trojan.Models.Category getCategoryFromAttr(int attr_ID)
        {
            int ID = getAttribute(attr_ID).CategoryId;
            return db.Categories.Where(b => b.CategoryId == ID).FirstOrDefault();
        }
        private void CategoryCheck(string virusId)
        {
            List<Virus_Item> V_Items = new List<Virus_Item>();
            try
            {
                var y = from b in db.Virus_Item where (b.VirusId == virusId) select b;
                V_Items = y.ToList().OrderBy(p => p.AttributeId).ToList();
            }
            catch (Exception exp)
            {
                throw new Exception("ERROR: Fail on Category Check", exp);
            }
            foreach (Virus_Item X in V_Items)
            {
                if (X.Category == null)
                {
                    X.Category = getCategoryFromAttr(X.AttributeId);
                }
            }
            db.SaveChanges();
        }

        //Scan the row and return all column ID's with value 1
        private List<Matrix_Cell> scanRowTrue(int rowNum, string subM)
        {
            //Scan row in specific subMatrix
            if (subM != null)
            {
                var X = from b in db.Matrix_Cell where (b.RowId == rowNum) && (b.submatrix == subM) && (b.value == true) select b;
                return X.ToList();
            }
            //Scan entire row
            else
            {
                var X = from b in db.Matrix_Cell where (b.RowId == rowNum) && (b.value == true) select b;
                return X.ToList();
            }
            
        }

        //Return all of the matrix cells in a particulat column that are in a particular submatrix
        private List<Matrix_Cell> scanColumnTrue(int Id, string subM)
        {
            if (subM != null)
            {
                var X = from b in db.Matrix_Cell where (b.ColumnId == Id) && (b.submatrix == subM) && (b.value == true) select b;
                return X.ToList();
            }
            else
            {
                var X = from b in db.Matrix_Cell where (b.ColumnId == Id) && (b.value == true) select b;
                return X.ToList();
            }
            
        }

        //Scan the row and return all column ID's
        private List<Matrix_Cell> getRow(int rowNum, string subM)
        {
            //Scan row in specific subMatrix
            if (subM != null)
            {
                var X = from b in db.Matrix_Cell where (b.RowId == rowNum) && (b.submatrix == subM) select b;
                return X.ToList();
            }
            //Scan entire row
            else
            {
                var X = from b in db.Matrix_Cell where (b.RowId == rowNum) select b;
                return X.ToList();
            }
        }

        //Return all of the matrix cells in a particulat column that are in a particular submatrix
        private List<Matrix_Cell> getColumn(int Id, string subM)
        {
            if (subM != null)
            {
                var X = from b in db.Matrix_Cell where (b.ColumnId == Id) && (b.submatrix == subM) select b;
                return X.ToList();
            }
            else
            {
                var X = from b in db.Matrix_Cell where (b.ColumnId == Id) select b;
                return X.ToList();
            }

        }

        protected void UpdateBtn_Click(object sender, EventArgs e)
        {
            abstractionGrid.Visible = abstractionResults.Visible = false;
            directNone.Visible = direct.Visible = directGrid.Visible = false;
            indirectNone.Visible = indirectGrid.Visible = indirect.Visible = false;
            ColumnGrid.Visible = ColumnResults.Visible = false;
            RowGrid.Visible = RowResults.Visible = false;
            
            using (VirusDescriptionActions usersVirus = new VirusDescriptionActions())
            {
                usersVirus.CleanVirus();
                string id = usersVirus.GetVirusId();
                UpdateCartItems();
                int total = usersVirus.GetCount();
                if (usersVirus.GetCount() > 0)
                {
                    VirusDescriptionTitle.InnerText = "Current Virus Total";
                }
                else
                {
                    noneSelected();
                    setBuilt(false);
                }
            }
        }

        private void noneSelected()
        {
            using (VirusDescriptionActions usersVirus = new VirusDescriptionActions())
            {
                setBuilt(false);
                usersVirus.EmptyVirus();
                DescriptionList.DataSource = null;
                DescriptionList.DataBind();
                VirusDescriptionTitle.Visible = false;
                NoSelected.Visible = true;
                labels.Visible = false;
                LabelTotalText.Visible = lblTotal.Visible = false;
                LabelTotalF_in.Visible = lblTotalF_in.Visible = false;
                LabelTotalF_out.Visible = lblTotalF_out.Visible = false;
                buttonTable.Visible = false;
                UpdateBtn.Visible = false;
                BuildCombo.Visible = false;
                BuildRow.Visible = false;
                BuildCol.Visible = false;
                ClearBtn.Visible = false;
                canNot.Visible = false;
                abstractionNone.Visible = abstractionNone.Visible = abstractionResults.Visible = abstractionGrid.Visible = false;
                directNone.Visible = direct.Visible = directGrid.Visible = false;
                indirectNone.Visible = indirectGrid.Visible = indirect.Visible = false;
                RowResults.Visible = RowGrid.Visible = false;
                ColumnResults.Visible = ColumnGrid.Visible = false;
                ConnectionsResults.Visible = false;
                ConnectionsGrid.Visible = false;
                LocationGrid.Visible = Locationlbl.Visible = false;                
            }
        }

        protected void ClearBtn_Click(object sender, EventArgs e)
        {
            noneSelected();
        }

        protected void BuildComboBtn_Click(object sender, EventArgs e)
        {
            ColumnGrid.Visible = ColumnResults.Visible = false;
            LocationGrid.Visible = Locationlbl.Visible = false;
            RowGrid.Visible = RowResults.Visible = false;
            notes.Visible = false;
            List<int> abstraction = new List<int>();
            List<int> removed = new List<int>();
            List<int> removed2 = new List<int>();
            List<int> R34_Results = new List<int>();
            List<Trojan.Models.Attribute> Direct_Insertion = new List<Trojan.Models.Attribute>();
            List<Trojan.Models.Attribute> Indirect_Insertion = new List<Trojan.Models.Attribute>();
            List<Trojan.Models.Attribute> R2_Abstraction_Output = new List<Trojan.Models.Attribute>();
            List<Trojan.Models.Attribute> PropertiesList = new List<Trojan.Models.Attribute>();
            List<Matrix_Cell> tempRow = new List<Matrix_Cell>();
            List<Connection> Connections = new List<Connection>();
            string virusId;
            using (VirusDescriptionActions usersVirus = new VirusDescriptionActions())
            {
                usersVirus.CleanVirus();
                int total = usersVirus.GetOnCount();
                if (total > 0)
                {
                    setBuilt(true);
                    virusId = usersVirus.GetVirusId();
                    List<Matrix_Cell> colTrue = new List<Matrix_Cell>();
                    VirusDescriptionActions.VirusDescriptionUpdates[] currentBuild = new VirusDescriptionActions.VirusDescriptionUpdates[DescriptionList.Rows.Count];
                    for (int i = 0; i < DescriptionList.Rows.Count; i++)
                    {
                        IOrderedDictionary rowValues = new OrderedDictionary();
                        rowValues = GetValues(DescriptionList.Rows[i]);
                        currentBuild[i].AttributeId = Convert.ToInt32(rowValues["AttributeId"]);
                        PropertiesList.Add(getAttribute(currentBuild[i].AttributeId));

                        //If current attribute is turned on
                        if (usersVirus.Get_OnOff(virusId, currentBuild[i].AttributeId))
                        {
                            colTrue = getColumn(currentBuild[i].AttributeId, "R23");
                            foreach (Matrix_Cell N in colTrue)
                            {
                                if (!abstraction.Contains(N.RowId) && N.value == true)
                                {
                                    if (!removed.Contains(N.RowId))
                                    {
                                        abstraction.Add(N.RowId);
                                    }
                                }
                                //A new attribute may remove a value from comboBuild
                                else if (abstraction.Contains(N.RowId) && N.value == false)
                                {
                                    abstraction.Remove(N.RowId);
                                }
                                else
                                {
                                    //Do Nothing
                                }
                                if (N.value == false && !removed.Contains(N.RowId))
                                {
                                    removed.Add(N.RowId);
                                }
                            }
                            //=========== Find R34 Values ==============//
                            tempRow = getRow(currentBuild[i].AttributeId, "R34");
                            foreach (Matrix_Cell W in tempRow)
                            {
                                if (W.value == false)
                                {
                                    removed2.Add(W.ColumnId);
                                    if (R34_Results.Contains(W.ColumnId))
                                    {
                                        R34_Results.Remove(W.ColumnId);
                                    }
                                }
                                if (!removed2.Contains(W.ColumnId) && !R34_Results.Contains(W.ColumnId) && W.value == true)
                                {
                                    R34_Results.Add(W.ColumnId);
                                }
                            }
                        }
                    }
                    if (abstraction.Count != 0)
                    {
                        //For combination trojans all of the properties attributes have now been looked at
                        //The resulting life cycle or abstraction properties found from submatrix R23 are stored in list abstraction
                        //Start Building Connections
                        List<Matrix_Cell> R2 = new List<Matrix_Cell>();
                        List<Matrix_Cell> R1 = new List<Matrix_Cell>();
                        List<Matrix_Cell> R12 = new List<Matrix_Cell>();
                        List<Matrix_Cell> tempCols = new List<Matrix_Cell>();
                        List<Matrix_Cell> tempCols2 = new List<Matrix_Cell>();

                        foreach (int A in abstraction)
                        {
                            R2_Abstraction_Output.Add(getAttribute(A));
                        }
                        Trojan.Models.Attribute tempAttribute = new Trojan.Models.Attribute();
                        abstraction.OrderByDescending(i => i);
                        int Max = abstraction.Max();
                        for (int i = Max; i > 0; --i)
                        {
                            tempCols = scanColumnTrue(i, null);
                            foreach(Matrix_Cell X in tempCols){
                                //Direct Connection
                                if ((X.submatrix == "R12") && ((X.RowId) != (i - 1)))
                                {
                                    if (!Connection_Check(Connections, X.RowId, X.ColumnId, true, virusId))
                                    {
                                        Connections.Add(new Connection(X.RowId, X.ColumnId, true, virusId));
                                    }
                                    if (!Attribute_Check(Direct_Insertion, X.RowId))
                                    {
                                        Direct_Insertion.Add(getAttribute(X.RowId));
                                    }
                                }
                                //Step Connection
                                else
                                {
                                    if (!Connection_Check(Connections, X.RowId, X.ColumnId, false, virusId))
                                    {
                                        Connections.Add(new Connection(X.RowId, X.ColumnId, false, virusId));
                                    }
                                    if (!Attribute_Check(Indirect_Insertion, X.RowId))
                                    {
                                        Indirect_Insertion.Add(getAttribute(X.RowId));
                                    }
                                }
                            }
                        }

                        R2.Clear(); R1.Clear(); R12.Clear();
                        if (Direct_Insertion.Count > 0)
                        {
                            directGrid.DataSource = Attribute_Sorting(Direct_Insertion);
                            directGrid.DataBind();
                            direct.Visible = directGrid.Visible = true;
                            directNone.Visible = false;
                        }
                        else
                        {
                            directNone.Visible = true;
                            direct.Visible = false;
                            notes.Visible = true;
                        }
                        if (Indirect_Insertion.Count > 0)
                        {
                            indirectGrid.DataSource = Attribute_Sorting(Indirect_Insertion);
                            indirectGrid.DataBind();
                            indirect.Visible = indirectGrid.Visible = false;
                            indirectNone.Visible = false;
                        }
                        else
                        {
                            indirectNone.Visible = true;
                            indirect.Visible = false;
                            notes.Visible = true;
                        }
                        if (R2_Abstraction_Output.Count > 0)
                        {
                            abstractionGrid.DataSource = Attribute_Sorting(R2_Abstraction_Output);
                            abstractionGrid.DataBind();
                            abstractionGrid.Visible = abstractionResults.Visible = true;
                            abstractionNone.Visible = false;
                        }
                        else
                        {
                            abstractionNone.Visible = true;
                            abstractionResults.Visible = false;
                            notes.Visible = true;
                        }
                        if (Connections.Count > 0)
                        {
                            ConnectionsGrid.DataSource = Connection_Sorting(Connections);
                            ConnectionsGrid.DataBind();
                            ConnectionsResults.Visible = false;
                            ConnectionsGrid.Visible = false;
                        }
                        else
                        {
                            ConnectionsResults.Visible = false;
                            ConnectionsGrid.Visible = false;
                        }
                        List<Models.Attribute> Locations = new List<Models.Attribute>();
                        if (R34_Results.Count > 0)
                        {
                            foreach (int u in R34_Results)
                            {
                                Locations.Add(getAttribute(u));
                            }
                            LocationGrid.Visible = Locationlbl.Visible = true;
                            LocationGrid.DataSource = Locations;
                            LocationGrid.DataBind();
                        }
                        else
                        {
                            LocationGrid.Visible = Locationlbl.Visible = false;
                        }

                        //Add the connections to the DB
                        foreach (Connection Q in Connections)
                        {
                            db.Connections.Add(Q);
                        }

                        //Add the Locations to the Virus_Item table
                        foreach (Models.Attribute X in Locations)
                        {
                            db.Virus_Item.Add(new Virus_Item(virusId, X.AttributeId, X, getCategory(X.CategoryId), false));
                        }
                        List<Node> Nodes = edgesToNodes(Connections);
                        foreach (Node N in Nodes)
                        {
                            db.Virus_Item.Add(new Virus_Item(virusId, N.nodeID, getAttribute(N.nodeID), getCategoryFromAttr(N.nodeID), false));
                        }
                    
                        db.SaveChanges();
                        CategoryCheck(virusId);
                    }
                    else
                    {
                        setBuilt(false);
                        notes.Visible = true;
                        canNot.Visible = false;
                        abstractionEmpty.Visible = true;
                        abstractionNone.Visible = abstractionNone.Visible = abstractionResults.Visible = abstractionGrid.Visible = false;
                        directNone.Visible = direct.Visible = directGrid.Visible = false;
                        indirectNone.Visible = indirectGrid.Visible = indirect.Visible = false;
                        RowResults.Visible = RowGrid.Visible = false;
                        ColumnResults.Visible = ColumnGrid.Visible = false;
                    }
                }
                //Total <= 0
                else
                {
                    setBuilt(false);
                    notes.Visible = true;
                    canNot.Visible = true;
                    abstractionNone.Visible = abstractionNone.Visible = abstractionResults.Visible = abstractionGrid.Visible = false;
                    directNone.Visible = direct.Visible = directGrid.Visible = false;
                    indirectNone.Visible = indirectGrid.Visible = indirect.Visible = false;
                    RowResults.Visible = RowGrid.Visible = false;
                    ColumnResults.Visible = ColumnGrid.Visible = false;
                }
            }
        }
        protected void BuildRowBtn_Click(object sender, EventArgs e)
        {
            abstractionGrid.Visible = abstractionResults.Visible = false;
            directNone.Visible = direct.Visible = directGrid.Visible = false;
            indirectNone.Visible = indirectGrid.Visible = indirect.Visible = false;
            ConnectionsResults.Visible = false;
            ConnectionsGrid.Visible = false;
            ColumnGrid.Visible = ColumnResults.Visible = false;
            RowGrid.Visible = RowResults.Visible = true;
            using (VirusDescriptionActions usersVirus = new VirusDescriptionActions())
            {
                setBuilt(true);
                int total = usersVirus.GetOnCount();
                if (total > 0)
                {
                    List<Matrix_Cell> rowTrue = new List<Matrix_Cell>();
                    var removedSet = new HashSet<int>();
                    List<int> resultsInt = new List<int>();
                    List<Trojan.Models.Attribute> results = new List<Trojan.Models.Attribute>();
                    Trojan.Models.Attribute temp = new Trojan.Models.Attribute();
                    String virusId = usersVirus.GetVirusId();
                    VirusDescriptionActions.VirusDescriptionUpdates[] currentBuild = new VirusDescriptionActions.VirusDescriptionUpdates[DescriptionList.Rows.Count];
                    for (int i = 0; i < DescriptionList.Rows.Count; i++)
                    {
                        IOrderedDictionary rowValues = new OrderedDictionary();
                        rowValues = GetValues(DescriptionList.Rows[i]);
                        currentBuild[i].AttributeId = Convert.ToInt32(rowValues["AttributeId"]);

                        if (usersVirus.Get_OnOff(virusId, currentBuild[i].AttributeId))
                        {
                            rowTrue = getRow(currentBuild[i].AttributeId, null);
                            foreach (Matrix_Cell A in rowTrue)
                            {
                                if (A.value == false)
                                {
                                    removedSet.Add(A.ColumnId);
                                    if (resultsInt.Contains(A.ColumnId))
                                    {
                                        resultsInt.Remove(A.ColumnId);
                                    }
                                }
                                if ((A.value == true) && (!removedSet.Contains(A.ColumnId)) && (!resultsInt.Contains(A.ColumnId)))
                                {
                                    resultsInt.Add(A.ColumnId);
                                }
                            }
                        }
                    }
                    foreach (int X in resultsInt)
                    {
                        results.Add(getAttribute(X));
                    }
                    RowGrid.DataSource = Attribute_Sorting(results);
                    RowGrid.DataBind();
                }
                else
                {
                    notes.Visible = true;
                    canNot.Visible = true;
                    abstractionNone.Visible = abstractionNone.Visible = abstractionResults.Visible = abstractionGrid.Visible = false;
                    directNone.Visible = direct.Visible = directGrid.Visible = false;
                    indirectNone.Visible = indirectGrid.Visible = indirect.Visible = false;
                    RowResults.Visible = RowGrid.Visible = false;
                    ColumnResults.Visible = ColumnGrid.Visible = false; 
                }
            }
        }
        protected void BuildColumnBtn_Click(object sender, EventArgs e)
        {
            
            abstractionGrid.Visible = abstractionResults.Visible = false;
            directNone.Visible = direct.Visible = directGrid.Visible = false;
            indirectNone.Visible = indirectGrid.Visible = indirect.Visible = false;
            ConnectionsResults.Visible = false;
            ConnectionsGrid.Visible = false;
            ColumnGrid.Visible = ColumnResults.Visible = true;
            RowGrid.Visible = RowResults.Visible = false;
            Trojan.Models.Attribute temp = new Trojan.Models.Attribute();
            List<Matrix_Cell> colTrue = new List<Matrix_Cell>();
            using (VirusDescriptionActions usersVirus = new VirusDescriptionActions())
            {
                setBuilt(true);
                int total = usersVirus.GetOnCount();
                if (total > 0)
                {
                    List<Trojan.Models.Attribute> results = new List<Trojan.Models.Attribute>();
                    var removedSet = new HashSet<int>();
                    List<int> resultsInt = new List<int>();
                    String virusId = usersVirus.GetVirusId();
                    VirusDescriptionActions.VirusDescriptionUpdates[] currentBuild = new VirusDescriptionActions.VirusDescriptionUpdates[DescriptionList.Rows.Count];
                    for (int i = 0; i < DescriptionList.Rows.Count; i++)
                    {
                        IOrderedDictionary rowValues = new OrderedDictionary();
                        rowValues = GetValues(DescriptionList.Rows[i]);
                        currentBuild[i].AttributeId = Convert.ToInt32(rowValues["AttributeId"]);

                        if (usersVirus.Get_OnOff(virusId, currentBuild[i].AttributeId))
                        {
                            colTrue = getColumn(currentBuild[i].AttributeId, null);
                            foreach (Matrix_Cell A in colTrue)
                            {
                                if (A.value == false)
                                {
                                    removedSet.Add(A.RowId);
                                    if (resultsInt.Contains(A.RowId))
                                    {
                                        resultsInt.Remove(A.RowId);
                                    }
                                }
                                if ((A.value == true) && (!removedSet.Contains(A.RowId)) && (!resultsInt.Contains(A.RowId)))
                                {
                                    resultsInt.Add(A.RowId);
                                }
                            }
                        }
                    }
                    foreach (int X in resultsInt)
                    {
                        results.Add(getAttribute(X));
                    }
                    ColumnGrid.DataSource = Attribute_Sorting(results);
                    ColumnGrid.DataBind();
                }
                else
                {
                    notes.Visible = true;
                    canNot.Visible = true;
                    abstractionNone.Visible = abstractionNone.Visible = abstractionResults.Visible = abstractionGrid.Visible = false;
                    directNone.Visible = direct.Visible = directGrid.Visible = false;
                    indirectNone.Visible = indirectGrid.Visible = indirect.Visible = false;
                    RowResults.Visible = RowGrid.Visible = false;
                    ColumnResults.Visible = ColumnGrid.Visible = false; 
                } 
            }
        }
        protected List<Connection> Connection_Sorting(List<Connection> List)
        {
            List<Connection> SortedList = List.OrderBy(p => p.source).ThenBy(c => c.target).ToList();
            return SortedList;
        }
        protected List<Trojan.Models.Attribute> Attribute_Sorting(List<Trojan.Models.Attribute> List)
        {
            List<Trojan.Models.Attribute> SortedList = List.OrderBy(p => p.AttributeId).ToList();
            return SortedList;
        }
        protected bool Connection_Check(List<Connection> List, int source_, int dest, bool TF, string virusId){
            foreach(Connection X in List){
                if (X.source == source_ && X.target == dest && X.VirusId == virusId) return true;
            }
            return false;
        }
        protected bool Attribute_Check(List<Trojan.Models.Attribute> List, int Y)
        {
            foreach (Trojan.Models.Attribute X in List)
            {
                if (X.AttributeId == Y) return true;
            }
            return false;
        }
        
        //Checks to see if the list of nodes containts the Id Y
        protected bool NodeCheck(List<Node> Nodes, int Y)
        {
            foreach (Node X in Nodes)
            {
                if (X.nodeID == Y) return true;
            }
            return false;
        }
        
        //Takes the list of connections generated and returns a list of all the nodes
        private List<Node> edgesToNodes(List<Connection> Connections)
        {
            List<Node> Nodes = new List<Node>();
            Trojan.Models.Attribute tempAttribute;
            foreach (Connection F in Connections)
            {
                
                if (!NodeCheck(Nodes, F.source))
                {
                    tempAttribute = getAttribute(F.source);
                    if (F.source <= 5) Nodes.Add(new Node(F.source, tempAttribute.AttributeName, "Chip Life Cycle", tempAttribute.F_in, tempAttribute.F_out));
                    else if ((5 < F.source) && (F.source <= 11)) Nodes.Add(new Node(F.source, tempAttribute.AttributeName, "Abstraction", tempAttribute.F_in, tempAttribute.F_out));
                    else if ((11 < F.source) && (F.source <= 28)) Nodes.Add(new Node(F.source, tempAttribute.AttributeName, "Properties", tempAttribute.F_in, tempAttribute.F_out));
                    else
                    {
                        Nodes.Add(new Node(F.source, tempAttribute.AttributeName, "Location", tempAttribute.F_in, tempAttribute.F_out));
                    }
                }
                if (!NodeCheck(Nodes, F.target))
                {
                    tempAttribute = getAttribute(F.target);
                    if (F.target <= 5) Nodes.Add(new Node(F.target, tempAttribute.AttributeName, "Chip Life Cycle", tempAttribute.F_in, tempAttribute.F_out));
                    else if ((5 < F.target) && (F.target <= 11)) Nodes.Add(new Node(F.target, tempAttribute.AttributeName, "Abstraction", tempAttribute.F_in, tempAttribute.F_out));
                    else if ((11 < F.target) && (F.target <= 28)) Nodes.Add(new Node(F.target, tempAttribute.AttributeName, "Properties", tempAttribute.F_in, tempAttribute.F_out));
                    else
                    {
                        Nodes.Add(new Node(F.target, tempAttribute.AttributeName, "Location", tempAttribute.F_in, tempAttribute.F_out));
                    }
                }
            }
            return Nodes.OrderBy(p => p.nodeID).ToList();
        }
        
        protected void VisualizeBtn_Click(object sender, EventArgs e)
        {
            string virusId;
            List<Connection> Connections = new List<Connection>();
            List<Models.Virus_Item> V_Items = new List<Models.Virus_Item>();
            List<Node> Nodes = new List<Node>();
            using (VirusDescriptionActions usersVirus = new VirusDescriptionActions())
            {
                virusId = usersVirus.GetVirusId();
            }
            try
            {
                if (db.Connections.Any(o => o.VirusId == virusId))
                {
                    try
                    {
                        var x = from b in db.Connections where (b.VirusId == virusId) select b;
                        Connections = x.ToList().OrderBy(p => p.source).ThenBy(c => c.target).ToList();
                        var y = from b in db.Virus_Item where (b.VirusId == virusId) select b;
                        V_Items = y.ToList().OrderBy(p => p.AttributeId).ToList();
                    }
                    catch (Exception exp)
                    {
                        throw new Exception("ERROR: Unable to receive Connections for this virusd - " + exp.Message.ToString(), exp);
                    }

                    foreach (Virus_Item X in V_Items)
                    {
                        Nodes.Add(new Node(X.AttributeId, X.Attribute.AttributeName, X.Category.CategoryName, X.Attribute.F_in, X.Attribute.F_out));
                    }                 
                    string json;
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
                    //var json = JsonConvert.SerializeObject(Connections);
                    //ClientScript.RegisterArrayDeclaration("data", json);
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "id", "visualize('#visrep', " + Connections.Count + "," + Nodes.Count + ")", true);
                    
                }
                else
                {
                    notes.Visible = true;
                    canNot.Visible = false;
                    notBuilt.Visible = true;
                    //visJumboContainer.Visible = false;
                    abstractionNone.Visible = abstractionNone.Visible = abstractionResults.Visible = abstractionGrid.Visible = false;
                    directNone.Visible = direct.Visible = directGrid.Visible = false;
                    indirectNone.Visible = indirectGrid.Visible = indirect.Visible = false;
                    RowResults.Visible = RowGrid.Visible = false;
                    ColumnResults.Visible = ColumnGrid.Visible = false;
                }
            }
            catch (Exception exp2)
            {
                throw new Exception("ERROR: Unable to check Edges table for content - " + exp2.Message.ToString(), exp2);
            }
        }
    }
}