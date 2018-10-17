<%@ Page Language="C#" AutoEventWireup="true" Inherits="DTcms.Web.UI.Page.article_show" ValidateRequest="false" %>
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

	templateBuilder.Append("<!DOCTYPE html>\r\n<!--HTML5 doctype-->\r\n<html>\r\n<head>\r\n    <meta http-equiv=\"Content-type\" content=\"text/html; charset=utf-8\">\r\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=0\">\r\n    <meta name=\"apple-mobile-web-app-capable\" content=\"yes\" />\r\n    ");
	string category_title = get_category_title(model.category_id,"文章");

	templateBuilder.Append("\r\n    <title>");
	templateBuilder.Append(Utils.ObjectToStr(model.title));
	templateBuilder.Append("</title>\r\n    <link href=\"");
	templateBuilder.Append("/templates/main");
	templateBuilder.Append("/css/sm.css\" rel=\"stylesheet\" type=\"text/css\" />\r\n    <link href=\"");
	templateBuilder.Append("/templates/main");
	templateBuilder.Append("/css/app.css\" rel=\"stylesheet\" type=\"text/css\" />\r\n    <script type=\"text/javascript\" charset=\"utf-8\" src=\"");
	templateBuilder.Append(Utils.ObjectToStr(config.webpath));
	templateBuilder.Append("scripts/jquery/jquery-1.11.2.min.js\"></");
	templateBuilder.Append("script>\r\n</head>\r\n\r\n<body>\r\n<div class=\"page-group\">\r\n    <div id=\"\" class=\"page page-current\">\r\n		<header class=\"bar bar-nav\">\r\n			<a class=\"button button-link button-nav pull-left back\" href=\"");
	templateBuilder.Append(linkurl("article_list",1054));

	templateBuilder.Append("\" style=\" top:0;\">\r\n				<span class=\"icon icon-left\"></span>\r\n			</a>\r\n			<h1 class=\"title\">读经计划</h1>\r\n		</header>\r\n        <nav class=\"bar bar-tab\">\r\n            <a class=\"tab-item external active\" href=\"");
	templateBuilder.Append(linkurl("article_list",1054));

	templateBuilder.Append("\">\r\n                <span class=\"icon icon-home\"></span>\r\n                <span class=\"tab-label\">读经教育理念</span>\r\n            </a>\r\n            <a class=\"tab-item external\" href=\"wx_login.aspx\">\r\n                <span class=\"icon icon-me\"></span>\r\n                <span class=\"tab-label\">账户选择</span>\r\n            </a>\r\n        </nav>\r\n        <div class=\"content\" id=\"article-content\" style=\"padding:.8rem; font-size:.7rem;\">\r\n            ");
	templateBuilder.Append(Utils.ObjectToStr(model.content));
	templateBuilder.Append("\r\n        </div>\r\n    </div>\r\n</div>\r\n</body>\r\n</html>\r\n");
	Response.Write(templateBuilder.ToString());
}
</script>
