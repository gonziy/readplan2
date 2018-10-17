<%@ Page Language="C#" AutoEventWireup="true" Inherits="DTcms.Web.UI.Page.usercenter" ValidateRequest="false" %>
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

	templateBuilder.Append("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\r\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\r\n<head>\r\n    <meta http-equiv=\"Content-type\" content=\"text/html; charset=utf-8\" />\r\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0\" />\r\n    <meta name=\"apple-mobile-web-app-capable\" content=\"yes\" />\r\n    <meta name=\"apple-mobile-web-app-status-bar-style\" content=\"black\" />\r\n    <title>我的 - ");
	templateBuilder.Append(Utils.ObjectToStr(site.name));
	templateBuilder.Append("</title>\r\n    <link href=\"");
	templateBuilder.Append("/templates/main");
	templateBuilder.Append("/css/sm.css\" rel=\"stylesheet\" type=\"text/css\" />\r\n    <link href=\"");
	templateBuilder.Append("/templates/main");
	templateBuilder.Append("/css/app.css\" rel=\"stylesheet\" type=\"text/css\" />\r\n    <link rel=\"stylesheet\" href=\"");
	templateBuilder.Append("/templates/main");
	templateBuilder.Append("/css/swiper.css\" />\r\n    <script type=\"text/javascript\" charset=\"utf-8\" src=\"");
	templateBuilder.Append(Utils.ObjectToStr(config.webpath));
	templateBuilder.Append("scripts/jquery/jquery-1.11.2.min.js\"></");
	templateBuilder.Append("script>\r\n\r\n\r\n</head>\r\n\r\n<body>\r\n\r\n    ");
	if (action=="index")
	{

	templateBuilder.Append("\r\n    <div class=\"page-group\">\r\n        <div id=\"\" class=\"page page-current\">\r\n            <header class=\"bar bar-nav\">\r\n                <h1 class=\"title\">读经计划</h1>\r\n            </header>\r\n            <nav class=\"bar bar-tab\">\r\n                <a class=\"tab-item external\" href=\"");
	templateBuilder.Append(linkurl("article_list",1054));

	templateBuilder.Append("\">\r\n                    <span class=\"icon icon-home\"></span>\r\n                    <span class=\"tab-label\">读经教育理念</span>\r\n                </a>\r\n                <a class=\"tab-item external active\" href=\"");
	templateBuilder.Append(linkurl("usercenter2","index"));

	templateBuilder.Append("\">\r\n                    <span class=\"icon icon-me\"></span>\r\n                    <span class=\"tab-label\">我</span>\r\n                </a>\r\n            </nav>\r\n            <div class=\"content\">\r\n                <div style=\"margin:6rem 0 0 0\">\r\n                    ");
	if (!string.IsNullOrEmpty(InviterName))
	{

	templateBuilder.Append("\r\n                    <p style=\"font-size:.7rem; text-align:center; color:#229073\">您的悦读推荐人：<u>");
	templateBuilder.Append(InviterName.ToString());

	templateBuilder.Append("</u></p>\r\n                    ");
	}	//end for if

	templateBuilder.Append("\r\n                    <ul style=\" \">\r\n                        <li onclick=\"location='calendar.aspx'\">\r\n                            <div class=\"item-inner\" style=\" text-align:center;margin:1.3rem auto;padding:0; border:none; color:#229073;\">\r\n                                今日读经\r\n                            </div>\r\n                        </li>\r\n                        <li onclick=\"location='userreadlog.aspx?action=zhengben'\">\r\n                            <div class=\"item-inner\" style=\" text-align:center;margin:1.3rem auto;padding:0; border:none; color:#229073;\">\r\n                                我的读经\r\n                            </div>\r\n                        </li>\r\n                        <li onclick=\"location='news.aspx'\">\r\n                            <div class=\"item-inner\" style=\" text-align:center;margin:1.3rem auto;padding:0; border:none; color:#229073;\">\r\n                                读经计划\r\n                            </div>\r\n                        </li>\r\n                        <li onclick=\"location='");
	templateBuilder.Append(Utils.ObjectToStr(config.webpath));
	templateBuilder.Append("api/payment/wxapipay/index.aspx?pay_order_no=");
	templateBuilder.Append(Utils.ObjectToStr(pay_id));
	templateBuilder.Append("&pay_order_amount=988'\">\r\n                            <div class=\"item-inner\" style=\" text-align:center;margin:1.3rem auto;padding:0; border:none; color:#229073;\">\r\n                                升级为VIP\r\n                            </div>\r\n                        </li>\r\n                    </ul>\r\n                </div>\r\n            </div>\r\n        </div>\r\n    </div>\r\n    ");
	}	//end for if

	templateBuilder.Append("\r\n\r\n</body>\r\n</html>");
	Response.Write(templateBuilder.ToString());
}
</script>
