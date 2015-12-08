<%@ Page Title="Manage Account" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Manage.aspx.cs" Inherits="Trojan.Account.Manage" %>

<%@ Register Src="~/Account/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %>.</h2>

    <div>
        <asp:PlaceHolder runat="server" ID="successMessage" Visible="false" ViewStateMode="Disabled">
            <p class="text-success"><%: SuccessMessage %></p>
        </asp:PlaceHolder>
    </div>

    <div class="row">
        <div class="col-md-12">
            <div class="form-horizontal">
                <hr />
                <dl class="dl-horizontal">
                    <dt>Password:</dt>
                    <dd>
                        <asp:HyperLink NavigateUrl="/Account/ManagePassword" Text="[Change]" Visible="false" ID="ChangePassword" runat="server" />
                        <asp:HyperLink NavigateUrl="/Account/ManagePassword" Text="[Create]" Visible="false" ID="CreatePassword" runat="server" />
                    </dd>
                    <dt>Delete a Trojan:</dt>
                    <dd>
                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>
                                <div>
                                    <asp:DropDownList ID="trojanDrpDown" width="200px" runat="server" style="display:inline" AutoPostBack="true"></asp:DropDownList>
                                    <button type="button" ID="deleteTrojanBtn" data-toggle="modal" data-target="#deleteTrojanModal" style="display:inline" class="btn btn-primary btn-xs">Delete <span class="glyphicon glyphicon-remove"></span></button>
                                </div>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="confirmDeleteTrojan" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>

                    </dd>
                    <dt>Delete a Metod:</dt>
                    <dd>
                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>
                                <div>
                                    <asp:DropDownList ID="detectDrpDwn" width="200px" runat="server" style="display:inline" AutoPostBack="true"></asp:DropDownList>
                                    <asp:LinkButton ID="dtcnDeleteBtn" runat="server" style="display:inline" data-toggle="modal" data-target="#deleteMethodModal" CssClass="btn btn-primary btn-xs" >Delete <span class="glyphicon glyphicon-remove"></span></asp:LinkButton>
                                </div>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="deleteMethodBtn" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>

                    </dd>
<%--                    <dt>External Logins:</dt>
                    <dd><%: LoginsCount %>
                        <asp:HyperLink NavigateUrl="/Account/ManageLogins" Text="[Manage]" runat="server" />

                    </dd>--%>
                    <%--
                        Phone Numbers can used as a second factor of verification in a two-factor authentication system.
                        See <a href="http://go.microsoft.com/fwlink/?LinkId=403804">this article</a>
                        for details on setting up this ASP.NET application to support two-factor authentication using SMS.
                        Uncomment the following blocks after you have set up two-factor authentication
                    --%>
                    <%--
                    <dt>Phone Number:</dt>
                    <% if (HasPhoneNumber)
                       { %>
                    <dd>
                        <asp:HyperLink NavigateUrl="/Account/AddPhoneNumber" runat="server" Text="[Add]" />
                    </dd>
                    <% }
                       else
                       { %>
                    <dd>
                        <asp:Label Text="" ID="PhoneNumber" runat="server" />
                        <asp:HyperLink NavigateUrl="/Account/AddPhoneNumber" runat="server" Text="[Change]" /> &nbsp;|&nbsp;
                        <asp:LinkButton Text="[Remove]" OnClick="RemovePhone_Click" runat="server" />
                    </dd>
                    <% } %>
                    --%>

                   <%-- <dt>Two-Factor Authentication:</dt>
                    <dd>
                        <p>
                            There are no two-factor authentication providers configured. See <a href="http://go.microsoft.com/fwlink/?LinkId=403804">this article</a>
                            for details on setting up this ASP.NET application to support two-factor authentication.
                        </p>--%>
                        <% if (TwoFactorEnabled)
                          { %> 
                        <%--
                        Enabled
                        <asp:LinkButton Text="[Disable]" runat="server" CommandArgument="false" OnClick="TwoFactorDisable_Click" />
                        --%>
                        <% }
                          else
                          { %> 
                        <%--
                        Disabled
                        <asp:LinkButton Text="[Enable]" CommandArgument="true" OnClick="TwoFactorEnable_Click" runat="server" />
                        --%>
                        <% } %>
                    <%--</dd>--%>
                </dl>
            </div>
        </div>
    </div>
    <div class="modal fase" id="deleteTrojanModal" role="dialog" draggable="false">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h2>Are you sure?</h2>
                </div>
                <div class="modal-body">
                    <p>By pressing 'Confirm' below you will remove this Trojan Virus from your account. If you are unsure, hit Cancel</p>
                </div>
                <div class="modal-footer">
                    <div>
                        <asp:Button CssClass="btn btn-primary" ID="confirmDeleteTrojan" runat="server" OnClick="deleteTrojanBtn_Click" Text="Confirm" style="display=inline"/>
                        <button type="button" class="btn btn-primary" data-dismiss="modal" aria-hidden="true">Cancel</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
        <div class="modal fase" id="deleteMethodModal" role="dialog" draggable="false">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h2>Are you sure?</h2>
                </div>
                <div class="modal-body">
                    <p>By pressing 'Confirm' below you will remove this detection method from your account. If you are unsure, hit Cancel</p>
                </div>
                <div class="modal-footer">
                    <div>
                        <asp:Button CssClass="btn btn-primary" ID="deleteMethodBtn" runat="server" Onclick="dtcnDeleteBtn_Click" Text="Confirm" style="display=inline"/>
                        <button type="button" class="btn btn-primary" data-dismiss="modal" aria-hidden="true">Cancel</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
