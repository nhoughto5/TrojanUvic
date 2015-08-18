using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;
namespace Trojan.Models
{
    public class TrojanContext : DbContext
    {
        public TrojanContext()
            : base("Trojan")
        {

        }
        public DbSet<Category> Categories { get; set; }
        public DbSet<Attribute> Attributes { get; set; }
        public DbSet<Virus_Item> VirusDescription { get; set; }
        public DbSet<Matrix_Cell> Matrix_Cell { get; set; }
    }
}