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

    <script type="text/javascript">


        function start(element, numNodes, numEdges) {
            // set up SVG for D3
            var width = 960,
                height = 500,
                colors = d3.scale.category10();

            var svg = d3.select("#visrep")
              .append('svg')
              .attr('oncontextmenu', 'return false;')
              .attr('width', width)
              .attr('height', height);

            // set up initial nodes and links
            //  - nodes are known by 'id', not by index in array.
            //  - reflexive edges are indicated on the node (as a bold black circle).
            //  - links are always source < target; edge directions are set by 'left' and 'right'.
            var nodes, links;
            var nodes = [
                { id: 0, reflexive: false },
                { id: 1, reflexive: true },
                { id: 2, reflexive: false }
            ],
              lastNodeId = 2;
            nodes = [];
            for (var i = 0; i < numNodes; ++i) {
                nodes.push({ id: nod[i].nodeID, reflexive: true });
                //d3.select(element).append("h3").text("Node: " + nodes[i].id);
            }
            for (var i = 0; i < numNodes; ++i) {
                d3.select(element).append("h3").text("Node "+i+": " + nodes[i].id);
            }
            lastNodeId = numNodes - 1;
            var links = [
                { source: nodes[0], target: nodes[1], left: false, right: true },
                { source: nodes[1], target: nodes[2], left: false, right: true }
            ]
            links = [];
            for (var i = 0; i < numEdges; ++i) {
                d3.select(element).append("h3").text("Source: " + nodes[edges[i].source - 1].id + " Target: " + nodes[edges[i].target - 1].id);
                links.push({ source: nodes[edges[i].source - 1], target: nodes[edges[i].target - 1], left: false, right: true });
            }


            // init D3 force layout
            var force = d3.layout.force()
                .nodes(nodes)
                .links(links)
                .size([width, height])
                .linkDistance(150)
                .charge(-500)
                .on('tick', tick)

            // define arrow markers for graph links
            svg.append('svg:defs').append('svg:marker')
                .attr('id', 'end-arrow')
                .attr('viewBox', '0 -5 10 10')
                .attr('refX', 6)
                .attr('markerWidth', 3)
                .attr('markerHeight', 3)
                .attr('orient', 'auto')
              .append('svg:path')
                .attr('d', 'M0,-5L10,0L0,5')
                .attr('fill', '#000');

            svg.append('svg:defs').append('svg:marker')
                .attr('id', 'start-arrow')
                .attr('viewBox', '0 -5 10 10')
                .attr('refX', 4)
                .attr('markerWidth', 3)
                .attr('markerHeight', 3)
                .attr('orient', 'auto')
              .append('svg:path')
                .attr('d', 'M10,-5L0,0L10,5')
                .attr('fill', '#000');

            // line displayed when dragging new nodes
            var drag_line = svg.append('svg:path')
              .attr('class', 'link dragline hidden')
              .attr('d', 'M0,0L0,0');

            // handles to link and node element groups
            var path = svg.append('svg:g').selectAll('path'),
                circle = svg.append('svg:g').selectAll('g');

            // mouse event vars
            var selected_node = null,
                selected_link = null,
                mousedown_link = null,
                mousedown_node = null,
                mouseup_node = null;

            function resetMouseVars() {
                mousedown_node = null;
                mouseup_node = null;
                mousedown_link = null;
            }

            // update force layout (called automatically each iteration)
            function tick() {
                // draw directed edges with proper padding from node centers
                path.attr('d', function (d) {
                    var deltaX = d.target.x - d.source.x,
                        deltaY = d.target.y - d.source.y,
                        dist = Math.sqrt(deltaX * deltaX + deltaY * deltaY),
                        normX = deltaX / dist,
                        normY = deltaY / dist,
                        sourcePadding = d.left ? 17 : 12,
                        targetPadding = d.right ? 17 : 12,
                        sourceX = d.source.x + (sourcePadding * normX),
                        sourceY = d.source.y + (sourcePadding * normY),
                        targetX = d.target.x - (targetPadding * normX),
                        targetY = d.target.y - (targetPadding * normY);
                    return 'M' + sourceX + ',' + sourceY + 'L' + targetX + ',' + targetY;
                });

                circle.attr('transform', function (d) {
                    return 'translate(' + d.x + ',' + d.y + ')';
                });
            }

            // update graph (called when needed)
            function restart() {
                // path (link) group
                path = path.data(links);

                // update existing links
                path.classed('selected', function (d) { return d === selected_link; })
                  .style('marker-start', function (d) { return d.left ? 'url(#start-arrow)' : ''; })
                  .style('marker-end', function (d) { return d.right ? 'url(#end-arrow)' : ''; });


                // add new links
                path.enter().append('svg:path')
                  .attr('class', 'link')
                  .classed('selected', function (d) { return d === selected_link; })
                  .style('marker-start', function (d) { return d.left ? 'url(#start-arrow)' : ''; })
                  .style('marker-end', function (d) { return d.right ? 'url(#end-arrow)' : ''; })
                  .on('mousedown', function (d) {
                      if (d3.event.ctrlKey) return;

                      // select link
                      mousedown_link = d;
                      if (mousedown_link === selected_link) selected_link = null;
                      else selected_link = mousedown_link;
                      selected_node = null;
                      restart();
                  });

                // remove old links
                path.exit().remove();


                // circle (node) group
                // NB: the function arg is crucial here! nodes are known by id, not by index!
                circle = circle.data(nodes, function (d) { return d.id; });

                // update existing nodes (reflexive & selected visual states)
                circle.selectAll('circle')
                  .style('fill', function (d) { return (d === selected_node) ? d3.rgb(colors(d.id)).brighter().toString() : colors(d.id); })
                  .classed('reflexive', function (d) { return d.reflexive; });

                // add new nodes
                var g = circle.enter().append('svg:g');

                g.append('svg:circle')
                  .attr('class', 'node')
                  .attr('r', 12)
                  .style('fill', function (d) { return (d === selected_node) ? d3.rgb(colors(d.id)).brighter().toString() : colors(d.id); })
                  .style('stroke', function (d) { return d3.rgb(colors(d.id)).darker().toString(); })
                  .classed('reflexive', function (d) { return d.reflexive; })
                  .on('mouseover', function (d) {
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

                // show node IDs
                g.append('svg:text')
                    .attr('x', 0)
                    .attr('y', 4)
                    .attr('class', 'id')
                    .text(function (d) { return d.id; });

                // remove old nodes
                circle.exit().remove();

                // set the graph in motion
                force.start();
            }

            function mousedown() {
                // prevent I-bar on drag
                //d3.event.preventDefault();

                // because :active only works in WebKit?
                svg.classed('active', true);

                if (d3.event.ctrlKey || mousedown_node || mousedown_link) return;

                // insert new node at point
                var point = d3.mouse(this),
                    node = { id: ++lastNodeId, reflexive: false };
                node.x = point[0];
                node.y = point[1];
                nodes.push(node);

                restart();
            }

            function mousemove() {
                if (!mousedown_node) return;

                // update drag line
                drag_line.attr('d', 'M' + mousedown_node.x + ',' + mousedown_node.y + 'L' + d3.mouse(this)[0] + ',' + d3.mouse(this)[1]);

                restart();
            }

            function mouseup() {
                if (mousedown_node) {
                    // hide drag line
                    drag_line
                      .classed('hidden', true)
                      .style('marker-end', '');
                }

                // because :active only works in WebKit?
                svg.classed('active', false);

                // clear mouse event vars
                resetMouseVars();
            }

            function spliceLinksForNode(node) {
                var toSplice = links.filter(function (l) {
                    return (l.source === node || l.target === node);
                });
                toSplice.map(function (l) {
                    links.splice(links.indexOf(l), 1);
                });
            }

            // only respond once per keydown
            var lastKeyDown = -1;

            function keydown() {
                d3.event.preventDefault();

                if (lastKeyDown !== -1) return;
                lastKeyDown = d3.event.keyCode;

                // ctrl
                if (d3.event.keyCode === 17) {
                    circle.call(force.drag);
                    svg.classed('ctrl', true);
                }

                if (!selected_node && !selected_link) return;
                switch (d3.event.keyCode) {
                    case 8: // backspace
                    case 46: // delete
                        if (selected_node) {
                            nodes.splice(nodes.indexOf(selected_node), 1);
                            spliceLinksForNode(selected_node);
                        } else if (selected_link) {
                            links.splice(links.indexOf(selected_link), 1);
                        }
                        selected_link = null;
                        selected_node = null;
                        restart();
                        break;
                    case 66: // B
                        if (selected_link) {
                            // set link direction to both left and right
                            selected_link.left = true;
                            selected_link.right = true;
                        }
                        restart();
                        break;
                    case 76: // L
                        if (selected_link) {
                            // set link direction to left only
                            selected_link.left = true;
                            selected_link.right = false;
                        }
                        restart();
                        break;
                    case 82: // R
                        if (selected_node) {
                            // toggle node reflexivity
                            selected_node.reflexive = !selected_node.reflexive;
                        } else if (selected_link) {
                            // set link direction to right only
                            selected_link.left = false;
                            selected_link.right = true;
                        }
                        restart();
                        break;
                }
            }

            function keyup() {
                lastKeyDown = -1;

                // ctrl
                if (d3.event.keyCode === 17) {
                    circle
                      .on('mousedown.drag', null)
                      .on('touchstart.drag', null);
                    svg.classed('ctrl', false);
                }
            }

            // app starts here
            svg.on('mousedown', mousedown)
              .on('mousemove', mousemove)
              .on('mouseup', mouseup);
            d3.select(window)
              .on('keydown', keydown)
              .on('keyup', keyup);
            restart();
        }
        
        var nod;
        var edges;
        function visualize(element, numEdges, numNodes) {
            //start();
            //graph = new Visualizer(element);
            for (var i = 0; i < numEdges ; ++i) {
                //graph.addLink(edges[i].source, nodeEdge[i].target);
                d3.select(element).append("h3").text("Source: "+ edges[i].source + " Target: " + edges[i].target);
            }
            for (var i = 0; i < numNodes; ++i) {
                //graph.addNode(node[i].nodeID, nodes[i].Category);
                d3.select(element).append("h3").text("Node: " + nod[i].nodeID + " Category: " + nod[i].Category);
            }
            start(element, numNodes, numEdges);
        //    //graph.start();
        }


    </script>
</asp:Content>