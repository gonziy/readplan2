<%@ Page Language="C#" AutoEventWireup="true" Inherits="DTcms.Web.UI.Page.article_list" ValidateRequest="false" %>
<%@ Import namespace="System.Collections.Generic" %>
<%@ Import namespace="System.Text" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="DTcms.Common" %>

<script runat="server">
override protected void OnInit(EventArgs e)
{

	/* 
		This page was created by DTcms Template Engine at 2018-10-17 17:52:22.
		本页面代码由DTcms模板引擎生成于 2018-10-17 17:52:22. 
	*/

	base.OnInit(e);
	StringBuilder templateBuilder = new StringBuilder(220000);
	const string channel = "article";
	const int pagesize = 10;

	templateBuilder.Append("<!DOCTYPE html>\r\n<!--HTML5 doctype-->\r\n<html>\r\n<head>\r\n    <meta http-equiv=\"Content-type\" content=\"text/html; charset=utf-8\">\r\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=0\">\r\n    <meta name=\"apple-mobile-web-app-capable\" content=\"yes\" />\r\n    <title>");
	templateBuilder.Append(Utils.ObjectToStr(model.title));
	templateBuilder.Append(" - ");
	templateBuilder.Append(Utils.ObjectToStr(site.name));
	templateBuilder.Append("</title>\r\n    <link rel=\"stylesheet\" href=\"");
	templateBuilder.Append("/templates/main");
	templateBuilder.Append("/css/swiper.css\" />\r\n    <link href=\"");
	templateBuilder.Append("/templates/main");
	templateBuilder.Append("/css/sm.css\" rel=\"stylesheet\" type=\"text/css\" />\r\n    <link href=\"");
	templateBuilder.Append("/templates/main");
	templateBuilder.Append("/css/app.css\" rel=\"stylesheet\" type=\"text/css\" />\r\n    <script type=\"text/javascript\" charset=\"utf-8\" src=\"");
	templateBuilder.Append(Utils.ObjectToStr(config.webpath));
	templateBuilder.Append("scripts/jquery/jquery-1.11.2.min.js\"></");
	templateBuilder.Append("script>\r\n</head>\r\n\r\n<body>\r\n\r\n<div class=\"page-group\">\r\n        <div id=\"\" class=\"page page-current\">\r\n        <header class=\"bar bar-nav\">\r\n            <h1 class=\"title\">");
	templateBuilder.Append(Utils.ObjectToStr(model.title));
	templateBuilder.Append("</h1>\r\n        </header>  \r\n        <nav class=\"bar bar-tab\">\r\n            <a class=\"tab-item external active\" href=\"");
	templateBuilder.Append(linkurl("article_list",1054));

	templateBuilder.Append("\">\r\n                <span class=\"icon icon-home\"></span>\r\n                <span class=\"tab-label\">读经教育理念</span>\r\n            </a>\r\n            <a class=\"tab-item external\" href=\"wx_login.aspx\">\r\n                <span class=\"icon icon-me\"></span>\r\n                <span class=\"tab-label\">账户选择</span>\r\n            </a>\r\n        </nav>\r\n        <div class=\"content\">\r\n            <div class=\"list-block media-list\" style=\"margin:0;\">\r\n                <ul>\r\n                    ");
	DataTable newsList = get_article_list(channel, category_id, pagesize, page, "status=0", out totalcount, out pagelist, "article_list", category_id, "__id__");

	foreach(DataRow dr in newsList.Rows)
	{

	templateBuilder.Append("\r\n                    <li>\r\n                        <a href=\"");
	templateBuilder.Append(linkurl("article_show",Utils.ObjectToStr(dr["id"])));

	templateBuilder.Append("\" class=\"item-link item-content\">\r\n                            <div class=\"item-media\"><img src=\"" + Utils.ObjectToStr(dr["img_url"]) + "\" width=\"80\"></div>\r\n                            <div class=\"item-inner\">\r\n                                <div class=\"item-title-row\">\r\n                                    <div class=\"item-title\" style=\"font-size:.75rem; color:#333;\">" + Utils.ObjectToStr(dr["title"]) + "</div>\r\n                                </div>\r\n                                <div class=\"item-text\" style=\"font-size:.65rem; color:#999;\">" + Utils.ObjectToStr(dr["zhaiyao"]) + "</div>\r\n                            </div>\r\n                        </a>\r\n                    </li>\r\n                    ");
	}	//end for if

	templateBuilder.Append("\r\n                </ul>\r\n                <!--分页页码-->\r\n                <div class=\"page-list\">");
	templateBuilder.Append(Utils.ObjectToStr(pagelist));
	templateBuilder.Append("</div>\r\n                <!--/分页页码-->\r\n            </div>\r\n        </div>\r\n    </div>\r\n</div>\r\n</body>\r\n</html>\r\n");
	Response.Write(templateBuilder.ToString());
}
</script>
