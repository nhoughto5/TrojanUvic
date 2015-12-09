using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;
using System.Data.Entity;
using System.Web.Http;
using Trojan.Models;
using Trojan.Logic;

namespace Trojan
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
            Database.SetInitializer(new DatabaseInit());
            TrojanContext db = new TrojanContext();
            db.Database.Initialize(force: true);
            RouteTable.Routes.MapHttpRoute("DescriptionAPI", "api/{controller}/{id}");

            // Create the custom role and user.
            RoleActions roleActions = new RoleActions();
            roleActions.AddUserAndRole();
        }
    }
}