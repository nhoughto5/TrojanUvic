using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(dbTest.Startup))]
namespace dbTest
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
