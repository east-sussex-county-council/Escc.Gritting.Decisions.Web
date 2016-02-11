using System;
using EsccWebTeam.Data.Web;

namespace Escc.Gritting.Decisions.Web
{
    /// <summary>
    /// Display a paged archive of gritting decisions
    /// </summary>
    public partial class decisions : System.Web.UI.Page
    {
        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            var totalResults = 0;
            var decisions = DecisionManager.ReadRouteSetDecisions(this.paging.PageSize, this.paging.CurrentPage, out totalResults);

            this.paging.TotalResults = totalResults;
            this.decisionArchive.DataSource = decisions;
            this.decisionArchive.DataBind();

            this.pageMetadata.RssFeedUrl = Iri.MakeAbsolute(new Uri("decisionsrss.ashx", UriKind.Relative)).ToString();


#if !DEBUG
            Http.CacheFor(0, 10);
#endif
        }
    }
}