<%@ Page Language="C#" AutoEventWireup="true" Inherits="DTcms.Web.UI.Page.article" ValidateRequest="false" %>
<%@ Import namespace="System.Collections.Generic" %>
<%@ Import namespace="System.Text" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="DTcms.Common" %>

<script runat="server">
override protected void OnInit(EventArgs e)
{

	/* 
		This page was created by DTcms Template Engine at 2018-07-26 20:58:35.
		本页面代码由DTcms模板引擎生成于 2018-07-26 20:58:35. 
	*/

	base.OnInit(e);
	StringBuilder templateBuilder = new StringBuilder(220000);
	const string channel = "news";

	templateBuilder.Append("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\r\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\r\n<head>\r\n<meta http-equiv=\"Content-type\" content=\"text/html; charset=utf-8\">\r\n<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0\">\r\n<meta name=\"apple-mobile-web-app-capable\" content=\"yes\">\r\n<meta name=\"apple-mobile-web-app-status-bar-style\" content=\"black\">\r\n<title>选择书籍 - ");
	templateBuilder.Append(Utils.ObjectToStr(site.name));
	templateBuilder.Append("</title>\r\n<link href=\"");
	templateBuilder.Append("/templates/main");
	templateBuilder.Append("/css/sm.css\" rel=\"stylesheet\" type=\"text/css\" />\r\n<link href=\"");
	templateBuilder.Append("/templates/main");
	templateBuilder.Append("/css/app.css?v=2\" rel=\"stylesheet\" type=\"text/css\" />\r\n<script type=\"text/javascript\" charset=\"utf-8\" src=\"");
	templateBuilder.Append(Utils.ObjectToStr(config.webpath));
	templateBuilder.Append("scripts/jquery/jquery-1.11.2.min.js\"></");
	templateBuilder.Append("script>\r\n<script type=\"text/javascript\" charset=\"utf-8\" src=\"http://m.sui.taobao.org/assets/js/zepto.js\"></");
	templateBuilder.Append("script>\r\n\r\n</head>\r\n\r\n<body>\r\n<div class=\"page-group\">\r\n    <div id=\"\" class=\"page page-current\">\r\n        <header class=\"bar bar-nav\">\r\n            <a class=\"button button-link button-nav pull-left back\" href=\"");
	templateBuilder.Append(linkurl("usercenter","index"));

	templateBuilder.Append("\">\r\n                <span class=\"icon icon-left\"></span>\r\n            </a>\r\n            <h1 class=\"title\">选择书籍</h1>\r\n        </header>\r\n        <nav class=\"bar bar-tab\">\r\n            <a class=\"tab-item external\" href=\"");
	templateBuilder.Append(linkurl("article_list",1054));

	templateBuilder.Append("\">\r\n                <span class=\"icon icon-home\"></span>\r\n                <span class=\"tab-label\">读经教育理念</span>\r\n            </a>\r\n            <a class=\"tab-item external active\" href=\"");
	templateBuilder.Append(linkurl("usercenter","index"));

	templateBuilder.Append("\">\r\n                <span class=\"icon icon-me\"></span>\r\n                <span class=\"tab-label\">我</span>\r\n            </a>\r\n        </nav>\r\n        <div class=\"content\">\r\n            <!--books-->\r\n            <ul class=\"selectbookds\">\r\n                ");
	DataTable categoryList1 = get_category_child_list("news", 3);

	foreach(DataRow cdr1 in categoryList1.Rows)
	{

	templateBuilder.Append("\r\n                <li>\r\n                    <a href=\"");
	templateBuilder.Append(linkurl("news_list",Utils.ObjectToStr(cdr1["id"])));

	templateBuilder.Append("\" external>\r\n                        <img src=\"" + Utils.ObjectToStr(cdr1["img_url"]) + "\" class=\"book_img\" />\r\n                        <h4>" + Utils.ObjectToStr(cdr1["title"]) + "</h4>\r\n                    </a>\r\n                </li>\r\n                ");
	}	//end for if

	templateBuilder.Append("\r\n            </ul>\r\n            <!--books-->\r\n        </div>\r\n    </div>\r\n</div>\r\n\r\n</body>\r\n</html>");
	Response.Write(templateBuilder.ToString());
}
</script>
