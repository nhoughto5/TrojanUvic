<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="OpenAuthProviders.ascx.cs" Inherits="Trojan.Account.OpenAuthProviders" %>

<div id="socialLoginList">
    <h4>University of Victoria</h4>
    <hr />
    <asp:ListView runat="server" ID="providerDetails" ItemType="System.String"
        SelectMethod="GetProviderNames" ViewStateMode="Disabled">
        <ItemTemplate>
            <p>
                <button type="submit" class="btn btn-default" name="provider" value="<%#: Item %>"
                    title="Log in using your <%#: Item %> account.">
                    <%#: Item %>
                </button>
            </p>
        </ItemTemplate>
        <EmptyDataTemplate>
            <div>
                <%--<p>There are no external authentication services configured. See <a href="http://go.microsoft.com/fwlink/?LinkId=252803">this article</a> for details on setting up this ASP.NET application to support logging in via external services.</p>--%>
                  <a href="http://www.uvic.ca"><img style="width:60%" src="../Images/University_of_Victoria_Logo_and_Wordmark.png" /></a>
            </div>
        </EmptyDataTemplate>
    </asp:ListView>
</div>
