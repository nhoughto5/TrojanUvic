//using System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Web;
//using System.Web.Services;

//namespace Trojan
//{
//    /// <summary>
//    /// Summary description for updateGraph
//    /// </summary>
//    [WebService(Namespace = "http://tempuri.org/")]
//    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
//    [System.ComponentModel.ToolboxItem(false)]
//    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
//    [System.Web.Script.Services.ScriptService]
//    public class updateGraph : System.Web.Services.WebService
//    {

//        [WebMethod(EnableSession = true)]
//        public bool analyseGraph(int x)
//        {
//            bool B = true;

//            //Call method updateGraph from code behind
//            using (VirusDescription virus = new VirusDescription())
//            {
//                B = virus.updateGraph(x);
//            }
//            return B;
//        }
//    }
//}
