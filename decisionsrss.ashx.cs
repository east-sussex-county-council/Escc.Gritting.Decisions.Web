using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using System.Web;
using System.Xml;
using System.Xml.Serialization;
using System.Xml.Xsl;
using eastsussexgovuk.webservices.TextXhtml.HouseStyle;
using EsccWebTeam.Data.Web;

namespace Escc.Gritting.Decisions.Web
{
    /// <summary>
    /// An RSS feed of road maintenance decisions
    /// </summary>
    public class decisionsrss : IHttpHandler
    {
        /// <summary>
        /// Enables processing of HTTP Web requests by a custom HttpHandler that implements the <see cref="T:System.Web.IHttpHandler"/> interface.
        /// </summary>
        /// <param name="context">An <see cref="T:System.Web.HttpContext"/> object that provides references to the intrinsic server objects (for example, Request, Response, Session, and Server) used to service HTTP requests.</param>
        public void ProcessRequest(HttpContext context)
        {
            // Can't use application/rss+xml because browsers don't load it properly
            if (context == null) throw new ArgumentNullException("context");
            context.Response.ContentType = "text/xml";

            // Get the decisions
            var decisions = DecisionManager.ReadRouteSetDecisions(20, 1);

            // Serialise to XML as UTF8
            using (MemoryStream writeStream = new MemoryStream())
            {

                XmlSerializer xs = new XmlSerializer(typeof(List<GrittingDecision>), null, new Type[] { typeof(RouteSetDecision) }, null, "http://www.eastsussex.gov.uk/EsccWebTeam.Gritting");
                XmlTextWriter xmlTextWriter = new XmlTextWriter(writeStream, Encoding.UTF8);
                xs.Serialize(xmlTextWriter, decisions);

                // Transform into RSS and output
                XslCompiledTransform xslt = new XslCompiledTransform();
                using (var readStream = (MemoryStream)xmlTextWriter.BaseStream)
                {
                    readStream.Position = 0;
                    xslt.Load(Path.GetDirectoryName(context.Server.MapPath(context.Request.Url.AbsolutePath)) + Path.DirectorySeparatorChar + "decisionsrss.xslt");

                    var args = new XsltArgumentList();
                    args.AddParam("Rfc822Date", String.Empty, DateTimeFormatter.Rfc822DateTime(DateTime.Now));
                    //this.items.TransformArgumentList.AddParam("Iso8601Date", String.Empty, DateTimeFormatter.Iso8601DateTime(DateTime.Now));
                    args.AddParam("CurrentUrl", String.Empty, context.Request.Url.ToString());
                    args.AddParam("HtmlVersionUrl", String.Empty, Iri.MakeAbsolute(new Uri("decisions.aspx", UriKind.Relative)).ToString());

                    xslt.Transform(new XmlTextReader(readStream), args, context.Response.OutputStream);
                }
            }
            // Include client-side caching for this data
#if (!DEBUG)
            Http.CacheFor(0, 10);
#endif
        }

        /// <summary>
        /// Gets a value indicating whether another request can use the <see cref="T:System.Web.IHttpHandler"/> instance.
        /// </summary>
        /// <value></value>
        /// <returns>true if the <see cref="T:System.Web.IHttpHandler"/> instance is reusable; otherwise, false.
        /// </returns>
        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}