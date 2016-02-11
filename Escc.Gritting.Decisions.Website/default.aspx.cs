using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EsccWebTeam.Data.Web;

namespace Escc.Gritting.Decisions.Web
{
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.pageMetadata.RssFeedUrl = Iri.MakeAbsolute(new Uri("decisionsrss.ashx", UriKind.Relative)).ToString();
        }
    }
}