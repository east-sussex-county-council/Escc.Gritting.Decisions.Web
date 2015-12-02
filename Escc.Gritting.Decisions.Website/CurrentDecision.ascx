<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CurrentDecision.ascx.cs" Inherits="Escc.Gritting.Decisions.Web.CurrentDecision" %>
<ClientDependency:Css runat="server" Files="Gritting" />
<table class="data gritting">
<thead><tr><th scope="col">Time of update</th><th scope="col">Gritting zone</th><th scope="col">Action</th><th scope="col" class="actiontime">Time</th></tr></thead>
<tbody>
<asp:PlaceHolder ID="table" runat="server" />
</tbody>
</table>
<p class="earlier"><a href="/roadsandtransport/roads/maintenance/saltingandgritting/decisions.aspx">See earlier gritting decisions</a></p>
<p><a href="gritting_zones.pdf" type="application/pdf">Map of gritting zones <span class="downloadDetail">(PDF, 155KB)</span></a></p>
<p><a href="/roadsandtransport/roads/maintenance/saltingandgritting/decisionsrss.ashx" class="rssFeed rss subscribe" rel="alternate" type="application/rss+xml">Subscribe by RSS to gritting decisions</a></p>
<p><a class="email subscribe" href="http://blogtrottr.com/?subscribe=http%3A%2F%2Fwww.eastsussex.gov.uk%2Froadsandtransport%2Froads%2Fmaintenance%2Fsaltingandgritting%2Fdecisionsrss.ashx">Subscribe by email to gritting decisions</a></p>

