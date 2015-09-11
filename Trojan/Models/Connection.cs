using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Trojan.Models
{
    public class Connection
    {
        public int source { get; set; }
        public int destination { get; set; }
        public bool direct { get; set; }
        public Connection(int source_, int destination_, bool direct_)
        {
            source = source_;
            destination = destination_;
            direct = direct_;
        }
    }
}