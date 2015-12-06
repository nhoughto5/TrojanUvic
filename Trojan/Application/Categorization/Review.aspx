<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Review.aspx.cs" Inherits="Trojan.Application.Categorization.Application.Review" %>
<%@ PreviousPageType VirtualPath="~/Application/Categorization/CategorizationMain.aspx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script src="http://marvl.infotech.monash.edu/webcola/cola.v3.min.js"></script>
    <script type="text/JavaScript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
    <script src="../../JavaScript/visualizer.js" type="text/javascript"></script>


    <h1>Review of Trojan <asp:Label runat="server" ID="label1"></asp:Label></h1>
    <div id="visJumboContainer" style="text-align:center" >
            <div id="visrep" ></div>
    </div>
</asp:Content>
