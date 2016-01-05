using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(TrojanSystemWeb.Startup))]
namespace TrojanSystemWeb
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
