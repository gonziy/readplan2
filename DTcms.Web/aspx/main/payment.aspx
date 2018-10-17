<%@ Page Language="C#" AutoEventWireup="true" Inherits="DTcms.Web.UI.Page.payment" ValidateRequest="false" %>
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

	templateBuilder.Append("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\r\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\r\n<head>\r\n<head>\r\n    <meta http-equiv=\"Content-type\" content=\"text/html; charset=utf-8\">\r\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0\">\r\n    <meta name=\"apple-mobile-web-app-capable\" content=\"yes\">\r\n    <meta name=\"apple-mobile-web-app-status-bar-style\" content=\"black\">\r\n    <title>支付  - ");
	templateBuilder.Append(Utils.ObjectToStr(site.name));
	templateBuilder.Append("</title>\r\n    <link href=\"");
	templateBuilder.Append("/templates/main");
	templateBuilder.Append("/css/sm.css\" rel=\"stylesheet\" type=\"text/css\" />\r\n    <link href=\"");
	templateBuilder.Append("/templates/main");
	templateBuilder.Append("/css/app.css?v=2\" rel=\"stylesheet\" type=\"text/css\" />\r\n    <script type=\"text/javascript\" charset=\"utf-8\" src=\"");
	templateBuilder.Append(Utils.ObjectToStr(config.webpath));
	templateBuilder.Append("scripts/jquery/jquery-1.11.2.min.js\"></");
	templateBuilder.Append("script>\r\n\r\n</head>\r\n\r\n<body>\r\n<div class=\"page-group\">\r\n	<div id=\"\" class=\"page page-current\">\r\n		<div id=\"alertbox\" class=\"content\">\r\n\r\n				<!--/提交支付-->\r\n				");
	if (action=="succeed")
	{

	templateBuilder.Append("\r\n				    <div class=\"wrap-box\">\r\n					    <h2>支付成功</h2>\r\n					    <hr data-am-widget=\"divider\" style=\"\" />\r\n					    <div class=\"tip\">\r\n						    <span class=\"icon check\"></span>\r\n						    <p>^_^，您的订单已经支付成功！</p>\r\n						<p>您可以点击这里进入<a href='");
	templateBuilder.Append(Utils.ObjectToStr(config.webpath));
	templateBuilder.Append("wx_login.aspx'>账户管理</a>使用读书功能！</p>\r\n						<p>如有其它问题，请立即与我们客服人员联系。</p>\r\n				    </div>\r\n				    <!--/支付成功-->\r\n                ");
	}
	else
	{

	templateBuilder.Append("\r\n                    <!--支付失败-->\r\n                    <div class=\"wrap-box\">\r\n                        <h2>支付失败</h2>\r\n                        <hr data-am-widget=\"divider\" style=\"\" />\r\n                        <div class=\"tip\">\r\n                            <span class=\"icon check\"></span>\r\n                            <p>Ծ‸Ծ，您的订单没有支付成功！</p>\r\n							<p>请立即与我们客服人员联系。</p>\r\n                        </div>\r\n                    </div>\r\n                    <!--/支付失败-->\r\n				");
	}	//end for if

	templateBuilder.Append("\r\n\r\n		</div>\r\n	</div>\r\n</div>\r\n</body>\r\n</html>\r\n");
	Response.Write(templateBuilder.ToString());
}
</script>
