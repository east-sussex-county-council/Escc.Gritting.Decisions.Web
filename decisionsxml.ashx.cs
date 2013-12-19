using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Text;
using System.Web;
using System.Xml;
using System.Xml.Serialization;
using EsccWebTeam.Data.Web;

namespace Escc.Gritting.Decisions.Web
{
    /// <summary>
    /// XML data feed of road maintenance decisions
    /// </summary>
    public class decisionsxml : IHttpHandler
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

            // Get the decisions, supporting paging of data
            int pageSize = GetPageSize(context);
            int page = GetPageNumber(context);

            var decisions = DecisionManager.ReadRouteSetDecisions(pageSize, page);

            // Serialise to page as UTF8
            using (MemoryStream writeStream = new MemoryStream())
            {
                XmlSerializer xs = new XmlSerializer(typeof(List<GrittingDecision>), new Type[] { typeof(RouteSetDecision) });
                XmlTextWriter xmlTextWriter = new XmlTextWriter(writeStream, Encoding.UTF8);
                using (var readStream = (MemoryStream)xmlTextWriter.BaseStream)
                {
                    xs.Serialize(xmlTextWriter, decisions);
                    context.Response.Write(new UTF8Encoding().GetString(readStream.ToArray()));
                }
            }
            // Include client-side caching for this data
#if (!DEBUG)
            Http.CacheFor(0, 10);
#endif
        }

        /// <summary>
        /// Gets the page number of data to select.
        /// </summary>
        /// <param name="context">The context.</param>
        /// <returns></returns>
        private static int GetPageNumber(HttpContext context)
        {
            int page = 1;
            if (!String.IsNullOrEmpty(context.Request.QueryString["page"]))
            {
                try
                {
                    page = Int32.Parse(context.Request.QueryString["page"], CultureInfo.CurrentCulture);
                }
                catch (FormatException)
                {
                    Http.Status400BadRequest();
                    context.Response.Write("<Error>Page number not valid</Error>");
                    context.Response.End();
                }
                catch (OverflowException)
                {
                    Http.Status400BadRequest();
                    context.Response.Write("<Error>Page number not valid</Error>");
                    context.Response.End();
                }
            }
            return page;
        }

        /// <summary>
        /// Gets the size of the page of data to select.
        /// </summary>
        /// <param name="context">The context.</param>
        /// <returns></returns>
        private static int GetPageSize(HttpContext context)
        {
            int pageSize = 20;
            if (!String.IsNullOrEmpty(context.Request.QueryString["pagesize"]))
            {
                try
                {
                    pageSize = Int32.Parse(context.Request.QueryString["pagesize"], CultureInfo.CurrentCulture);
                }
                catch (FormatException)
                {
                    Http.Status400BadRequest();
                    context.Response.Write("<Error>Page size not valid</Error>");
                    context.Response.End();
                }
                catch (OverflowException)
                {
                    Http.Status400BadRequest();
                    context.Response.Write("<Error>Page size not valid</Error>");
                    context.Response.End();
                }
            }
            return pageSize;
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