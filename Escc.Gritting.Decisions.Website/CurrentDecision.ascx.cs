using System;
using System.Collections.Generic;
using System.Globalization;
using System.Text;
using System.Text.RegularExpressions;
using System.Web.UI;

namespace Escc.Gritting.Decisions.Web
{
    /// <summary>
    /// Display the current gritting decision within an ASPX page
    /// </summary>
    public partial class CurrentDecision : UserControl
    {
        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            var decisions = DecisionManager.ReadLatestRouteSetDecisions();
            if (decisions.Count == 0)
            {
                this.table.Controls.Add(new LiteralControl("<tr><td colspan=\"4\">There are no gritting decisions at the moment.</td></tr>\n"));
                return;
            }


            var routeSets = DecisionManager.ReadRouteSets();

            // Is there a whole county decision that's more recent than anything else?
            RouteSetDecision latestDomainDecision = null;
            RouteSetDecision latestCountyDecision = null;
            List<RouteSetDecision> countyDecisions = new List<RouteSetDecision>();

            foreach (RouteSetDecision decision in decisions)
            {
                if (decision.RouteSet.IsWholeCounty)
                {
                    if (latestCountyDecision == null || decision.DecisionTime > latestCountyDecision.DecisionTime) latestCountyDecision = decision;
                    countyDecisions.Add(decision);
                }
                else
                {
                    if (latestDomainDecision == null || decision.DecisionTime > latestDomainDecision.DecisionTime) latestDomainDecision = decision;
                }
            }

            if (latestCountyDecision != null && (latestDomainDecision == null || latestCountyDecision.DecisionTime > latestDomainDecision.DecisionTime))
            {
                // Show latest decisions for whole county
                DisplayDecisionsForArea(latestCountyDecision, countyDecisions);
            }
            else
            {
                // Otherwise show the latest update for each route set. Could have primary/secondary decision superceding whole county, or vice versa.
                var decisionsByDomain = GroupDecisionsByDomainName(decisions);

                foreach (var decisionsForDomain in decisionsByDomain.Values)
                {
                    RouteSetDecision latest = null;
                    foreach (var decision in decisionsForDomain)
                    {
                        if (latest == null || decision.DecisionTime > latest.DecisionTime) latest = decision;
                    }

                    DisplayDecisionsForArea(latest, decisionsForDomain);
                }
            }
        }

        private static Dictionary<string, List<RouteSetDecision>> GroupDecisionsByDomainName(IList<GrittingDecision> decisions)
        {
            var decisionsByDomain = new Dictionary<string, List<RouteSetDecision>>();
            foreach (RouteSetDecision decision in decisions)
            {
                if (!decisionsByDomain.ContainsKey(decision.RouteSet.GrittingDomainName))
                {
                    decisionsByDomain.Add(decision.RouteSet.GrittingDomainName, new List<RouteSetDecision>());
                }

                decisionsByDomain[decision.RouteSet.GrittingDomainName].Add(decision);
            }
            return decisionsByDomain;
        }

        private void DisplayDecisionsForArea(RouteSetDecision latestDecision, List<RouteSetDecision> decisionsForArea)
        {
            if (latestDecision.RouteSet.RouteTypeToGrit == GrittingRouteType.All)
            {
                AddDecisionToTable(latestDecision);
            }
            else
            {
                RouteSetDecision latestPrimaryDecision = null;
                RouteSetDecision latestSecondaryDecision = null;

                foreach (var decision in decisionsForArea)
                {
                    if (decision.RouteSet.RouteTypeToGrit == GrittingRouteType.Primary && (latestPrimaryDecision == null || decision.DecisionTime > latestPrimaryDecision.DecisionTime)) latestPrimaryDecision = decision;
                    else if (decision.RouteSet.RouteTypeToGrit == GrittingRouteType.Secondary && (latestSecondaryDecision == null || decision.DecisionTime > latestSecondaryDecision.DecisionTime)) latestSecondaryDecision = decision;
                }

                if (latestPrimaryDecision != null) AddDecisionToTable(latestPrimaryDecision);
                if (latestSecondaryDecision != null) AddDecisionToTable(latestSecondaryDecision);
            }
        }


        private void AddDecisionToTable(RouteSetDecision decision)
        {
            var routeRow = new StringBuilder("<tr><td>");
            routeRow.Append(Server.HtmlEncode(eastsussexgovuk.webservices.TextXhtml.HouseStyle.DateTimeFormatter.ShortBritishDateNoYearWithTime(decision.DecisionTime)));
            routeRow.Append("</td><td>");
            routeRow.Append(Server.HtmlEncode(decision.RouteSet.RouteSetName));
            routeRow.Append("</td><td class=\"action ");
            routeRow.Append(Regex.Replace(decision.Action, "[^a-zA-Z]*", String.Empty).ToLower(CultureInfo.CurrentCulture));
            routeRow.Append("\">");
            routeRow.Append(Server.HtmlEncode(decision.Action));
            routeRow.Append("</td><td class=\"actiontime\">");
            if (decision.ActionTime.HasValue)
            {
                routeRow.Append(Server.HtmlEncode(eastsussexgovuk.webservices.TextXhtml.HouseStyle.DateTimeFormatter.Time(decision.ActionTime.Value)));
            }
            routeRow.Append("</td></tr>\n");
            this.table.Controls.Add(new LiteralControl(routeRow.ToString()));
        }
    }
}