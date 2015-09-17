<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="VirusDescription.aspx.cs" Inherits="Trojan.VirusDescription" %>
<asp:Content ID="DescriptionContent" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript" src="Scripts/d3.js"></script>
    <script type="text/javascript" src="JavaScript/DirectedGraph.js"></script>
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
            <asp:BoundField DataField="destination" HeaderText="Destination" />        
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
    
    <%--<script type="text/javascript">

        function visualize(element) {
            d3.select(element).append("h2").text("We did it!!!");
        }
    </script>--%>

    <script type="text/javascript">
        function Visualizer(el) {

            // Add and remove elements on the graph object
            this.addNode = function (id, Cat) {
                nodes.push({ "id": id, "Category": Cat });
                update();
            }

            this.removeNode = function (id) {
                var i = 0;
                var n = findNode(id);
                while (i < links.length) {
                    if ((links[i]['source'] === n) || (links[i]['target'] == n)) links.splice(i, 1);
                    else i++;
                }
                var index = findNodeIndex(id);
                if (index !== undefined) {
                    nodes.splice(index, 1);
                    update();
                }
            }

            this.addLink = function (sourceId, targetId) {
                var sourceNode = findNode(sourceId);
                var targetNode = findNode(targetId);

                if ((sourceNode !== undefined) && (targetNode !== undefined)) {
                    links.push({ "source": sourceNode, "target": targetNode });
                    update();
                }
            }

            var findNode = function (id) {
                for (var i = 0; i < nodes.length; i++) {
                    if (nodes[i].id === id)
                        return nodes[i]
                };
            }

            var findNodeIndex = function (id) {
                for (var i = 0; i < nodes.length; i++) {
                    if (nodes[i].id === id)
                        return i
                };
            }

            // set up the D3 visualisation in the specified element
            var w = $(el).innerWidth(),
                h = $(el).innerHeight();

            var vis = this.vis = d3.select(el).append("svg:svg")
                .attr("width", w)
                .attr("height", h);

            var force = d3.layout.force()
                .gravity(.05)
                .distance(100)
                .charge(-100)
                .size([w, h]);

            var nodes = force.nodes(),
                links = force.links();

            var update = function () {

                var link = vis.selectAll("line.link")
                    .data(links, function (d) { return d.source.id + "-" + d.target.id; });

                link.enter().insert("line")
                    .attr("class", "link");

                link.exit().remove();

                var node = vis.selectAll("g.node")
                    .data(nodes, function (d) { return d.id; });

                var nodeEnter = node.enter().append("g")
                    .attr("class", "node").attr('r', 12).style('fill', function (d) {
                        if (d.Category == 1) return "red";
                        else if (d.Category == 2) return "blue";
                        else if (d.Category == 3) return "yellow";
                        else return "green";
                    }).style("stroke", "black").classed('reflexive', function (d) { return d.reflexive; }).on('mouseover', function (d) {
                        if (!mousedown_node || d === mousedown_node) return;
                        // enlarge target node
                        d3.select(this).attr('transform', 'scale(1.1)');
                    })
                    .on('mouseout', function (d) {
                        if (!mousedown_node || d === mousedown_node) return;
                        // unenlarge target node
                        d3.select(this).attr('transform', '');
                    })
                    .on('mousedown', function (d) {
                        if (d3.event.ctrlKey) return;

                        // select node
                        mousedown_node = d;
                        if (mousedown_node === selected_node) selected_node = null;
                        else selected_node = mousedown_node;
                        selected_link = null;

                        // reposition drag line
                        drag_line
                          .style('marker-end', 'url(#end-arrow)')
                          .classed('hidden', false)
                          .attr('d', 'M' + mousedown_node.x + ',' + mousedown_node.y + 'L' + mousedown_node.x + ',' + mousedown_node.y);

                        restart();
                    })
                    .on('mouseup', function (d) {
                        if (!mousedown_node) return;

                        // needed by FF
                        drag_line
                          .classed('hidden', true)
                          .style('marker-end', '');

                        // check for drag-to-self
                        mouseup_node = d;
                        if (mouseup_node === mousedown_node) { resetMouseVars(); return; }

                        // unenlarge target node
                        d3.select(this).attr('transform', '');

                        // add link to graph (update if exists)
                        // NB: links are strictly source < target; arrows separately specified by booleans
                        var source, target, direction;
                        if (mousedown_node.id < mouseup_node.id) {
                            source = mousedown_node;
                            target = mouseup_node;
                            direction = 'right';
                        } else {
                            source = mouseup_node;
                            target = mousedown_node;
                            direction = 'left';
                        }

                        var link;
                        link = links.filter(function (l) {
                            return (l.source === source && l.target === target);
                        })[0];

                        if (link) {
                            link[direction] = true;
                        } else {
                            link = { source: source, target: target, left: false, right: false };
                            link[direction] = true;
                            links.push(link);
                        }

                        // select new link
                        selected_link = link;
                        selected_node = null;
                        restart();
                    });

                //show node IDs
                nodeEnter.append('svg:text').attr('x', 0).attr('y', 4).attr('class', 'id').text(function (d) { return d.id; });

                //remove old nodes
                node.exit().remove();

                force.on("tick", function () {
                    link.attr("x1", function (d) { return d.source.x; })
                        .attr("y1", function (d) { return d.source.y; })
                        .attr("x2", function (d) { return d.target.x; })
                        .attr("y2", function (d) { return d.target.y; });

                    node.attr("transform", function (d) { return "translate(" + d.x + "," + d.y + ")"; });
                });

                //Restart the force layout.
                force.start();
            }

            // Make it all go
            update();
        }

        
        var data;
        var nodeEdges;
        function visualize(element, length) {
            graph = new Visualizer(element);
            d3.select(element).append("h3").text(nodeEdges[0].source);
            for (var i = 0; i < length ; ++i) {
                //graph.addLink(nodeEdges[i].source, nodeEdge[i].target);
                d3.select(element).append("h3").text(nodeEdges[i].source);
            }
            //d3.select(element).selectAll("h2").data(nodeEdges).enter().append("h2").text(function (d) { return "We did it: " + d});
        }


    </script>
</asp:Content>