﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity;

namespace Trojan.Models
{
    public class severityRating
    {
        [Key]
        public int id { get; set; }
        public string VirusId { get; set; }
        public bool Saved;

        public string iR { get; set; }
        public string iA { get; set; }
        public string iE { get; set; }
        public string iL { get; set; }
        public string iF { get; set; }
        public string iC { get; set; }
        public string iP { get; set; }
        public string iO { get; set; }

        public string cR { get; set; }
        public string cA { get; set; }
        public string cE { get; set; }
        public string cL { get; set; }
        public string cF { get; set; }
        public string cC { get; set; }
        public string cP { get; set; }
        public string cO { get; set; }

        public severityRating()
        {
            Saved = false;
        }
    }
}