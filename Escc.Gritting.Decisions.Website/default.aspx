<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="Escc.Gritting.Decisions.Web._default" %>
<% @Register TagPrefix="Gritting" TagName="CurrentDecision" src="CurrentDecision.ascx" %>
<asp:Content runat="server" ContentPlaceHolderID="metadata">
    <Metadata:MetadataControl runat="server" 
        Title="Gritting roads and pavements"
        Description="See the decisions made by East Sussex County Council about where and when to grit roads. Decisions are made at least once a day and more often during periods of severe weather."
        DateCreated="2011-12-02"
        IpsvPreferredTerms="Salting and gritting"
        LgslNumbers="561"
        LgilType="Providing information"
        RssFeedUrl="http://www.eastsussex.gov.uk/roadsandtransport/roads/maintenance/saltingandgritting/decisionsrss.ashx"
    />
    <link rel="alternate" type="text/xml" href="decisionsxml.ashx" />
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="content">
    
    
     
	
    <div class="article">
    <article>
	    
    
        
<h1 id="heading" class="text">Gritting roads and pavements</h1>

        
<div id="ctl00_content_ctl03_highlightLinks" class="section-nav" role="navigation">

<ul class="first">
<li><a href="/roadsandtransport/roads/maintenance/saltingandgritting/gritbins.htm">Grit bins &#8211; ordering and refilling</a> </li>
<li><a href="/news/disruption.htm">Alerts about disruption to council services</a> </li>
</ul><ul class="second">
<li><a href="/roadsandtransport/roads/contactus/contactcentre.htm">Enquiries &#8211; our Highways Contact Centre</a> </li>
</ul>


</div>
        


        <div class="text">
            

            



<h2 id="subtitle1">Gritting decisions</h2>
<p>You can also see our gritting decisions by following our <a class="twitter" href="http://twitter.com/esccroads">twitter feed</a>.</p>


            <Gritting:CurrentDecision runat="server"/>

<h2 id="subtitle3">Which roads do you grit?</h2>
<p><a href="/roadsandtransport/roads/maintenance/saltingandgritting/find/default.aspx"><strong>See a map of gritting routes in East Sussex</strong></a> </p>
<p><strong><a href="/roadsandtransport/roads/maintenance/saltingandgritting/map/default.aspx">Real-time gritters &#8211; see where our gritters are</a> </strong></p>
<p>When icy conditions are forecast we will grit all primary routes first. We grit 42% of the roads in East Sussex. This is all A and B roads and some C roads.</p>
<p>We give priority to the C roads leading to:</p>
<ul><li>Hospitals, fire, ambulance and police stations</li>
<li>bus and railway stations</li>
<li>most main shopping areas and schools</li>
<li>difficult sites (very steep hills etc)</li>
</ul>
<p>Gritters followed detailed, planned routes. Sometimes a gritter may be moving but not putting down any salt because:</p>
<ul><li>it is travelling to the start of the route</li>
<li>in order to complete its route, it has to travel along roads which are not part of that route</li>
<li>﻿it has finished and is returning to the depot.</li>
</ul>




<h2 id="subtitle4">Deciding when to grit</h2>
<p>We use the latest weather forecasting technology to decide when we need to grit the roads. This can often be different to other forecasts such as those on the television or radio.</p>
<p>We aim to grit the roads before frost and ice are formed by freezing temperatures. Rain or snow can wash salt away, so we try to grit after rain has passed but before the road surface freezes. Where possible, we avoid the morning and evening rush hours.</p>
<p>Gritting decisions are made at least once a day, sometimes more in colder weather.</p>




<h2 id="subtitle5">Why grit the road?</h2>
<p>Grit is another name for salt. It helps to keep our roads safe by lowering the temperature at which water freezes, reducing the risk of ice. This process takes time and needs traffic moving over it to start working.</p>
<p>The gritter only needs to drive along one side of the road, as the gritter is designed to spread the salt across the full width of the road.</p>




<h2 id="subtitle6">Why don't you grit pavements?</h2>
<p>We don't have the resources to routinely grit footpaths or pavements. We have to prioritise major roads rather than pavements to prevent the most serious accidents.</p>
<p>We encourage residents to help themselves by clearing snow and ice from public areas near their properties.</p>
<p>For more advice, see:</p>
<ul><li><a href="https://www.gov.uk/clear-snow-road-path-cycleway">Clear snow from a road, path or cycleway &#8211; GOV.UK</a> </li>
</ul>


            <h2 id="subtitle7">Grit bins</h2>
            <p>We currently have over 900 grit bins spread around the county. We are working with residents' associations, as well as parish, district and borough councils where they may wish to buy their own additional grit bins. For further infomation, see:</p>
<ul><li><a href="/roadsandtransport/roads/maintenance/saltingandgritting/gritbins.htm">Grit bins</a> </li>
</ul>

            <h2 id="subtitle8">Advice for winter driving</h2>
            <p>If the weather is bad and the roads are icy then do not drive unless it is essential. If you do need to travel, see more advice from the Met Office &#8211; <a href="http://www.highways.gov.uk/traffic-information/seasonal-advice/make-time-for-winter/">Get ready for winter</a>.</p>

            
        </div>

     <EastSussexGovUK:Related runat="server">
<PagesTemplate>
        <ul>
<li><a href="/roadsandtransport/roads/roadsafety/safedriving/default.htm">Safer driving</a> </li>
<li><a href="/roadsandtransport/roads/maintenance/saltingandgritting/informationpack.htm">Winter maintenance information leaflets</a> </li>
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