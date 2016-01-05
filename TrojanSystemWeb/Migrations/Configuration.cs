namespace TrojanSystemWeb.Migrations
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Migrations;
    using System.Linq;

    internal sealed class Configuration : DbMigrationsConfiguration<TrojanSystemWeb.Models.ApplicationDbContext>
    {
        public Configuration()
        {
            AutomaticMigrationsEnabled = false;
        }

        protected override void Seed(TrojanSystemWeb.Models.ApplicationDbContext context)
        {
            GetCategories().ForEach(c => context.Categories.AddOrUpdate(c));
        }

        private static List<Category> GetCategories()
        {
            var categories = new List<Category> {
                new Category
                {
                    CategoryId = 1,
                    CategoryName = "Chip Life Cycle",
                },
                new Category
                {
                    CategoryId = 2,
                    CategoryName = "Abstraction",
                },
                new Category
                {
                    CategoryId = 3,
                    CategoryName = "Properties",
                },
                new Category
                {
                    CategoryId = 4,
                    CategoryName = "Location",
                },
            };
            return categories;
        }
    }
}
