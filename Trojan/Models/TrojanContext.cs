using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;
namespace Trojan.Models
{
    public class TrojanContext : DbContext
    {
        public TrojanContext() : base("DefaultConnection")
        {

        }
        public DbSet<Category> Categories { get; set; }
        public DbSet<Attribute> Attributes { get; set; }
        public DbSet<Virus_Item> Virus_Item { get; set; }
        public DbSet<Matrix_Cell> Matrix_Cell { get; set; }
        //public DbSet<Connection> Connections { get; set; }
        //public DbSet<severityRating> InsertSeverity { get; set; }
        //public DbSet<severityRating> AbstractionSeverity { get; set; }
        //public DbSet<severityRating> EffectSeverity { get; set; }
        //public DbSet<severityRating> LogicTypeSeverity { get; set; }
        //public DbSet<severityRating> FunctionalitySeverity { get; set; }
        //public DbSet<severityRating> ActivationSeverity { get; set; }
        //public DbSet<severityRating> PhysicalLayoutSeverity { get; set; }
        //public DbSet<severityRating> LocationSeverity { get; set; }
        //public DbSet<severityRating> ChipAttributeSeverity { get; set; }
    }
}