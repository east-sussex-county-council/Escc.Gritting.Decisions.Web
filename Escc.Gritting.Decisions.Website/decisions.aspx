﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="decisions.aspx.cs" Inherits="Escc.Gritting.Decisions.Web.decisions" %>
<asp:Content runat="server" ContentPlaceHolderID="metadata">
    <Metadata:MetadataControl runat="server" id="pageMetadata" 
        Title="Gritting decisions"
        Description="See the decisions made by East Sussex County Council about where and when to grit roads. Decisions are made at least once a day and more often during periods of severe weather."
        DateCreated="2011-12-02"
        IpsvPreferredTerms="Salting and gritting"
        LgslNumbers="561"
        LgilType="Providing information"
        RssFeedTitle="Gritting decisions"
    />
    <ClientDependency:Css runat="server" Files="Gritting" />
    <link rel="alternate" type="text/xml" href="decisionsxml.ashx" />
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="content">
    <div class="article">
        <section>
            <h1 class="text">Gritting decisions</h1>
            <NavigationControls:PagingController runat="server" id="paging" PageSize="30" />
            <NavigationControls:PagingBarControl runat="server" PagingControllerId="paging" />
            <asp:repeater runat="server" id="decisionArchive">
                <HeaderTemplate>
                    <div class="text">
                    <table class="data">
                    <thead><tr><th scope="col">Time of update</th><th scope="col">Gritting zone</th><th scope="col">Action</th><th scope="col" class="actiontime">Time</th></tr></thead>
                    <tbody>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                    <td><%# Server.HtmlEncode(eastsussexgovuk.webservices.TextXhtml.HouseStyle.DateTimeFormatter.ShortBritishDateWithTime(((Escc.Gritting.RouteSetDecision)Container.DataItem).DecisionTime)) %></td>
                    <td><%# Server.HtmlEncode(((Escc.Gritting.RouteSetDecision)Container.DataItem).RouteSet.RouteSetName)%></td>
                    <td class="action <%# System.Text.RegularExpressions.Regex.Replace(((Escc.Gritting.RouteSetDecision)Container.DataItem).Action, "[^a-zA-Z]*", "").ToLower(System.Globalization.CultureInfo.CurrentCulture) %>">
                        <%# Server.HtmlEncode(((Escc.Gritting.RouteSetDecision)Container.DataItem).Action)%>
                    </td>
                    <td class="actiontime"><%# ((Escc.Gritting.RouteSetDecision)Container.DataItem).ActionTime.HasValue ? Server.HtmlEncode(eastsussexgovuk.webservices.TextXhtml.HouseStyle.DateTimeFormatter.Time(((Escc.Gritting.RouteSetDecision)Container.DataItem).ActionTime.Value)) : null%></td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </tbody>
                    </table>

                    <p><a href="gritting_zones.pdf" type="application/pdf">Map of gritting zones <span class="downloadDetail">(PDF, 155KB)</span></a></p>
                    <p><a href="decisionsrss.ashx" class="rssFeed rss subscribe" rel="alternate" type="application/rss+xml">Subscribe by RSS to gritting decisions</a></p>
                    <p><a class="email subscribe" href="http://blogtrottr.com/?subscribe=https%3A%2F%2Fnew.eastsussex.gov.uk%2Froadsandtransport%2Froads%2Fmaintenance%2Fgritting-roads-and-pavements%2Fdecisions%2Fdecisionsrss.ashx">Subscribe by email to gritting decisions</a></p>

                    </div>
                </FooterTemplate>
            </asp:repeater>
            <NavigationControls:PagingBarControl runat="server" PagingControllerId="paging" />
        </section>

        <EastSussexGovUK:Related runat="server">
            <WebsitesTemplate>
                <ul><li><a href="https://data.gov.uk/dataset/east-sussex-county-council-gritting-decisions">Our gritting decisions as open data</a></li></ul>
            </WebsitesTemplate>
        </EastSussexGovUK:Related>

        <EastSussexGovUK:Share runat="server" />
    </div>

    <EastSussexGovUK:TwitterSearch runat="server" Search="esccroads" />
</asp:Content>
