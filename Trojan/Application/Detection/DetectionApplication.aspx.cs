using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Trojan.Logic;
using Trojan.Models;

namespace Trojan.Application.Detection
{
    public partial class DetectionApplication : System.Web.UI.Page
    {
        TrojanContext db = new TrojanContext();
        List<string> iR = new List<string> { "5", "4", "3", "2", "1", "NA"};
        List<string> cR = new List<string> { "5", "4", "3", "2", "1", "NA" };
        List<string> iA = new List<string> { "6", "5", "4", "3", "2", "1", "NA" };
        List<string> cA = new List<string> { "6", "5", "4", "3", "2", "1", "NA" };
        List<string> iE = new List<string> { "F", "E", "D", "C", "B", "A", "9", "8", "7", "6", "5", "4", "3", "2", "1", "NA" };
        List<string> cE = new List<string> { "9", "8", "7", "6", "5", "4", "3", "2", "1", "NA" };
        List<string> iL = new List<string> { "3", "2", "1", "NA" };
        List<string> cL = new List<string> { "3", "2", "1", "NA" };
        List<string> iF = new List<string> { "3", "2", "1", "NA" };
        List<string> cF = new List<string> { "3", "2", "1", "NA" };
        List<string> iC = new List<string> { "7", "6", "5", "4", "3", "2", "1", "NA" };
        List<string> cC = new List<string> { "7", "6", "5", "4", "3", "2", "1", "NA" };
        List<string> iP = new List<string> { "8", "7", "6", "5", "4", "3", "2", "1", "NA" };
        List<string> cP = new List<string> { "6", "5", "4", "3", "2", "1", "NA" };
        List<string> iO = new List<string> { "V", "U", "T", "S", "R", "Q", "P", "O", "N", "M", "L", "K", "J", "I", "F", "E", "D", "C", "B", "A", "9", "8", "7", "6", "5", "4", "3", "2", "1", "NA" };
        List<string> cO = new List<string> { "5", "4", "3", "2", "1", "NA" };
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                covrgTable.Visible = true;
                populate();
                trojanDrpDwn.Items.Insert(0, new ListItem("-- Select a Trojan --", "0"));
                detectionMethodDrpDwn.Items.Insert(0, new ListItem("-- Select a Method --", "0"));
            }
        }
        protected void buildBtn_Click(object sender, EventArgs e)
        {

        }
        private void populate()
        {
            Ir_drpDwn.DataSource = iR;
            Ir_drpDwn.DataBind();

            Ia_drpDwn.DataSource = iA;
            Ia_drpDwn.DataBind();

            Ie_drpDwn.DataSource = iE;
            Ie_drpDwn.DataBind();

            Il_drpDwn.DataSource = iL;
            Il_drpDwn.DataBind();

            If_drpDwn.DataSource = iF;
            If_drpDwn.DataBind();

            Ic_drpDwn.DataSource = iC;
            Ic_drpDwn.DataBind();

            Ip_drpDwn.DataSource = iP;
            Ip_drpDwn.DataBind();

            Io_drpDwn.DataSource = iO;
            Io_drpDwn.DataBind();

            //====================//

            Cr_drpDwn.DataSource = cR;
            Cr_drpDwn.DataBind();

            Ca_drpDwn.DataSource = cA;
            Ca_drpDwn.DataBind();

            Ce_drpDwn.DataSource = cE;
            Ce_drpDwn.DataBind();

            Cl_drpDwn.DataSource = cL;
            Cl_drpDwn.DataBind();

            Cf_drpDwn.DataSource = cF;
            Cf_drpDwn.DataBind();

            Cc_drpDwn.DataSource = cC;
            Cc_drpDwn.DataBind();

            Cp_drpDwn.DataSource = cP;
            Cp_drpDwn.DataBind();

            Co_drpDwn.DataSource = cO;
            Co_drpDwn.DataBind();

            trojanDrpDwn.DataSource = (from b in db.severityRating where ((b.userName == HttpContext.Current.User.Identity.Name) && (b.coverage == false)) select b).ToList();
            trojanDrpDwn.DataValueField = "nickName";
            trojanDrpDwn.DataBind();

            detectionMethodDrpDwn.DataSource = (from b in db.severityRating where ((b.userName == HttpContext.Current.User.Identity.Name) && (b.coverage == true)) select b).ToList();
            detectionMethodDrpDwn.DataValueField = "nickName";
            detectionMethodDrpDwn.DataBind();
        }

        protected void saveBtn_Click(object sender, EventArgs e)
        {
            updateMessage.Visible = false;
            if (db.severityRating.Any(p => (p.nickName == methodNametxtbx.Text) && (p.userName == HttpContext.Current.User.Identity.Name)))
            {
                updateMessage.Visible = true;
                messageText.Text = "You already have a method with that name";
            }
            else {
                severityRating coverage = new severityRating();
                coverage.nickName = methodNametxtbx.Text;
                coverage.userName = HttpContext.Current.User.Identity.Name;
                coverage.Saved = true;
                coverage.coverage = true;
                using (VirusDescriptionActions usersVirus = new VirusDescriptionActions())
                {
                    coverage.VirusId = usersVirus.GetVirusId();
                }

                coverage.iR = Ir_drpDwn.SelectedValue;
                coverage.iA = Ia_drpDwn.SelectedValue;
                coverage.iE = Ie_drpDwn.SelectedValue;
                coverage.iL = Il_drpDwn.SelectedValue;
                coverage.iF = If_drpDwn.SelectedValue;
                coverage.iC = Ic_drpDwn.SelectedValue;
                coverage.iP = Ip_drpDwn.SelectedValue;
                coverage.iO = Io_drpDwn.SelectedValue;

                coverage.cR = Cr_drpDwn.SelectedValue;
                coverage.cA = Ca_drpDwn.SelectedValue;
                coverage.cE = Ce_drpDwn.SelectedValue;
                coverage.cL = Cl_drpDwn.SelectedValue;
                coverage.cF = Cf_drpDwn.SelectedValue;
                coverage.cC = Cc_drpDwn.SelectedValue;
                coverage.cP = Cp_drpDwn.SelectedValue;
                coverage.cO = Co_drpDwn.SelectedValue;

                db.severityRating.Add(coverage);
                db.SaveChanges();
                updateMessage.Visible = true;
                messageText.Text = "Method Rating Saved";
                detectionMethodDrpDwn.DataSource = (from b in db.severityRating where ((b.userName == HttpContext.Current.User.Identity.Name) && (b.coverage == true)) select b).ToList();
                detectionMethodDrpDwn.DataValueField = "nickName";
                detectionMethodDrpDwn.DataBind();
                detectionMethodDrpDwn.Items.Insert(0, new ListItem("-- Select a Method --", "0"));
            }

        }

        private int stringToIntCmpr(string input)
        {
            switch (input)
            {
                case "1":
                    return 1;
                case "2":
                    return 2;
                case "3":
                    return 3;
                case "4":
                    return 4;
                case "5":
                    return 5;
                case "6":
                    return 6;
                case "7":
                    return 7;
                case "8":
                    return 8;
                case "9":
                    return 8;
                case "A":
                    return 10;
                case "B":
                    return 11;
                case "C":
                    return 12;
                case "D":
                    return 13;
                case "E":
                    return 14;
                case "F":
                    return 15;
                case "G":
                    return 16;
                case "H":
                    return 17;
                case "I":
                    return 18;
                case "J":
                    return 19;
                case "K":
                    return 20;
                case "L":
                    return 21;
                case "M":
                    return 22;
                case "N":
                    return 23;
                case "O":
                    return 24;
                case "P":
                    return 25;
                case "Q":
                    return 26;
                case "R":
                    return 27;
                case "S":
                    return 28;
                case "T":
                    return 29;
                case "U":
                    return 30;
                case "V":
                    return 31;
                default:
                    return 0;
                    
            }
        }


        //Returns true if coverage method covers the trojan value
        private bool trjnDtcnCompare(string trojan, string detection)
        {
            int T = stringToIntCmpr(trojan);
            int D = stringToIntCmpr(detection);

            if (D >= T) return true;
            else return false;
        }

        private bool isNumber(string trojan, string detection)
        {
            if (trojan == "NA" || detection == "NA")
            {
                return false;
            }
            else return true;
        }
        private void clearResults()
        {
            resultLblIr.InnerText = "";
            resultLblIa.InnerText = "";
            resultLblIe.InnerText = "";
            resultLblIl.InnerText = "";
            resultLblIf.InnerText = "";
            resultLblIc.InnerText = "";
            resultLblIp.InnerText = "";
            resultLblIo.InnerText = "";

            resultLblCr.InnerText = "";
            resultLblCa.InnerText = "";
            resultLblCe.InnerText = "";
            resultLblCl.InnerText = "";
            resultLblCf.InnerText = "";
            resultLblCc.InnerText = "";
            resultLblCp.InnerText = "";
            resultLblCo.InnerText = "";
        }
        private void clearTrojan()
        {
            trjnCelliR_lbl.InnerText = "";
            trjnCelliA_lbl.InnerText = "";
            trjnCelliE_lbl.InnerText = "";
            trjnCelliL_lbl.InnerText = "";
            trjnCelliF_lbl.InnerText = "";
            trjnCelliC_lbl.InnerText = "";
            trjnCelliP_lbl.InnerText = "";
            trjnCelliO_lbl.InnerText = "";

            trjnCellcR_lbl.InnerText = "";
            trjnCellcA_lbl.InnerText = "";
            trjnCellcE_lbl.InnerText = "";
            trjnCellcL_lbl.InnerText = "";
            trjnCellcF_lbl.InnerText = "";
            trjnCellcC_lbl.InnerText = "";
            trjnCellcP_lbl.InnerText = "";
            trjnCellcO_lbl.InnerText = "";
        }

        private void clearDetection()
        {
            dtctnCelliR_lbl.InnerText = "";
            dtctnCelliA_lbl.InnerText = "";
            dtctnCelliE_lbl.InnerText = "";
            dtctnCelliL_lbl.InnerText = "";
            dtctnCelliF_lbl.InnerText = "";
            dtctnCelliC_lbl.InnerText = "";
            dtctnCelliP_lbl.InnerText = "";
            dtctnCelliO_lbl.InnerText = "";

            dtctnCellcR_lbl.InnerText = "";
            dtctnCellcA_lbl.InnerText = "";
            dtctnCellcE_lbl.InnerText = "";
            dtctnCellcL_lbl.InnerText = "";
            dtctnCellcF_lbl.InnerText = "";
            dtctnCellcC_lbl.InnerText = "";
            dtctnCellcP_lbl.InnerText = "";
            dtctnCellcO_lbl.InnerText = "";
        }
        protected void compareBtn_Click(object sender, EventArgs e)
        {
            severityRating trojan = db.severityRating.First(c => (c.userName == HttpContext.Current.User.Identity.Name) && (c.nickName == trojanDrpDwn.SelectedValue) && (c.coverage == false));
            severityRating method = db.severityRating.First(c => (c.userName == HttpContext.Current.User.Identity.Name) && (c.nickName == detectionMethodDrpDwn.SelectedValue) && (c.coverage == true));

            //iR
            if (isNumber(trojan.iR, method.iR))
            {
                if (trjnDtcnCompare(trojan.iR, method.iR))
                {
                    resultLblIr.InnerText = "1";
                    resultLblIr.Attributes.Clear();
                }
                else
                {
                    resultLblIr.InnerText = "0";
                    resultLblIr.Attributes.Add("class", "fail");
                }
            }
            else
            {
                resultLblIr.InnerText = "NA";
                resultLblIr.Attributes.Add("class", "fail");
            }

            //iA
            if (isNumber(trojan.iA, method.iA))
            {
                if (trjnDtcnCompare(trojan.iA, method.iA))
                {
                    resultLblIa.InnerText = "1";
                    resultLblIa.Attributes.Clear();
                }
                else
                {
                    resultLblIa.InnerText = "0";
                    resultLblIa.Attributes.Add("class", "fail");
                }
            }
            else
            {
                resultLblIa.InnerText = "NA";
                resultLblIa.Attributes.Add("class", "fail");
            }

            //iE
            if (isNumber(trojan.iE, method.iE))
            {
                if (trjnDtcnCompare(trojan.iE, method.iE))
                {
                    resultLblIe.InnerText = "1";
                    resultLblIe.Attributes.Clear();
                    //resultLblIe.Attributes.Remove("class");
                }
                else
                {
                    resultLblIe.InnerText = "0";
                    resultLblIe.Attributes.Add("class", "fail");
                }
            }
            else
            {
                resultLblIe.InnerText = "NA";
                resultLblIe.Attributes.Add("class", "fail");
            }

            //iL
            if (isNumber(trojan.iL, method.iL))
            {
                if (trjnDtcnCompare(trojan.iL, method.iL))
                {
                    resultLblIl.InnerText = "1";
                    resultLblIl.Attributes.Clear();
                }
                else
                {
                    resultLblIl.InnerText = "0";
                    resultLblIl.Attributes.Add("class", "fail");
                }
            }
            else
            {
                resultLblIl.InnerText = "NA";
                resultLblIl.Attributes.Add("class", "fail");
            }

            //iF
            if (isNumber(trojan.iF, method.iF))
            {
                if (trjnDtcnCompare(trojan.iF, method.iF))
                {
                    resultLblIf.InnerText = "1";
                    resultLblIf.Attributes.Clear();
                }
                else
                {
                    resultLblIf.InnerText = "0";
                    resultLblIf.Attributes.Add("class", "fail");
                }
            }
            else
            {
                resultLblIf.InnerText = "NA";
                resultLblIf.Attributes.Add("class", "fail");
            }

            //iC
            if (isNumber(trojan.iC, method.iC))
            {
                if (trjnDtcnCompare(trojan.iC, method.iC))
                {
                    resultLblIc.InnerText = "1";
                    resultLblIc.Attributes.Clear();
                }
                else
                {
                    resultLblIc.InnerText = "0";
                    resultLblIc.Attributes.Add("class", "fail");
                }
            }
            else
            {
                resultLblIc.InnerText = "NA";
                resultLblIc.Attributes.Add("class", "fail");
            }

            //iP
            if (isNumber(trojan.iP, method.iP))
            {
                if (trjnDtcnCompare(trojan.iP, method.iP))
                {
                    resultLblIp.InnerText = "1";
                    resultLblIp.Attributes.Clear();
                }
                else
                {
                    resultLblIp.InnerText = "0";
                    resultLblIp.Attributes.Add("class", "fail");
                }
            }
            else
            {
                resultLblIp.InnerText = "NA";
                resultLblIp.Attributes.Add("class", "fail");
            }

            //iO
            if (isNumber(trojan.iO, method.iO))
            {
                if (trjnDtcnCompare(trojan.iO, method.iO))
                {
                    resultLblIo.InnerText = "1";
                    resultLblIo.Attributes.Clear();
                }
                else
                {
                    resultLblIo.InnerText = "0";
                    resultLblIo.Attributes.Add("class", "fail");
                }
            }
            else
            {
                resultLblIo.InnerText = "NA";
                resultLblIo.Attributes.Add("class", "fail");
            }

            //========= Coverage =======//

            //cR
            if (isNumber(trojan.cR, method.cR))
            {
                if (trjnDtcnCompare(trojan.cR, method.cR))
                {
                    resultLblCr.InnerText = "1";
                    resultLblCr.Attributes.Clear();
                }
                else
                {
                    resultLblCr.InnerText = "0";
                    resultLblCr.Attributes.Add("class", "fail");
                }
            }
            else
            {
                resultLblCr.InnerText = "NA";
                resultLblCr.Attributes.Add("class", "fail");
            }

            //cA
            if (isNumber(trojan.cA, method.cA))
            {
                if (trjnDtcnCompare(trojan.cA, method.cA))
                {
                    resultLblCa.InnerText = "1";
                    resultLblCa.Attributes.Clear();
                }
                else
                {
                    resultLblCa.InnerText = "0";
                    resultLblCa.Attributes.Add("class", "fail");
                }
            }
            else
            {
                resultLblCa.InnerText = "NA";
                resultLblCa.Attributes.Add("class", "fail");
            }

            //cE
            if (isNumber(trojan.cE, method.cE))
            {
                if (trjnDtcnCompare(trojan.cE, method.cE))
                {
                    resultLblCe.InnerText = "1";
                    resultLblCe.Attributes.Clear();
                }
                else
                {
                    resultLblCe.InnerText = "0";
                    resultLblCe.Attributes.Add("class", "fail");
                }
            }
            else
            {
                resultLblCe.InnerText = "NA";
                resultLblCe.Attributes.Add("class", "fail");
            }

            //cL
            if (isNumber(trojan.cL, method.cL))
            {
                if (trjnDtcnCompare(trojan.cL, method.cL))
                {
                    resultLblCl.InnerText = "1";
                    resultLblCl.Attributes.Clear();
                }
                else
                {
                    resultLblCl.InnerText = "0";
                    resultLblCl.Attributes.Add("class", "fail");
                }
            }
            else
            {
                resultLblCl.InnerText = "NA";
                resultLblCl.Attributes.Add("class", "fail");
            }

            //cF
            if (isNumber(trojan.cF, method.cF))
            {
                if (trjnDtcnCompare(trojan.cF, method.cF))
                {
                    resultLblCf.InnerText = "1";
                    resultLblCf.Attributes.Clear();
                }
                else
                {
                    resultLblCf.InnerText = "0";
                    resultLblCf.Attributes.Add("class", "fail");
                }
            }
            else
            {
                resultLblCf.InnerText = "NA";
                resultLblCf.Attributes.Add("class", "fail");
            }

            //cC
            if (isNumber(trojan.cC, method.cC))
            {
                if (trjnDtcnCompare(trojan.cC, method.cC))
                {
                    resultLblCc.InnerText = "1";
                    resultLblCc.Attributes.Clear();
                }
                else
                {
                    resultLblCc.InnerText = "0";
                    resultLblCc.Attributes.Add("class", "fail");
                }
            }
            else
            {
                resultLblCc.InnerText = "NA";
                resultLblCc.Attributes.Add("class", "fail");
            }

            //cP
            if (isNumber(trojan.cP, method.cP))
            {
                if (trjnDtcnCompare(trojan.cP, method.cP))
                {
                    resultLblCp.InnerText = "1";
                    resultLblCp.Attributes.Clear();
                }
                else
                {
                    resultLblCp.InnerText = "0";
                    resultLblCp.Attributes.Add("class", "fail");
                }
            }
            else
            {
                resultLblCp.InnerText = "NA";
                resultLblCp.Attributes.Add("class", "fail");
            }

            //cO
            if (isNumber(trojan.cO, method.cO))
            {
                if (trjnDtcnCompare(trojan.cO, method.cO))
                {
                    resultLblCo.InnerText = "1";
                    resultLblCo.Attributes.Clear();
                }
                else
                {
                    resultLblCo.InnerText = "0";
                    resultLblCo.Attributes.Add("class", "fail");
                }
            }
            else
            {
                resultLblCo.InnerText = "NA";
                resultLblCo.Attributes.Add("class", "fail");
            }
        }

        protected void trojanDrpDwn_SelectedIndexChanged(object sender, EventArgs e)
        {
            clearResults();
            if(trojanDrpDwn.SelectedIndex == 0)
            {
                clearTrojan();
            }
            else
            {
                severityRating rating = db.severityRating.First(c => (c.userName == HttpContext.Current.User.Identity.Name) && (c.nickName == trojanDrpDwn.SelectedValue) && (c.coverage == false));

                trjnCelliR_lbl.InnerText = rating.iR;
                trjnCelliA_lbl.InnerText = rating.iA;
                trjnCelliE_lbl.InnerText = rating.iE;
                trjnCelliL_lbl.InnerText = rating.iL;
                trjnCelliF_lbl.InnerText = rating.iF;
                trjnCelliC_lbl.InnerText = rating.iC;
                trjnCelliP_lbl.InnerText = rating.iP;
                trjnCelliO_lbl.InnerText = rating.iO;

                trjnCellcR_lbl.InnerText = rating.cR;
                trjnCellcA_lbl.InnerText = rating.cA;
                trjnCellcE_lbl.InnerText = rating.cE;
                trjnCellcL_lbl.InnerText = rating.cL;
                trjnCellcF_lbl.InnerText = rating.cF;
                trjnCellcC_lbl.InnerText = rating.cC;
                trjnCellcP_lbl.InnerText = rating.cP;
                trjnCellcO_lbl.InnerText = rating.cO;
            }

        }
        protected void detectionMethodDrpDwn_SelectedIndexChanged(object sender, EventArgs e)
        {
            clearResults();
            if(detectionMethodDrpDwn.SelectedIndex == 0)
            {
                clearDetection();
            }
            else
            {
                severityRating rating = db.severityRating.First(c => (c.userName == HttpContext.Current.User.Identity.Name) && (c.nickName == detectionMethodDrpDwn.SelectedValue) && (c.coverage == true));

                dtctnCelliR_lbl.InnerText = rating.iR;
                dtctnCelliA_lbl.InnerText = rating.iA;
                dtctnCelliE_lbl.InnerText = rating.iE;
                dtctnCelliL_lbl.InnerText = rating.iL;
                dtctnCelliF_lbl.InnerText = rating.iF;
                dtctnCelliC_lbl.InnerText = rating.iC;
                dtctnCelliP_lbl.InnerText = rating.iP;
                dtctnCelliO_lbl.InnerText = rating.iO;

                dtctnCellcR_lbl.InnerText = rating.cR;
                dtctnCellcA_lbl.InnerText = rating.cA;
                dtctnCellcE_lbl.InnerText = rating.cE;
                dtctnCellcL_lbl.InnerText = rating.cL;
                dtctnCellcF_lbl.InnerText = rating.cF;
                dtctnCellcC_lbl.InnerText = rating.cC;
                dtctnCellcP_lbl.InnerText = rating.cP;
                dtctnCellcO_lbl.InnerText = rating.cO;
            }

        }
    }
}