using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Trojan.Models
{
    public class Node
    {
        public int nodeID;
        public string Category;

        public Node(int ID, string Cat)
        {
            nodeID = ID;
            Category = Cat;
        }
        public Node()
        {

        }
    }
}