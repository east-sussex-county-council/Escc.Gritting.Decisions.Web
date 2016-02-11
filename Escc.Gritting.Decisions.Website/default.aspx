<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="Escc.Gritting.Decisions.Web._default" %>
<% @Register TagPrefix="Gritting" TagName="CurrentDecision" src="CurrentDecision.ascx" %>
<asp:Content runat="server" ContentPlaceHolderID="metadata">
    <Metadata:MetadataControl runat="server" ID="pageMetadata"
        Title="Will roads in East Sussex be gritted today?"
        Description="See the decisions made by East Sussex County Council about where and when to grit roads. Decisions are made at least once a day and more often during periods of severe weather."
        DateCreated="2011-12-02"
        IpsvPreferredTerms="Salting and gritting"
        LgslNumbers="561"
        LgilType="Providing information"
        RssFeedTitle="Gritting decisions"
    />
    <link rel="alternate" type="text/xml" href="decisionsxml.ashx" />
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="content">
    
    
     
	
    <div class="article">
    <article>
        <div class="text">
	    
    
        
<h1>Will roads in East Sussex be gritted today?</h1>

<p>You can also see our gritting decisions by following our <a class="twitter" href="http://twitter.com/esccroads">twitter feed</a>.</p>


            <Gritting:CurrentDecision runat="server"/>

        </div>

     <EastSussexGovUK:Related runat="server">
<PagesTemplate>
        <ul>
<li><a href="/roadsandtransport/roads/roadsafety/safedriving/">Safer driving</a> </li>
<li><a href="/roadsandtransport/roads/maintenance/gritting-roads-and-pavements/informationpack/">Winter maintenance information leaflets</a> </li>
</ul>
    </PagesTemplate>

    <WebsitesTemplate>
            <ul>
<li><a href="https://www.gov.uk/driving-adverse-weather-conditions-226-to-237">Highway Code &#8211; Driving in adverse weather</a> </li>
<li><a href="http://www.metoffice.gov.uk/weather/uk/se/se_forecast_weather.html">MetOffice &#8211; Weather</a> </li>
</ul>
    </WebsitesTemplate>
</EastSussexGovUK:Related>

        <EastSussexGovUK:Share runat="server"/>        
    </article>
    </div>

    



    <EastSussexGovUK:TwitterSearch runat="server" Search="esccroads" />
</asp:Content>