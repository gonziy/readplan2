<%@ Page Language="C#" AutoEventWireup="true" Inherits="DTcms.Web.UI.Page.login" ValidateRequest="false" %>
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

	templateBuilder.Append("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\r\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\r\n<head>\r\n    <meta http-equiv=\"Content-type\" content=\"text/html; charset=utf-8\" />\r\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0\" />\r\n    <meta name=\"apple-mobile-web-app-capable\" content=\"yes\" />\r\n    <meta name=\"apple-mobile-web-app-status-bar-style\" content=\"black\" />\r\n    <title>登录 - ");
	templateBuilder.Append(Utils.ObjectToStr(site.name));
	templateBuilder.Append("</title>\r\n    <link href=\"");
	templateBuilder.Append("/templates/main");
	templateBuilder.Append("/css/sm.css\" rel=\"stylesheet\" type=\"text/css\" />\r\n    <link href=\"");
	templateBuilder.Append("/templates/main");
	templateBuilder.Append("/css/app.css\" rel=\"stylesheet\" type=\"text/css\" />\r\n    <script type=\"text/javascript\" charset=\"utf-8\" src=\"");
	templateBuilder.Append(Utils.ObjectToStr(config.webpath));
	templateBuilder.Append("scripts/jquery/jquery-1.11.2.min.js\"></");
	templateBuilder.Append("script>\r\n\r\n    <script type=\"text/javascript\" charset=\"utf-8\" src=\"");
	templateBuilder.Append("/templates/main");
	templateBuilder.Append("/js/common.js\"></");
	templateBuilder.Append("script>\r\n    <script type=\"text/javascript\" charset=\"utf-8\" src=\"");
	templateBuilder.Append("/templates/main");
	templateBuilder.Append("/js/login-validate.js\"></");
	templateBuilder.Append("script>\r\n</head>\r\n\r\n<body>\r\n\r\n    <div class=\"page-group\">\r\n        <div id=\"\" class=\"page page-current\">\r\n            <header class=\"bar bar-nav\">\r\n                <h1 class=\"title\">登录</h1>\r\n            </header>\r\n\r\n            <div class=\"content\">\r\n                <div class=\"list-block\">\r\n                    <div id=\"loginbox\">\r\n                        <form class=\"am-form am-form-horizontal\" id=\"loginform\" name=\"loginform\" url=\"");
	templateBuilder.Append(Utils.ObjectToStr(config.webpath));
	templateBuilder.Append("tools/submit_ajax.ashx?action=user_login&site=");
	templateBuilder.Append(Utils.ObjectToStr(site.build_path));
	templateBuilder.Append("\">\r\n                            <ul>\r\n                                <li>\r\n                                    <div class=\"item-content\">\r\n                                        <div class=\"item-inner\">\r\n                                            <div class=\"item-input\">\r\n                                                <input type=\"text\" id=\"txtUserName\" name=\"txtUserName\" placeholder=\"手机号/用户名\" />\r\n                                            </div>\r\n                                        </div>\r\n                                    </div>\r\n                                </li>\r\n                                <li>\r\n                                    <div class=\"item-content\">\r\n                                        <div class=\"item-inner\">\r\n                                            <div class=\"item-input\">\r\n                                                <input type=\"password\" id=\"txtPassword\" name=\"txtPassword\" placeholder=\"请输入密码\" />\r\n                                            </div>\r\n                                        </div>\r\n                                    </div>\r\n                                </li>\r\n                            </ul>\r\n                            <div class=\"content-padded\">\r\n                                <input id=\"btnSubmit\" name=\"btnSubmit\" type=\"submit\" value=\"登录\" class=\"button button-big button-fill button-danger\" />\r\n                            </div>\r\n                            <div class=\"content-padded\">\r\n                                <a href=\"");
	templateBuilder.Append(Utils.ObjectToStr(config.webpath));
	templateBuilder.Append("wx_login.aspx\" class=\"button button-big button-fill\">微信一键登录</a>\r\n                            </div>\r\n                            <input id=\"turl\" name=\"turl\" type=\"hidden\" value=\"");
	templateBuilder.Append(Utils.ObjectToStr(turl));
	templateBuilder.Append("\" />\r\n                        </form>\r\n                    </div>\r\n                </div>\r\n            </div>\r\n\r\n        </div>\r\n    </div>\r\n\r\n</body>\r\n</html>");
	Response.Write(templateBuilder.ToString());
}
</script>
