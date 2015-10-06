using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Trojan.Models
{
    public class Node
    {
        public int nodeID;
        public string nodeName;
        public string Category;
        public int F_in;
        public int F_out;
        public Node(int ID, string name, string Cat, int Fin, int Fout)
        {
            nodeID = ID;
            Category = Cat;
            F_in = Fin;
            F_out = Fout;
            nodeName = name;
        }
        public Node()
        {

        }
    }
}