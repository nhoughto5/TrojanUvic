using System.Collections.Generic;
using System.Data.Entity;
using Trojan.Logic;
namespace Trojan.Models
{
    public class DatabaseInit : DropCreateDatabaseAlways<TrojanContext>
    {

        protected override void Seed(TrojanContext context)
        {
            //dBInitLists.GetCategories().ForEach(c => context.Categories.Add(c));
            //dBInitLists.GetAttributes().ForEach(p => context.Attributes.Add(p));
            //dBInitLists.GetCells().ForEach(a => context.Matrix_Cell.Add(a));
        }
    }
}