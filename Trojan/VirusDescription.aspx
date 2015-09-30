<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="VirusDescription.aspx.cs" Inherits="Trojan.VirusDescription" %>
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
    <div id="NoSelected" align="center" runat="server" class="ContentHead"><h1>&nbsp&nbsp</h1><h3>No Attributes Selected</h3></div>
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
    <div id="RowResults" runat="server" class="ContentHead"><h1>Row Analysis Results</h1></div>
    <asp:GridView ID="RowGrid" runat="server" AutoGenerateColumns="false" ShowFooter="false" GridLines="Vertical" CellPadding="4" ItemType="Trojan.Models.Attribute" CssClass="table table-striped table-bordered">
        <Columns>
            <asp:BoundField DataField="AttributeId" HeaderText="ID" SortExpression="AttributeId" />
            <asp:BoundField DataField="AttributeName" HeaderText="Name" />        
            <asp:BoundField DataField="CategoryName" HeaderText="Category" />
        </Columns>
    </asp:GridView>
    <div id="ColumnResults" runat="server" class="ContentHead"><h1>Column Analysis Results</h1></div>
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
    <div id="notBuilt" runat="server" class="Content"><h4>Virus must be built before visualization</h4></div>
    <div id="directNone" runat="server" class="Content"><h4>No Direct Connections to Insertion</h4></div>
    <div id="indirectNone" runat="server" class="Content"><h4>No Indirect Connections to Insertion</h4></div>
    <div id="abstractionNone" runat="server" class="Content"><h4>No Results for Abstraction Category</h4></div>
    <div>&nbsp</div>
    
    <div id="visJumboContainer" class="jumbotron">
        <div id="visrep" class="ContentHead"></div>
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
            var X, Y;
            var propertiesRadius = 0.5 * (radius * numProperties);
            var locationRadius = 0.5 * (radius * numLocations);
            var W = 0, Z = 0;
            var maxX = 0;
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
                else if (nod[i-1].Category == "Properties") {
                    X = maxX + (propertiesRadius * Math.cos((2 * W * Math.PI) / numProperties));
                    Y = ((height) / 2) + (20 * numProperties) + (propertiesRadius * Math.sin((2 * W * Math.PI) / numProperties));
                    console.log("Properties " + nod[i-1].nodeID +": " + X + " " + Y);
                    ++W;
                }
                else if (nod[i-1].Category == "Location") {
                    X = (maxX - (10 * propertiesRadius)) + (locationRadius * Math.cos((2 * Z * Math.PI) / numLocations));
                    Y = ((height) / 2) + (20 * numLocations) + (propertiesRadius * Math.sin((2 * Z * Math.PI) / numLocations));
                    console.log("Location " + nod[i-1].nodeID + ": " + X + " " + Y);
                    ++Z;
                }
                //Insertion or Abstraction
                else {
                    X = m - (R / 2) + (i * d) - 100;
                    if (X > maxX) {
                        maxX = X;
                    }
                    Y = (height) / 2;
                    console.log("Insert or Abs " + nod[i-1].nodeID + ": " + X + " " + Y);
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
                    Category: nod[i - 2].Category
                };
            });
            var propertiesCentX = maxX;
            var propertiesCentY = ((height) / 2) + (20 * numProperties);
            var locationCentX = (maxX - (10 * propertiesRadius));
            var locationCentY = propertiesCentY;
            //console.log("Setting properties center: " + propertiesCentX + " " + propertiesCentY);
            //console.log("Setting locations centerL " + locationCentX + " " + locationCentY);
            for (var i = 0; i < numNodes; ++i) {
                d3.select(element).append("h3").text("Node " + i + ": " + nodes[i].id + " X " + nodes[i].x);
            }
            i = 0;
            links = d3.range(numEdges).map(function () {
                i++;
                return {
                    source: nodes[edges[i-1].source],
                    target: nodes[edges[i-1].target],
                    direct: edges[i-1].direct,
                    left: false,
                    right: true
                }
            });
            for (var i = 0; i < numEdges; ++i) {
                d3.select(element).append("h3").text("Source: " + nodes[edges[i].source - 1].id + " Target: " + nodes[edges[i].target - 1].id);
            }

            var path = svg.append("svg:g").selectAll("path").data(links).enter().append("svg:path").attr("class", "link").attr("d", function (d) { return linkPath(d) }).attr('marker-end', 'url(#arrow)');

            var circleGroup = svg.selectAll("g").data(nodes);
            var groupEnter = circleGroup.enter().append("g").attr("transform", function (d) {
                console.log("Drawing node " + d.id + ": " + d.x)
                return "translate(" + [d.x, d.y] + ")";
            }).style("cursor", "pointer");
            var circle = groupEnter.append("circle").attr("cx", 0).attr("cy", 0).attr("r", radius).attr("class", function (d) { return classSelector(d) }).append("svg:title").text(function (d) { return d.x; });
            var label = circleGroup.append("text").attr("y", 5).text(function (d) { return d.id; }).attr({ "alignment-baseline": "middle", "text-anchor": "middle" }).style("class", "id");
            var propOuterRadius = (propertiesRadius + (radius * 2));
            var locationOuterRadius = (locationRadius + (radius * 2));

            var propertiesCircle = svg.append("circle").attr("class", "circle").attr("cx", propertiesCentX).attr("cy", propertiesCentY).attr("r", propOuterRadius);
            var propertiesPath = svg.append("svg:g").append("svg:path")
                                    .attr("class", "link").attr("d", function () {
                                        var distance = 1.5 * propOuterRadius;
                                        var start = "M " + (nodes[numOnLine].x + radius) + ", " + nodes[numOnLine].y;
                                        var p1 = "L " + (nodes[numOnLine].x + distance) + ", " + nodes[numOnLine].y;
                                        var p2 = "L " + (nodes[numOnLine].x + distance) + ", " + propertiesCentY;
                                        var end = "L " + (propertiesCentX + (propertiesRadius + (radius * 2))) + ", " + propertiesCentY;
                                        var str = start + p1 + p2 + end;
                                        //console.log("Properties String: " + str);
                                        return str;
                                    }).attr('marker-end', 'url(#arrow2)');

            var locationCircle = svg.append("circle").attr("class", "circle").attr("cx", locationCentX).attr("cy", locationCentY).attr("r", locationOuterRadius);
            var locationPath = svg.append("svg:g").append("svg:path").attr("class", "link").attr("d", function (d) {
                                        var start = "M " + (propertiesCentX - propOuterRadius) + "," + locationCentY;
                                        var end = "L " + (locationCentX + locationOuterRadius)+ "," + locationCentY
                                        //console.log("Location String: " + start + end);
                                        return (start + end);
                                    }).attr('marker-end', 'url(#arrow2)');

        }

        function onTheLine(d) {
            if ((d.Category == "Chip Life Cycle") || (d.Category == "Abstraction")) {
                return true;
            }
            else return false;
        }
        function linkPath(d) {
            var str;
            if (d.direct != true) {
                //console.log("Not direct: " + d.source.id + " to " + d.target.id);
                str = "M " + d.source.x + ", " + d.source.y + " L " + (d.target.x - radius) + ", " + d.target.y;
            }
            else {
                
                var direction = -1;
                var distance = radius * (d.target.id);
                //console.log("Direct: " + d.source.id + " to " + d.target.id + " height: " + distance);
                var dy = direction * distance;
                var height = d.source.y + dy;
                var p1 = "M " + d.source.x + ", " + (d.source.y + (radius * direction));
                var p2 = " L " + d.source.x + ", " + (height);
                var p3 = " L " + d.target.x + ", " + height;
                var p4 = " L " + d.target.x + ", " + (d.target.y + (direction * radius));
                //M(source.x, source.y) + L(source.x, height) + L(target.x, height) + L(target.x, target.y);
                //p1 + p2 + p3 + p4
                str = p1 + p2 + p3 + p4;
            }
            return str;

        }
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

                
        function visualize(element, numEdges, numNodes) {
            svg = d3.selectAll(element).append('svg').attr('width', width).attr('height', height);

            initVis(element, numNodes, numEdges);
        }

        function dblclick(d) {
            d.fixed = false;
        }

    </script>
</asp:Content>