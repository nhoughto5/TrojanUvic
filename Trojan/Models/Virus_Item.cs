//Schema that defines each Attribute item added to the virus description 

using System;
using System.ComponentModel.DataAnnotations;

namespace Trojan.Models
{
    public class Virus_Item
    {
        [Key]
        public string ItemId { get; set; }

        public string VirusId { get; set; }

        public bool On_Off { get; set; }

        public System.DateTime DateCreated { get; set; }

        public int AttributeId { get; set; }

        public virtual Attribute Attribute { get; set; }

        public virtual Category Category { get; set; }

        public Virus_Item(string V_Id, int A_Id, Attribute Attr, Category Category_)
        {
            ItemId = Guid.NewGuid().ToString();
            VirusId = V_Id;
            On_Off = true;
            DateCreated = DateTime.Now;
            AttributeId = A_Id;
            Attribute = Attr;
            Category = Category_;
        }

        public Virus_Item()
        {

        }

    }
}