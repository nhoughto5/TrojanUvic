<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DetectionApplication.aspx.cs" Inherits="Trojan.Application.Detection.DetectionApplication" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .fail{
            color: red;
        }
    </style>
    <h2>Detection</h2>
    <div id="newDetectionMethod" runat="server">
        <h4>Build a new Coverage Vector</h4>
        <div class="well">
            <p style="font-size: 11px">*Hover Over Each Column Heading for Information*</p>
            <asp:Table runat="server" ID="covrgTable" CssClass="table table-striped table-bordered">
                <asp:TableHeaderRow runat="server" ID="HeaderRow">
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Insertion">I<sub>R</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Abstraction">I<sub>A</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Effect">I<sub>E</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Logic Type">I<sub>L</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Functionality">I<sub>F</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Activation">I<sub>C</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Physical Layout">I<sub>P</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="border-right-width: medium; text-align:center" Font-Size="Large"><span title="Location">I<sub>O</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Insertion">C<sub>R</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Abstraction">C<sub>A</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Effect">C<sub>E</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Logic Type">C<sub>L</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Functionality">C<sub>F</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Activation">C<sub>C</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Physical Layout">C<sub>P</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Location">C<sub>O</sub></span></asp:TableHeaderCell>
                </asp:TableHeaderRow>
                <asp:TableRow runat="server" ID="cvrgTblRow1">
                    <asp:TableCell style="text-align:center" ID="celliR">
                        <asp:DropDownList ID="Ir_drpDwn" runat="server"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell style="text-align:center" ID="celliA">
                        <asp:DropDownList ID="Ia_drpDwn" runat="server"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell style="text-align:center" ID="celliE">
                        <asp:DropDownList ID="Ie_drpDwn" runat="server"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell style="text-align:center" ID="celliL">
                        <asp:DropDownList ID="Il_drpDwn" runat="server"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell style="text-align:center" ID="celliF">
                        <asp:DropDownList ID="If_drpDwn" runat="server"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell style="text-align:center" ID="celliC">
                        <asp:DropDownList ID="Ic_drpDwn" runat="server"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell style="text-align:center" ID="celliP">
                        <asp:DropDownList ID="Ip_drpDwn" runat="server"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell ID="celliO" Style="border-right-width: medium; text-align:center">
                        <asp:DropDownList ID="Io_drpDwn" runat="server"></asp:DropDownList>
                    </asp:TableCell>


                    <asp:TableCell style="text-align:center" ID="cellcR">
                        <asp:DropDownList ID="Cr_drpDwn" runat="server"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell style="text-align:center" ID="cellcA">
                        <asp:DropDownList ID="Ca_drpDwn" runat="server"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell style="text-align:center" ID="cellcE">
                        <asp:DropDownList ID="Ce_drpDwn" runat="server"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell style="text-align:center" ID="cellcL">
                        <asp:DropDownList ID="Cl_drpDwn" runat="server"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell style="text-align:center" ID="cellcF">
                        <asp:DropDownList ID="Cf_drpDwn" runat="server"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell style="text-align:center" ID="cellcC">
                        <asp:DropDownList ID="Cc_drpDwn" runat="server"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell style="text-align:center" ID="cellcP">
                        <asp:DropDownList ID="Cp_drpDwn" runat="server"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell style="text-align:center" ID="cellcO">
                        <asp:DropDownList ID="Co_drpDwn" runat="server"></asp:DropDownList>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>

            <div style="text-align: right;">
                <asp:UpdatePanel runat="server" ID="updatePnl" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:PlaceHolder runat="server" ID="updateMessage" Visible="false">
                        <p class="text-danger">
                            <asp:Literal runat="server" ID="messageText" />
                        </p>
                    </asp:PlaceHolder>
                    </ContentTemplate>
                </asp:UpdatePanel>
                Give your method a name &nbsp;
                <asp:TextBox ID="methodNametxtbx" columns="30" runat="server"></asp:TextBox>
                <asp:Button runat="server" ID="saveBtn" style="display:inline" Text="Save Coverage Rating" OnClick="saveBtn_Click" />
            </div>
        </div>
        <br />
        <hr/>
    </div>
    <h2>Comparison</h2>
    <h4>Select a Detection Method and a Trojan</h4>
    <div id="currentMethod" runat="server" class="well">
        <p style="font-size: 11px">Detection Method</p>
        <asp:UpdatePanel runat="server" ID="detectionPanel" UpdateMode="Conditional">
            <ContentTemplate>
                <asp:Table runat="server" ID="Table1" CssClass="table table-striped table-bordered">
                <asp:TableHeaderRow runat="server" ID="TableHeaderRow1">
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Insertion">I<sub>R</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Abstraction">I<sub>A</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Effect">I<sub>E</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Logic Type">I<sub>L</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Functionality">I<sub>F</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Activation">I<sub>C</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Physical Layout">I<sub>P</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="border-right-width: medium; text-align:center" Font-Size="Large"><span title="Location">I<sub>O</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Insertion">C<sub>R</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Abstraction">C<sub>A</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Effect">C<sub>E</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Logic Type">C<sub>L</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Functionality">C<sub>F</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Activation">C<sub>C</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Physical Layout">C<sub>P</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Location">C<sub>O</sub></span></asp:TableHeaderCell>
                </asp:TableHeaderRow>
                <asp:TableRow runat="server" ID="TableRow1">
                    <asp:TableCell style="text-align:center" ID="dtctnCelliR">
                        <label id="dtctnCelliR_lbl" runat="server"></label>
                    </asp:TableCell>
                    <asp:TableCell style="text-align:center" ID="dtctnCelliA">
                        <label id="dtctnCelliA_lbl" runat="server"></label>
                    </asp:TableCell>
                    <asp:TableCell style="text-align:center" ID="dtctnCelliE">
                        <label id="dtctnCelliE_lbl" runat="server"></label>
                    </asp:TableCell>
                    <asp:TableCell style="text-align:center" ID="dtctnCelliL">
                        <label id="dtctnCelliL_lbl" runat="server"></label>
                    </asp:TableCell>
                    <asp:TableCell style="text-align:center" ID="dtctnCelliF">
                        <label id="dtctnCelliF_lbl" runat="server"></label>
                    </asp:TableCell>
                    <asp:TableCell style="text-align:center" ID="dtctnCelliC">
                        <label id="dtctnCelliC_lbl" runat="server"></label>
                    </asp:TableCell>
                    <asp:TableCell style="text-align:center" ID="dtctnCelliP">
                        <label id="dtctnCelliP_lbl" runat="server"></label>
                    </asp:TableCell>
                    <asp:TableCell ID="dtctnCelliO" Style="border-right-width: medium; text-align:center">
                        <label id="dtctnCelliO_lbl" runat="server"></label>
                    </asp:TableCell>


                    <asp:TableCell style="text-align:center" ID="dtctnCellcR">
                        <label id="dtctnCellcR_lbl" runat="server"></label>
                    </asp:TableCell>
                    <asp:TableCell style="text-align:center" ID="dtctnCellcA">
                        <label id="dtctnCellcA_lbl" runat="server"></label>
                    </asp:TableCell>
                    <asp:TableCell style="text-align:center" ID="dtctnCellcE">
                        <label id="dtctnCellcE_lbl" runat="server"></label>
                    </asp:TableCell>
                    <asp:TableCell style="text-align:center" ID="dtctnCellcL">
                        <label id="dtctnCellcL_lbl" runat="server"></label>
                    </asp:TableCell>
                    <asp:TableCell style="text-align:center" ID="dtctnCellcF">
                        <label id="dtctnCellcF_lbl" runat="server"></label>
                    </asp:TableCell>
                    <asp:TableCell style="text-align:center" ID="dtctnCellcC">
                        <label id="dtctnCellcC_lbl" runat="server"></label>
                    </asp:TableCell>
                    <asp:TableCell style="text-align:center" ID="dtctnCellcP">
                        <label id="dtctnCellcP_lbl" runat="server"></label>
                    </asp:TableCell>
                    <asp:TableCell style="text-align:center" ID="dtctnCellcO">
                        <label id="dtctnCellcO_lbl" runat="server"></label>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="detectionMethodDrpDwn" EventName="SelectedIndexChanged" />
            </Triggers>
        </asp:UpdatePanel>
        
        <hr />
        <p style="font-size: 11px">Trojan Virus</p>
        <asp:UpdatePanel runat="server" ID="trojanPanel" UpdateMode="Conditional">
            <ContentTemplate>
                <asp:Table runat="server" ID="Table3" CssClass="table table-striped table-bordered">
                    <asp:TableHeaderRow runat="server" ID="TableHeaderRow3">
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Insertion">I<sub>R</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Abstraction">I<sub>A</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Effect">I<sub>E</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Logic Type">I<sub>L</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Functionality">I<sub>F</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Activation">I<sub>C</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Physical Layout">I<sub>P</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="border-right-width: medium; text-align:center" Font-Size="Large"><span title="Location">I<sub>O</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Insertion">C<sub>R</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Abstraction">C<sub>A</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Effect">C<sub>E</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Logic Type">C<sub>L</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Functionality">C<sub>F</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Activation">C<sub>C</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Physical Layout">C<sub>P</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Location">C<sub>O</sub></span></asp:TableHeaderCell>
                    </asp:TableHeaderRow>
                    <asp:TableRow runat="server" ID="TableRow3">
                        <asp:TableCell style="text-align:center" ID="trjnCelliR">
                            <label id="trjnCelliR_lbl" runat="server"></label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align:center" ID="trjnCelliA">
                            <label id="trjnCelliA_lbl" runat="server"></label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align:center" ID="trjnCelliE">
                            <label id="trjnCelliE_lbl" runat="server"></label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align:center" ID="trjnCelliL">
                            <label id="trjnCelliL_lbl" runat="server"></label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align:center" ID="trjnCelliF">
                            <label id="trjnCelliF_lbl" runat="server"></label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align:center" ID="trjnCelliC">
                            <label id="trjnCelliC_lbl" runat="server"></label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align:center" ID="trjnCelliP">
                            <label id="trjnCelliP_lbl" runat="server"></label>
                        </asp:TableCell>
                        <asp:TableCell ID="trjnCelliO" Style="border-right-width: medium; text-align:center">
                            <label id="trjnCelliO_lbl" runat="server"></label>
                        </asp:TableCell>


                        <asp:TableCell style="text-align:center" ID="trjnCellcR">
                            <label id="trjnCellcR_lbl" runat="server"></label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align:center" ID="trjnCellcA">
                            <label id="trjnCellcA_lbl" runat="server"></label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align:center" ID="trjnCellcE">
                            <label id="trjnCellcE_lbl" runat="server"></label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align:center" ID="trjnCellcL">
                            <label id="trjnCellcL_lbl" runat="server"></label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align:center" ID="trjnCellcF">
                            <label id="trjnCellcF_lbl" runat="server"></label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align:center" ID="trjnCellcC">
                            <label id="trjnCellcC_lbl" runat="server"></label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align:center" ID="trjnCellcP">
                            <label id="trjnCellcP_lbl" runat="server"></label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align:center" ID="trjnCellcO">
                            <label id="trjnCellcO_lbl" runat="server"></label>
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="trojanDrpDwn" EventName="SelectedIndexChanged" />
            </Triggers>
        </asp:UpdatePanel>
        
        <div runat="server" id="resultDiv">
            <hr />
            <p style="font-size: 11px">Comparison Result: A value of 1 represents the case where the method covers the trojan</p>
            <asp:UpdatePanel runat="server" ID="resultPanel" UpdateMode="Conditional">
                <ContentTemplate>
                    <asp:Table runat="server" ID="resultRow" CssClass="table table-striped table-bordered">
                        <asp:TableHeaderRow runat="server" CssClass="info">
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Insertion">I<sub>R</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Abstraction">I<sub>A</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Effect">I<sub>E</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Logic Type">I<sub>L</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Functionality">I<sub>F</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Activation">I<sub>C</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Physical Layout">I<sub>P</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="border-right-width: medium; text-align:center" Font-Size="Large"><span title="Location">I<sub>O</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Insertion">C<sub>R</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Abstraction">C<sub>A</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Effect">C<sub>E</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Logic Type">C<sub>L</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Functionality">C<sub>F</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Activation">C<sub>C</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Physical Layout">C<sub>P</sub></span></asp:TableHeaderCell>
                    <asp:TableHeaderCell style="text-align:center" Font-Size="Large"><span title="Location">C<sub>O</sub></span></asp:TableHeaderCell>
                </asp:TableHeaderRow>
                        <asp:TableRow>
                            <asp:TableHeaderCell style="text-align:center" ID="cmprResultiR">
                                <label id="resultLblIr" runat="server"></label>
                            </asp:TableHeaderCell>
                            <asp:TableHeaderCell style="text-align:center" ID="cmprResultiA">
                                <label id="resultLblIa" runat="server"></label>
                            </asp:TableHeaderCell>
                            <asp:TableHeaderCell style="text-align:center" ID="cmprResultiE">
                                <label id="resultLblIe" runat="server"></label>
                            </asp:TableHeaderCell>
                            <asp:TableHeaderCell style="text-align:center" ID="cmprResultiL">
                                <label id="resultLblIl" runat="server"></label>
                            </asp:TableHeaderCell>
                            <asp:TableHeaderCell style="text-align:center" ID="cmprResultiF">
                                <label id="resultLblIf" runat="server"></label>
                            </asp:TableHeaderCell>
                            <asp:TableHeaderCell style="text-align:center" ID="cmprResultiC">
                                <label id="resultLblIc" runat="server"></label>
                            </asp:TableHeaderCell>
                            <asp:TableHeaderCell style="text-align:center" ID="cmprResultiP">
                                <label id="resultLblIp" runat="server"></label>
                            </asp:TableHeaderCell>
                            <asp:TableHeaderCell ID="cmprResultiO" Style="border-right-width: medium; text-align:center">
                                <label id="resultLblIo" runat="server"></label>
                            </asp:TableHeaderCell>


                            <asp:TableHeaderCell style="text-align:center" ID="cmprResultcR">
                                <label id="resultLblCr" runat="server"></label>
                            </asp:TableHeaderCell>
                            <asp:TableHeaderCell style="text-align:center" ID="cmprResultcA">
                                <label id="resultLblCa" runat="server"></label>
                            </asp:TableHeaderCell>
                            <asp:TableHeaderCell style="text-align:center" ID="cmprResultcE">
                                <label id="resultLblCe" runat="server"></label>
                            </asp:TableHeaderCell>
                            <asp:TableHeaderCell style="text-align:center" ID="cmprResultcL">
                                <label id="resultLblCl" runat="server"></label>
                            </asp:TableHeaderCell>
                            <asp:TableHeaderCell style="text-align:center" ID="cmprResultcF">
                                <label id="resultLblCf" runat="server"></label>
                            </asp:TableHeaderCell>
                            <asp:TableHeaderCell style="text-align:center" ID="cmprResultcC">
                                <label id="resultLblCc" runat="server"></label>
                            </asp:TableHeaderCell>
                            <asp:TableHeaderCell style="text-align:center" ID="cmprResultcP">
                                <label id="resultLblCp" runat="server"></label>
                            </asp:TableHeaderCell>
                            <asp:TableHeaderCell style="text-align:center" ID="cmprResultcO">
                                <label id="resultLblCo" runat="server"></label>
                            </asp:TableHeaderCell>
                        </asp:TableRow>
                    </asp:Table>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="trojanDrpDwn" EventName="SelectedIndexChanged" />
                    <asp:AsyncPostBackTrigger ControlID="detectionMethodDrpDwn" EventName="SelectedIndexChanged" />
                    <asp:AsyncPostBackTrigger ControlID="compareBtn" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
        <div>
            <div style="display:inline;">
               
                <asp:DropDownList  runat="server" ID="detectionMethodDrpDwn" OnSelectedIndexChanged="detectionMethodDrpDwn_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                <label>Select a Detection Method</label>
            </div>

            <div style="display:inline; float: right; ">
                <label>Select a Trojan</label>
                <asp:DropDownList runat="server" ID="trojanDrpDwn" OnSelectedIndexChanged="trojanDrpDwn_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
            </div>
        </div>
        <div style="text-align:center">
            <asp:Button CssClass="btn btn-default" runat="server" ID="compareBtn" Text="Compare" OnClick="compareBtn_Click" />
        </div>
    </div>

 

</asp:Content>
