﻿using System;
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
                //if (!getBuiltStatus())
                //{
                //    hideResults();
                //    //NoSelected.Visible = true;
                //}
                if (totalNumberofAttributes > 0)
                {
                    // Display Total.
                    hideResults();
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
                    noneSelected();
                    
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
                hideResults();
                NoSelected.Visible = true;
                buttonTable.Visible = false;
                UpdateBtn.Visible = false;
                BuildCombo.Visible = false;
                BuildRow.Visible = false;
                BuildCol.Visible = false;
                ClearBtn.Visible = false;
                VirusDescriptionTitle.Visible = false;
            }
        }

        private void selectionNotPossible()
        {
            noneSelected();
            NoSelected.Visible = false;
            notPossible.Visible = true;
            VirusDescriptionTitle.Visible = false;
            buttonTable.Visible = false;
            UpdateBtn.Visible = false;
            BuildCombo.Visible = false;
            BuildRow.Visible = false;
            BuildCol.Visible = false;
            ClearBtn.Visible = false;
            VisualizeBtn.Visible = false;
            startOverBtn.Visible = true;
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
            List<Trojan.Models.Attribute> PropertiesList = new List<Trojan.Models.Attribute>();
            VirusDescriptionActions.VirusDescriptionUpdates[] currentBuild = new VirusDescriptionActions.VirusDescriptionUpdates[DescriptionList.Rows.Count];
            Trojan.Models.Attribute tempAttr = new Models.Attribute();
            var categorySet = new HashSet<string>();
            string virusId = null;
            using (VirusDescriptionActions usersVirus = new VirusDescriptionActions())
            {
                usersVirus.CleanVirus();
                int total = usersVirus.GetOnCount();
                if (total > 0)
                {
                    virusId = usersVirus.GetVirusId();
                    IOrderedDictionary rowValues = new OrderedDictionary();
                    for (int i = 0; i < DescriptionList.Rows.Count; i++)
                    {
                        rowValues = GetValues(DescriptionList.Rows[i]);
                        currentBuild[i].AttributeId = Convert.ToInt32(rowValues["AttributeId"]);
                        tempAttr = getAttribute(currentBuild[i].AttributeId);
                        //If current attribute is turned on
                        if (usersVirus.Get_OnOff(virusId, currentBuild[i].AttributeId))
                        {
                            categorySet.Add(tempAttr.CategoryName);
                            PropertiesList.Add(tempAttr);
                        }
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
            PropertiesList = Attribute_Sorting(PropertiesList);
            //Contains only Properties
            if ((categorySet.Contains("Properties")) && (!categorySet.Contains("Chip Life Cycle")) && (!categorySet.Contains("Abstraction")) && (!categorySet.Contains("Location")))
            {
                backPropagation(PropertiesList, virusId);
            }
            //Contains Insertion or Abstraction but not Location of Properties
            else if (((categorySet.Contains("Chip Life Cycle")) || (categorySet.Contains("Abstraction"))) && ((!categorySet.Contains("Location")) || (!categorySet.Contains("Properties"))))
            {
                forwardPropagation(PropertiesList, virusId);
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
                    List<int> resultsInt = new List<int>();
                    List<int> userSubmitted = new List<int>();
                    List<Trojan.Models.Attribute> results = new List<Trojan.Models.Attribute>();
                    String virusId = usersVirus.GetVirusId();
                    VirusDescriptionActions.VirusDescriptionUpdates[] currentBuild = new VirusDescriptionActions.VirusDescriptionUpdates[DescriptionList.Rows.Count];
                    for (int i = 0; i < DescriptionList.Rows.Count; i++)
                    {
                        IOrderedDictionary rowValues = new OrderedDictionary();
                        rowValues = GetValues(DescriptionList.Rows[i]);
                        currentBuild[i].AttributeId = Convert.ToInt32(rowValues["AttributeId"]);
                        if (usersVirus.Get_OnOff(virusId, currentBuild[i].AttributeId))
                        {
                            userSubmitted.Add(currentBuild[i].AttributeId);
                        }
                    }
                    resultsInt = testRow(userSubmitted, null);
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
            using (VirusDescriptionActions usersVirus = new VirusDescriptionActions())
            {
                setBuilt(true);
                int total = usersVirus.GetOnCount();
                if (total > 0)
                {
                    List<Trojan.Models.Attribute> results = new List<Trojan.Models.Attribute>();
                    List<int> userSubmitted = new List<int>();
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
                            userSubmitted.Add(currentBuild[i].AttributeId);
                        }
                    }
                    resultsInt = testColumn(userSubmitted, null);
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

        private void backPropagation(List<Trojan.Models.Attribute> PropertiesList, string virusId)
        {
            List<int> propertyIDs = attrToInt(PropertiesList);
            List<int> LocationIDs = testRow(propertyIDs, "R34");
            List<int> abstractionResults = testColumn(propertyIDs, "R23");
            if (abstractionResults.Count == 0) selectionNotPossible();
            else
            {
                List<Connection> Connections = new List<Connection>();
                List<Matrix_Cell> tempCol = new List<Matrix_Cell>();
                var nodeSet = new HashSet<int>();
                bool tempDirect = false;
                int maxAbstraction = abstractionResults.Max();

                //Adds nodes in Abstraction and Insertion Category
                for (int i = maxAbstraction; i > 0; --i)
                {
                    tempCol = scanColumnTrue(i, null);
                    nodeSet.Add(i);
                    foreach (Matrix_Cell X in tempCol)
                    {
                        tempDirect = directConnection(X, i);
                        Connections.Add(new Connection(X.RowId, i, tempDirect, virusId));
                    }
                }
                List<int> Nodes = nodeSet.ToList().Concat(LocationIDs).ToList().Concat(propertyIDs).ToList();
                Nodes.Sort();
                displayResults(Nodes, Connections);
                saveToDB(Nodes, Connections, virusId);
            }
            
        }

        private void saveToDB(List<int> NodeInt, List<Connection> Edges, string virusId)
        {
            List<Models.Attribute> Nodes = intToAttr(NodeInt);
            using (VirusDescriptionActions usersVirus = new VirusDescriptionActions())
            { 
                usersVirus.EmptyVirus(); 
            }
            foreach (Connection Q in Edges)
            {
                db.Connections.Add(Q);
            }
            foreach (Models.Attribute N in Nodes)
            {
                db.Virus_Item.Add(new Virus_Item(virusId, N.AttributeId, N, getCategoryFromAttr(N.AttributeId), false));
            }
            db.SaveChanges();
        }
        private bool directConnection(Matrix_Cell X, int i)
        {
            if (Math.Abs(i - X.RowId) == 1) return false;
            else return true;
        }

        //Used when attributes chosen are all 'Insertion' or 'Abstraction'
        private void forwardPropagation(List<Trojan.Models.Attribute> PropertiesList, string virusId)
        {
            int highestAttr = PropertiesList[PropertiesList.Count - 1].AttributeId;
            int currentAttr = PropertiesList[0].AttributeId;
            Trojan.Models.Attribute tempAttr = new Models.Attribute();
            List<Connection> Connections = new List<Connection>();
            List<Matrix_Cell> tempRow = new List<Matrix_Cell>();
            List<Models.Virus_Item> V_Items = new List<Models.Virus_Item>();
            List<int> abstraction = new List<int>();
            bool tempDirect = false;
            int i = 0;
            while (currentAttr <= highestAttr)
            {
                //Add to abstraction list
                if (PropertiesList[i].CategoryName == "Abstraction")
                {
                    abstraction.Add(currentAttr);
                }

                //Create a new virus item, check if it was user chosen or not
                if (Attribute_Check(PropertiesList, currentAttr))
                {
                    tempAttr = getAttribute(currentAttr);
                    V_Items.Add(new Virus_Item(virusId, currentAttr, tempAttr, getCategoryFromAttr(currentAttr), true));
                }
                else
                {
                    tempAttr = getAttribute(currentAttr);
                    V_Items.Add(new Virus_Item(virusId, currentAttr, tempAttr, getCategoryFromAttr(currentAttr), false));
                }

                tempRow = scanRowTrue(currentAttr, "null");
                foreach (Matrix_Cell M in tempRow)
                {
                    tempDirect = false;
                    if(M.submatrix == "R12"){
                        tempDirect = true;
                    }
                    if (M.ColumnId <= highestAttr)
                    {
                        Connections.Add(new Connection(currentAttr, M.ColumnId, tempDirect, virusId));

                    }
                }

                ++currentAttr;
                ++i;
            }
            foreach (int X in abstraction)
            {
                tempRow = scanRowTrue(X, "R23");

            }
        }

        //Used when attributes chosen are a mix of all Categories
        private void mixedPropagation()
        {

        }

        private List<int> testColumn(List<int> list, string subMatrix)
        {
            List<int> resultsInt = new List<int>();
            List<Matrix_Cell> colTrue = new List<Matrix_Cell>();
            var removedSet = new HashSet<int>();
            foreach (int X in list)
            {
                colTrue = getColumn(X, subMatrix);
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
            return resultsInt;
        }
        private List<int> testRow(List<int> list, string subMatrix)
        {
            List<int> resultsInt = new List<int>();
            List<Matrix_Cell> rowTrue = new List<Matrix_Cell>();
            var removedSet = new HashSet<int>();
            foreach (int X in list)
            {
                rowTrue = getRow(X, subMatrix);
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
            return resultsInt;
        }
        
        private void displayResults(List<int> NodeInt, List<Connection> Edges){
            List<Models.Attribute> Nodes = intToAttr(NodeInt);
            if ((Nodes.Count == 0) || (Edges.Count == 0))
            {
                notes.Visible = true;
                notPossible.Visible = true;
            }
            else
            {
                nodesGrid.DataSource = Attribute_Sorting(Nodes);
                nodesGrid.DataBind();
                nodesDiv.Visible = true;
                nodesGrid.Visible = true;
                ConnectionsGrid.DataSource = Connection_Sorting(Edges);
                ConnectionsGrid.DataBind();
                ConnectionsResults.Visible = true;
                ConnectionsGrid.Visible = true;
            }
        }

        //Convert a list of attributes to a list of ints (Attribute ID)
        private List<int> attrToInt(List<Trojan.Models.Attribute> attributes)
        {
            List<int> Ints = new List<int>();
            foreach(Trojan.Models.Attribute A in attributes){
                Ints.Add(A.AttributeId);
            }
            return Ints;
        }
        private List<Models.Attribute> intToAttr(List<int> ints)
        {
            List<Models.Attribute> attrs = new List<Models.Attribute>();
            foreach (int X in ints)
            {
                attrs.Add(getAttribute(X));
            }
            return attrs;
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
        private void hideResults()
        {
            labels.Visible = false;
            NoSelected.Visible = false;
            LabelTotalText.Visible = lblTotal.Visible = false;
            LabelTotalF_in.Visible = lblTotalF_in.Visible = false;
            LabelTotalF_out.Visible = lblTotalF_out.Visible = false;
            canNot.Visible = false;
            abstractionNone.Visible = abstractionNone.Visible = abstractionResults.Visible = abstractionGrid.Visible = false;
            directNone.Visible = direct.Visible = directGrid.Visible = false;
            indirectNone.Visible = indirectGrid.Visible = indirect.Visible = false;
            RowResults.Visible = RowGrid.Visible = false;
            ColumnResults.Visible = ColumnGrid.Visible = false;
            ConnectionsResults.Visible = false;
            ConnectionsGrid.Visible = false;
            LocationGrid.Visible = Locationlbl.Visible = false;
            nodesDiv.Visible = nodesGrid.Visible = false;
            notes.Visible = abstractionEmpty.Visible = notPossible.Visible = notBuilt.Visible = false;
            jumboWrap.Visible = false;
        }
        protected void VisualizeBtn_Click(object sender, EventArgs e)
        {
            string virusId;
            hideResults();
            jumboWrap.Visible = true;
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