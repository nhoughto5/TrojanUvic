namespace Trojan.Migrations
{
    using Logic;
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Migrations;
    using System.Linq;

    internal sealed class Configuration : DbMigrationsConfiguration<Trojan.Models.TrojanContext>
    {
        public Configuration()
        {
            AutomaticMigrationsEnabled = false;
        }

        protected override void Seed(Trojan.Models.TrojanContext context)
        {
            dBInitLists.GetCategories().ForEach(c => context.Categories.AddOrUpdate(c));
            dBInitLists.GetAttributes().ForEach(p => context.Attributes.AddOrUpdate(p));
            dBInitLists.GetCells().ForEach(a => context.Matrix_Cell.AddOrUpdate(a));
        }
    }
}
