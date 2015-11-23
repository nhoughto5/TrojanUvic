using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Trojan.Models
{
    public class Virus
    {
        public Virus()
        {
            Virus_Items = new List<Virus_Item>();
        }
        public int id { get; set; }
        public string userName { get; set; }
        public string virusId { get; set; }
        public virtual ICollection<Virus_Item> Virus_Items {get; set;}
    }
}