﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="VirusDescription.aspx.cs" Inherits="Trojan.VirusDescription" %>
<asp:Content ID="DescriptionContent" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript" src="Scripts/d3.js"></script>
    <script type="text/javascript" src="JavaScript/DirectedGraph.js"></script>
    <style>

        .Chip{
        fill: red;
        stroke: black;
        stroke-width: 2px;
    }
    .Abstraction{
        fill: orange;
        stroke: black;
        stroke-width: 2px;
    }
    .Properties{
        fill: lightgreen;
        stroke: black;
        stroke-width: 2px;
    }
    .Location{
        fill: yellow;
        stroke: black;
        stroke-width: 2px;
    }
    path.link {
	  fill: none;
	  stroke: #000;
	  stroke-width: 3px;
	  cursor: default;
	}

	.circle{
		fill: transparent;
		stroke : black;
		stroke-width: 2px;
	}

    </style>
    <link rel="stylesheet" type="text/css" href="Content/visualizer.css" />
    <div id="VirusDescriptionTitle" runat="server" class="ContentHead"><h1>Virus Description</h1></div>
    <div id="NoSelected" align="center" runat="server" class="ContentHead"><h1>&nbsp&nbsp</h1><h3>** No Attributes Selected **</h3></div>
    <asp:GridView ID="DescriptionList" runat="server" AutoGenerateColumns="False" ShowFooter="True" GridLines="Vertical" CellPadding="4"
        ItemType="Trojan.Models.Virus_Item" SelectMethod="GetVirusDescription" 
        CssClass="table table-striped table-bordered" EnableCaching ="true">   
        <Columns>
        <asp:BoundField DataField="AttributeId" HeaderText="ID" SortExpression="AttributeId" />        
        <asp:BoundField DataField="Attribute.AttributeName" HeaderText="Name" />        
        <asp:BoundField DataField="Attribute.CategoryName" HeaderText="Category" />
        <asp:BoundField DataField="Attribute.F_in" HeaderText="F_in" />
        <asp:BoundField DataField="Attribute.F_out" HeaderText="F_out" />     
        <asp:TemplateField   HeaderText="Select Attribute">            
                <ItemTemplate>
                    <asp:CheckBox id="On_Off_CheckBox" runat="server"></asp:CheckBox>
                </ItemTemplate>        
        </asp:TemplateField >
        <asp:TemplateField HeaderText="On/Off">
            <ItemTemplate>
                <asp:Label ID ="Attrib_OnOff" runat="server" Text='<%#Item.On_Off ? "On" : "Off" %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Remove Item">            
                <ItemTemplate>
                    <asp:CheckBox id="Remove" runat="server"></asp:CheckBox>
                </ItemTemplate>        
        </asp:TemplateField>    
        </Columns>    
    </asp:GridView>
    <div id="labels" runat="server">
        <p></p>
        <strong>
            <asp:Label ID="LabelTotalText" runat="server" Text="Total Attributes: "></asp:Label>
            <asp:Label ID="lblTotal" runat="server" EnableViewState="false"></asp:Label>
        </strong>
    </div>
    <div>
        <strong>
            <asp:Label ID="LabelTotalF_in" runat="server" Text="Total F_in: "></asp:Label>
            <asp:Label ID="lblTotalF_in" runat="server" EnableViewState="false"></asp:Label>
        </strong>
    </div>
    <div>
        <strong>
            <asp:Label ID="LabelTotalF_out" runat="server" Text="Total F_out: "></asp:Label>
            <asp:Label ID="lblTotalF_out" runat="server" EnableViewState="false"></asp:Label>
        </strong>
    </div>
    <br />
    <div id="notPossible" runat="server" align="center" class="Content">
        <h4>** This Combination Has No Result **</h4>
        <br />
        <asp:Button ID="startOverBtn" class="btn btn-primary" runat="server" Text="Start Over" OnClick="ClearBtn_Click" />
    </div>
    <br />
    <table id="buttonTable" runat="server" style="margin: 0 auto; border-collapse: separate; border-spacing: 5px; font-weight: bold;"> 
    <tr>
        <td>
        <asp:Button ID="UpdateBtn" class="btn btn-danger" runat="server" Text="Update" OnClick="UpdateBtn_Click" />
        </td>
        <td>
            <asp:Button ID="BuildCombo" class="btn btn-danger" runat="server" Text="Build Combo" OnClick="BuildComboBtn_Click" />
        </td>
        <td>
            <asp:Button ID="BuildRow" class="btn btn-danger" runat="server" Text="Build Row" OnClick="BuildRowBtn_Click" />
        </td>
        <td>
            <asp:Button ID="BuildCol" class="btn btn-danger" runat="server" Text="Build Column" OnClick="BuildColumnBtn_Click" />
        </td>
        <td>
            <asp:Button ID="ClearBtn" class="btn btn-danger" runat="server" Text="Clear" OnClick="ClearBtn_Click" />
        </td>
        <td>
            <asp:Button ID="VisualizeBtn" class="btn btn-danger" runat="server" Text="Visualize" OnClick="VisualizeBtn_Click" />
        </td>
    </tr>
    </table>
    
    <div id="abstractionResults" runat="server" class="ContentHead"><h1>Abstraction Results</h1></div>
    <asp:GridView ID="abstractionGrid" runat="server" AutoGenerateColumns="false" ShowFooter="false" GridLines="Vertical" CellPadding="4" ItemType="Trojan.Models.Attribute" CssClass="table table-striped table-bordered">
        <Columns>
            <asp:BoundField DataField="AttributeId" HeaderText="ID" SortExpression="AttributeId" />
            <asp:BoundField DataField="AttributeName" HeaderText="Name" />        
            <asp:BoundField DataField="CategoryName" HeaderText="Category" />
        </Columns>
    </asp:GridView>
    <div id="direct" runat="server" class="ContentHead"><h1>Direct Connections to Insertion</h1></div>
    <asp:GridView ID="directGrid" runat="server" AutoGenerateColumns="false" ShowFooter="false" GridLines="Vertical" CellPadding="4" ItemType="Trojan.Models.Attribute" CssClass="table table-striped table-bordered">
        <Columns>
            <asp:BoundField DataField="AttributeId" HeaderText="ID" SortExpression="AttributeId" />
            <asp:BoundField DataField="AttributeName" HeaderText="Name" />        
            <asp:BoundField DataField="CategoryName" HeaderText="Category" />
        </Columns>
    </asp:GridView>
    <div id="indirect" runat="server" class="ContentHead"><h1>Indirect Connections to Insertion</h1></div>
    
    <asp:GridView ID="indirectGrid" runat="server" AutoGenerateColumns="false" ShowFooter="false" GridLines="Vertical" CellPadding="4" ItemType="Trojan.Models.Attribute" CssClass="table table-striped table-bordered">
        <Columns>
            <asp:BoundField DataField="AttributeId" HeaderText="ID" SortExpression="AttributeId" />
            <asp:BoundField DataField="AttributeName" HeaderText="Name" />        
            <asp:BoundField DataField="CategoryName" HeaderText="Category" />
        </Columns>
    </asp:GridView>


    <div id="nodesDiv" runat="server" class="ContentHead"><h1>Attributes</h1></div>
    
    <asp:GridView ID="nodesGrid" runat="server" AutoGenerateColumns="false" ShowFooter="false" GridLines="Vertical" CellPadding="4" ItemType="Trojan.Models.Attribute" CssClass="table table-striped table-bordered">
        <Columns>
            <asp:BoundField DataField="AttributeId" HeaderText="ID" SortExpression="AttributeId" />
            <asp:BoundField DataField="AttributeName" HeaderText="Name" />        
            <asp:BoundField DataField="CategoryName" HeaderText="Category" />
        </Columns>
    </asp:GridView>

    <div id="RowResults" runat="server" class="ContentHead"><h1>Row Analysis Results</h1><h4>Attributes shared by each row</h4></div>
    <asp:GridView ID="RowGrid" runat="server" AutoGenerateColumns="false" ShowFooter="false" GridLines="Vertical" CellPadding="4" ItemType="Trojan.Models.Attribute" CssClass="table table-striped table-bordered">
        <Columns>
            <asp:BoundField DataField="AttributeId" HeaderText="ID" SortExpression="AttributeId" />
            <asp:BoundField DataField="AttributeName" HeaderText="Name" />        
            <asp:BoundField DataField="CategoryName" HeaderText="Category" />
        </Columns>
    </asp:GridView>
    <div id="ColumnResults" runat="server" class="ContentHead"><h1>Column Analysis Results</h1><h4>Attributes shared by each column</h4></div>
    <asp:GridView ID="ColumnGrid" runat="server" AutoGenerateColumns="false" ShowFooter="false" GridLines="Vertical" CellPadding="4" ItemType="Trojan.Models.Attribute" CssClass="table table-striped table-bordered">
        <Columns>
            <asp:BoundField DataField="AttributeId" HeaderText="ID" SortExpression="AttributeId" />
            <asp:BoundField DataField="AttributeName" HeaderText="Name" />        
            <asp:BoundField DataField="CategoryName" HeaderText="Category" />
        </Columns>
    </asp:GridView>
    <div id="ConnectionsResults" runat="server" class="ContentHead"><h1>Connections</h1></div>
    <asp:GridView ID="ConnectionsGrid" runat="server"  AutoGenerateColumns="false" ShowFooter="false" GridLines="Vertical" CellPadding="4" CssClass="table table-striped table-bordered" ItemType="Trojan.Models.Connection">
        <Columns>
            <asp:BoundField DataField="source" HeaderText="Source" SortExpression="source" />
            <asp:BoundField DataField="target" HeaderText="Target" />        
            <asp:BoundField DataField="direct" HeaderText="Direct Connection" />
        </Columns>
    </asp:GridView>
    <div id="Locationlbl" runat="server" class="ContentHead"><h1>Location Results</h1></div>
    <asp:GridView ID="LocationGrid" runat="server" AutoGenerateColumns="false" ShowFooter="false" GridLines="Vertical" CellPadding="4" ItemType="Trojan.Models.Attribute" CssClass="table table-striped table-bordered">
        <Columns>
            <asp:BoundField DataField="AttributeId" HeaderText="ID" SortExpression="AttributeId" />
            <asp:BoundField DataField="AttributeName" HeaderText="Name" />        
            <asp:BoundField DataField="CategoryName" HeaderText="Category" />
        </Columns>
    </asp:GridView>
    <div>&nbsp</div>
    <div>&nbsp</div>
    <div>&nbsp</div>
    
    <div id="notes" runat="server" class="Content"><h2>**Notes**</h2></div>
    <div id="canNot" runat="server" class="Content"><h4>Select attributes to build a virus</h4></div>
    <div id="abstractionEmpty" runat="server" class="Content"><h4>There are no access points to Abstraction Category</h4></div>
    <div id="notBuilt" runat="server" class="Content"><h4>Virus must be built before visualization</h4></div>
    <div id="directNone" runat="server" class="Content"><h4>No Direct Connections to Insertion</h4></div>
    <div id="indirectNone" runat="server" class="Content"><h4>No Indirect Connections to Insertion</h4></div>
    <div id="abstractionNone" runat="server" class="Content"><h4>No Results for Abstraction Category</h4></div>
    
    <div>&nbsp</div>
    <div id="jumboWrap" runat="server">
        <div id="visJumboContainer" class="jumbotron">
            <div id="visrep" style="text-align:center"></div>
        </div>
    </div>

    
    <script src="http://marvl.infotech.monash.edu/webcola/cola.v3.min.js"></script>
    <script type="text/javascript">

        var width = 960, height = 500, colors = d3.scale.category10();
        var svg = null, force = null;
        var nod, edges; //C# puts data in here
        var circle = null, path = null;
        var nodes = null, links = null;
        var nodesArray = null, linkArray = null;
        var circleGroup = null; var radius = 12;
        var markerWidth = 6,
        markerHeight = 4,
        refX = radius + (markerWidth) + 1,
        refY = 0;
        var step = 35;

        function initVis (element, numNodes, numEdges) {
            
            svg.selectAll('*').remove();

            svg.append('svg:defs').append('svg:marker')
			.attr("id", "arrow")
			.attr("viewBox", "0 -5 10 10")
			.attr("refX", 10)
			.attr("refY", refY)
			.attr("markerWidth", markerWidth)
			.attr("markerHeight", markerHeight)
			.attr("orient", "auto")
			.append("svg:path")
			.attr("d", "M0,-5 L10,0L0,5").attr('fill', "#000");

            svg.append('svg:defs').append('svg:marker')
                .attr("id", "arrow2")
                .attr("viewBox", "0 -5 10 10")
                .attr("refX", 10)
                .attr("refY", 0)
                .attr("markerWidth", markerWidth)
                .attr("markerHeight", markerHeight)
                .attr("orient", "auto")
                .append("svg:path")
                .attr("d", "M0,-5 L10,0L0,5").attr('fill', "#000");


            var numOnLine = 0, numProperties = 0, numLocations = 0;
            for (var j = 0; j < numNodes; j++) {
                if ((nod[j].Category == "Chip Life Cycle") || (nod[j].Category == "Abstraction")) ++numOnLine;
                else if (nod[j].Category == "Properties") ++numProperties;
                else {
                    ++numLocations;
                }
            }
            var i = 0; var L = 40, r = 12, lineLimit = 10;
            var d = 2 * r + L;
            var R = (numOnLine - 1) * d;
            var m = width / 2;
            var lineHeight = height / 3;
            var X, Y;
            var propertiesRadius = 0.5 * (radius * numProperties);
            var locationRadius = 0.5 * (radius * numLocations);
            
            var dropDown = (5 * step);
            var W = 0, Z = 0;

            var locationCentX = width / 3;
            var propertiesCentX = 2 * locationCentX;
            var propertiesCentY = (lineHeight) + dropDown;
            var locationCentY = propertiesCentY;

            //Create Node Data
            nodes = d3.range(numNodes+1).map(function () {
                if (i == 0) {
                    ++i;
                    return {
                        x: 0,
                        y: 0,
                        id: 0,
                        reflexive: true,
                        r: radius,
                        Fin: 0,
                        Fout: 0,
                        Category: "Filler"
                    }
                }
                else if (nod[i - 1].Category == "Properties") {
                    if (numProperties == 1) {
                        X = propertiesCentX;
                    }
                    else {
                        X = propertiesCentX + (propertiesRadius * Math.cos((2 * W * Math.PI) / numProperties));
                    }
                    
                    Y = (lineHeight + dropDown + (propertiesRadius * Math.sin((2 * W * Math.PI) / numProperties)));
                    ++W;
                }
                else if (nod[i - 1].Category == "Location") {
                    if (numLocations == 1) {
                        X = locationCentX;
                    }
                    else {
                        X = (locationCentX + (locationRadius * Math.cos((2 * Z * Math.PI) / numLocations)));
                    }
                    Y = (lineHeight + dropDown + (locationRadius * Math.sin((2 * Z * Math.PI) / numLocations)));
                    ++Z;
                }
                //Insertion or Abstraction
                else {
                    X = m - (R / 2) + (i * d) - 100;
                    Y = lineHeight;
                }
                ++i;
                return {
                    x: X,
                    y: Y,
                    id: nod[i - 2].nodeID,
                    reflexive: true,
                    r: radius,
                    Fin: nod[i - 2].F_in,
                    Fout: nod[i - 2].F_out,
                    Category: nod[i - 2].Category,
                    name: nod[i - 2].nodeName
                };
            });

            //Create Link Data
            var sources = []; var targets = [];
            i = 0;
            var under = false;
            links = d3.range(numEdges).map(function () {
                i++;
                if(edges[i - 1].direct == true){
                    if (!isPresent(sources, edges[i - 1].source)) {
                        sources.push(edges[i - 1].source);
                    }
                    else {
                        under = !under;
                    }
                    if (!isPresent(targets, edges[i - 1].target)) {
                        targets.push(edges[i - 1].target);
                    }
                    else {
                        under = !under;
                    }
                }

                return {
                    source: nodes[edges[i-1].source],
                    target: nodes[edges[i-1].target],
                    direct: edges[i-1].direct,
                    left: false,
                    right: true,
                    under: under
                }
            });            
            var propOuterRadius = (propertiesRadius + (radius * 2));
            var locationOuterRadius = (locationRadius + (radius * 2));
            //Add the paths between nodes to the page
            var path = svg.append("svg:g").selectAll("path").data(links).enter().append("svg:path").attr("class", "link").attr("d", function (d) { return linkPath(d) }).attr('marker-end', 'url(#arrow)');
            var propertiesCircle = svg.append("circle").attr("class", "circle").attr("cx", propertiesCentX).attr("cy", propertiesCentY).attr("r", propOuterRadius);
            var locationCircle = svg.append("circle").attr("class", "circle").attr("cx", locationCentX).attr("cy", locationCentY).attr("r", locationOuterRadius);
            //Add Nodes to page
            var circleGroup = svg.selectAll("g").data(nodes);
            var groupEnter = circleGroup.enter().append("g").attr("transform", function (d) {
                                                        return "translate(" + [d.x, d.y] + ")";
                                                    }).style("cursor", "pointer");
            var circle = groupEnter.append("circle").attr("cx", 0).attr("cy", 0).attr("r", radius).attr("class", function (d) { return classSelector(d) }).append("svg:title").text(function (d) {return labelGen(d);});
            var label = circleGroup.append("text").attr("y", 1).attr("x", -1).text(function (d) { return d.id; }).attr({ "alignment-baseline": "middle", "text-anchor": "middle" }).style("class", "id");

            //var propOuterRadius = (propertiesRadius + (radius * 2));
            //var locationOuterRadius = (locationRadius + (radius * 2));

            //Add highlight circle for properties category
            //var propertiesCircle = svg.append("circle").attr("class", "circle").attr("cx", propertiesCentX).attr("cy", propertiesCentY).attr("r", propOuterRadius);
            var propertiesPath = svg.append("svg:g").append("svg:path")
                                    .attr("class", "link").attr("d", function () {
                                        var distance = 1.5 * propOuterRadius;
                                        var start = "M " + (nodes[numOnLine].x + radius) + ", " + nodes[numOnLine].y;
                                        var p1 = "L " + (nodes[numOnLine].x + distance) + ", " + nodes[numOnLine].y;
                                        var p2 = "L " + (nodes[numOnLine].x + distance) + ", " + (propertiesCentY);
                                        var end = "L " + (propertiesCentX + (propertiesRadius + (radius * 2))) + ", " + propertiesCentY;
                                        var str = start + p1 + p2 + end;
                                        //console.log("Properties String: " + str);
                                        return str;
                                    }).attr('marker-end', 'url(#arrow2)');

            //Add highlight circle for Location category
            
            var locationPath = svg.append("svg:g").append("svg:path").attr("class", "link").attr("d", function (d) {
                var start = "M " + (propertiesCentX - propOuterRadius) + "," + locationCentY;
                var end = "L " + (locationCentX + locationOuterRadius) + "," + locationCentY
                return (start + end);
            }).attr('marker-end', 'url(#arrow2)');
            

        }

        //Create the labels for mouse-over
        function labelGen(d) {
            var str = "Attribute: " + d.name + "\n" + "Category: " + d.Category + "\n"+ "F_in: " + d.Fin + "\n" + "F_out: " + d.Fout;
            return str;
        }
        
        var direction = 1;
        var numOfUps = 1; var numOfDowns = 1;
        var linksThatGoUnder = false;

        //Generate the string required to direct paths
        function linkPath(d) {
            var str;
            if (d.direct != true) {
                str = "M " + d.source.x + ", " + d.source.y + " L " + (d.target.x - radius) + ", " + d.target.y;
            }
            else {
                
                var distance;
                if(d.under == true){
                    direction = 1; //Goes under the line
                    distance = step * calcStep(numOfDowns);
                    numOfDowns++;
                }
                else {
                    direction = -1;
                    distance = step * calcStep(numOfUps);
                    ++numOfUps;
                }
                var dy = direction * distance;
                var height = d.source.y + dy;
                var p1 = "M " + d.source.x + ", " + (d.source.y + (radius * direction));
                var p2 = " L " + d.source.x + ", " + (height);
                var p3 = " L " + d.target.x + ", " + height;
                var p4 = " L " + d.target.x + ", " + (d.target.y + (direction * radius));

                //M(source.x, source.y) + L(source.x, height) + L(target.x, height) + L(target.x, target.y);
                str = p1 + p2 + p3 + p4;
            }
            return str;
        }

        //Calculate the height of each link
        function calcStep(x){
            if(x == 1){
                return x;
            }
            else if (x == 2) {
                return 1.5;
            }
            else if(x == 3){
                return 2;
            }
            else if(x == 4){
                return 2.5;
            }
            else if (x == 5){
                return 3;
            }
            else if (x == 6){
                return 3.5;
            }
            else if (x == 7) {
                return 4;
            }
            else if (x == 8) {
                return 4.5;
            }
            else return 5;
        }

        //Check to see if a particular node is in an array
        function isPresent(list, x) {
            for (var i = 0; i < list.length; ++i) {
                if (list[i] == x) return true;
            }
            return false;
        }

        //Return the css class desired
        function classSelector(d) {
            if (d.Category == "Chip Life Cycle") {
                return "Chip";
            }
            else if (d.Category == "Abstraction") {
                return "Abstraction";
            }
            else if (d.Category == "Properties") {
                return "Properties";
            }
            else {
                return "Location";
            }
        }

        //Called by Server - Starts Javascript         
        function visualize(element, numEdges, numNodes) {
            svg = d3.selectAll(element).append('svg').attr('width', width).attr('height', height);
            initVis(element, numNodes, numEdges);
        }
    </script>
</asp:Content>