using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Trojan.Models
{
    public class Virus
    {
        public int id { get; set; }
        public string userName { get; set; }
        public string virusId { get; set; }
        public string virusNickName { get; set; }
    }
}